!classDefinition: #I category: 'Peano'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'Peano'!
I class
	instanceVariableNames: 'next'!

!I class methodsFor: 'as yet unclassified' stamp: 'MM 11/25/2021 14:18:16'!
aseSensitive: false]! !

!I class methodsFor: 'as yet unclassified'!
sing' stamp: 'MM 11/25/2021 14:18:16'! !

!I class methodsFor: 'as yet unclassified' stamp: 'len 1/9/2022 07:55:43'!
1 put: 16r21A0.		"SURJECTIVE ARROW"
	UnicodeCodePoints at: 16r9A+1 put: 16r21A3.		"INJECTIVE ARROW"
	UnicodeCodePoints at: 16r9B+1 put: 16r2194.		"BIJECTIVE ARROW"
	UnicodeCodePoints at: 16r9C+1 put: 16r21AA.		"INCLUSION ARROW"
	UnicodeCodePoints at: 16r9D+1 put: 16r21A6.		"MAPPING ARROW"
	UnicodeCodePoints at: 16r9E+1 put: 16r2202.		"partial differential"
	UnicodeCodePoints at: 16r9F+1 put: 16r221A.		"sqrt"! !

!I class methodsFor: 'as yet unclassified' stamp: 'jar 1/18/2022 18:57:25'!
t return (see Note 1 below)"
	unwindBottom _ (self findContextSuchThat: [:ctx | ctx selector = #cannotReturn:]) ifNil: [aContext].
	newTop _ aContext sender.
	"Insert ensure context under unwindBottom in self's stack (see Note 2 below)"
	unwindBottom insertSender: (self class contextEnsure: [here jump]).
	self jump.  "Control jumps to top (see Note 2 below)"
	"Control resumes here once the above inserted ensure block is executed"
	^newTop  "Return the new top context (see Note 3 below)"

	"Note 1: returning from #cannotReturn's sender would crash the VM so we install a guard ensure context right 
	above it and after returning here the unwind will continue safely. Try running and debugging this example 
	(avoid Proceeding the BCR error though; it may indeed crash the image):
	[[[] ensure: [^2]] ensure: [^42]] fork"

	"Note 2: the receiver is run by jumping directly to it (the active process abandons thisContext and executes 
	the receiver on its own stack; the receiver is its top context). However, before jumping to top we insert an ensure 
	block under unwindBottom context that will execute a jump back to thisContext when evaluated. The inserted 
	guard ensure context is removed once control jumps back to thisContext."

	"Note 3: it doesn't matter newTop is not a proper stack top context because #unwindTo will only use it as a starting 
	point in the search for the next unwind context and the computation will never return here. Cf. the pattern in 
	#runUntilErrorOrReturnFrom:: removing the inserted ensure context by stepping until popped when executing 
	non-local returns is not applicable here and would fail tests testTerminateInNestedEnsureWithReturn1 through 4."
! !

!I class methodsFor: 'as yet unclassified' stamp: 'len 8/20/2021 16:00:03'!
ifFalse: [result printTextLimitedTo: 10000].
			rpt _ rpt copyReplaceAll: Character lf asString with: Character lf asString, ' '.
			self afterSelectionInsertAndSelect: 
				((' ', rpt, ' ') initialFontFrom: emphasisHere)]
		ifFail: [ morph flash ]
		profiled: false.! !

!I class methodsFor: 'as yet unclassified'!
! !

!I class methodsFor: 'as yet unclassified' stamp: 'MM 11/25/2021 14:40:18'!
base allRegularDirectoriesDo: aBlock ]! !

!I class methodsFor: 'as yet unclassified'!
'! !


!I class methodsFor: '--** private fileout/in **--' stamp: 'yo 8/28/2023 21:44:52'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := II.! !


!classDefinition: #II category: 'Peano'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'Peano'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'as yet unclassified' stamp: 'HAW 1/4/2022 17:04:45'!
t put: aValue startpcsToBlockExtents: theContextsStartpcsToBlockExtents
	
	^self 
		privateTempAt: index 
		in: aContext 
		startpcsToBlockExtents: theContextsStartpcsToBlockExtents 
		ifXtraBindings: [ :xtraBinding | xtraBinding value: aValue ]
		ifNot: [ :ref | self privateDereference: ref in: aContext put: aValue ]
		! !

!II class methodsFor: 'as yet unclassified' stamp: 'MM 11/25/2021 13:43:45'!
model
	"Answer the value of model"

	^ model! !

!II class methodsFor: 'as yet unclassified' stamp: 'MM 11/25/2021 15:21:52'!
filterInput _ TextModelMorph textProvider: self textGetter: #filterString textSetter: #filterString:.
	filterInput acceptOnCR: true;
		askBeforeDiscardingEdits: false.
	actionsBar addMorph: filterInput layoutSpec: (LayoutSpec fixedHeight: 30).
	
	^ actionsBar! !

!II class methodsFor: 'as yet unclassified' stamp: 'len 8/20/2021 16:00:03'!
this description the new text selection."
	| rpt |
	self
		evaluateSelectionAndDo: [ :result |
			rpt _ model fullPrintIt
				ifTrue: [result printText]
				ifFalse: [result printTextLimitedTo: 10000].
			rpt _ rpt copyReplaceAll: Character lf asString with: Character lf asString, ' '.
			self afterSelectionInsertAndSelect: 
				((' ', rpt, ' ') initialFontFrom: emphasisHere)]
		ifFail: [ morph flash ]
		profiled: false.! !

!II class methodsFor: 'as yet unclassified' stamp: 'len 1/9/2022 07:55:43'!
"
	UnicodeCodePoints at: 16r9E+1 put: 16r2202.		"partial differential"
	UnicodeCodePoints at: 16r9F+1 put: 16r221A.		"sqrt"! !

!II class methodsFor: 'as yet unclassified' stamp: 'len 1/8/2022 10:53:19'!
elta $δ) (epsilon $ε) (lambda $λ) (mu $µ) (pi $π) (zeta $ζ) (Delta $Δ) (Gamma $Γ) (omega $ω) (N $ℕ) (Z $ℤ) (Q $ℚ) (R $ℝ) (C $ℂ) (P $ℙ) (infty $∞) (aleph $ℵ) (sqrt $√) (partial $∂) (deg $°))! !

!II class methodsFor: 'as yet unclassified'!
! !

!II class methodsFor: 'as yet unclassified'!
! !

!II class methodsFor: 'as yet unclassified'!
! !

!II class methodsFor: 'as yet unclassified' stamp: 'MM 11/25/2021 13:43:45'!
model: anObject
	"Set the value of model"

	model _ anObject! !

