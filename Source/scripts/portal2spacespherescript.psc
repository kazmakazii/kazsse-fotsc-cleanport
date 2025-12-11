;/ Decompiled by Champollion V1.0.1
Source   : Portal2SpaceSphereScript.psc
Modified : 2012-02-06 16:08:15
Compiled : 2012-02-07 11:56:08
User     : sawyer
Computer : SAWYER
/;
scriptName Portal2SpaceSphereScript extends ObjectReference
{basic behavior script for Space Core}

;-- Properties --------------------------------------
activator property portal2EscapeBurst auto
sound property Bark03 auto
objectReference property stateMarker auto
race property giantRace auto
sound property Bark05 auto
WordOfPower property portal2WordGO auto
quest property portal2quest auto
WordOfPower property Portal2WordTO auto
float property minPause = 2.50000 auto
float property maxPause = 7.00000 auto
WordOfPower property portal2WordSpace auto
MiscObject property Gold001 auto
sound property Bark02 auto
sound property Bark01 auto

;-- Variables ---------------------------------------
; activator ::portal2EscapeBurst_var
; wordofpower ::Portal2WordTO_var
bool loopOn = false
; miscobject ::Gold001_var
bool bTaughtShout = false
; wordofpower ::portal2WordGO_var
; float ::maxPause_var = 7.00000
; wordofpower ::portal2WordSpace_var
; sound ::Bark05_var
; float ::minPause_var = 2.50000
; sound ::Bark03_var
; sound ::Bark01_var
; race ::giantRace_var
; quest ::portal2quest_var
; sound ::Bark02_var
; objectreference ::stateMarker_var
bool chattering = false

;-- Functions ---------------------------------------

function OnActivate(ObjectReference akActionRef)

	;bool ::temp6
	
	; 000 : callmethod offendedChatter self ::temp6 ::Bark02_var akActionRef 
	self.offendedChatter(Bark02, akActionRef)
endFunction

function loopingChatter()

	;NONE ::nonevar
	;bool ::temp25
	;float ::temp26
	;bool ::temp27
	;ObjectReference ::temp28
	;bool ::temp29
	
	; 000 : assign loopOn true 
	loopOn = true
	; 001 : callstatic debug trace ::nonevar "Space core starting idle chatter" 0 
	debug.trace("Space core starting idle chatter", 0)
	; 002 : callmethod is3DLoaded self ::temp25 
	; 003 : jmpf ::temp25 017
	while self.is3DLoaded()
		; 004 : callstatic utility randomFloat ::temp26 ::minPause_var ::maxPause_var 
		; 005 : assign fpause ::temp26 
		float fpause = utility.randomFloat(minPause, maxPause)
		; 006 : not ::temp27 chattering 
		; 007 : jmpf ::temp27 014
		if !chattering
			; 008 : assign chattering true 
			chattering = true
			; 009 : cast ::temp28 self 
			; 010 : callmethod playAndWait ::Bark01_var ::temp29 ::temp28 
			Bark01.playAndWait(self as ObjectReference)
			; 011 : assign chattering false 
			chattering = false
			; 012 : callstatic utility wait ::nonevar fpause 
			utility.wait(fpause)
		; 013 : jmp 016
		else
			; 014 : callstatic debug trace ::nonevar "already chattering.  Hush!" 0 
			debug.trace("already chattering.  Hush!", 0)
			; 015 : callstatic utility wait ::nonevar fpause 
			utility.wait(fpause)
		endIf
	; 008 : assign chattering true 
	endWhile
	; 017 : assign loopOn false 
	loopOn = false
endFunction

function onCellLoad()

	;bool ::temp7
	;NONE ::nonevar
	
	; 000 : not ::temp7 loopOn 
	; 001 : jmpf ::temp7 004
	if !loopOn
		; 002 : callmethod loopingChatter self ::nonevar 
		self.loopingChatter()
	; 003 : jmp 004
	endIf
endFunction

