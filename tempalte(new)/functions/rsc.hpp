class EP_Subtitles
{    
	idd = -1;
	duration = 9999;
	fadein = 0.2;
	fadeout = 0.2;
	onLoad = "uiNamespace setVariable ['EP_Subtitles', _this select 0]";
	onUnLoad = "uinamespace setVariable ['EP_Subtitles', nil]";
	class controls
	{
		class DisplayText
		{    
			idc = 101;
			type = 13;
			style = "0x02+0x04";
			x = 0.5 - (0.4 * safeZoneW) / 2;
			y = safeZoneY + (7/8) * safeZoneH;
			w = (0.4 * safeZoneW);
			h = safeZoneH;
			shadow = 2;
			size = 0.045;
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
			text = "";
			class Attributes {
				align = "center";
				valign="top";
			}
		};  
	};	
};