!II class methodsFor: 'as yet unclassified'!
PackageInstaller methodsFor: 'initialization' stamp: 'MM 11/25/2021 16:15:28' overrides: 16920235! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'yo 8/28/2023 21:44:52'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !


!classDefinition: #III category: 'Peano'!
DenotativeObject subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'Peano'!
III class
	instanceVariableNames: 'next previous'!

!III class methodsFor: 'as yet unclassified' stamp: 'jar 1/18/2022 18:57:25'!
ing to top we insert an ensure 
	block under unwindBottom context that will execute a jump back to thisContext when evaluated. The inserted 
	guard ensure context is removed once control jumps back to thisContext."

	"Note 3: it doesn't matter newTop is not a proper stack top context because #unwindTo will only use it as a starting 
	point in the search for the next unwind context and the computation will never return here. Cf. the pattern in 
	#runUntilErrorOrReturnFrom:: removing the inserted ensure context by stepping until popped when executing 
	non-local returns is not applicable here and would fail tests testTerminateInNestedEnsureWithReturn1 through 4."
! !

!III class methodsFor: 'as yet unclassified' stamp: 'jar 1/18/2022 18:57:25'!
xt is removed once control jumps back to thisContext."

	"Note 3: it doesn't matter newTop is not a proper stack top context because #unwindTo will only use it as a starting 
	point in the search for the next unwind context and the computation will never return here. Cf. the pattern in 
	#runUntilErrorOrReturnFrom:: removing the inserted ensure context by stepping until popped when executing 
	non-local returns is not applicable here and would fail tests testTerminateInNestedEnsureWithReturn1 through 4."
! !

!III class methodsFor: 'as yet unclassified' stamp: 'jar 1/18/2022 18:57:25'!
ause #unwindTo will only use it as a starting 
	point in the search for the next unwind context and the computation will never return here. Cf. the pattern in 
	#runUntilErrorOrReturnFrom:: removing the inserted ensure context by stepping until popped when executing 
	non-local returns is not applicable here and would fail tests testTerminateInNestedEnsureWithReturn1 through 4."
! !

!III class methodsFor: 'as yet unclassified' stamp: 'jar 1/18/2022 18:57:25'!
eturn here. Cf. the pattern in 
	#runUntilErrorOrReturnFrom:: removing the inserted ensure context by stepping until popped when executing 
	non-local returns is not applicable here and would fail tests testTerminateInNestedEnsureWithReturn1 through 4."
! !

!III class methodsFor: 'as yet unclassified' stamp: 'jar 1/18/2022 18:57:25'!
s not applicable here and would fail tests testTerminateInNestedEnsureWithReturn1 through 4."
! !

!III class methodsFor: 'as yet unclassified'!
/2022 18:55:12' prior: 16833502! !

!III class methodsFor: 'as yet unclassified' stamp: 'jar 1/18/2022 18:55:12'!
blocks, try to complete the outer-most one; all nested 
	unwind blocks will be completed in the process; see tests in UnwindTest, testTerminationDuringUnwind. 
	Note: Halfway-through blocks have already set the complete variable (tempAt: 2) in their defining
	#ensure:/#ifCurtailed contexts from nil to true; we'll search for the bottom-most one.
	Note: #findNextUnwindContextUpTo: starts searching from the receiver's sender so we must check 
	whether the receiver itself is an unwind context as well; see testTerminateEnsureAsStackTop."
	ctxt _ top _ self.
	ctxt isUnwindContext ifFalse: [ctxt _ ctxt findNextUnwindContextUpTo: aContext].
	[ctxt isNil] whileFalse: [
		(ctxt tempAt:2) ifNotNil: [
			outerMost _ ctxt].
		ctxt _ ctxt findNextUnwindContextUpTo: aContext].
	outerMost ifNotNil: [top _ (top runUntilReturnFrom: outerMost) sender].

	"By now no halfway-through unwind blocks are on the stack. Create a new top context for each 
	pending unwind block (tempAt: 1) and execute it on the unwind block's stack to execute non-local 
	returns correctly. Cf. the unwind pattern in #resume:through:. In #unwindTo, using #value instead of 
	#runUntilReturnFrom: would lead to an incorrect evaluation of non-local returns on the wrong stack. 
	Note: top points to the former outerMost sender now, i.e. to the next unexplored context."
	ctxt _ top.
	ctxt isUnwindContext ifFalse: [ctxt _ ctxt findNextUnwindContextUpTo: aContext].
	[ctxt isNil] whileFalse: [
		(ctxt tempAt: 2) ifNil: [
			ctxt tempAt: 2 put: true.
			top _ (ctxt tempAt: 1) asContextWithSender: ctxt.
			top runUntilReturnFrom: top].
		ctxt _ ctxt findNextUnwindContextUpTo: aContext]
! !

!III class methodsFor: 'as yet unclassified' stamp: 'jar 1/18/2022 18:55:12'!
t, testTerminationDuringUnwind. 
	Note: Halfway-through blocks have already set the complete variable (tempAt: 2) in their defining
	#ensure:/#ifCurtailed contexts from nil to true; we'll search for the bottom-most one.
	Note: #findNextUnwindContextUpTo: starts searching from the receiver's sender so we must check 
	whether the receiver itself is an unwind context as well; see testTerminateEnsureAsStackTop."
	ctxt _ top _ self.
	ctxt isUnwindContext ifFalse: [ctxt _ ctxt findNextUnwindContextUpTo: aContext].
	[ctxt isNil] whileFalse: [
		(ctxt tempAt:2) ifNotNil: [
			outerMost _ ctxt].
		ctxt _ ctxt findNextUnwindContextUpTo: aContext].
	outerMost ifNotNil: [top _ (top runUntilReturnFrom: outerMost) sender].

	"By now no halfway-through unwind blocks are on the stack. Create a new top context for each 
	pending unwind block (tempAt: 1) and execute it on the unwind block's stack to execute non-local 
	returns correctly. Cf. the unwind pattern in #resume:through:. In #unwindTo, using #value instead of 
	#runUntilReturnFrom: would lead to an incorrect evaluation of non-local returns on the wrong stack. 
	Note: top points to the former outerMost sender now, i.e. to the next unexplored context."
	ctxt _ top.
	ctxt isUnwindContext ifFalse: [ctxt _ ctxt findNextUnwindContextUpTo: aContext].
	[ctxt isNil] whileFalse: [
		(ctxt tempAt: 2) ifNil: [
			ctxt tempAt: 2 put: true.
			top _ (ctxt tempAt: 1) asContextWithSender: ctxt.
			top runUntilReturnFrom: top].
		ctxt _ ctxt findNextUnwindContextUpTo: aContext]
