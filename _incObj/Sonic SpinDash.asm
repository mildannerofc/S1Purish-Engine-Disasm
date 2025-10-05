; ---------------------------------------------------------------------------
; Subroutine to check for starting to charge a spindash
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||


Sonic_SpinDash:
		tst.b	spindash_flag(a0)
		bne.s	Sonic_UpdateSpindash
		cmpi.b	#id_Duck,obAnim(a0)
		bne.s	return_1AC8C
		move.b	(v_jpadpress2).w,d0
		andi.b	#btnB|btnC|btnA,d0
		beq.w	return_1AC8C
		move.b	#id_Roll,obAnim(a0)
		move.w	#sfx_Roll,d0
		jsr	(PlaySound_Special).l
		addq.l	#4,sp
		move.b	#1,spindash_flag(a0)
		move.w	#0,spindash_counter(a0)
		cmpi.b	#12,obSubtype(a0)	; if he's drowning, branch to not make dust
		blo.s	+
		move.b	#2,(v_spindust+obAnim).w
+
		bsr.w	Sonic_LevelBound
		bsr.w	Sonic_AnglePos

return_1AC8C:
		rts
; End of function Sonic_SpinDash


; ---------------------------------------------------------------------------
; Subroutine to update an already-charging spindash
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||


Sonic_UpdateSpindash:
		move.b	#id_Roll,obAnim(a0)
		move.b	(v_jpadhold2).w,d0 
		btst	#bitDn,d0
		bne.w	Sonic_ChargingSpindash

		; unleash the charged spindash and start rolling quickly:
		move.b	#$E,obHeight(a0)
		move.b	#7,obWidth(a0)
		move.b	#id_Roll,obAnim(a0)
		addq.w	#5,obY(a0)	; add the difference between Sonic's rolling and standing heights
		move.b	#0,spindash_flag(a0)
		moveq	#0,d0
		move.b	spindash_counter(a0),d0
		add.w	d0,d0
		move.w	SpindashSpeeds(pc,d0.w),obInertia(a0)

		; Determine how long to lag the camera for.
		; Notably, the faster Sonic goes, the less the camera lags.
		; This is seemingly to prevent Sonic from going off-screen.
		move.w	obInertia(a0),d0
		subi.w	#$800,d0 ; $800 is the lowest spin dash speed
		add.w	d0,d0
		andi.w	#$1F00,d0 ; This line is not necessary, as none of the removed bits are ever set in the first place
		neg.w	d0
		addi.w	#$2000,d0
		move.w	d0,($FFFFEED0).w

		btst	#0,obStatus(a0)
		beq.s	+
		neg.w	obInertia(a0)
+
		bset	#2,obStatus(a0)
		move.b	#0,(v_spindust+obAnim).w 
		move.w	#sfx_Teleport,d0	; spindash zoom sound
		jsr	(PlaySound_Special).l 
		bra.s	Sonic_Spindash_ResetScr
; ===========================================================================
SpindashSpeeds:
		dc.w  $800	; 0
		dc.w  $880	; 1
		dc.w  $900	; 2
		dc.w  $980	; 3
		dc.w  $A00	; 4
		dc.w  $A80	; 5
		dc.w  $B00	; 6
		dc.w  $B80	; 7
		dc.w  $C00	; 8
		dc.w  $C60	; 9
; ===========================================================================

Sonic_ChargingSpindash:			; If still charging the dash...
		tst.w	spindash_counter(a0)
		beq.s	+
		move.w	spindash_counter(a0),d0
		lsr.w	#5,d0
		sub.w	d0,spindash_counter(a0)
		bcc.s	+
		move.w	#0,spindash_counter(a0)
+
		move.b	(v_jpadpress2).w,d0 
		andi.b	#btnB|btnC|btnA,d0
		beq.w	Sonic_Spindash_ResetScr
		move.w	#(id_Roll<<8)|(id_Walk<<0),obAnim(a0)
		move.w	#sfx_Roll,d0
		jsr	(PlaySound_Special).l
		addi.w	#$200,spindash_counter(a0)
		cmpi.w	#$800,spindash_counter(a0)
		blo.s	Sonic_Spindash_ResetScr
		move.w	#$800,spindash_counter(a0)

Sonic_Spindash_ResetScr:
		addq.l	#4,sp
		cmpi.w	#(224/2)-16,($FFFFEED8).w
		beq.s	loc_1AD8C
		bhs.s	+
		addq.w	#4,($FFFFEED8).w
+		subq.w	#2,($FFFFEED8).w

loc_1AD8C:
		bsr.w	Sonic_LevelBound
		bsr.w	Sonic_AnglePos
		move.w	#$60,(v_lookshift).w
		rts
; End of function Sonic_UpdateSpindash