;/ Decompiled by Champollion V1.0.1
Source   : portal2atronachForgeScript.psc
Modified : 2012-02-06 21:42:02
Compiled : 2012-02-07 11:55:54
User     : sawyer
Computer : SAWYER
/;
scriptName portal2atronachForgeScript extends ObjectReference
{modified version of original script}

;-- Properties --------------------------------------
bool property sigilStoneInstalled auto hidden
{has the sigil stone been installed?}
objectReference property summonFXpoint auto
{Where we place the summoning FX cloud}
formlist property ResultList auto
{Master list of recipe results.  Indices of Rewards MUST MATCH those of the recipe list}
formlist property spaceCoreResultList auto
{The Item(s) you can craft with space core.}
formlist property SigilRecipeList auto
{Recipes that are only available when sigil stone is installed}
formlist property spaceCoreRecipeList auto
{Recipe(s) are only available with Space Core}
formlist property RecipeList auto
{Master list of valid recipes. Most Complex should be first}
objectReference property lastSummonedObject auto hidden
activator property summonFX auto
{Point to a fake summoning cloud activator}
bool property spaceCoreInstalled auto hidden
{has the space core been installed?}
formlist property SigilResultList auto
{Items attainable only with sigil stone installed}
objectReference property DropBox auto
{where the player places items to be crafted}
objectReference property createPoint auto
{Marker where we place created items}

;-- Variables ---------------------------------------
; objectreference ::createPoint_var
; bool ::spaceCoreInstalled_var
; objectreference ::lastSummonedObject_var
; objectreference ::DropBox_var
; formlist ::spaceCoreRecipeList_var
; activator ::summonFX_var
; formlist ::SigilRecipeList_var
; formlist ::RecipeList_var
; bool ::sigilStoneInstalled_var
; formlist ::spaceCoreResultList_var
; formlist ::SigilResultList_var
; formlist ::ResultList_var
; objectreference ::summonFXpoint_var

;-- Functions ---------------------------------------

bool function scanSubList(formlist recipe)

	;int ::temp11
	;bool ::temp12
	;form ::temp13
	;bool ::temp14
	
	; 000 : callmethod getSize recipe ::temp11 
	; 001 : assign size ::temp11 
	int size = recipe.getSize()
	; 002 : assign cnt 0 
	int cnt = 0
	; 003 : cmp_lt ::temp12 cnt size 
	; 004 : jmpf ::temp12 015
	while cnt < size
		; 005 : callmethod getAt recipe ::temp13 cnt 
		; 006 : assign toCheck ::temp13 
		form toCheck = recipe.getAt(cnt)
		; 007 : callmethod getItemCount ::DropBox_var ::temp11 toCheck 
		; 008 : cmp_lt ::temp14 ::temp11 1 
		; 009 : jmpf ::temp14 012
		if DropBox.getItemCount(toCheck) < 1
			; 010 : return false 
			return false
		; 011 : jmp 012
		endIf
		; 012 : iadd ::temp11 cnt 1 
		; 013 : assign cnt ::temp11 
		cnt += 1
	; 014 : jmp 003
	endWhile
	; 015 : return true 
	return true
endFunction

function removeIngredients(formlist recipe)

	;int ::temp15
	;bool ::temp16
	;form ::temp17
	;NONE ::nonevar
	
	; 000 : callmethod getSize recipe ::temp15 
	; 001 : assign size ::temp15 
	int size = recipe.getSize()
	; 002 : assign cnt 0 
	int cnt = 0
	; 003 : cmp_lt ::temp16 cnt size 
	; 004 : jmpf ::temp16 011
	while cnt < size
		; 005 : callmethod getAt recipe ::temp17 cnt 
		; 006 : assign toCheck ::temp17 
		form toCheck = recipe.getAt(cnt)
		; 007 : callmethod removeItem ::DropBox_var ::nonevar toCheck 1 false none 
		DropBox.removeItem(toCheck, 1, false, none)
		; 008 : iadd ::temp15 cnt 1 
		; 009 : assign cnt ::temp15 
		cnt += 1
	; 010 : jmp 003
	endWhile
endFunction

; Skipped compiler generated GotoState

; Skipped compiler generated GetState