! !

!III class methodsFor: 'as yet unclassified' stamp: 'jar 1/18/2022 18:55:12'!
ch for the bottom-most one.
	Note: #findNextUnwindContextUpTo: starts searching from the receiver's sender so we must check 
	whether the receiver itself is an unwind context as well; see testTerminateEnsureAsStackTop."
	ctxt _ top _ self.
	ctxt isUnwindContext ifFalse: [ctxt _ ctxt findNextUnwindContextUpTo: aContext].
	[ctxt isNil] whileFalse: [
		(ctxt tempAt:2) ifNotNil: [
			outerMost _ ctxt].
		ctxt _ ctxt findNextUnwindContextUpTo: aContext].
	outerMost ifNotNil: [top _ (top runUntilReturnFrom: outerMost) sender].

	"By now no halfway-through unwind blocks are on the stack. Create a new top context for each 
	pending unwind block (tempAt: 1) and execute it on the unwind block's stack to execute non-local 
	returns correctly. Cf. the unwind pattern in #resume:through:. In #unwindTo, using #value instead of 
	#runUntilReturnFrom: would lead to an incorrect evaluation of non-local returns on the wrong stack. 
	Note: top points to the former outerMost sender now, i.e. to the next unexplored context."
	ctxt _ top.
	ctxt isUnwindContext ifFalse: [ctxt _ ctxt findNextUnwindContextUpTo: aContext].
	[ctxt isNil] whileFalse: [
		(ctxt tempAt: 2) ifNil: [
			ctxt tempAt: 2 put: true.
			top _ (ctxt tempAt: 1) asContextWithSender: ctxt.
			top runUntilReturnFrom: top].
		ctxt _ ctxt findNextUnwindContextUpTo: aContext]
! !

!III class methodsFor: 'as yet unclassified' stamp: 'jar 1/18/2022 18:55:12'!
ether the receiver itself is an unwind context as well; see testTerminateEnsureAsStackTop."
	ctxt _ top _ self.
	ctxt isUnwindContext ifFalse: [ctxt _ ctxt findNextUnwindContextUpTo: aContext].
	[ctxt isNil] whileFalse: [
		(ctxt tempAt:2) ifNotNil: [
			outerMost _ ctxt].
		ctxt _ ctxt findNextUnwindContextUpTo: aContext].
	outerMost ifNotNil: [top _ (top runUntilReturnFrom: outerMost) sender].

	"By now no halfway-through unwind blocks are on the stack. Create a new top context for each 
	pending unwind block (tempAt: 1) and execute it on the unwind block's stack to execute non-local 
	returns correctly. Cf. the unwind pattern in #resume:through:. In #unwindTo, using #value instead of 
	#runUntilReturnFrom: would lead to an incorrect evaluation of non-local returns on the wrong stack. 
	Note: top points to the former outerMost sender now, i.e. to the next unexplored context."
	ctxt _ top.
	ctxt isUnwindContext ifFalse: [ctxt _ ctxt findNextUnwindContextUpTo: aContext].
	[ctxt isNil] whileFalse: [
		(ctxt tempAt: 2) ifNil: [
			ctxt tempAt: 2 put: true.
			top _ (ctxt tempAt: 1) asContextWithSender: ctxt.
			top runUntilReturnFrom: top].
		ctxt _ ctxt findNextUnwindContextUpTo: aContext]
! !

!III class methodsFor: 'as yet unclassified' stamp: 'jar 1/18/2022 18:55:12'!
ntext ifFalse: [ctxt _ ctxt findNextUnwindContextUpTo: aContext].
	[ctxt isNil] whileFalse: [
		(ctxt tempAt:2) ifNotNil: [
			outerMost _ ctxt].
		ctxt _ ctxt findNextUnwindContextUpTo: aContext].
	outerMost ifNotNil: [top _ (top runUntilReturnFrom: outerMost) sender].

	"By now no halfway-through unwind blocks are on the stack. Create a new top context for each 
	pending unwind block (tempAt: 1) and execute it on the unwind block's stack to execute non-local 
	returns correctly. Cf. the unwind pattern in #resume:through:. In #unwindTo, using #value instead of 
	#runUntilReturnFrom: would lead to an incorrect evaluation of non-local returns on the wrong stack. 
	Note: top points to the former outerMost sender now, i.e. to the next unexplored context."
	ctxt _ top.
	ctxt isUnwindContext ifFalse: [ctxt _ ctxt findNextUnwindContextUpTo: aContext].
	[ctxt isNil] whileFalse: [
		(ctxt tempAt: 2) ifNil: [
			ctxt tempAt: 2 put: true.
			top _ (ctxt tempAt: 1) asContextWithSender: ctxt.
			top runUntilReturnFrom: top].
		ctxt _ ctxt findNextUnwindContextUpTo: aContext]
! !


!III class methodsFor: '--** private fileout/in **--' stamp: 'yo 8/28/2023 21:44:52'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !


!classDefinition: #IIII category: 'Peano'!
DenotativeObject subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: 'Peano'!
IIII class
	instanceVariableNames: 'next previous'!

!IIII class methodsFor: 'as yet unclassified' stamp: 'jar 1/18/2022 18:55:12'!
Note: top points to the former outerMost sender now, i.e. to the next unexplored context."
	ctxt _ top.
	ctxt isUnwindContext ifFalse: [ctxt _ ctxt findNextUnwindContextUpTo: aContext].
	[ctxt isNil] whileFalse: [
		(ctxt tempAt: 2) ifNil: [
			ctxt tempAt: 2 put: true.
			top _ (ctxt tempAt: 1) asContextWithSender: ctxt.
			top runUntilReturnFrom: top].
		ctxt _ ctxt findNextUnwindContextUpTo: aContext]
! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'jar 1/18/2022 18:55:12'!
ndContextUpTo: aContext].
	[ctxt isNil] whileFalse: [
		(ctxt tempAt: 2) ifNil: [
			ctxt tempAt: 2 put: true.
			top _ (ctxt tempAt: 1) asContextWithSender: ctxt.
			top runUntilReturnFrom: top].
		ctxt _ ctxt findNextUnwindContextUpTo: aContext]
! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'jar 1/18/2022 18:55:12'!
mpAt: 1) asContextWithSender: ctxt.
			top runUntilReturnFrom: top].
		ctxt _ ctxt findNextUnwindContextUpTo: aContext]
! !

