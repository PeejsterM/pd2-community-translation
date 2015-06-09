local text_original = LocalizationManager.text -- Don't change this either.
local printStrings = true -- This will output strings to text files inside the "translation" folder in your PAYDAY 2 directory.

local useSillyTrans = true -- It's memeday, fellas!
local useFixedTrans = true -- Fix errors in grammar, orthography, or things that are just plain wrong.
local useShortTrans = true -- Shorten or remove superfluous text.
local useReal_Trans = true -- Use this table if you want to actually translate something from English. I probably won't use this, but it's good to have it anyway.
local useGame_Trans = true -- Separate from FixedTrans, this table should be used for anything that gets game mechanics wrong.
local useOtherTrans = true -- None of the above.

local parseMacros = true -- If true, macros display normally. If false, they display as $MACRO_NAME;.
local writeMacros = false -- if false, change macros for a split second so that they display as $MACRO_NAME; when writing to stringdump.txt

local testAllStrings = 0 --[[
Change this number if you want help for finding string_ids so that you can replace them.
turning testAllStrings to 1 will set all unknown strings to their string_id. For example, Dallas's name will show up as "menu_russian".
turning testAllStrings to 2 will show the stringid with the actual string next to it. Dallas will show up as "menu_russian: Dallas"
Setting it to 2 will turn the gui into an absolute clusterfuck, so make sure you actually know how to navigate the menus beforehard!
]]

--the BLT hook doesn't handle localization changes in a way that allows us to use testAllStrings, so instead of using the BLT-friendly method, we are going to overwrite PAYDAY 2's localization function.
function LocalizationManager:text(string_id, macros)
	if noExportTable[string_id] == true then
		pass_to_original(false, self, string_id, macros)
		--I might do something with indices on the no export table that are set to values other than true, but right now I don't think it'll do anything useful.
	end

	--unknown strings
	if (useSillyTrans == true and sillyTransTable[string_id]) then return sillyTransTable[string_id] end
	if (useFixedTrans == true and fixedTransTable[string_id]) then return fixedTransTable[string_id] end
	if (useShortTrans == true and shortTransTable[string_id]) then return shortTransTable[string_id] end
	if (useReal_Trans == true and real_TransTable[string_id]) then return real_TransTable[string_id] end
	if (useGame_Trans == true and game_TransTable[string_id]) then return game_TransTable[string_id] end
	if (useOtherTrans == true and otherTransTable[string_id]) then return otherTransTable[string_id] end
	
	--we don't yet have this string in any of our lists, so we're going to try testAllStrings
	if (testAllStrings == 1) then return string_id end
	if (testAllStrings == 2) then return string_id .. ": " .. pass_to_original(true, self, string_id, macros) end
	
	--Fallback.
	return pass_to_original(true, self, string_id, macros)
end

function pass_to_original(writeThis, self, string_id, macros)
	if printStrings == true and writeThis then
		local _parseMacros = parseMacros
		parseMacros = writeMacros
		string_print(string_id, text_original(self, string_id, macros))
		parseMacros = _parseMacros
	end
	return text_original(self, string_id, macros)
end

function string_print(string_id, string_original, macros)
	local export = io.open("translation/" .. string_id .. ".txt", "w")
	export:write(string_original)
	export:close()
end
