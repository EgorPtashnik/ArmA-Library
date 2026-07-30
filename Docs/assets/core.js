/**
 * ArmA-Library docs — core engine.
 * Exposes a global `ArmADocs` registry with a small plugin API:
 *
 *   ArmADocs.register(category, entries)
 *       Register a set of function docs under a category label.
 *
 *   ArmADocs.addRoute({ match, url, label })
 *       Add a URL-redirect rule for names that have no local docs.
 *       Rules are tried in insertion order; the first `match(name)` that
 *       returns truthy wins.
 *
 *   ArmADocs.addAliases(map)
 *       Register explicit per-name URL overrides. Wins over addRoute rules.
 *       Value may be a plain URL string, or `{ url, label }`.
 *       Example: { "CBA_fnc_addPerFrameHandler": "https://…" }
 *
 *   ArmADocs.setDefaultRoute({ url, label })
 *       Fallback used when no alias and no `addRoute` rule matches.
 *
 *   ArmADocs.setConfig({ redirectDelayMs })
 *       Tweak runtime knobs (currently only the auto-redirect delay).
 *
 *   ArmADocs.start()
 *       Must be called once after all modules have registered.
 *       Renders the sidebar and dispatches the current URL hash.
 */
(function () {
    "use strict";

    const registry = {
        docs: {},          // { name: { category, description, syntax, params, returns, example } }
        aliases: {},       // { lowercaseName: { url, label } }  — explicit per-name overrides
        routes: [],        // [{ match(name), url(name), label(name)|label }]
        defaultRoute: null
    };

    const config = {
        redirectDelayMs: 1200
    };

    // -----------------------------------------------------------------------
    //  Helpers
    // -----------------------------------------------------------------------
    function escapeHtml(s) {
        return String(s).replace(/[&<>"']/g, ch => ({
            "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;"
        }[ch]));
    }

    function getRequestedName() {
        return decodeURIComponent((location.hash || "").replace(/^#/, "")).trim();
    }

    function findDoc(name) {
        const key = Object.keys(registry.docs).find(k => k.toLowerCase() === name.toLowerCase());
        return key ? { key, doc: registry.docs[key] } : null;
    }

    function resolveRoute(name) {
        // 1. Explicit alias — wins over everything.
        const alias = registry.aliases[name.toLowerCase()];
        if (alias) {
            return {
                match: () => true,
                url:   () => alias.url,
                label: alias.label || "external docs"
            };
        }

        // 2. Prefix / pattern rules, in insertion order.
        for (const r of registry.routes) {
            if (r.match(name)) return r;
        }

        // 3. Fallback.
        return registry.defaultRoute;
    }

    function ruleLabel(rule, name) {
        return typeof rule.label === "function" ? rule.label(name) : (rule.label || "external docs");
    }

    // -----------------------------------------------------------------------
    //  Rendering
    // -----------------------------------------------------------------------
    let contentEl, navEl, filterEl;

    function renderDoc(name, doc) {
        const rows = (doc.params || []).map(p => `
            <tr>
                <td>${escapeHtml(p.name)}</td>
                <td>${escapeHtml(p.type || "")}</td>
                <td>${p.desc || ""}</td>
            </tr>
        `).join("");

        contentEl.innerHTML = `
            <h2>${escapeHtml(name)}</h2>
            <div class="subtitle">${escapeHtml(doc.category || "")}</div>

            <section><p>${doc.description || ""}</p></section>

            ${doc.syntax ? `
                <section>
                    <h3>Syntax</h3>
                    <pre>${escapeHtml(doc.syntax)}</pre>
                </section>` : ""}

            ${rows ? `
                <section>
                    <h3>Parameters</h3>
                    <table class="params">
                        <thead><tr><th>Name</th><th>Type</th><th>Description</th></tr></thead>
                        <tbody>${rows}</tbody>
                    </table>
                </section>` : ""}

            ${doc.returns ? `
                <section>
                    <h3>Returns</h3>
                    <p>${doc.returns}</p>
                </section>` : ""}

            ${doc.example ? `
                <section>
                    <h3>Example</h3>
                    <pre>${escapeHtml(doc.example)}</pre>
                </section>` : ""}
        `;
    }

    function renderRedirect(name) {
        const rule = resolveRoute(name);
        if (!rule) {
            contentEl.innerHTML = `
                <p class="placeholder">
                    No local docs and no route registered for
                    <code>${escapeHtml(name)}</code>.
                </p>`;
            return;
        }

        const url = rule.url(name);
        const label = ruleLabel(rule, name);

        contentEl.innerHTML = `
            <div class="redirect-banner">
                <p>No local documentation for <code>${escapeHtml(name)}</code>.</p>
                <p>Redirecting to ${escapeHtml(label)}:
                    <a href="${url}" target="_blank" rel="noopener">${escapeHtml(url)}</a>
                </p>
                <button id="cancelRedirect">Cancel</button>
            </div>
        `;

        let cancelled = false;
        document.getElementById("cancelRedirect").addEventListener("click", () => {
            cancelled = true;
        });

        setTimeout(() => {
            if (!cancelled) location.replace(url);
        }, config.redirectDelayMs);
    }

    function renderEmpty() {
        contentEl.innerHTML = `
            <p class="placeholder">
                Select a function on the left, or open
                <code>#function_name</code> directly in the URL.
            </p>`;
    }

    function renderNav(filter) {
        const f = (filter || "").toLowerCase();
        const groups = {};

        Object.keys(registry.docs).sort().forEach(name => {
            if (f && !name.toLowerCase().includes(f)) return;
            const cat = registry.docs[name].category || "Other";
            (groups[cat] = groups[cat] || []).push(name);
        });

        const active = getRequestedName();
        const html = Object.keys(groups).sort().map(cat => `
            <div class="group-title">${escapeHtml(cat)}</div>
            ${groups[cat].map(name => `
                <a class="fn-link ${name === active ? "active" : ""}"
                   href="#${encodeURIComponent(name)}">${escapeHtml(name)}</a>
            `).join("")}
        `).join("");

        navEl.innerHTML = html || `<div class="placeholder">No matches.</div>`;
    }

    function route() {
        const name = getRequestedName();
        renderNav(filterEl.value);

        if (!name) return renderEmpty();

        const found = findDoc(name);
        if (found) renderDoc(found.key, found.doc);
        else renderRedirect(name);
    }

    // -----------------------------------------------------------------------
    //  Public API
    // -----------------------------------------------------------------------
    window.ArmADocs = {
        register(category, entries) {
            for (const name of Object.keys(entries || {})) {
                registry.docs[name] = Object.assign({ category }, entries[name]);
            }
        },

        addRoute(rule) {
            registry.routes.push(rule);
        },

        addAliases(map) {
            for (const name of Object.keys(map || {})) {
                const value = map[name];
                registry.aliases[name.toLowerCase()] = (typeof value === "string")
                    ? { url: value, label: null }
                    : { url: value.url, label: value.label || null };
            }
        },

        setDefaultRoute(rule) {
            registry.defaultRoute = rule;
        },

        setConfig(overrides) {
            Object.assign(config, overrides || {});
        },

        start() {
            contentEl = document.getElementById("content");
            navEl = document.getElementById("nav");
            filterEl = document.getElementById("filter");

            window.addEventListener("hashchange", route);
            filterEl.addEventListener("input", () => renderNav(filterEl.value));
            route();
        }
    };
})();
