local writeTextNumber = 0 -- Don't change this at any point. I mean, you probably could at any point if you wanted to, but you shouldn't.
local text_original = LocalizationManager.text -- Don't change this either.
local printStrings = true -- This will output all strings to a text file if true.
local sillyTrans = true -- It's memeday, fellas!
local fixedTrans = true -- Fix errors in English.
local shortTrans = true -- Shorten or remove superfluous text.
local ratsSucks = false -- Modifies some of Bain's subtitles so that the ingredients are always correct.
local testAllStrings = 0 -- Change this number if you want help for finding string_ids so that you can replace them.
-- turning testAllStrings to 1 will set all unknown strings to their string_id. For example, Dallas's name will show up as "menu_russian".
-- turning testAllStrings to 2 will show the stringid with the actual string next to it. Dallas will show up as "menu_russian: Dallas"
-- Setting it to 2 will turn the gui into an absolute clusterfuck, so make sure you actually know how to navigate the menus beforehard!

--Anything in this table will not be exported to stringdump.txt.
local noExportTable = {
	"hud_gage_assignment_progress",
	"prop_timer_gui_seconds",
	"prop_timer_gui_malfunction",
	"prop_timer_gui_error",
	"hud_day_payout",
	"hud_days_title",
	"hud_bonus_bags_payout",
	"hud_bonus_bags",
	"hud_potential_xp",
	"hud_objective",
	"hud_secured_loot",
	"hud_mission_bags",
	"hud_assault_end_line",
	""}
	
local ratsAcidTable = {"pln_rats_stage1_20_any_01", "pln_rt1_20_any_01", "pln_rt1_20_any_02", "pln_rt1_20_any_03", "pln_rt1_20_any_04", "pln_rt1_20_any_05", "pln_rt1_20_any_06", "pln_rt1_20_any_07", "pln_rt1_20_any_08", "pln_rt1_20_any_09", "pln_rt1_20_any_10"}
	
local ratsSodaTable = {"pln_rats_stage1_22_any_01", "pln_rt1_22_any_01", "pln_rt1_22_any_02", "pln_rt1_22_any_03", "pln_rt1_22_any_04", "pln_rt1_22_any_05", "pln_rt1_22_any_06", "pln_rt1_22_any_07", "pln_rt1_22_any_08", "pln_rt1_22_any_09", "pln_rt1_22_any_10"}

local ratsChloTable = {"pln_rats_stage1_24_any_01", "pln_rt1_24_any_01", "pln_rt1_24_any_02", "pln_rt1_24_any_03", "pln_rt1_24_any_04", "pln_rt1_24_any_05", "pln_rt1_24_any_06", "pln_rt1_24_any_07", "pln_rt1_24_any_08", "pln_rt1_24_any_09", "pln_rt1_24_any_10"}

