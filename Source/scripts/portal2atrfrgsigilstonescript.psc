;/ Decompiled by Champollion V1.0.1
Source   : portal2AtrFrgSigilStoneScript.psc
Modified : 2012-02-07 11:56:35
Compiled : 2012-02-07 11:56:37
User     : sawyer
Computer : SAWYER
/;
scriptName portal2AtrFrgSigilStoneScript extends ObjectReference
{Modified Version of original script.}

;-- Properties --------------------------------------
sound property Bark04 auto
miscObject property sigilStone auto
sound property Bark02 auto
objectReference property portal2SpaceCoreREF auto
message property defaultLackTheItemMSG auto
miscObject property Portal2SpaceCore auto
portal2AtronachForgeSCRIPT property Forge auto
objectReference property sigilStoneREF auto

;-- Variables ---------------------------------------
int SFXindex
; message ::defaultLackTheItemMSG_var
; miscobject ::sigilStone_var
; miscobject ::Portal2SpaceCore_var
; objectreference ::portal2SpaceCoreREF_var
; portal2atronachforgescript ::Forge_var
; sound ::Bark04_var
; sound ::Bark02_var
; objectreference ::sigilStoneREF_var

;-- Functions ---------------------------------------

function onActivate(ObjectReference actronaut)

	;bool ::temp0
	;bool ::temp1
	;form ::temp2
	;int ::temp3
	;bool ::temp4
	;bool ::temp5
	;NONE ::nonevar
	;actor ::temp6
	
	; 000 : propget sigilStoneInstalled ::Forge_var ::temp0 
	; 001 : cmp_eq ::temp0 ::temp0 false 
	; 002 : cast ::temp0 ::temp0 
	; 003 : jmpf ::temp0 007
	; 004 : propget spaceCoreInstalled ::Forge_var ::temp1 
	; 005 : cmp_eq ::temp1 ::temp1 false 
	; 006 : cast ::temp0 ::temp1 
	; 007 : jmpf ::temp0 048
	if Forge.sigilStoneInstalled == false && Forge.spaceCoreInstalled == false
		; 008 : cast ::temp2 ::sigilStone_var 
		; 009 : callmethod getItemCount actronaut ::temp3 ::temp2 
		; 010 : cmp_lt ::temp1 ::temp3 1 
		; 011 : cast ::temp1 ::temp1 
		; 012 : jmpf ::temp1 017
		; 013 : cast ::temp2 ::Portal2SpaceCore_var 
		; 014 : callmethod getItemCount actronaut ::temp3 ::temp2 
		; 015 : cmp_lt ::temp4 ::temp3 1 
		; 016 : cast ::temp1 ::temp4 
		; 017 : jmpf ::temp1 020
		if actronaut.getItemCount(sigilStone as form) < 1 && actronaut.getItemCount(Portal2SpaceCore as form) < 1
			; 018 : callmethod show ::defaultLackTheItemMSG_var ::temp3 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 
			defaultLackTheItemMSG.show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
		; 019 : jmp 047
		; 020 : cast ::temp2 ::sigilStone_var 
		; 021 : callmethod getItemCount actronaut ::temp3 ::temp2 
		; 022 : comp_gte ::temp4 ::temp3 1 
		; 023 : jmpf ::temp4 031
		elseIf actronaut.getItemCount(sigilStone as form) >= 1
			; 024 : assign ::temp5 true 
			; 025 : propset sigilStoneInstalled ::Forge_var ::temp5 
			Forge.sigilStoneInstalled = true
			; 026 : callmethod enable ::sigilStoneREF_var ::nonevar false 
			sigilStoneREF.enable(false)
			; 027 : cast ::temp6 actronaut 
			; 028 : cast ::temp2 ::sigilStone_var 
			; 029 : callmethod removeItem ::temp6 ::nonevar ::temp2 1 false none 
			(actronaut as actor).removeItem(sigilStone as form, 1, false, none)
		; 030 : jmp 047
		; 031 : cast ::temp2 ::Portal2SpaceCore_var 
		; 032 : callmethod getItemCount actronaut ::temp3 ::temp2 
		; 033 : comp_gte ::temp5 ::temp3 1 
		; 034 : jmpf ::temp5 047
		elseIf actronaut.getItemCount(Portal2SpaceCore as form) >= 1
			; 035 : assign ::temp4 true 
			; 036 : propset spaceCoreInstalled ::Forge_var ::temp4 
			Forge.spaceCoreInstalled = true
			; 037 : callmethod enable ::portal2SpaceCoreREF_var ::nonevar false 
			portal2SpaceCoreREF.enable(false)
			; 038 : jmpf SFXindex 041
			if SFXindex
				; 039 : callstatic sound stopInstance ::nonevar SFXindex 
				sound.stopInstance(SFXindex)
			; 040 : jmp 041
			endIf
			; 041 : callmethod play ::Bark04_var ::temp3 actronaut 
			; 042 : assign SFXindex ::temp3 
			SFXindex = Bark04.play(actronaut)
			; 043 : cast ::temp6 actronaut 
			; 044 : cast ::temp2 ::Portal2SpaceCore_var 
			; 045 : callmethod removeItem ::temp6 ::nonevar ::temp2 1 false none 
			(actronaut as actor).removeItem(Portal2SpaceCore as form, 1, false, none)
		; 046 : jmp 047
		endIf
	; 047 : jmp 073
	; 048 : propget sigilStoneInstalled ::Forge_var ::temp4 
	; 049 : cmp_eq ::temp5 ::temp4 true 
	; 050 : jmpf ::temp5 058
	elseIf Forge.sigilStoneInstalled == true
		; 051 : assign ::temp1 false 
		; 052 : propset sigilStoneInstalled ::Forge_var ::temp1 
		Forge.sigilStoneInstalled = false
		; 053 : callmethod disable ::sigilStoneREF_var ::nonevar false 
		sigilStoneREF.disable(false)
		; 054 : cast ::temp6 actronaut 
		; 055 : cast ::temp2 ::sigilStone_var 
		; 056 : callmethod addItem ::temp6 ::nonevar ::temp2 1 false 
		(actronaut as actor).addItem(sigilStone as form, 1, false)
	; 057 : jmp 073
	; 058 : propget spaceCoreInstalled ::Forge_var ::temp4 
	; 059 : cmp_eq ::temp1 ::temp4 true 
	; 060 : jmpf ::temp1 073
	elseIf Forge.spaceCoreInstalled == true
		; 061 : assign ::temp4 false 
		; 062 : propset spaceCoreInstalled ::Forge_var ::temp4 
		Forge.spaceCoreInstalled = false
		; 063 : callmethod disable ::portal2SpaceCoreREF_var ::nonevar false 
		portal2SpaceCoreREF.disable(false)
		; 064 : jmpf SFXindex 067
		if SFXindex
			; 065 : callstatic sound stopInstance ::nonevar SFXindex 
			sound.stopInstance(SFXindex)
		; 066 : jmp 067
		endIf
		; 067 : callmethod play ::Bark02_var ::temp3 actronaut 
		; 068 : assign SFXindex ::temp3 
		SFXindex = Bark02.play(actronaut)
		; 069 : cast ::temp6 actronaut 
		; 070 : cast ::temp2 ::Portal2SpaceCore_var 
		; 071 : callmethod addItem ::temp6 ::nonevar ::temp2 1 false 
		(actronaut as actor).addItem(Portal2SpaceCore as form, 1, false)
	; 072 : jmp 073
	endIf
endFunction

; Skipped compiler generated GotoState

; Skipped compiler generated GetState
