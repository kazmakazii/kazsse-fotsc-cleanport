;/ Decompiled by Champollion V1.0.1
Source   : portal2ControlScript.psc
Modified : 2012-02-07 11:59:44
Compiled : 2012-02-07 11:59:49
User     : sawyer
Computer : SAWYER
/;
scriptName portal2ControlScript extends ObjectReference
{basic control script for portal 2 event}

;-- Properties --------------------------------------
objectReference property portal2contrailSFXref auto
explosion property touchdownFX auto
objectReference property touchdownFX02 auto
objectReference property entrycontrail auto
objectReference property stateMarker auto
objectReference property touchdownFX01 auto
quest property portal2quest auto
ImageSpaceModifier property EntryFX auto
objectReference property spaceCoreRef auto

;-- Variables ---------------------------------------
bool bHasFired = false
; imagespacemodifier ::EntryFX_var
; objectreference ::touchdownFX01_var
bool bReadyToFire = false
; explosion ::touchdownFX_var
; quest ::portal2quest_var
; objectreference ::portal2contrailSFXref_var
; objectreference ::entrycontrail_var
; objectreference ::spaceCoreRef_var
; objectreference ::stateMarker_var
; objectreference ::touchdownFX02_var

;-- Functions ---------------------------------------

; Skipped compiler generated GotoState

; Skipped compiler generated GetState

;-- State -------------------------------------------
state finished
endState

;-- State -------------------------------------------
auto state waiting

	function onCellAttach()

		;actor ::temp0
		;ObjectReference ::temp1
		;float ::temp2
		;float ::temp3
		;bool ::temp4
		
		; 000 : callstatic game getPlayer ::temp0 
		; 001 : cast ::temp1 self 
		; 002 : callmethod getDistance ::temp0 ::temp2 ::temp1 
		; 003 : cast ::temp3 2048 
		; 004 : cmp_lt ::temp4 ::temp2 ::temp3 
		; 005 : jmpf ::temp4 008
		if game.getPlayer().getDistance(self as ObjectReference) < 2048 as float
			; 006 : assign bReadyToFire false 
			bReadyToFire = false
		; 007 : jmp 009
		else
			; 008 : assign bReadyToFire true 
			bReadyToFire = true
		endIf
	endFunction

	function onTriggerEnter(ObjectReference akActionRef)

		;None ::NoneVar
		;bool ::temp6
		;bool ::temp7
		;float ::temp8
		;form ::temp9
		;ObjectReference ::temp10
		
		; 000 : callstatic debug trace ::NoneVar "Player has entered Space Core entry trigger" 0 
		debug.trace("Player has entered Space Core entry trigger", 0)
		; 001 : cast ::temp6 bReadyToFire 
		; 002 : jmpf ::temp6 005
		; 003 : not ::temp6 bHasFired 
		; 004 : cast ::temp6 ::temp6 
		; 005 : cast ::temp6 ::temp6 
		; 006 : jmpf ::temp6 010
		; 007 : callmethod getStageDone ::portal2quest_var ::temp7 0 
		; 008 : cmp_eq ::temp7 ::temp7 false 
		; 009 : cast ::temp6 ::temp7 
		; 010 : jmpf ::temp6 034
		if bReadyToFire as bool && !bHasFired && portal2quest.getStageDone(0) == false
			; 011 : callstatic debug trace ::NoneVar "Space Core is primed to fire!" 0 
			debug.trace("Space Core is primed to fire!", 0)
			; 012 : callmethod setStage ::portal2quest_var ::temp7 0 
			portal2quest.setStage(0)
			; 013 : assign bHasFired true 
			bHasFired = true
			; 014 : callmethod enable ::entrycontrail_var ::NoneVar false 
			entrycontrail.enable(false)
			; 015 : callmethod enable ::portal2contrailSFXref_var ::NoneVar false 
			portal2contrailSFXref.enable(false)
			; 016 : cast ::temp8 4096 
			; 017 : callmethod rampRumble self ::temp7 0.250000 0.250000 ::temp8 
			self.rampRumble(0.250000, 0.250000, 4096 as float)
			; 018 : callstatic utility wait ::NoneVar 3.30000 
			utility.wait(3.30000)
			; 019 : cast ::temp9 ::touchdownFX_var 
			; 020 : callmethod placeaTMe ::spaceCoreRef_var ::temp10 ::temp9 1 false false 
			spaceCoreRef.placeaTMe(touchdownFX as form, 1, false, false)
			; 021 : cast ::temp8 4096 
			; 022 : callmethod rampRumble self ::temp7 0.750000 0.500000 ::temp8 
			self.rampRumble(0.750000, 0.500000, 4096 as float)
			; 023 : callmethod enable ::touchdownFX01_var ::NoneVar false 
			touchdownFX01.enable(false)
			; 024 : callmethod enable ::touchdownFX02_var ::NoneVar false 
			touchdownFX02.enable(false)
			; 025 : callmethod enable ::spaceCoreRef_var ::NoneVar false 
			spaceCoreRef.enable(false)
			; 026 : callmethod enable ::stateMarker_var ::NoneVar false 
			stateMarker.enable(false)
			; 027 : callmethod GotoState self ::NoneVar "Finished" 
			self.GotoState("Finished")
			; 028 : callstatic utility wait ::NoneVar 9.70000 
			utility.wait(9.70000)
			; 029 : callmethod disable ::portal2contrailSFXref_var ::NoneVar false 
			portal2contrailSFXref.disable(false)
			; 030 : callmethod disable ::touchdownFX01_var ::NoneVar false 
			touchdownFX01.disable(false)
			; 031 : callmethod disable ::touchdownFX02_var ::NoneVar false 
			touchdownFX02.disable(false)
			; 032 : callmethod disable ::entrycontrail_var ::NoneVar false 
			entrycontrail.disable(false)
		; 033 : jmp 034
		endIf
	endFunction

	function onTriggerLeave(ObjectReference akActionRef)

		;bool ::temp5
		
		; 000 : cmp_eq ::temp5 bReadyToFire false 
		; 001 : jmpf ::temp5 004
		if bReadyToFire == false
			; 002 : assign bReadyToFire true 
			bReadyToFire = true
		; 003 : jmp 004
		endIf
	endFunction
endState
