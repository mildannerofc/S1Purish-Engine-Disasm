Stage_5_8_Intro_Header:
	smpsHeaderStartSong 1
	smpsHeaderVoice     Stage_5_8_Intro_Voices
	smpsHeaderChan      $04, $01
	smpsHeaderTempo     $01, $09

	smpsHeaderDAC       Stage_5_8_Intro_DAC
	smpsHeaderFM        Stage_5_8_Intro_FM1,	$0C, $10
	smpsHeaderFM        Stage_5_8_Intro_FM2,	$0C, $10
	smpsHeaderFM        Stage_5_8_Intro_FM3,	$0C, $10
	smpsHeaderPSG       Stage_5_8_Intro_PSG1,	$23, $00, $00, $00

; FM1 Data
Stage_5_8_Intro_FM1:
	smpsSetvoice        $00
	smpsPan             panCenter, $00
	dc.b	nA1, $04, nRst, $08, nA1, $04, nRst, $08, nA2, $04, nRst, $10
	dc.b	nA2, $04, nA1, nRst, nA2, nA1, nRst, $08, nA2, $04, nRst, $08
	dc.b	nRst, nA1, $04
	smpsJump            Stage_5_8_Intro_FM1

; FM2 Data
Stage_5_8_Intro_FM2:
	smpsSetvoice        $00
	smpsPan             panRight, $00
	dc.b	nRst, $0C

Stage_5_8_Intro_Jump01:
	dc.b	nA1, $04, nRst, $08, nA1, $04, nRst, $08, nA2, $04, nRst, $10
	dc.b	nA2, $04, nA1, nRst, nA2, nA1, nRst, $08, nA2, $04, nRst, $08
	dc.b	nRst, nA1, $04
	smpsJump            Stage_5_8_Intro_Jump01

; FM3 Data
Stage_5_8_Intro_FM3:
	smpsSetvoice        $00
	smpsPan             panLeft, $00
	dc.b	nRst, $48

Stage_5_8_Intro_Jump00:
	dc.b	nA1, $04, nRst, $08, nA1, $04, nRst, $08, nA2, $04, nRst, $10
	dc.b	nA2, $04, nA1, nRst, nA2, nA1, nRst, $08, nA2, $04, nRst, $08
	dc.b	nRst, nA1, $04
	smpsJump            Stage_5_8_Intro_Jump00

; PSG1 Data
Stage_5_8_Intro_PSG1:
	smpsPSGform         $E7
	smpsPSGvoice        fTone_02

Stage_5_8_Intro_Jump02:
	dc.b	nAb6, $0C, $08, $04
	smpsJump            Stage_5_8_Intro_Jump02

; DAC Data
Stage_5_8_Intro_DAC:
	dc.b	dKick, $18, dSnare, $14, dKick, $0C, $10, dSnare, $14, dKick, $04, $18
	dc.b	dSnare, $14, dKick, $0C, dSnare, $04, dKick, $0C, dSnare, $14, $04
	smpsJump            Stage_5_8_Intro_DAC

Stage_5_8_Intro_Voices:
;	Voice $00
;	$28
;	$39, $35, $30, $31, 	$1F, $1F, $1F, $1F, 	$0C, $0A, $07, $0A
;	$07, $07, $07, $09, 	$27, $17, $17, $F7, 	$17, $32, $14, $7F
	smpsVcAlgorithm     $00
	smpsVcFeedback      $05
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $03, $03, $03
	smpsVcCoarseFreq    $01, $00, $05, $09
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0A, $07, $0A, $0C
	smpsVcDecayRate2    $09, $07, $07, $07
	smpsVcDecayLevel    $0F, $01, $01, $02
	smpsVcReleaseRate   $07, $07, $07, $07
	smpsVcTotalLevel    $7F, $14, $32, $17

