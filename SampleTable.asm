
; ---------------------------------------------------------------
SampleTable:
	;			type			pointer		Hz
	dcSample	TYPE_DPCM, 		Kick, 		8000				; $81 - Kick
	dcSample	TYPE_PCM,		Snare,		24000				; $82 - Snare
	dcSample	TYPE_DPCM, 		Timpani, 	7250				; $83 - Timpani
	dcSample	TYPE_PCM,		Clap,		17000				; $84 - Clap
	dcSample	TYPE_PCM,		Cymbal,		16953				; $85 - Cymbal
	dcSample	TYPE_NONE										; $86 - PLACEHOLDER
	dcSample	TYPE_NONE										; $87 - PLACEHOLDER
	dcSample	TYPE_DPCM, 		Timpani, 	9750				; $88 - Hi-Timpani
	dcSample	TYPE_DPCM, 		Timpani, 	8750				; $89 - Mid-Timpani
	dcSample	TYPE_DPCM, 		Timpani, 	7150				; $8A - Low-Timpani
	dcSample	TYPE_DPCM, 		Timpani, 	7000				; $8B - Floor-Timpani
	dcSample	TYPE_PCM,		SegaPCM,	0, FLAGS_SFX		; $8C	NOTE: sample rate is auto-detected from WAV file
	dc.w	-1	; end marker

; ---------------------------------------------------------------
	incdac	Kick, "sound/dac/kick.dpcm"
	incdac	Snare, "sound/dac/snare.pcm"
	incdac	Timpani, "sound/dac/timpani.dpcm"
	incdac	Clap, "sound/dac/clap.wav"
	incdac	Cymbal, "sound/dac/cymbal.wav"
	incdac	SegaPCM, "sound/dac/sega.wav"
	even
