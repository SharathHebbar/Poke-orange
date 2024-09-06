RTC:: ; 46f
; update time and time-sensitive palettes

; rtc enabled?
	ld a, [wSpriteUpdatesEnabled]
	and a
	ret z

	call UpdateTime

; obj update on?
	ld a, [VramState]
	bit 0, a ; obj update
	ret z

TimeOfDayPals:: ; 47e
	farcall _TimeOfDayPals
	ret
; 485

UpdateTimePals:: ; 485
	farcall _UpdateTimePals
	ret
; 48c
