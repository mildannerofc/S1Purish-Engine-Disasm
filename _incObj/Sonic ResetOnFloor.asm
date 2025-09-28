; ---------------------------------------------------------------------------
; Subroutine to	reset Sonic's mode when he lands on the floor
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Sonic_ResetOnFloor:
		btst	#4,obStatus(a0)
		beq.s	loc_137AE
		nop	
		nop	
		nop	

loc_137AE:
		bclr	#5,obStatus(a0)
		bclr	#1,obStatus(a0)
		bclr	#4,obStatus(a0)
		btst	#2,obStatus(a0)
		beq.s	loc_137E4
		bclr	#2,obStatus(a0)
		move.b	#$13,obHeight(a0)
		move.b	#9,obWidth(a0)
		move.b	#id_Walk,obAnim(a0) ; use running/walking animation
		subq.w	#5,obY(a0)

loc_137E4:
       move.b   #0,$3C(a0)
       move.w   #0,($FFFFF7D0).w
       move.b   #0,$2F(a0)   ; clear jumpdash flag
        tst.b    $29(a0)        ; was jumpdash flag set
        beq.s    locret_12232
        move.b    #0,$29(a0)    ; clear jumpdash flag
        bsr.w        JD_Reset
        move.w    $10(a0),$20(a0)

locret_12232:
        rts
; End of function Sonic_ResetOnFloor