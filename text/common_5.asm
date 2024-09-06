UnknownText_0x1c505e::
	text "Start!"
	done

UnknownText_0x1c5066::
	text "Not enough"
	line "coins."
	prompt

UnknownText_0x1c5079::
	text "Darn<...> Ran out of"
	line "coins<...>"
	done

UnknownText_0x1c5092::
	text "Play again?"
	done

UnknownText_0x1c509f::
	text "lined up!"
	line "Won @"
	text_from_ram StringBuffer2
	text " coins!"
	done

UnknownText_0x1c50bb::
	text "Darn!"
	done

UnknownText_0x1c55db::
	text "Select CONTINUE &"
	line "reset settings."
	prompt

UnknownText_0x1c561c::
	text "Reset the clock?"
	done

UnknownText_0x1c564a::
	text "Clear all save"
	line "data?"
	done

UnknownText_0x1c5660::
	text_from_ram wMonOrItemNameBuffer
	text " learned"
	line "@"
	text_from_ram StringBuffer2
	text "!@"
	sound_dex_fanfare_50_79
	text_waitbutton
	db "@@"

UnknownText_0x1c5678::
	text "Which move should"
	next "be forgotten?"
	done

UnknownText_0x1c5699::
	text "Stop learning"
	line "@"
	text_from_ram StringBuffer2
	text "?"
	done

UnknownText_0x1c56af::
	text_from_ram wMonOrItemNameBuffer
	text ""
	line "did not learn"
	cont "@"
	text_from_ram StringBuffer2
	text "."
	prompt

UnknownText_0x1c56c9::
	text_from_ram wMonOrItemNameBuffer
	text " is"
	line "trying to learn"
	cont "@"
	text_from_ram StringBuffer2
	text "."

	para "But @"
	text_from_ram wMonOrItemNameBuffer
	text ""
	line "can't learn more"
	cont "than four moves."

	para "Delete an older"
	line "move to make room"
	cont "for @"
	text_from_ram StringBuffer2
	text "?"
	done

UnknownText_0x1c5740::
	text "1, 2 and<...>@"
	interpret_data
	db "@@"

UnknownText_0x1c574e::
	text " Poof!@"
	interpret_data
	text ""
	para "@"
	text_from_ram wMonOrItemNameBuffer
	text " forgot"
	line "@"
	text_from_ram StringBuffer1
	text "."

	para "And<...>"
	prompt

UnknownText_0x1c5772::
	text "HM moves can't be"
	line "forgotten now."
	prompt

UnknownText_0x1c5793::
	text "Play with three"
	line "coins?"
	done

UnknownText_0x1c57ab::
	text "Not enough coins<...>"
	prompt

UnknownText_0x1c57be::
	text "Choose a card."
	done

UnknownText_0x1c57ce::
	text "Place your bet."
	done

UnknownText_0x1c57df::
	text "Want to play"
	line "again?"
	done

UnknownText_0x1c57f4::
	text "The cards have"
	line "been shuffled."
	prompt

UnknownText_0x1c5813::
	text "Yeah!"
	done

UnknownText_0x1c581a::
	text "Darn<...>"
	done

UnknownText_0x1c5aa6::
	text "Oh no! The #MON"
	line "broke free!"
	prompt

UnknownText_0x1c5ac3::
	text "Aww! It appeared"
	line "to be caught!"
	prompt

UnknownText_0x1c5ae3::
	text "Aargh!"
	line "Almost had it!"
	prompt

UnknownText_0x1c5afa::
	text "Shoot! It was so"
	line "close too!"
	prompt

UnknownText_0x1c5b17::
	text "Gotcha! @"
	text_from_ram EnemyMonNick
	text ""
	line "was caught!@"
	sound_caught_mon
	db "@@"

Text_Waitbutton_2::
	text_waitbutton
	db "@@"

UnknownText_0x1c5b38::
	text_from_ram wMonOrItemNameBuffer
	text " was"
	line "sent to BILL's PC."
	prompt

UnknownText_0x1c5b53::
	text_from_ram EnemyMonNick
	text "'s data"
	line "was newly added to"
	cont "the #DEX.@"
	sound_slot_machine_start
	text_waitbutton
	db "@@"

UnknownText_0x1c5b7f::
	text "Give a nickname to"
	line "@"
	text_from_ram StringBuffer1
	text "?"
	done

UnknownText_0x1c5b9a::
	text_from_ram StringBuffer1
	text "'s"
	line "@"
	text_from_ram StringBuffer2
	text " rose."
	prompt

UnknownText_0x1c5bac::
	text "That can't be used"
	line "on this #MON."
	prompt

Text_RepelUsedEarlierIsStillInEffect::
	text "The REPEL used"
	line "earlier is still"
	cont "in effect."
	prompt

UnknownText_0x1c5bf9::
	text "Played the #"
	line "FLUTE."

	para "Now, that's a"
	line "catchy tune!"
	prompt

