const_value = 1
	const TRADECENTER_CHRIS1
	const TRADECENTER_CHRIS2

TradeCenter_MapScriptHeader:

.MapTriggers: db 1
	maptrigger .Trigger0

.MapCallbacks: db 1
	dbw MAPCALLBACK_OBJECTS, TradeCenter_SetWhichChris

.Trigger0:
	priorityjump TradeCenter_Initialize
	end

TradeCenter_SetWhichChris:
	special Special_CableClubCheckWhichChris
	iffalse .Chris2
	disappear TRADECENTER_CHRIS2
	appear TRADECENTER_CHRIS1
	return

.Chris2:
	disappear TRADECENTER_CHRIS1
	appear TRADECENTER_CHRIS2
	return

TradeCenter_Initialize:
	dotrigger $1
	domaptrigger POKECENTER_2F, $1
	end

MapTradeCenterSignpost1Script:
	special Special_TradeCenter
	newloadmap MAPSETUP_LINKRETURN
	end

TradeCenter_MapEventHeader:

.Warps: db 2
	warp_def $7, $4, 2, POKECENTER_2F
	warp_def $7, $5, 2, POKECENTER_2F

.XYTriggers: db 0

.Signposts: db 2
	signpost 4, 4, SIGNPOST_RIGHT, MapTradeCenterSignpost1Script
	signpost 4, 5, SIGNPOST_LEFT, MapTradeCenterSignpost1Script

.PersonEvents: db 2
	person_event SPRITE_CHRIS, 4, 3, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ChrisScript_0x193499, EVENT_TEMPORARY_1
	person_event SPRITE_CHRIS, 4, 6, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ChrisScript_0x193499, EVENT_TEMPORARY_2
