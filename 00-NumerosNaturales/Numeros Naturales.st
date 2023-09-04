!classDefinition: #I category: 'Numeros Naturales'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'Numeros Naturales'!
I class
	instanceVariableNames: 'next'!

!I class methodsFor: 'Operations' stamp: 'manuel urko 8/25/2023 16:31:15'!
* aNaturalNumber
	^aNaturalNumber
	
	! !

!I class methodsFor: 'Operations' stamp: 'manuel urko 8/24/2023 21:34:35'!
+ aNaturalNumber
	^aNaturalNumber  next
	
	! !

!I class methodsFor: 'Operations' stamp: 'manuel urko 8/28/2023 21:44:08'!
- aNaturalNumber
	^self error: self descripcionDeErrorDeNumerosNegativosNoSoportados 
	
	! !

!I class methodsFor: 'Operations' stamp: 'manuel urko 8/30/2023 10:11:19'!
/ aNaturalNumber
	self = aNaturalNumber ifTrue: [^I].
	^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor 
	
	! !

!I class methodsFor: 'Operations' stamp: 'manuel urko 8/30/2023 10:26:48'!
< aNaturalNumber
	self = aNaturalNumber ifTrue: [^false].
	^true
	
	! !

!I class methodsFor: 'Operations' stamp: 'h 9/3/2023 22:57:29'!
next
	^next.
	
	! !

!I class methodsFor: 'Operations' stamp: 'manuel urko 8/24/2023 21:57:06'!
restateA: unNumeroNatural
	^unNumeroNatural previous
	
	! !


!I class methodsFor: 'errorMessages' stamp: 'manuel urko 8/30/2023 10:05:05'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un numero mayor'
	
	! !

!I class methodsFor: 'errorMessages' stamp: 'manuel urko 8/28/2023 21:43:31'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'Resta de numeros negativos no soportados'
	
	! !


!I class methodsFor: '--** private fileout/in **--' stamp: 'h 9/3/2023 23:01:29'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := II.! !


!classDefinition: #II category: 'Numeros Naturales'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'Numeros Naturales'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'Operations' stamp: 'manuel urko 8/28/2023 21:47:23'!
* aNaturalNumber
	^aNaturalNumber + (self previous * aNaturalNumber)! !

!II class methodsFor: 'Operations' stamp: 'manuel urko 8/24/2023 21:35:03'!
+ aNaturalNumber
	^self previous + aNaturalNumber next.
	
	! !

!II class methodsFor: 'Operations' stamp: 'manuel urko 8/28/2023 21:49:07'!
- aNaturalNumber
	^aNaturalNumber restateA: self! !

!II class methodsFor: 'Operations' stamp: 'h 9/3/2023 22:57:01'!
/ aNaturalNumber

	self < aNaturalNumber ifTrue: [^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor].

	aNaturalNumber = self ifTrue: [^I].
	^I + (self - aNaturalNumber / aNaturalNumber )! !

!II class methodsFor: 'Operations' stamp: 'manuel urko 8/30/2023 10:26:53'!
< aNaturalNumber
	self = aNaturalNumber ifTrue: [^false].
	^self previous < aNaturalNumber! !

!II class methodsFor: 'Operations' stamp: 'manuel urko 8/28/2023 21:49:43'!
next
	next ifNotNil: [^next].
	next := II createChildNamed: self name, 'I'.
	next previous: self.
	^next.
	
	! !

!II class methodsFor: 'Operations' stamp: 'manuel urko 8/24/2023 21:32:07'!
previous
	^previous
	
	! !

!II class methodsFor: 'Operations' stamp: 'h 9/3/2023 22:55:50'!
restateA: unNumeroNatural
	^self previous restateA: unNumeroNatural previous.! !


!II class methodsFor: 'errorMessages' stamp: 'manuel urko 9/2/2023 18:39:32'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un numero mayor'
	
	! !

!II class methodsFor: 'errorMessages' stamp: 'manuel urko 9/2/2023 18:39:42'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'Resta de numeros negativos no soportados'
	
	! !


!II class methodsFor: 'initialization' stamp: 'manuel urko 8/24/2023 21:32:07'!
previous: aNaturalNumber
	previous:=aNaturalNumber
	
	! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'h 9/3/2023 23:01:30'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !


!classDefinition: #III category: 'Numeros Naturales'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'Numeros Naturales'!
III class
	instanceVariableNames: ''!

!III class methodsFor: '--** private fileout/in **--' stamp: 'h 9/3/2023 23:01:30'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !


!classDefinition: #IIII category: 'Numeros Naturales'!
II subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: 'Numeros Naturales'!
IIII class
	instanceVariableNames: ''!

!IIII class methodsFor: '--** private fileout/in **--' stamp: 'h 9/3/2023 23:01:30'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := III.! !

I initializeAfterFileIn!
II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!