function onGrab()

	;ObjectReference ::temp0
	;bool ::temp1
	
	; 000 : cast ::temp0 self 
	; 001 : callmethod offendedChatter self ::temp1 ::Bark02_var ::temp0 
	self.offendedChatter(Bark02, self as ObjectReference)
endFunction

; Skipped compiler generated GotoState

function onEquipped(actor akActor)

	;int ::temp2
	;bool ::temp3
	;bool ::temp4
	;ObjectReference ::temp5
	;NONE ::nonevar
	
	; 000 : callstatic utility randomInt ::temp2 0 10 
	; 001 : assign dice ::temp2 
	int dice = utility.randomInt(0, 10)
	; 002 : not ::temp3 bTaughtShout 
	; 003 : cast ::temp3 ::temp3 
	; 004 : jmpf ::temp3 007
	; 005 : cmp_eq ::temp4 dice 10 
	; 006 : cast ::temp3 ::temp4 
	; 007 : jmpf ::temp3 017
	if !bTaughtShout && dice == 10
		; 008 : assign chattering true 
		chattering = true
		; 009 : cast ::temp5 akActor 
		; 010 : callmethod playAndWait ::Bark05_var ::temp4 ::temp5 
		Bark05.playAndWait(akActor as ObjectReference)
		; 011 : callstatic game teachWord ::nonevar ::portal2WordGO_var 
		game.teachWord(portal2WordGO)
		; 012 : callstatic game teachWord ::nonevar ::Portal2WordTO_var 
		game.teachWord(Portal2WordTO)
		; 013 : callstatic game teachWord ::nonevar ::portal2WordSpace_var 
		game.teachWord(portal2WordSpace)
		; 014 : assign bTaughtShout true 
		bTaughtShout = true
		; 015 : assign chattering false 
		chattering = false
	; 016 : jmp 017
	endIf
	; 017 : callstatic utility randomInt ::temp2 0 10 
	; 018 : assign rand ::temp2 
	int rand = utility.randomInt(0, 10)
	; 019 : cmp_eq ::temp4 rand 0 
	; 020 : jmpf ::temp4 024
	if rand == 0
		; 021 : cast ::temp5 akActor 
		; 022 : callmethod offendedChatter self ::temp3 ::Bark02_var ::temp5 
		self.offendedChatter(Bark02, akActor as ObjectReference)
	; 023 : jmp 026
	else
		; 024 : cast ::temp5 akActor 
		; 025 : callmethod offendedChatter self ::temp3 ::Bark01_var ::temp5 
		self.offendedChatter(Bark01, akActor as ObjectReference)
	endIf
endFunction

bool function offendedChatter(sound bark, ObjectReference sfxSource)

	;NONE ::nonevar
	;bool ::temp30
	;bool ::temp31
	
	; 000 : callstatic debug trace ::nonevar "Space Sphere wants to complain" 0 
	debug.trace("Space Sphere wants to complain", 0)
	; 001 : not ::temp30 chattering 
	; 002 : jmpf ::temp30 008
	if !chattering
		; 003 : assign chattering true 
		chattering = true
		; 004 : callmethod playAndWait bark ::temp31 sfxSource 
		bark.playAndWait(sfxSource)
		; 005 : assign chattering false 
		chattering = false
		; 006 : return true 
		return true
	; 007 : jmp 010
	else
		; 008 : callstatic debug trace ::nonevar "Space Sphere was already busy talking, though" 0 
		debug.trace("Space Sphere was already busy talking, though", 0)
		; 009 : return false 
		return false
	endIf
endFunction

function onHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)

	;String ::temp12
	;String ::temp13
	;NONE ::nonevar
	;bool ::temp14
	;actor ::temp15
	;race ::temp16
	;bool ::temp17
	;int ::temp18
	;float ::temp19
	;float ::temp20
	;float ::temp21
	;Form ::temp22
	;ObjectReference ::temp23
	;bool ::temp24
	
	; 000 : cast ::temp12 akProjectile 
	; 001 : strcat ::temp12 "Ack!  Space core has been hit by a" ::temp12 
	; 002 : strcat ::temp12 ::temp12 " from " 
	; 003 : cast ::temp13 akSource 
	; 004 : strcat ::temp13 ::temp12 ::temp13 
	; 005 : strcat ::temp12 ::temp13 ".  " 
	; 006 : cast ::temp13 akAggressor 
	; 007 : strcat ::temp13 ::temp12 ::temp13 
	; 008 : strcat ::temp12 ::temp13 " ought to be ashamed." 
	; 009 : callstatic debug trace ::nonevar ::temp12 0 
	debug.trace("Ack!  Space core has been hit by a" + akProjectile as String + " from " + akSource as String + ".  " + akAggressor as String + " ought to be ashamed.", 0)
	; 010 : callmethod isInInterior self ::temp14 
	; 011 : not ::temp14 ::temp14 
	; 012 : cast ::temp14 ::temp14 
	; 013 : jmpf ::temp14 018
	; 014 : cast ::temp15 akAggressor 
	; 015 : callmethod getRace ::temp15 ::temp16 
	; 016 : cmp_eq ::temp17 ::temp16 ::giantRace_var 
	; 017 : cast ::temp14 ::temp17 
	; 018 : jmpf ::temp14 040
	if !self.isInInterior() && (akAggressor as actor).getRace() == giantRace
		; 019 : callstatic debug trace ::nonevar "Space core hit by a giant's power attack" 0 
		debug.trace("Space core hit by a giant's power attack", 0)
		; 020 : callmethod play ::Bark03_var ::temp18 akAggressor 
		Bark03.play(akAggressor)
		; 021 : propget z self ::temp19 
		; 022 : assign startZ ::temp19 
		float startZ = self.z
		; 023 : cast ::temp19 0 
		; 024 : cast ::temp20 0 
		; 025 : cast ::temp21 400 
		; 026 : callmethod applyHavokImpulse self ::nonevar ::temp19 ::temp20 1.00000 ::temp21 
		self.applyHavokImpulse(0 as float, 0 as float, 1.00000, 400 as float)
		; 027 : cast ::temp22 ::portal2EscapeBurst_var 
		; 028 : callmethod placeatMe self ::temp23 ::temp22 1 false false 
		self.placeatMe(portal2EscapeBurst as Form, 1, false, false)
		; 029 : callstatic utility wait ::nonevar 4.00000 
		utility.wait(4.00000)
		; 030 : propget z self ::temp19 
		; 031 : cast ::temp20 3000 
		; 032 : fadd ::temp21 startZ ::temp20 
		; 033 : comp_gte ::temp17 ::temp19 ::temp21 
		; 034 : jmpf ::temp17 039
		if self.z >= startZ + 3000 as float
			; 035 : callmethod disable self ::nonevar false 
			self.disable(false)
			; 036 : callmethod disable ::stateMarker_var ::nonevar false 
			stateMarker.disable(false)
			; 037 : callmethod setStage ::portal2quest_var ::temp24 100 
			portal2quest.setStage(100)
		; 038 : jmp 039
		endIf
	; 035 : callmethod disable self ::nonevar false 
	endIf
endFunction

; Skipped compiler generated GetState

function onLoad()

	;bool ::temp8
	;NONE ::nonevar
	
	; 000 : not ::temp8 loopOn 
	; 001 : jmpf ::temp8 004
	if !loopOn
		; 002 : callmethod loopingChatter self ::nonevar 
		self.loopingChatter()
	; 003 : jmp 004
	endIf
endFunction

function OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)

	;ObjectReference ::temp9
	;bool ::temp10
	;bool ::temp11
	;NONE ::nonevar
	
	; 000 : cast ::temp9 none 
	; 001 : cmp_eq ::temp10 akNewContainer ::temp9 
	; 002 : cast ::temp10 ::temp10 
	; 003 : jmpf ::temp10 006
	; 004 : not ::temp11 loopOn 
	; 005 : cast ::temp10 ::temp11 
	; 006 : jmpf ::temp10 009
	if akNewContainer == none && !loopOn
		; 007 : callmethod loopingChatter self ::nonevar 
		self.loopingChatter()
	; 008 : jmp 009
	endIf
endFunction
