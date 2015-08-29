text_original = text_original or LocalizationManager.text

--######################################################################################################################################################
--#
--# Change "false" here to "true" to enable the exporting of strings.
--# In order for this to work, you need to create a directory named "translation" in the root of your Payday 2 Installation.
--#
--######################################################################################################################################################

local printStrings = true

local string_input = ""

if printStrings == true and not file.DirectoryExists("translation/") then
	printStrings = false
	local menu = QuickMenu:new("No translation directory", "You have `printStrings` set to true in translation.lua, but haven't made a translation/ directory in the root directory of your Payday 2 Install.\n"..
	                           "BLT mods can't create directories, so you'll need to create one if you'd like to have localization strings echoed out.", {
			[1] = {
				text = "Close",
				is_cancel_button = true
			}
		});
	NotificationsManager:AddNotification("no_translation_dir", "No $PAYDAY2/translation directory exists", "You have printStrings enabled but no directory created", 1000, function()
		menu:show();
		NotificationsManager:RemoveNotification("no_translation_dir");
	end);
end

translationTable = {}
savedThisSessionTable = {}
--the BLT hook doesn't handle localization changes in a way that allows us to use testAllStrings, so instead of using the BLT-friendly method, we are going to overwrite PAYDAY 2's localization function.
function LocalizationManager:text(string_id, macros)
	if string_id == nil then return end

	local export = nil
	local return_string = "ERROR: " .. string_id
	local str_id = nil
	local utsLocalizedThis = false
	local bltLocalizedThis = false
	
	--This is just a multi-platform thing, I'm sure. Leave this here, though.

	if( not string_id or string_id == "" ) then
		return_string = ""
	elseif( self:exists( string_id .. "_" .. self._platform ) ) then
		str_id = string_id .. "_" .. self._platform
	elseif( self:exists( string_id ) ) then
		str_id = string_id
	end
	
	--Check out our translations.
	
	if translationTable[str_id] then
		utsLocalizedThis = true
		return_string = translationTable[str_id]
	end
	
	--BLT fallback.
	
	if self._custom_localizations[string_id] then
		return_string = self._custom_localizations[string_id]
		bltLocalizedThis = true
		if not return_string == nil then
			if macros and type(macros) == "table" then
				for k, v in pairs( macros ) do
					return_string = return_string:gsub( "$" .. k, v )
				end
			end
		end
	end
	
	--String hasn't been translated by BLT or by UTS, so let's export it if that option is available to us.
	
	if printStrings == true and not (utsLocalizedThis or bltLocalizedThis) and not noExportTable[string_id] and not savedThisSessionTable[string_id] then
		export = io.open("translation/" .. string_id .. ".txt", "w")
		export:write(Localizer:lookup( Idstring(string_id)))
		export:close()
		savedThisSessionTable[string_id] = true
	end
	
	if( str_id ) then
		return_string_b = return_string
		if utsLocalizedThis then
			self._macro_context = macros
			return_string = self:_localizer_post_process(return_string)
			self._macro_context = nil
		else
			--string_print(str_id, return_string)
			--self._macro_context = macros
			--return_string = Localizer:lookup( Idstring( str_id ) )
			--self._macro_context = nil
			return_string = text_original(self, string_id, macros)
		end
	end
	if return_string == nil then
		return ""
	else
		return return_string
	end
end