!IIII class methodsFor: 'as yet unclassified'!
cess methodsFor: 'changing process state' stamp: 'jar 1/18/2022 19:30:02' prior: 16917643! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'jar 1/18/2022 19:30:02'!
er. Unwind to execute pending ensure: and
	 ifCurtailed: blocks before terminating; allow all unwind blocks to run; if they are currently in
	 progress, let them finish. If the process is in the middle of a #critical: section, release it properly."
	
	"If terminating the active process, create a parallel stack and run unwinds from there;
	 if terminating a suspended process, create a parallel stack for the process being terminated
	 and resume the suspended process to complete its termination from the parallel stack. Use
	 a priority higher than the active priority to make the process that invoked the termination
	 wait for its completion."

	"If terminating a suspended process (including runnable or blocked), always suspend the 
	 terminating process first so it doesn't accidentally get woken up. Equally important is the
	 side effect of the suspension; for pre-2022 VMs #suspend returns a list the process was
	 previously waiting on; figure out if we are terminating the process while waiting in
	 Semaphore>>critical:. In this case, pop the suspendedContext so that we leave the ensure:
	 block inside Semaphore>>critical: without signaling the semaphore.
	 Execute termination wrapped in #valueEnsured to ensure it completes even if the 
	 terminator process itself gets terminated before it's finished; see testTerminateInTerminate."

	| top |
	self isActiveProcess ifTrue: [
		top _ thisContext.
		^[top unwindTo: nil. self suspend] asContext jump].

	[	| oldList |
		suspendedContext isContext ifFalse: [^self].
		oldList _ self suspend.
		(oldList class == Semaphore and:[
			suspendedContext method == (Semaphore compiledMethodAt: #critical:)]) ifTrue: [
				suspendedContext _ suspendedContext home	].
		top _ suspendedContext.
		suspendedContext _ [top unwindTo: nil. self suspend] asContext.
		self priority: Processor activePriority + 1; resume
	] valueEnsured! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'jar 1/18/2022 19:30:02'!
m finish. If the process is in the middle of a #critical: section, release it properly."
	
	"If terminating the active process, create a parallel stack and run unwinds from there;
	 if terminating a suspended process, create a parallel stack for the process being terminated
	 and resume the suspended process to complete its termination from the parallel stack. Use
	 a priority higher than the active priority to make the process that invoked the termination
	 wait for its completion."

	"If terminating a suspended process (including runnable or blocked), always suspend the 
	 terminating process first so it doesn't accidentally get woken up. Equally important is the
	 side effect of the suspension; for pre-2022 VMs #suspend returns a list the process was
	 previously waiting on; figure out if we are terminating the process while waiting in
	 Semaphore>>critical:. In this case, pop the suspendedContext so that we leave the ensure:
	 block inside Semaphore>>critical: without signaling the semaphore.
	 Execute termination wrapped in #valueEnsured to ensure it completes even if the 
	 terminator process itself gets terminated before it's finished; see testTerminateInTerminate."

	| top |
	self isActiveProcess ifTrue: [
		top _ thisContext.
		^[top unwindTo: nil. self suspend] asContext jump].

	[	| oldList |
		suspendedContext isContext ifFalse: [^self].
		oldList _ self suspend.
		(oldList class == Semaphore and:[
			suspendedContext method == (Semaphore compiledMethodAt: #critical:)]) ifTrue: [
				suspendedContext _ suspendedContext home	].
		top _ suspendedContext.
		suspendedContext _ [top unwindTo: nil. self suspend] asContext.
		self priority: Processor activePriority + 1; resume
	] valueEnsured! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'jar 1/18/2022 19:30:02'!
s being terminated
	 and resume the suspended process to complete its termination from the parallel stack. Use
	 a priority higher than the active priority to make the process that invoked the termination
	 wait for its completion."

	"If terminating a suspended process (including runnable or blocked), always suspend the 
	 terminating process first so it doesn't accidentally get woken up. Equally important is the
	 side effect of the suspension; for pre-2022 VMs #suspend returns a list the process was
	 previously waiting on; figure out if we are terminating the process while waiting in
	 Semaphore>>critical:. In this case, pop the suspendedContext so that we leave the ensure:
	 block inside Semaphore>>critical: without signaling the semaphore.
	 Execute termination wrapped in #valueEnsured to ensure it completes even if the 
	 terminator process itself gets terminated before it's finished; see testTerminateInTerminate."

	| top |
	self isActiveProcess ifTrue: [
		top _ thisContext.
		^[top unwindTo: nil. self suspend] asContext jump].

	[	| oldList |
		suspendedContext isContext ifFalse: [^self].
		oldList _ self suspend.
		(oldList class == Semaphore and:[
			suspendedContext method == (Semaphore compiledMethodAt: #critical:)]) ifTrue: [
				suspendedContext _ suspendedContext home	].
		top _ suspendedContext.
		suspendedContext _ [top unwindTo: nil. self suspend] asContext.
		self priority: Processor activePriority + 1; resume
	] valueEnsured! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'jar 1/18/2022 19:30:02'!
er than the active priority to make the process that invoked the termination
	 wait for its completion."

	"If terminating a suspended process (including runnable or blocked), always suspend the 
	 terminating process first so it doesn't accidentally get woken up. Equally important is the
	 side effect of the suspension; for pre-2022 VMs #suspend returns a list the process was
	 previously waiting on; figure out if we are terminating the process while waiting in
	 Semaphore>>critical:. In this case, pop the suspendedContext so that we leave the ensure:
	 block inside Semaphore>>critical: without signaling the semaphore.
	 Execute termination wrapped in #valueEnsured to ensure it completes even if the 
	 terminator process itself gets terminated before it's finished; see testTerminateInTerminate."

	| top |
	self isActiveProcess ifTrue: [
		top _ thisContext.
		^[top unwindTo: nil. self suspend] asContext jump].

	[	| oldList |
		suspendedContext isContext ifFalse: [^self].
		oldList _ self suspend.
		(oldList class == Semaphore and:[
			suspendedContext method == (Semaphore compiledMethodAt: #critical:)]) ifTrue: [
				suspendedContext _ suspendedContext home	].
		top _ suspendedContext.
		suspendedContext _ [top unwindTo: nil. self suspend] asContext.
		self priority: Processor activePriority + 1; resume
	] valueEnsured! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'jar 1/18/2022 19:30:02'!
he 
	 terminating process first so it doesn't accidentally get woken up. Equally important is the
	 side effect of the suspension; for pre-2022 VMs #suspend returns a list the process was
	 previously waiting on; figure out if we are terminating the process while waiting in
	 Semaphore>>critical:. In this case, pop the suspendedContext so that we leave the ensure:
	 block inside Semaphore>>critical: without signaling the semaphore.
	 Execute termination wrapped in #valueEnsured to ensure it completes even if the 
	 terminator process itself gets terminated before it's finished; see testTerminateInTerminate."

	| top |
	self isActiveProcess ifTrue: [
		top _ thisContext.
		^[top unwindTo: nil. self suspend] asContext jump].

	[	| oldList |
		suspendedContext isContext ifFalse: [^self].
		oldList _ self suspend.
		(oldList class == Semaphore and:[
			suspendedContext method == (Semaphore compiledMethodAt: #critical:)]) ifTrue: [
				suspendedContext _ suspendedContext home	].
		top _ suspendedContext.
		suspendedContext _ [top unwindTo: nil. self suspend] asContext.
		self priority: Processor activePriority + 1; resume
	] valueEnsured! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'jar 1/18/2022 19:30:02'!
n; for pre-2022 VMs #suspend returns a list the process was
	 previously waiting on; figure out if we are terminating the process while waiting in
	 Semaphore>>critical:. In this case, pop the suspendedContext so that we leave the ensure:
	 block inside Semaphore>>critical: without signaling the semaphore.
	 Execute termination wrapped in #valueEnsured to ensure it completes even if the 
	 terminator process itself gets terminated before it's finished; see testTerminateInTerminate."

	| top |
	self isActiveProcess ifTrue: [
		top _ thisContext.
		^[top unwindTo: nil. self suspend] asContext jump].

	[	| oldList |
		suspendedContext isContext ifFalse: [^self].
		oldList _ self suspend.
		(oldList class == Semaphore and:[
			suspendedContext method == (Semaphore compiledMethodAt: #critical:)]) ifTrue: [
				suspendedContext _ suspendedContext home	].
		top _ suspendedContext.
		suspendedContext _ [top unwindTo: nil. self suspend] asContext.
		self priority: Processor activePriority + 1; resume
	] valueEnsured! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'jar 1/18/2022 19:30:02'!
s while waiting in
	 Semaphore>>critical:. In this case, pop the suspendedContext so that we leave the ensure:
	 block inside Semaphore>>critical: without signaling the semaphore.
	 Execute termination wrapped in #valueEnsured to ensure it completes even if the 
	 terminator process itself gets terminated before it's finished; see testTerminateInTerminate."

	| top |
	self isActiveProcess ifTrue: [
		top _ thisContext.
		^[top unwindTo: nil. self suspend] asContext jump].

	[	| oldList |
		suspendedContext isContext ifFalse: [^self].
		oldList _ self suspend.
		(oldList class == Semaphore and:[
			suspendedContext method == (Semaphore compiledMethodAt: #critical:)]) ifTrue: [
				suspendedContext _ suspendedContext home	].
		top _ suspendedContext.
		suspendedContext _ [top unwindTo: nil. self suspend] asContext.
		self priority: Processor activePriority + 1; resume
	] valueEnsured! !


!IIII class methodsFor: '--** private fileout/in **--' stamp: 'yo 8/28/2023 21:44:52'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIII.
	previous := III.! !


!classDefinition: #IIIII category: 'Peano'!
DenotativeObject subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIII class' category: 'Peano'!
IIIII class
	instanceVariableNames: 'next previous'!

!IIIII class methodsFor: 'as yet unclassified' stamp: 'jar 1/18/2022 19:30:02'!
op _ suspendedContext.
		suspendedContext _ [top unwindTo: nil. self suspend] asContext.
		self priority: Processor activePriority + 1; resume
	] valueEnsured! !

!IIIII class methodsFor: 'as yet unclassified'!
! !

!IIIII class methodsFor: 'as yet unclassified'!
.cs.st----! !

!IIIII class methodsFor: 'as yet unclassified'!
'jar 6/1/2021 11:57:00'! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'jar 6/1/2021 11:57:00'!
d: blocks before terminating.
	Process termination and exception handling in border cases has been the subject of a deep overhaul in the first months of 2021, by Jaromir Matas.
	See, for instance
		https://lists.cuis.st/mailman/archives/cuis-dev/2021-May/003171.html
		https://lists.cuis.st/mailman/archives/cuis-dev/2021-June/003187.html
	You can also look for other related mail threads in the Cuis mail list.
	Many new tests were added to BaseImageTests.pck.st
	Thank you Jaromir for this important contribution!!
	Note: This implementation was replaced by a new one, also from Jaromir, on January, 2022. This new implementation
	instead of using a separate process, use a separate, cloned stack, from the same process.
	We are keeping the 2021 approach, terminating from a new, forked process, in this method,
	just in case it proves useful too."

	| ctxt unwindBlock oldList outerMost top newTop |
	self isRunning ifTrue: [
		"If terminating the active process, suspend it first and terminate it as a suspended process."
		[self terminate] fork.
		^self suspend].

	[ "run the whole termination wrapped in #valueEnsured to ensure unwind is completed 	even if 
	the process terminating another process gets terminated - see #testTerminateInTerminate"
	"Always suspend the process first so it doesn't accidentally get woken up"
	oldList _ self suspend.
	suspendedContext ifNil: [^self]. "self is already terminated"
	"Figure out if we are terminating the process while waiting in Semaphore>>critical:
	In this case, pop the suspendedContext so that we leave the ensure: block inside
	Semaphore>>critical: without signaling the semaphore."
	(oldList class == Semaphore and:[
		suspendedContext method == (Semaphore compiledMethodAt: #critical:)]) ifTrue: [
			suspendedContext _ suspendedContext home.
	].

	top _ suspendedContext.
	suspendedContext _ nil. "disable this process while running its stack in active process below"
	"If terminating a process halfways through an unwind, try to complete that unwind block first;
	if there are multiple such nested unwind blocks, try to complete the outer-most one; nested 
	unwind blocks will be completed in the process. Halfway-through blocks have already set the 
	complete variable (tempAt: 2) in their defining #ensure:/#ifCurtailed contexts from nil to true.
	Note: #findNextUnwindContextUpTo: starts searching from the receiver's sender but the receiver 
	itself may be an unwind context."
	ctxt _ top.
	ctxt isUnwindContext ifFalse: [ctxt _ ctxt findNextUnwindContextUpTo: nil].
	[ctxt isNil] whileFalse: [
		(ctxt tempAt:2) ifNotNil: [
			outerMost _ ctxt].
		ctxt _ ctxt findNextUnwindContextUpTo: nil].
	outerMost ifNotNil: [newTop _ self complete: top to: outerMost].

	"By now no halfway-through unwind blocks are on the stack. Create a new top context for each 
	pending unwind block (tempAt: 1) and execute it on the unwind block's stack. 
	Note: using #value instead of #complete:to: would lead to incorrect evaluation of non-local returns.
	Note: newTop sender points to the former outerMost sender, i.e. the next unexplored context."
	ctxt _ newTop ifNil: [top] ifNotNil: [newTop sender].
	ctxt isUnwindContext ifFalse: [ctxt _ ctxt findNextUnwindContextUpTo: nil].
	[ctxt isNil] whileFalse: [
		(ctxt tempAt: 2) ifNil: [
			ctxt tempAt: 2 put: true.
			unwindBlock _ ctxt tempAt: 1.
			top _ unwindBlock asContextWithSender: ctxt.
			self complete: top to: top].
		ctxt _ ctxt findNextUnwindContextUpTo: nil]
	] valueEnsured! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'jar 6/1/2021 11:57:00'!
y Jaromir Matas.
	See, for instance
		https://lists.cuis.st/mailman/archives/cuis-dev/2021-May/003171.html
		https://lists.cuis.st/mailman/archives/cuis-dev/2021-June/003187.html
	You can also look for other related mail threads in the Cuis mail list.
	Many new tests were added to BaseImageTests.pck.st
	Thank you Jaromir for this important contribution!!
	Note: This implementation was replaced by a new one, also from Jaromir, on January, 2022. This new implementation
	instead of using a separate process, use a separate, cloned stack, from the same process.
	We are keeping the 2021 approach, terminating from a new, forked process, in this method,
	just in case it proves useful too."

	| ctxt unwindBlock oldList outerMost top newTop |
	self isRunning ifTrue: [
		"If terminating the active process, suspend it first and terminate it as a suspended process."
		[self terminate] fork.
		^self suspend].

	[ "run the whole termination wrapped in #valueEnsured to ensure unwind is completed 	even if 
	the process terminating another process gets terminated - see #testTerminateInTerminate"
	"Always suspend the process first so it doesn't accidentally get woken up"
	oldList _ self suspend.
	suspendedContext ifNil: [^self]. "self is already terminated"
	"Figure out if we are terminating the process while waiting in Semaphore>>critical:
	In this case, pop the suspendedContext so that we leave the ensure: block inside
	Semaphore>>critical: without signaling the semaphore."
	(oldList class == Semaphore and:[
		suspendedContext method == (Semaphore compiledMethodAt: #critical:)]) ifTrue: [
			suspendedContext _ suspendedContext home.
	].

	top _ suspendedContext.
	suspendedContext _ nil. "disable this process while running its stack in active process below"
	"If terminating a process halfways through an unwind, try to complete that unwind block first;
	if there are multiple such nested unwind blocks, try to complete the outer-most one; nested 
	unwind blocks will be completed in the process. Halfway-through blocks have already set the 
	complete variable (tempAt: 2) in their defining #ensure:/#ifCurtailed contexts from nil to true.
	Note: #findNextUnwindContextUpTo: starts searching from the receiver's sender but the receiver 
	itself may be an unwind context."
	ctxt _ top.
	ctxt isUnwindContext ifFalse: [ctxt _ ctxt findNextUnwindContextUpTo: nil].
	[ctxt isNil] whileFalse: [
		(ctxt tempAt:2) ifNotNil: [
			outerMost _ ctxt].
		ctxt _ ctxt findNextUnwindContextUpTo: nil].
	outerMost ifNotNil: [newTop _ self complete: top to: outerMost].

	"By now no halfway-through unwind blocks are on the stack. Create a new top context for each 
	pending unwind block (tempAt: 1) and execute it on the unwind block's stack. 
	Note: using #value instead of #complete:to: would lead to incorrect evaluation of non-local returns.
	Note: newTop sender points to the former outerMost sender, i.e. the next unexplored context."
	ctxt _ newTop ifNil: [top] ifNotNil: [newTop sender].
	ctxt isUnwindContext ifFalse: [ctxt _ ctxt findNextUnwindContextUpTo: nil].
	[ctxt isNil] whileFalse: [
		(ctxt tempAt: 2) ifNil: [
			ctxt tempAt: 2 put: true.
			unwindBlock _ ctxt tempAt: 1.
			top _ unwindBlock asContextWithSender: ctxt.
			self complete: top to: top].
		ctxt _ ctxt findNextUnwindContextUpTo: nil]
	] valueEnsured! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'jar 6/1/2021 11:57:00'!
y new tests were added to BaseImageTests.pck.st
	Thank you Jaromir for this important contribution!!
	Note: This implementation was replaced by a new one, also from Jaromir, on January, 2022. This new implementation
	instead of using a separate process, use a separate, cloned stack, from the same process.
	We are keeping the 2021 approach, terminating from a new, forked process, in this method,
	just in case it proves useful too."

	| ctxt unwindBlock oldList outerMost top newTop |
	self isRunning ifTrue: [
		"If terminating the active process, suspend it first and terminate it as a suspended process."
		[self terminate] fork.
		^self suspend].

	[ "run the whole termination wrapped in #valueEnsured to ensure unwind is completed 	even if 
	the process terminating another process gets terminated - see #testTerminateInTerminate"
	"Always suspend the process first so it doesn't accidentally get woken up"
	oldList _ self suspend.
	suspendedContext ifNil: [^self]. "self is already terminated"
	"Figure out if we are terminating the process while waiting in Semaphore>>critical:
	In this case, pop the suspendedContext so that we leave the ensure: block inside
	Semaphore>>critical: without signaling the semaphore."
	(oldList class == Semaphore and:[
		suspendedContext method == (Semaphore compiledMethodAt: #critical:)]) ifTrue: [
			suspendedContext _ suspendedContext home.
	].

	top _ suspendedContext.
	suspendedContext _ nil. "disable this process while running its stack in active process below"
	"If terminating a process halfways through an unwind, try to complete that unwind block first;
	if there are multiple such nested unwind blocks, try to complete the outer-most one; nested 
	unwind blocks will be completed in the process. Halfway-through blocks have already set the 
	complete variable (tempAt: 2) in their defining #ensure:/#ifCurtailed contexts from nil to true.
	Note: #findNextUnwindContextUpTo: starts searching from the receiver's sender but the receiver 
	itself may be an unwind context."
	ctxt _ top.
	ctxt isUnwindContext ifFalse: [ctxt _ ctxt findNextUnwindContextUpTo: nil].
	[ctxt isNil] whileFalse: [
		(ctxt tempAt:2) ifNotNil: [
			outerMost _ ctxt].
		ctxt _ ctxt findNextUnwindContextUpTo: nil].
	outerMost ifNotNil: [newTop _ self complete: top to: outerMost].

	"By now no halfway-through unwind blocks are on the stack. Create a new top context for each 
	pending unwind block (tempAt: 1) and execute it on the unwind block's stack. 
	Note: using #value instead of #complete:to: would lead to incorrect evaluation of non-local returns.
	Note: newTop sender points to the former outerMost sender, i.e. the next unexplored context."
	ctxt _ newTop ifNil: [top] ifNotNil: [newTop sender].
	ctxt isUnwindContext ifFalse: [ctxt _ ctxt findNextUnwindContextUpTo: nil].
	[ctxt isNil] whileFalse: [
		(ctxt tempAt: 2) ifNil: [
			ctxt tempAt: 2 put: true.
			unwindBlock _ ctxt tempAt: 1.
			top _ unwindBlock asContextWithSender: ctxt.
			self complete: top to: top].
		ctxt _ ctxt findNextUnwindContextUpTo: nil]
	] valueEnsured! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'jar 6/1/2021 11:57:00'!
was replaced by a new one, also from Jaromir, on January, 2022. This new implementation
	instead of using a separate process, use a separate, cloned stack, from the same process.
	We are keeping the 2021 approach, terminating from a new, forked process, in this method,
	just in case it proves useful too."

	| ctxt unwindBlock oldList outerMost top newTop |
	self isRunning ifTrue: [
		"If terminating the active process, suspend it first and terminate it as a suspended process."
		[self terminate] fork.
		^self suspend].

	[ "run the whole termination wrapped in #valueEnsured to ensure unwind is completed 	even if 
	the process terminating another process gets terminated - see #testTerminateInTerminate"
	"Always suspend the process first so it doesn't accidentally get woken up"
	oldList _ self suspend.
	suspendedContext ifNil: [^self]. "self is already terminated"
	"Figure out if we are terminating the process while waiting in Semaphore>>critical:
	In this case, pop the suspendedContext so that we leave the ensure: block inside
	Semaphore>>critical: without signaling the semaphore."
	(oldList class == Semaphore and:[
		suspendedContext method == (Semaphore compiledMethodAt: #critical:)]) ifTrue: [
			suspendedContext _ suspendedContext home.
	].

	top _ suspendedContext.
	suspendedContext _ nil. "disable this process while running its stack in active process below"
	"If terminating a process halfways through an unwind, try to complete that unwind block first;
	if there are multiple such nested unwind blocks, try to complete the outer-most one; nested 
	unwind blocks will be completed in the process. Halfway-through blocks have already set the 
	complete variable (tempAt: 2) in their defining #ensure:/#ifCurtailed contexts from nil to true.
	Note: #findNextUnwindContextUpTo: starts searching from the receiver's sender but the receiver 
	itself may be an unwind context."
	ctxt _ top.
	ctxt isUnwindContext ifFalse: [ctxt _ ctxt findNextUnwindContextUpTo: nil].
	[ctxt isNil] whileFalse: [
		(ctxt tempAt:2) ifNotNil: [
			outerMost _ ctxt].
		ctxt _ ctxt findNextUnwindContextUpTo: nil].
	outerMost ifNotNil: [newTop _ self complete: top to: outerMost].

	"By now no halfway-through unwind blocks are on the stack. Create a new top context for each 
	pending unwind block (tempAt: 1) and execute it on the unwind block's stack. 
	Note: using #value instead of #complete:to: would lead to incorrect evaluation of non-local returns.
	Note: newTop sender points to the former outerMost sender, i.e. the next unexplored context."
	ctxt _ newTop ifNil: [top] ifNotNil: [newTop sender].
	ctxt isUnwindContext ifFalse: [ctxt _ ctxt findNextUnwindContextUpTo: nil].
	[ctxt isNil] whileFalse: [
		(ctxt tempAt: 2) ifNil: [
			ctxt tempAt: 2 put: true.
			unwindBlock _ ctxt tempAt: 1.
			top _ unwindBlock asContextWithSender: ctxt.
			self complete: top to: top].
		ctxt _ ctxt findNextUnwindContextUpTo: nil]
	] valueEnsured! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'jar 6/1/2021 11:57:00'!
ng the 2021 approach, terminating from a new, forked process, in this method,
	just in case it proves useful too."

	| ctxt unwindBlock oldList outerMost top newTop |
	self isRunning ifTrue: [
		"If terminating the active process, suspend it first and terminate it as a suspended process."
		[self terminate] fork.
		^self suspend].

	[ "run the whole termination wrapped in #valueEnsured to ensure unwind is completed 	even if 
	the process terminating another process gets terminated - see #testTerminateInTerminate"
	"Always suspend the process first so it doesn't accidentally get woken up"
	oldList _ self suspend.
	suspendedContext ifNil: [^self]. "self is already terminated"
	"Figure out if we are terminating the process while waiting in Semaphore>>critical:
	In this case, pop the suspendedContext so that we leave the ensure: block inside
	Semaphore>>critical: without signaling the semaphore."
	(oldList class == Semaphore and:[
		suspendedContext method == (Semaphore compiledMethodAt: #critical:)]) ifTrue: [
			suspendedContext _ suspendedContext home.
	].

	top _ suspendedContext.
	suspendedContext _ nil. "disable this process while running its stack in active process below"
	"If terminating a process halfways through an unwind, try to complete that unwind block first;
	if there are multiple such nested unwind blocks, try to complete the outer-most one; nested 
	unwind blocks will be completed in the process. Halfway-through blocks have already set the 
	complete variable (tempAt: 2) in their defining #ensure:/#ifCurtailed contexts from nil to true.
	Note: #findNextUnwindContextUpTo: starts searching from the receiver's sender but the receiver 
	itself may be an unwind context."
	ctxt _ top.
	ctxt isUnwindContext ifFalse: [ctxt _ ctxt findNextUnwindContextUpTo: nil].
	[ctxt isNil] whileFalse: [
		(ctxt tempAt:2) ifNotNil: [
			outerMost _ ctxt].
		ctxt _ ctxt findNextUnwindContextUpTo: nil].
	outerMost ifNotNil: [newTop _ self complete: top to: outerMost].

	"By now no halfway-through unwind blocks are on the stack. Create a new top context for each 
	pending unwind block (tempAt: 1) and execute it on the unwind block's stack. 
	Note: using #value instead of #complete:to: would lead to incorrect evaluation of non-local returns.
	Note: newTop sender points to the former outerMost sender, i.e. the next unexplored context."
	ctxt _ newTop ifNil: [top] ifNotNil: [newTop sender].
	ctxt isUnwindContext ifFalse: [ctxt _ ctxt findNextUnwindContextUpTo: nil].
	[ctxt isNil] whileFalse: [
		(ctxt tempAt: 2) ifNil: [
			ctxt tempAt: 2 put: true.
			unwindBlock _ ctxt tempAt: 1.
			top _ unwindBlock asContextWithSender: ctxt.
			self complete: top to: top].
		ctxt _ ctxt findNextUnwindContextUpTo: nil]
	] valueEnsured! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'jar 6/1/2021 11:57:00'!
ndBlock oldList outerMost top newTop |
	self isRunning ifTrue: [
		"If terminating the active process, suspend it first and terminate it as a suspended process."
		[self terminate] fork.
		^self suspend].

	[ "run the whole termination wrapped in #valueEnsured to ensure unwind is completed 	even if 
	the process terminating another process gets terminated - see #testTerminateInTerminate"
	"Always suspend the process first so it doesn't accidentally get woken up"
	oldList _ self suspend.
	suspendedContext ifNil: [^self]. "self is already terminated"
	"Figure out if we are terminating the process while waiting in Semaphore>>critical:
	In this case, pop the suspendedContext so that we leave the ensure: block inside
	Semaphore>>critical: without signaling the semaphore."
	(oldList class == Semaphore and:[
		suspendedContext method == (Semaphore compiledMethodAt: #critical:)]) ifTrue: [
			suspendedContext _ suspendedContext home.
	].

	top _ suspendedContext.
	suspendedContext _ nil. "disable this process while running its stack in active process below"
	"If terminating a process halfways through an unwind, try to complete that unwind block first;
	if there are multiple such nested unwind blocks, try to complete the outer-most one; nested 
	unwind blocks will be completed in the process. Halfway-through blocks have already set the 
	complete variable (tempAt: 2) in their defining #ensure:/#ifCurtailed contexts from nil to true.
	Note: #findNextUnwindContextUpTo: starts searching from the receiver's sender but the receiver 
	itself may be an unwind context."
	ctxt _ top.
	ctxt isUnwindContext ifFalse: [ctxt _ ctxt findNextUnwindContextUpTo: nil].
	[ctxt isNil] whileFalse: [
		(ctxt tempAt:2) ifNotNil: [
			outerMost _ ctxt].
		ctxt _ ctxt findNextUnwindContextUpTo: nil].
	outerMost ifNotNil: [newTop _ self complete: top to: outerMost].

	"By now no halfway-through unwind blocks are on the stack. Create a new top context for each 
	pending unwind block (tempAt: 1) and execute it on the unwind block's stack. 
	Note: using #value instead of #complete:to: would lead to incorrect evaluation of non-local returns.
	Note: newTop sender points to the former outerMost sender, i.e. the next unexplored context."
	ctxt _ newTop ifNil: [top] ifNotNil: [newTop sender].
	ctxt isUnwindContext ifFalse: [ctxt _ ctxt findNextUnwindContextUpTo: nil].
	[ctxt isNil] whileFalse: [
		(ctxt tempAt: 2) ifNil: [
			ctxt tempAt: 2 put: true.
			unwindBlock _ ctxt tempAt: 1.
			top _ unwindBlock asContextWithSender: ctxt.
			self complete: top to: top].
		ctxt _ ctxt findNextUnwindContextUpTo: nil]
	] valueEnsured! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'jar 6/1/2021 11:57:00'!
inate it as a suspended process."
		[self terminate] fork.
		^self suspend].

	[ "run the whole termination wrapped in #valueEnsured to ensure unwind is completed 	even if 
	the process terminating another process gets terminated - see #testTerminateInTerminate"
	"Always suspend the process first so it doesn't accidentally get woken up"
	oldList _ self suspend.
	suspendedContext ifNil: [^self]. "self is already terminated"
	"Figure out if we are terminating the process while waiting in Semaphore>>critical:
	In this case, pop the suspendedContext so that we leave the ensure: block inside
	Semaphore>>critical: without signaling the semaphore."
	(oldList class == Semaphore and:[
		suspendedContext method == (Semaphore compiledMethodAt: #critical:)]) ifTrue: [
			suspendedContext _ suspendedContext home.
	].

	top _ suspendedContext.
	suspendedContext _ nil. "disable this process while running its stack in active process below"
	"If terminating a process halfways through an unwind, try to complete that unwind block first;
	if there are multiple such nested unwind blocks, try to complete the outer-most one; nested 
	unwind blocks will be completed in the process. Halfway-through blocks have already set the 
	complete variable (tempAt: 2) in their defining #ensure:/#ifCurtailed contexts from nil to true.
	Note: #findNextUnwindContextUpTo: starts searching from the receiver's sender but the receiver 
	itself may be an unwind context."
	ctxt _ top.
	ctxt isUnwindContext ifFalse: [ctxt _ ctxt findNextUnwindContextUpTo: nil].
	[ctxt isNil] whileFalse: [
		(ctxt tempAt:2) ifNotNil: [
			outerMost _ ctxt].
		ctxt _ ctxt findNextUnwindContextUpTo: nil].
	outerMost ifNotNil: [newTop _ self complete: top to: outerMost].

	"By now no halfway-through unwind blocks are on the stack. Create a new top context for each 
	pending unwind block (tempAt: 1) and execute it on the unwind block's stack. 
	Note: using #value instead of #complete:to: would lead to incorrect evaluation of non-local returns.
	Note: newTop sender points to the former outerMost sender, i.e. the next unexplored context."
	ctxt _ newTop ifNil: [top] ifNotNil: [newTop sender].
	ctxt isUnwindContext ifFalse: [ctxt _ ctxt findNextUnwindContextUpTo: nil].
	[ctxt isNil] whileFalse: [
		(ctxt tempAt: 2) ifNil: [
			ctxt tempAt: 2 put: true.
			unwindBlock _ ctxt tempAt: 1.
			top _ unwindBlock asContextWithSender: ctxt.
			self complete: top to: top].
		ctxt _ ctxt findNextUnwindContextUpTo: nil]
	] valueEnsured! !


!IIIII class methodsFor: '--** private fileout/in **--' stamp: 'yo 8/28/2023 21:44:52'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := IIII.! !

I initializeAfterFileIn!
II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!
IIIII initializeAfterFileIn!