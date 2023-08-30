!classDefinition: #I category: 'Peano'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'Peano'!
I class
	instanceVariableNames: 'next previous'!

!I class methodsFor: 'as yet unclassified' stamp: 'manuel urko 8/25/2023 16:31:15'!
* aNaturalNumber
	^aNaturalNumber
	
	! !

!I class methodsFor: 'as yet unclassified' stamp: 'manuel urko 8/24/2023 21:34:35'!
+ aNaturalNumber
	^aNaturalNumber  next
	
	! !

!I class methodsFor: 'as yet unclassified' stamp: 'manuel urko 8/28/2023 21:44:08'!
- aNaturalNumber
	^self error: self descripcionDeErrorDeNumerosNegativosNoSoportados 
	
	! !

!I class methodsFor: 'as yet unclassified' stamp: 'manuel urko 8/30/2023 10:11:19'!
/ aNaturalNumber
	self = aNaturalNumber ifTrue: [^I].
	^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor 
	
	! !

!I class methodsFor: 'as yet unclassified' stamp: 'manuel urko 8/30/2023 10:26:48'!
< aNaturalNumber
	self = aNaturalNumber ifTrue: [^false].
	^true
	
	! !

!I class methodsFor: 'as yet unclassified' stamp: 'manuel urko 8/30/2023 10:05:05'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un numero mayor'
	
	! !

!I class methodsFor: 'as yet unclassified' stamp: 'manuel urko 8/28/2023 21:43:31'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'Resta de numeros negativos no soportados'
	
	! !

!I class methodsFor: 'as yet unclassified' stamp: 'manuel urko 8/24/2023 21:30:45'!
next
	next ifNotNil: [^next].
	next := self cloneNamed: self name, 'I'.
	next previous: self.
	^next.
	
	! !

!I class methodsFor: 'as yet unclassified' stamp: 'manuel urko 8/24/2023 21:31:34'!
previous
	^previous
	
	! !

!I class methodsFor: 'as yet unclassified' stamp: 'manuel urko 8/24/2023 21:31:24'!
previous: aNaturalNumber
	previous:=aNaturalNumber
	
	! !

!I class methodsFor: 'as yet unclassified' stamp: 'manuel urko 8/24/2023 21:57:06'!
restateA: unNumeroNatural
	^unNumeroNatural previous
	
	! !


!I class methodsFor: '--** private fileout/in **--' stamp: 'manuel urko 8/30/2023 10:42:04'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := II.
	previous := nil.! !


!classDefinition: #II category: 'Peano'!
I subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'Peano'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'as yet unclassified' stamp: 'manuel urko 8/28/2023 21:47:23'!
* aNaturalNumber
	^aNaturalNumber + (self previous * aNaturalNumber)! !

!II class methodsFor: 'as yet unclassified' stamp: 'manuel urko 8/24/2023 21:35:03'!
+ aNaturalNumber
	^self previous + aNaturalNumber next.
	
	! !

!II class methodsFor: 'as yet unclassified' stamp: 'manuel urko 8/28/2023 21:49:07'!
- aNaturalNumber
	^aNaturalNumber restateA: self! !

!II class methodsFor: 'as yet unclassified' stamp: 'manuel urko 8/30/2023 10:27:43'!
/ aNaturalNumber
	aNaturalNumber = self ifTrue: [^I].
	self < aNaturalNumber ifTrue: [^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor].
	^I + (self - aNaturalNumber / aNaturalNumber )! !

!II class methodsFor: 'as yet unclassified' stamp: 'manuel urko 8/30/2023 10:26:53'!
< aNaturalNumber
	self = aNaturalNumber ifTrue: [^false].
	^self previous < aNaturalNumber! !

!II class methodsFor: 'as yet unclassified' stamp: 'manuel urko 8/28/2023 21:49:43'!
next
	next ifNotNil: [^next].
	next := II createChildNamed: self name, 'I'.
	next previous: self.
	^next.
	
	! !

!II class methodsFor: 'as yet unclassified' stamp: 'manuel urko 8/24/2023 21:32:07'!
previous
	^previous
	
	! !

!II class methodsFor: 'as yet unclassified' stamp: 'manuel urko 8/24/2023 21:32:07'!
previous: aNaturalNumber
	previous:=aNaturalNumber
	
	! !

!II class methodsFor: 'as yet unclassified' stamp: 'manuel urko 8/28/2023 21:48:13'!
restateA: unNumeroNatural
	^unNumeroNatural previous - self previous.! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'manuel urko 8/30/2023 10:42:04'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.
	next := III.
	previous := I.! !


!classDefinition: #III category: 'Peano'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'Peano'!
III class
	instanceVariableNames: ''!

!III class methodsFor: '--** private fileout/in **--' stamp: 'manuel urko 8/30/2023 10:42:04'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.
	next := IIII.
	previous := II.! !


!classDefinition: #IIII category: 'Peano'!
II subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: 'Peano'!
IIII class
	instanceVariableNames: ''!

!IIII class methodsFor: '--** private fileout/in **--' stamp: 'manuel urko 8/30/2023 10:42:04'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := III.
	next := nil.
	previous := III.! !

I initializeAfterFileIn!
II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!