function LocalizationManager:text(string_id, ...)
	return (string_id == "hud_assault_assault" and sillyTrans == true) and "stealthfags getting btfo"
	-- Add lines in the same format as these. The first is the string_id, and the second is what the string should show up as. The "or" is important.
	or (string_id == "menu_jowi" and shortTrans == true) and "Wick"
	or (string_id == "menu_l_lootscreen" and sillyTrans == true) and "Guys, the cards, go pick one."
	or (string_id == "hud_casing_mode_ticker" and sillyTrans == true) and "do we do this stelath?"
	or (string_id == "menu_ghostable_stage" and sillyTrans == true) and "stealth???"
	or (string_id == "hud_offshore_account" and sillyTrans == true) and "bitcoins"
	
	--Rats / Cook Off
	or (inTable(ratsAcidTable, string_id) and ratsSucks == true) and "Add muriatic acid to continue the process!"
	or (inTable(ratsSodaTable, string_id) and ratsSucks == true) and "Add caustic soda to continue the process!"
	or (inTable(ratsChloTable, string_id) and ratsSucks == true) and "Add hydrogen chloride to continue the process!"
	
	--Mallcrasher
	or (string_id == "hud_v_mallcrasher_mission1_hl" and sillyTrans == true) and "Guys, the mall, go enter it."
	or (string_id == "hud_v_mallcrasher_mission2_hl" and sillyTrans == true) and "Guys, the mall, go crash it."
	or (string_id == "hud_v_mallcrasher_mission6_hl" and sillyTrans == true) and "Guys, the copter, wait for it."
	or (string_id == "hud_v_mallcrasher_mission7_hl" and sillyTrans == true) and "Guys, the escape, go to it."
	
	--Hoxout Day 1
	or (string_id == "hud_heist_hox1_1_hl" and sillyTrans == true) and "Guys, the Hoxton, go get him."
	or (string_id == "hud_heist_hox1_2_hl" and sillyTrans == true) and "Guys, the driver, go signal him."
	or (string_id == "hud_heist_hox1_3_hl" and sillyTrans == true) and "Guys, the truck, go cover it."
	or (string_id == "hud_heist_hox1_5_hl" and sillyTrans == true) and "Guys, the ticket, go get it."
	or (string_id == "hud_heist_hox1_6_hl" and sillyTrans == true) and "Guys, the bollards, go lower them."
	or (string_id == "hud_heist_hox1_7_hl" and sillyTrans == true) and "Guys, the computer, go hack it."
	or (string_id == "hud_heist_hox1_8_hl" and sillyTrans == true) and "Guys, the computer, go restart it."
	or (string_id == "hud_heist_hox1_9_hl" and sillyTrans == true) and "Guys, the button, go push it."
	or (string_id == "hud_heist_hox1_10_hl" and sillyTrans == true) and "Guys, the job, go finish it."
	or (string_id == "hud_heist_hox1_12_hl" and sillyTrans == true) and "Guys, the car, go move it."
	or (string_id == "hud_heist_hox1_15_hl" and sillyTrans == true) and "Guys, a bridge, go make one."
	or (string_id == "hud_heist_hox1_17_hl" and sillyTrans == true) and "Guys, the armor, go remove it."
	
	--nobody plays Big Oil
	or (string_id == "hud_e_welcome_jungle_stage1_mission1_hl" and sillyTrans == true) and "Guys, the house, go inside it."
	or (string_id == "hud_e_welcome_jungle_stage1_mission2_hl" and sillyTrans == true) and "Guys, the address, go find it."
	or (string_id == "hud_e_welcome_jungle_stage1_mission3_hl" and sillyTrans == true) and "Guys, the escape, go to it."
	or (string_id == "hud_e_welcome_jungle_stage2_mission1_hl" and sillyTrans == true) and "Guys, the server room, go find it."
	or (string_id == "hud_e_welcome_jungle_stage2_mission2_hl" and sillyTrans == true) and "Guys, the security system, go override it."
	or (string_id == "hud_e_welcome_jungle_stage2_mission3_hl" and sillyTrans == true) and "Guys, the power, go restart it."
	or (string_id == "hud_e_welcome_jungle_stage2_mission4_hl" and sillyTrans == true) and "Guys, the engine, go figure it out."
	or (string_id == "hud_e_welcome_jungle_stage2_mission5_hl" and sillyTrans == true) and "Guys, the copter, go call it."
	or (string_id == "hud_e_welcome_jungle_stage2_mission6_hl" and sillyTrans == true) and "Guys, the engine, go take it to the copter."
	or (string_id == "hud_e_welcome_jungle_stage2_mission7_hl" and sillyTrans == true) and "Guys, the waiting game, go play it."
	or (string_id == "hud_e_welcome_jungle_stage2_mission8_hl" and sillyTrans == true) and "Guys, you fucked up, go retry it."
	or (string_id == "hud_e_welcome_jungle_stage2_mission9_hl" and sillyTrans == true) and "Guys, the lab door, go open it."
	or (string_id == "hud_e_welcome_jungle_stage2_mission11_hl" and sillyTrans == true) and "Guys, the copter, wait for it."
	
	--Election Day
	or (string_id == "hud_e_election_day_stage1new_mission1_hl" and sillyTrans == true) and "Guys, the docks, go enter them."
	or (string_id == "hud_e_election_day_stage1new_mission2_hl" and sillyTrans == true) and "Guys, the correct truck, go tag it."
	or (string_id == "hud_e_election_day_stage1new_mission3b_hl" and sillyTrans == true) and "Guys, the escape, go to it."
	or (string_id == "hud_e_election_day_stage1new_mission2b_hl" and sillyTrans == true) and "Guys, the shipping information, go upload it."
	or (string_id == "hud_e_election_day_stage2new_mission1_hl" and sillyTrans == true) and "Guys, the compound, go break into it."
	or (string_id == "hud_e_election_day_stage2new_mission2_hl" and sillyTrans == true) and "Guys, the voting machines, go hack them."
	or (string_id == "hud_e_election_day_stage2new_mission3_hl" and sillyTrans == true) and "Guys, the security footage, go steal it."
	or (string_id == "hud_e_election_day_stage2new_mission4_hl" and sillyTrans == true) and "Guys, the security footage, go take it."
	or (string_id == "hud_e_election_day_stage2new_mission6_hl" and sillyTrans == true) and "Guys, your bonus reward, go ignore it."
	or (string_id == "hud_e_election_day_stage3_mission1_hl" and sillyTrans == true) and "Guys, the polling place, go enter it."
	or (string_id == "hud_e_election_day_stage3_mission2_hl" and sillyTrans == true) and "Guys, the server, go scramble it."
	or (string_id == "hud_e_election_day_stage3_mission2b_hl" and sillyTrans == true) and "Guys, the data scrambler, go restart it."
	or (string_id == "hud_e_election_day_stage3_mission2c_hl" and sillyTrans == true) and "Guys, the data scrambler, wait for it."
	or (string_id == "hud_e_election_day_stage3_mission3_hl" and sillyTrans == true) and "Guys, the bank, go breach it."
	or (string_id == "hud_e_election_day_stage3_mission4_hl" and sillyTrans == true) and "Guys, the vault, go open it."
	or (string_id == "hud_e_election_day_stage3_mission5_hl" and sillyTrans == true) and "Guys, the money, go bag it."
	or (string_id == "hud_e_election_day_stage3_mission5alt_hl" and sillyTrans == true) and "Guys, the vault, go enter it."
	or (string_id == "hud_e_election_day_stage3_mission6_hl" and sillyTrans == true) and "Guys, the money, go secure it."
	or (string_id == "hud_e_election_day_stage3_mission8_hl" and sillyTrans == true) and "Guys, le thermal drill joke :^)"
	or (string_id == "hud_e_election_day_stage3_mission9_hl" and sillyTrans == true) and "Guys, le thermal drill joke :^)"
	
	or (string_id == "bm_melee_baseballbat" and fixedTrans == true) and "Disappointment Bat"
	or (string_id == "bm_msk_anonymous" and fixedTrans == true) and "le 4chan man"
	or (string_id == "bm_msk_skulloverkillplus" and sillyTrans == true) and "I cheat at video games"
	
	or (string_id == "cn_menu_downtown_title" and shortTrans == true) and ""
	or (string_id == "cn_menu_foggy_bottom_title" and shortTrans == true) and ""
	or (string_id == "cn_menu_georgetown_title" and shortTrans == true) and ""
	or (string_id == "cn_menu_shaw_title" and shortTrans == true) and ""
	or (string_id == "cn_menu_westend_title" and shortTrans == true) and ""
	
	or (string_id == "cn_menu_pro_job" and shortTrans == true) and "Pro"
	or (string_id == "cn_menu_community" and shortTrans == true) and "Group"
	or (string_id == "cn_menu_dlc" and shortTrans == true) and "DLC"
	
	or (string_id == "menu_l_global_value_infamous" and sillyTrans == true) and "You cheated for this!"
	or (string_id == "menu_success" and sillyTrans == true) and "You're winner!"
	or (string_id == "message_obtained_equipment" and sillyTrans == true) and "get equipped with:"
	or (string_id == "hud_carry_lance_bag" and sillyTrans == true) and "broke-dick piece-of-shit drill"
	
	--misc. gui shit
	or (string_id == "menu_visit_forum3" and sillyTrans == true) and "it's memeday fellas!"
	or (string_id == "menu_or_press_any_xbox_button" and shortTrans == true) and ""
	
	--if these aren't part of the script, they're going to spam the shit out of stringdump.txt, so let's fix that
	--some of them aren't possible to replace with this script unless we can figure out what variables these strings reference, such as player names
	--in theory you could probably fix this, but it isn't worth the time.
	or inTable(noExportTable, string_id) and pass_to_original(true, self, string_id, ...)
	
	--unknown strings
	or testAllStrings == 1 and string_id
	or testAllStrings == 2 and string_id .. ": " .. pass_to_original(false, self, string_id, ...)
	or pass_to_original(false, self, string_id, ...)
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
