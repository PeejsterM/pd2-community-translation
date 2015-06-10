local printStrings = false -- This will output strings to text files inside the "translation" folder in your PAYDAY 2 directory.

local useSillyTrans = true -- It's memeday, fellas!
local useFixedTrans = true -- Fix errors in grammar, orthography, or things that are just plain wrong.
local useShortTrans = true -- Shorten or remove superfluous text.
local useReal_Trans = true -- Use this table if you want to actually translate something from English. I probably won't use this, but it's good to have it anyway.
local useGame_Trans = true -- Separate from FixedTrans, this table should be used for anything that gets game mechanics wrong.
local useOtherTrans = true -- None of the above.

local testAllStrings = 0 --[[
Change this number if you want help for finding string_ids so that you can replace them.
turning testAllStrings to 1 will set all unknown strings to their string_id. For example, Dallas's name will show up as "menu_russian".
turning testAllStrings to 2 will show the stringid with the actual string next to it. Dallas will show up as "menu_russian: Dallas"
Setting it to 2 will turn the gui into an absolute clusterfuck, so make sure you actually know how to navigate the menus beforehard!
]]

--the BLT hook doesn't handle localization changes in a way that allows us to use testAllStrings, so instead of using the BLT-friendly method, we are going to overwrite PAYDAY 2's localization function.
function LocalizationManager:text(string_id, macros)
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
	
	--Check each of our translation tables.
	
	if utsTransTable[string_id] then
		return_string = utsTransTable[string_id]
		utsLocalizedThis = true
	end
	
	if (useSillyTrans == true and sillyTransTable[string_id]) then
		return_string = sillyTransTable[string_id]
		utsLocalizedThis = true
	end
	if (useFixedTrans == true and fixedTransTable[string_id]) then
		return_string = fixedTransTable[string_id]
		utsLocalizedThis = true
	end
	if (useShortTrans == true and shortTransTable[string_id]) then
		return_string = shortTransTable[string_id]
		utsLocalizedThis = true
	end
	if (useReal_Trans == true and real_TransTable[string_id]) then
		return_string = real_TransTable[string_id]
		utsLocalizedThis = true
	end
	if (useGame_Trans == true and game_TransTable[string_id]) then
		return_string = game_TransTable[string_id]
		utsLocalizedThis = true
	end
	if (useOtherTrans == true and otherTransTable[string_id]) then
		return_string = otherTransTable[string_id]
		utsLocalizedThis = true
	end
	
	--BLT Fallback.
	
	if self._custom_localizations[string_id] then
		return_string = self._custom_localizations[string_id]
		bltLocalizedThis = true
		if macros and type(macros) == "table" then
			for k, v in pairs( macros ) do
				return_string = return_string:gsub( "$" .. k, v )
			end
		end
	end
	
	--String hasn't been translated by BLT or by UTS, so let's export it if that option is available to us.
	
	if printStrings == true and not (utsLocalizedThis or bltLocalizedThis) and noExportTable[string_id] then
		export = io.open("translation/" .. string_id .. ".txt", "w")
		export:write(Localizer:lookup( Idstring(string_id)))
	end
	
	if( str_id ) then
		return_string_b = return_string
		if utsLocalizedThis then
			self._macro_context = macros
			return_string = self:_localizer_post_process(return_string)
			self._macro_context = nil
		else
			--string_print(str_id, return_string)
			self._macro_context = macros
			return_string = Localizer:lookup( Idstring( str_id ) )
			self._macro_context = nil
		end
	end
	
	if export ~= nil then
		export:close()
	end

	return return_string
end