UnknownText_0x1c5c28::
	text "All sleeping"
	line "#MON woke up."
	prompt

UnknownText_0x1c5c44::
	text "<PLAYER> played the"
	line "# FLUTE.@"
	text_waitbutton
	db "@@"

UnknownText_0x1c5c7b::
	text "Coins:"
	line "@"
	deciram Coins, 2, 4
	db "@@"

Text_TurnOffExpAll::
	text "The EXP.ALL was"
	line "turned off."
	done

Text_TurnOnExpAll::
	text "The EXP.ALL was"
	line "turned on!"

	para "The whole party"
	line "will gain EXP."
	done

Text_RaiseThePPOfWhichMove::
	text "Raise the PP of"
	line "which move?"
	done

Text_RestoreThePPOfWhichMove::
	text "Restore the PP of"
	line "which move?"
	done

Text_PPIsMaxedOut::
	text_from_ram StringBuffer2
	text "'s PP"
	line "is maxed out."
	prompt

Text_PPsIncreased::
	text_from_ram StringBuffer2
	text "'s PP"
	line "increased."
	prompt
	
Text_PPsMaximized::
	text_from_ram StringBuffer2
	text "'s PP"
	line "maximized."
	prompt

UnknownText_0x1c5cf1::
	text "PP was restored."
	prompt

UnknownText_0x1c5d3e::
	text "It looks bitter<...>"
	prompt

UnknownText_0x1c5d50::
	text "That can't be used"
	line "on an EGG."
	prompt

UnknownText_0x1c5d6e::
	text "OAK: <PLAYER>!"
	line "This isn't the"
	cont "time to use that!"
	prompt

UnknownText_0x1c5db6::
	text "It won't have any"
	line "effect."
	prompt

UnknownText_0x1c5dd0::
	text "The trainer"
	line "blocked the BALL!"
	prompt

UnknownText_0x1c5def::
	text "Don't be a thief!"
	prompt

UnknownText_0x1c5e3a::
	text "The #MON BOX"
	line "is full. That"
	cont "can't be used now."
	prompt

UnknownText_0x1c5e68::
	text "<PLAYER> used the@"
	text_low
	text_from_ram StringBuffer2
	text "."
	done

UnknownText_0x1c5ea8::
	text_from_ram StringBuffer1
	text " knows"
	line "@"
	text_from_ram StringBuffer2
	text "."
	prompt

UnknownText_0x1c5eba::
	text "That #MON knows"
	line "only one move."
	done

UnknownText_0x1c5eda::
	text "Oh, make it forget"
	line "@"
	text_from_ram StringBuffer1
	text "?"
	done

UnknownText_0x1c5ef5::
	text "Done! Your #MON"
	line "forgot the move."
	done

UnknownText_0x1c5f17::
	text "An EGG doesn't"
	line "know any moves!"
	done

UnknownText_0x1c5f36::
	text "No? Come visit me"
	line "again."
	done

UnknownText_0x1c5f50::
	text "Which move should"
	line "it forget, then?"
	prompt

UnknownText_0x1c5f74::
	text "Um<...> Oh, yes, I'm"
	line "the MOVE DELETER."

	para "I can make #MON"
	line "forget moves."

	para "Shall I make a"
	line "#MON forget?"
	done

UnknownText_0x1c5fd1::
	text "Which #MON?"
	prompt

Text_DSTIsThatOK::
	text " DST,"
	line "is that OK?"
	done

UnknownText_0x1c5ff1::
	text ","
	line "is that OK?"
	done
	
MoveReminderIntroText::
	text "Hi! I'm the"
	line "MOVE RELEARNER."

	para "I'll make your"
	line "#MON relearn"

	para "a move if you'll"
	line "trade me a"
	cont "HEART SCALE."
	done

MoveReminderPromptText::
	text "Do you want me to"
	line "teach one of your"
	cont "#MON a move?"
	done

MoveReminderWhichMonText::
	text "Which #MON"
	line "needs tutoring?"
	done

MoveReminderWhichMoveText::
	text "Which move should"
	line "it remember?"
	done

MoveReminderNoHeartScaleText::
	text "Huh? You don't"
	line "have any HEART"
	cont "SCALES."

	para "Sometimes you can"
	line "find them outside."
	done

MoveReminderEggText::
	text "Huh? That's just"
	line "an EGG."
	done

MoveReminderNoMonText::
	text "Huh? That's not"
	line "a #MON."
	done

MoveReminderNoMovesText::
	text "Sorry, There isn't"
	line "any move I can"

	para "make that #MON"
	line "remember."
	done

MoveReminderCancelText::
	text "If your #MON"
	line "needs to learn a"

	para "move, return with"
	line "a HEART SCALE."
	done

AlreadyHaveTMText::
	text "You already have"
	line "that TM."
	done
	
ShellBoxText::
	text "Shells:"
	line "@"
	deciram Shells, 2, 4
	db "@@"
