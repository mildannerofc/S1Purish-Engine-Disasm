Sonic_JumpDash:
        tst.b    $29(a0)        ; was jumpdash flag set
        bne.w    JD_Move
        move.b    ($FFFFF603).w,d0    ; is ABC pressed? (part 1)
        andi.b    #$70,d0            ; is ABC pressed? (part 2)
        beq.w    JD_End            ; if not, branch
        tst.b    $2F(a0)        ; was jumpdash flag set
        bne.s    JD_End
        move.b    #1,$2F(a0)    ; if not, set jumpdash flag
        move.b    #$C,$29(a0)    ; if not, set jumpdash flag
        move.b    #$BC,d0            ; set jumpdash sound
        jsr    (PlaySound_Special).l    ; play jumpdash sound
        move.w    $10(a0),d0
        move.w    d0,($FFFFF63C).w
        btst    #0,$22(a0)        ; is sonic facing left?
        beq.s    JD_NoFlip        ; if yes, branch
        sub.w    #$600,d0
        bra.s    JD_Cont

JD_NoFlip:
        add.w    #$600,d0

JD_Cont:
        move.w    d0,$10(a0)

JD_Move:
        sub.b    #1,$29(a0)
        tst.b    $29(a0)
        beq.s    JD_Reset
        clr.w    $12(a0)            ; clear Sonic's Y-velocity to move sonic directly down

JD_End:
        rts                ; return

JD_Reset:
       tst.w   $10(a0)
       beq.s   JD_End
       blt.s   JD_Reset2
       tst.b   ($FFFFF63C).w
       bgt.s   JD_Reset3
       bra.s   JD_Reset4

JD_Reset2:
       tst.b   ($FFFFF63C).w
       blt.s   JD_Reset3

JD_Reset4:
       neg.w   ($FFFFF63C).w

JD_Reset3:
       move.w   ($FFFFF63C).w,$10(a0)
       rts