bool function ScanForRecipes(formlist Recipes, formlist Results)

	;int ::temp2
	;bool ::temp3
	;bool ::temp4
	;form ::temp5
	;formlist ::temp6
	;bool ::temp7
	;NONE ::nonevar
	;ObjectReference ::temp8
	;actor ::temp10
	;actor ::temp9
	
	; 000 : assign i 0 
	int i = 0
	; 001 : callmethod getSize Recipes ::temp2 
	; 002 : assign t ::temp2 
	int t = Recipes.getSize()
	; 003 : assign foundCombine false 
	bool foundCombine = false
	; 004 : assign checking true 
	bool checking = true
	; 005 : cmp_eq ::temp3 checking true 
	; 006 : cast ::temp3 ::temp3 
	; 007 : jmpf ::temp3 010
	; 008 : cmp_lt ::temp4 i t 
	; 009 : cast ::temp3 ::temp4 
	; 010 : jmpf ::temp3 031
	while checking == true && i < t
		; 011 : callmethod getAt Recipes ::temp5 i 
		; 012 : cast ::temp6 ::temp5 
		; 013 : assign currentRecipe ::temp6 
		formlist currentRecipe = Recipes.getAt(i) as formlist
		; 014 : cast ::temp6 none 
		; 015 : cmp_eq ::temp4 currentRecipe ::temp6 
		; 016 : jmpf ::temp4 018
		if currentRecipe == none
			
		; 017 : jmp 025
		; 018 : callmethod scanSubList self ::temp7 currentRecipe 
		; 019 : cmp_eq ::temp7 ::temp7 true 
		; 020 : jmpf ::temp7 025
		elseIf self.scanSubList(currentRecipe) == true
			; 021 : callmethod removeIngredients self ::nonevar currentRecipe 
			self.removeIngredients(currentRecipe)
			; 022 : assign foundCombine true 
			foundCombine = true
			; 023 : assign checking false 
			checking = false
		; 024 : jmp 025
		endIf
		; 025 : cmp_eq ::temp7 foundCombine false 
		; 026 : jmpf ::temp7 030
		if foundCombine == false
			; 027 : iadd ::temp2 i 1 
			; 028 : assign i ::temp2 
			i += 1
		; 029 : jmp 030
		endIf
	; 027 : iadd ::temp2 i 1 
	endWhile
	; 031 : cmp_eq ::temp4 foundCombine true 
	; 032 : jmpf ::temp4 060
	if foundCombine == true
		; 033 : cast ::temp5 ::summonFX_var 
		; 034 : callmethod placeatme ::summonFXpoint_var ::temp8 ::temp5 1 false false 
		summonFXpoint.placeatme(summonFX as form, 1, false, false)
		; 035 : callstatic utility wait ::nonevar 0.330000 
		utility.wait(0.330000)
		; 036 : callmethod getAt Results ::temp5 i 
		; 037 : callmethod placeatme ::createPoint_var ::temp8 ::temp5 1 false false 
		; 038 : assign newREF ::temp8 
		ObjectReference newREF = createPoint.placeatme(Results.getAt(i), 1, false, false)
		; 039 : jmpf ::lastSummonedObject_var 048
		if lastSummonedObject
			; 040 : cast ::temp9 ::lastSummonedObject_var 
			; 041 : callmethod isDead ::temp9 ::temp7 
			; 042 : jmpf ::temp7 047
			if (lastSummonedObject as actor).isDead()
				; 043 : callmethod RemoveAllItems ::lastSummonedObject_var ::nonevar ::DropBox_var false true 
				lastSummonedObject.RemoveAllItems(DropBox, false, true)
				; 044 : callmethod disable ::lastSummonedObject_var ::nonevar false 
				lastSummonedObject.disable(false)
				; 045 : callmethod delete ::lastSummonedObject_var ::nonevar 
				lastSummonedObject.delete()
			; 046 : jmp 047
			endIf
		; 043 : callmethod RemoveAllItems ::lastSummonedObject_var ::nonevar ::DropBox_var false true 
		endIf
		; 048 : assign ::lastSummonedObject_var newREF 
		lastSummonedObject = newREF
		; 049 : cast ::temp9 newREF 
		; 050 : cast ::temp10 none 
		; 051 : cmp_eq ::temp3 ::temp9 ::temp10 
		; 052 : not ::temp3 ::temp3 
		; 053 : jmpf ::temp3 058
		if newREF as actor != none
			; 054 : cast ::temp10 newREF 
			; 055 : callstatic game getPlayer ::temp9 
			; 056 : callmethod startCombat ::temp10 ::nonevar ::temp9 
			(newREF as actor).startCombat(game.getPlayer())
		; 057 : jmp 058
		endIf
		; 058 : return true 
		return true
	; 059 : jmp 061
	else
		; 060 : return false 
		return false
	endIf
endFunction

;-- State -------------------------------------------
state busy

	function onActivate(ObjectReference actronaut)

		; Empty function
	endFunction
endState

;-- State -------------------------------------------
auto state ready

	function onActivate(ObjectReference actronaut)

		;NONE ::nonevar
		;bool ::temp0
		;bool ::temp1
		
		bool DaedricItemCrafted
		; 000 : callmethod GotoState self ::nonevar "busy" 
		self.GotoState("busy")
		; 001 : jmpf ::spaceCoreInstalled_var 006
		if spaceCoreInstalled
			; 002 : callmethod ScanForRecipes self ::temp0 ::spaceCoreRecipeList_var ::spaceCoreResultList_var 
			; 003 : assign spaceCoreItemCrafted ::temp0 
			bool spaceCoreItemCrafted = self.ScanForRecipes(spaceCoreRecipeList, spaceCoreResultList)
			; 004 : callstatic utility wait ::nonevar 0.100000 
			utility.wait(0.100000)
		; 005 : jmp 006
		endIf
		; 006 : cmp_eq ::temp0 ::sigilStoneInstalled_var true 
		; 007 : jmpf ::temp0 012
		if sigilStoneInstalled == true
			; 008 : callmethod ScanForRecipes self ::temp1 ::SigilRecipeList_var ::SigilResultList_var 
			; 009 : assign DaedricItemCrafted ::temp1 
			DaedricItemCrafted = self.ScanForRecipes(SigilRecipeList, SigilResultList)
			; 010 : callstatic utility wait ::nonevar 0.100000 
			utility.wait(0.100000)
		; 011 : jmp 012
		endIf
		; 012 : cmp_eq ::temp1 ::sigilStoneInstalled_var false 
		; 013 : cast ::temp1 ::temp1 
		; 014 : jmpt ::temp1 017
		; 015 : cmp_eq ::temp0 DaedricItemCrafted false 
		; 016 : cast ::temp1 ::temp0 
		; 017 : jmpf ::temp1 020
		if sigilStoneInstalled == false || DaedricItemCrafted == false
			; 018 : callmethod ScanForRecipes self ::temp0 ::RecipeList_var ::ResultList_var 
			self.ScanForRecipes(RecipeList, ResultList)
		; 019 : jmp 020
		endIf
		; 020 : callmethod GotoState self ::nonevar "ready" 
		self.GotoState("ready")
	endFunction
endState
