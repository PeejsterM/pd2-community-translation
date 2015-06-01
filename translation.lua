local writeTextNumber = 0 -- Don't change this at any point. I mean, you probably could at any point if you wanted to, but you shouldn't.
local text_original = LocalizationManager.text -- Don't change this either.
local printStrings = true -- This will output all strings to a text file if true.

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

--Anything in this table will not be exported to stringdump.txt. Either I don't know the macros used in these, or there's no point to exporting them.
local noExportTable = {
	""}

--the BLT hook doesn't handle localization changes in a way that allows us to use testAllStrings, so instead of using the BLT-friendly method, we are going to overwrite PAYDAY 2's localization function.
function LocalizationManager:text(string_id, ...)
	local sillyTransTable = {}
	local fixedTransTable = {}
	local shortTransTable = {}
	local real_TransTable = {}
	local game_TransTable = {}
	local otherTransTable = {}

	--Refer to these if you want to add new lines.
	sillyTransTable["example string_id"] = "example text"
	fixedTransTable["example string_id"] = "example text"
	shortTransTable["example string_id"] = "example text"
	real_TransTable["example string_id"] = "example text"
	game_TransTable["example string_id"] = "example text"
	otherTransTable["example string_id"] = "example text"
	
	--[[
	if these aren't part of the script, they're going to spam the shit out of stringdump.txt, so let's fix that
	some of them aren't possible to replace with this script unless we can figure out what variables these strings reference, such as player names
	in theory you could probably fix this, but it isn't worth the time.
	]]
	if inTable(noExportTable, string_id) then pass_to_original(true, self, string_id, ...) end
	
	--unknown strings
	if (useSillyTrans == true and sillyTransTable[string_id]) then return sillyTransTable[string_id] end
	if (useFixedTrans == true and fixedTransTable[string_id]) then return fixedTransTable[string_id] end
	if (useShortTrans == true and shortTransTable[string_id]) then return shortTransTable[string_id] end
	if (useReal_Trans == true and real_TransTable[string_id]) then return real_TransTable[string_id] end
	if (useGame_Trans == true and game_TransTable[string_id]) then return game_TransTable[string_id] end
	if (useOtherTrans == true and otherTransTable[string_id]) then return otherTransTable[string_id] end
	
	--we don't yet have this string in any of our lists, so we're going to try testAllStrings
	if (testAllStrings == 0) then return pass_to_original(false, self, string_id, ...) end
	if (testAllStrings == 1) then return string_id end
	if (testAllStrings == 2) then return string_id .. ": " .. pass_to_original(false, self, string_id, ...) end
end

function pass_to_original(dontWrite, self, string_id, ...)
	if printStrings == true and not dontWrite then
		string_print(string_id, text_original(self, string_id, ...))
	end
	return text_original(self, string_id, ...)
end

function string_print(string_id, string_original)
    local file = io.open("stringdump.txt", "a")
	file:write(writeTextNumber .. "th line of text to translate... \n" .. string_id .. "\n" .. string_original .. "\n\n")
	writeTextNumber = writeTextNumber +1
    file:close()
end

function inTable(tbl, item)
    for key, value in pairs(tbl) do
        if value == item then return true end
    end
    return false
end
