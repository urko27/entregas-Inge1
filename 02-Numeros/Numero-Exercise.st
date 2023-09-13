!classDefinition: #NumeroTest category: 'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:11'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:12'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:18'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:20'!
test07EnteroDividesEnteroCorrectly

	self assert: two / two equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:38'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:52'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:56'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: oneHalf / oneFifth equals: fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: one + oneFifth equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test12FraccionAddsEnteroCorrectly

	self assert: oneFifth + one equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:50'!
test13EnteroMultipliesFraccionCorrectly

	self assert: two * oneFifth equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:52'!
test14FraccionMultipliesEnteroCorrectly

	self assert: oneFifth * two equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:57'!
test15EnteroDividesFraccionCorrectly

	self assert: one / twoFifth equals: fiveHalfs  ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:59'!
test16FraccionDividesEnteroCorrectly

	self assert: twoFifth / five equals: twoTwentyfifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:40'!
test19AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: (two/five) * (five/two) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test21DividingFraccionesCanReturnAnEntero

	self assert: oneHalf / oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:43'!
test22DividingEnterosCanReturnAFraccion

	self assert: two / four equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 4/15/2021 16:45:35'!
test27EnteroSubstractsEnteroCorrectly

	self assert: four - one equals: three! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:41'!
test28FraccionSubstractsFraccionCorrectly
	
	self assert: twoFifth - oneFifth equals: oneFifth.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:00'!
test29EnteroSubstractsFraccionCorrectly

	self assert: one - oneHalf equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:05'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |
	
	sixFifth := (Entero with: 6) / (Entero with: 5).
	
	self assert: sixFifth - one equals: oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:08'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |
	
	threeHalfs := (Entero with: 3) / (Entero with: 2).
	
	self assert: threeHalfs - oneHalf equals: one.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:48'!
test32SubstractingSameEnterosReturnsZero

	self assert: one - one equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:01'!
test33SubstractingSameFraccionesReturnsZero

	self assert: oneHalf - oneHalf equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:14'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |
	
	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	

	self assert: one - fiveHalfs equals: negativeThreeHalfs.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:23'!
test35FibonacciZeroIsOne

	self assert: zero fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:32'!
test36FibonacciOneIsOne

	self assert: one fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:39'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: four fibonacci equals: five.
	self assert: three fibonacci equals: three. 
	self assert: five fibonacci equals: four fibonacci + three fibonacci.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:47'!
test38FibonacciNotDefinedForNegativeNumbers

	self 
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Entero negativeFibonacciErrorDescription ].! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:55'!
test39NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.
		! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:03'!
test40NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOne / two.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:17'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/23/2018 23:46:28'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #Numero category: 'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 22:21:28'!
- aSubtrahend

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'h 9/12/2023 00:18:58'!
addToFraction: firstAdder
	self subclassResponsibility! !

!Numero methodsFor: 'arithmetic operations' stamp: 'h 9/12/2023 00:18:54'!
addToInteger: firstAdder
	self subclassResponsibility! !

!Numero methodsFor: 'arithmetic operations' stamp: 'h 9/12/2023 00:19:34'!
divideFraction: fractionToDivide 
	self subclassResponsibility! !

!Numero methodsFor: 'arithmetic operations' stamp: 'h 9/12/2023 00:19:24'!
divideInteger: integerToDivide 
	self subclassResponsibility! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !

!Numero methodsFor: 'arithmetic operations' stamp: 'h 9/12/2023 00:19:11'!
multiplyByFraction: firstFactor
	self subclassResponsibility! !

!Numero methodsFor: 'arithmetic operations' stamp: 'h 9/12/2023 00:19:04'!
multiplyByInteger: firstFactor
	self subclassResponsibility! !

!Numero methodsFor: 'arithmetic operations' stamp: 'manuel urko 9/13/2023 11:01:05'!
negated
	
	^self * (Entero with: -1)! !

!Numero methodsFor: 'arithmetic operations' stamp: 'h 9/12/2023 00:18:45'!
substractToFraction: firstSubtrahend

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'h 9/12/2023 00:18:49'!
substractToInteger: firstSubtrahend

	self subclassResponsibility ! !


!Numero methodsFor: 'testing' stamp: 'NR 9/23/2018 23:36:49'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:02'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero!!!!!!'! !

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:09'!
invalidNumberTypeErrorDescription
	
	^ 'Tipo de número inválido!!!!!!'! !


!classDefinition: #Entero category: 'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'arithmetic operations' stamp: 'h 9/12/2023 00:15:34'!
* aMultiplier 
	
	^aMultiplier multiplyByInteger: self
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'h 9/12/2023 00:12:50'!
+ anAdder 

	^anAdder addToInteger: self.
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'h 9/12/2023 00:14:08'!
- aSubtrahend 
	^ aSubtrahend substractToInteger: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'h 9/12/2023 00:16:50'!
/ aDivisor 
	^aDivisor divideInteger: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 21:55'!
// aDivisor 
	
	^self class with: value // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'h 9/12/2023 00:12:34'!
addToFraction: firstAdder 

	^firstAdder numerator + (firstAdder denominator * self) / firstAdder denominator
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'manuel urko 9/12/2023 22:10:46'!
addToInteger: firstAdder 

	 ^self class with: value + firstAdder integerValue
	
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'h 9/12/2023 00:16:38'!
divideFraction: fractionToDivide
	^fractionToDivide numerator / (fractionToDivide denominator * self)! !

!Entero methodsFor: 'arithmetic operations' stamp: 'h 9/12/2023 00:16:31'!
divideInteger: integerToDivide 
	^Fraccion with: integerToDivide over: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'manuel urko 9/13/2023 10:53:05'!
fibonacci
	self subclassResponsibility .! !

!Entero methodsFor: 'arithmetic operations' stamp: 'manuel urko 9/12/2023 22:10:36'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: (value gcd: anEntero integerValue)! !

!Entero methodsFor: 'arithmetic operations' stamp: 'h 9/13/2023 13:57:49'!
multiplyByFraction: firstFractionFactor
	
	^self * firstFractionFactor numerator / firstFractionFactor denominator
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'h 9/13/2023 13:58:49'!
multiplyByInteger: firstIntegerFactor
	
	^self class with: value * firstIntegerFactor integerValue
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'h 9/12/2023 00:13:53'!
substractToFraction: firstSubtrahend 
	^firstSubtrahend numerator - (self * firstSubtrahend denominator) / firstSubtrahend denominator 
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'manuel urko 9/13/2023 11:02:37'!
substractToInteger: firstSubtrahend 

	^ self class with: firstSubtrahend integerValue - value.! !


!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 21:01'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:17'!
hash

	^value hash! !


!Entero methodsFor: 'initialization' stamp: 'manuel urko 9/12/2023 20:14:18'!
initializeWith: aValue.
	value := aValue! !

!Entero methodsFor: 'initialization' stamp: 'manuel urko 9/12/2023 20:07:31'!
test
	^value! !

!Entero methodsFor: 'initialization' stamp: 'manuel urko 9/12/2023 20:09:41'!
test: aValue
	value := aValue! !


!Entero methodsFor: 'value' stamp: 'HernanWilkinson 5/7/2016 21:02'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !


!Entero methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:53:19'!
printOn: aStream

	aStream print: value ! !


!Entero methodsFor: 'testing' stamp: 'h 9/13/2023 13:15:52'!
isNegative
	
	^self subclassResponsibility! !

!Entero methodsFor: 'testing' stamp: 'h 9/13/2023 13:15:56'!
isOne
	
	^self subclassResponsibility! !

!Entero methodsFor: 'testing' stamp: 'h 9/13/2023 13:16:00'!
isZero
	
	^self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: 'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'NR 4/15/2021 16:42:24'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no está definido aquí para Enteros Negativos!!!!!!'! !

!Entero class methodsFor: 'instance creation' stamp: 'h 9/13/2023 13:13:19'!
with: aValue

	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	aValue < 0 ifTrue: [^EnteroNegativo new initializeWith: aValue ].
	aValue = 0 ifTrue: [^EnteroCero new initializeWith: aValue].
	aValue = 1 ifTrue: [^EnteroUno new initializeWith: aValue].
	^EnteroPositivo new initializeWith: aValue.! !


!classDefinition: #EnteroCero category: 'Numero-Exercise'!
Entero subclass: #EnteroCero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroCero methodsFor: 'testing' stamp: 'h 9/13/2023 13:17:20'!
isNegative
	^false! !

!EnteroCero methodsFor: 'testing' stamp: 'h 9/13/2023 13:17:13'!
isOne
	^false.! !

!EnteroCero methodsFor: 'testing' stamp: 'manuel urko 9/12/2023 22:03:56'!
isZero
	^true.! !


!EnteroCero methodsFor: 'arithmetic operations' stamp: 'manuel urko 9/12/2023 20:05:21'!
fibonacci
	^super class with: 1! !


!classDefinition: #EnteroNegativo category: 'Numero-Exercise'!
Entero subclass: #EnteroNegativo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroNegativo methodsFor: 'testing' stamp: 'manuel urko 9/12/2023 22:04:42'!
isNegative
	^true.! !

!EnteroNegativo methodsFor: 'testing' stamp: 'h 9/13/2023 13:16:57'!
isOne
	^false! !

!EnteroNegativo methodsFor: 'testing' stamp: 'h 9/13/2023 13:16:49'!
isZero
	^false! !


!EnteroNegativo methodsFor: 'arithmetic operations' stamp: 'manuel urko 9/12/2023 18:02:00'!
fibonacci
	^self error: Entero negativeFibonacciErrorDescription.! !


!classDefinition: #EnteroPositivo category: 'Numero-Exercise'!
Entero subclass: #EnteroPositivo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroPositivo methodsFor: 'testing' stamp: 'h 9/13/2023 13:18:05'!
isNegative
	^false! !

!EnteroPositivo methodsFor: 'testing' stamp: 'h 9/13/2023 13:17:50'!
isOne
	^false! !

!EnteroPositivo methodsFor: 'testing' stamp: 'h 9/13/2023 13:17:42'!
isZero
	^false! !


!EnteroPositivo methodsFor: 'arithmetic operations' stamp: 'h 9/13/2023 13:21:47'!
fibonacci
	| one two |
	one := Entero with: 1.
	two := Entero with: 2.
	
	^ (self - one) fibonacci + (self - two) fibonacci.! !


!classDefinition: #EnteroUno category: 'Numero-Exercise'!
Entero subclass: #EnteroUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroUno methodsFor: 'testing' stamp: 'h 9/13/2023 13:18:33'!
isNegative
	^false.! !

!EnteroUno methodsFor: 'testing' stamp: 'manuel urko 9/12/2023 22:04:56'!
isOne
	^true.! !

!EnteroUno methodsFor: 'testing' stamp: 'h 9/13/2023 13:18:28'!
isZero
	^false.! !


!EnteroUno methodsFor: 'arithmetic operations' stamp: 'manuel urko 9/12/2023 21:35:44'!
fibonacci
	^self! !


!classDefinition: #Fraccion category: 'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'arithmetic operations' stamp: 'h 9/12/2023 00:15:41'!
* aMultiplier 
	
	^aMultiplier multiplyByFraction: self
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'h 9/12/2023 00:12:58'!
+ anAdder 
	
	^anAdder addToFraction: self! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'h 9/12/2023 00:14:17'!
- aSubtrahend 
	
	^aSubtrahend substractToFraction: self
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'h 9/12/2023 00:16:56'!
/ aDivisor 
	^aDivisor divideFraction: self! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'h 9/12/2023 00:13:16'!
addToFraction: firstAdder 
	
	| newNumerator newDenominator |
	
	newNumerator := (numerator * firstAdder denominator) + (denominator * firstAdder numerator).
	newDenominator := denominator * firstAdder denominator.
	
	^newNumerator / newDenominator ! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'h 9/12/2023 00:13:07'!
addToInteger: firstAdder 
	
	^self numerator  + (self denominator * firstAdder) / self denominator! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'h 9/12/2023 00:17:08'!
divideFraction: fractionToDivide
	^(denominator * fractionToDivide numerator) / (numerator * fractionToDivide denominator)! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'h 9/12/2023 00:17:02'!
divideInteger: fractionToDivide 
	^(self denominator * fractionToDivide) / self numerator! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'h 9/13/2023 13:58:06'!
multiplyByFraction: firstFractionFactor 
	
	^(numerator * firstFractionFactor numerator) / (denominator * firstFractionFactor denominator)
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'h 9/13/2023 14:00:12'!
multiplyByInteger: firstIntegerFactor
	
	^firstIntegerFactor * self numerator / self denominator
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'h 9/12/2023 00:14:37'!
substractToFraction: firstSubtrahend 
	
	| newNumerator newDenominator |
	
	newNumerator := (denominator * firstSubtrahend numerator) - (numerator * firstSubtrahend denominator).
	newDenominator := denominator * firstSubtrahend denominator.
	
	^newNumerator / newDenominator 
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'h 9/12/2023 00:14:28'!
substractToInteger: firstSubtrahend 
	
	^ (firstSubtrahend * self denominator) - self numerator / self denominator 

! !


!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:42'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 22:54'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'testing' stamp: 'NR 9/23/2018 23:41:38'!
isNegative
	
	^numerator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:54:46'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: 'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'h 9/13/2023 14:19:28'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	aDivisor isZero ifTrue: [ self error: self canNotDivideByZeroErrorDescription ].
	aDividend isZero ifTrue: [ ^aDividend ]. 
	
	aDivisor isNegative ifTrue:[ ^aDividend negated / aDivisor negated].
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	denominator isOne ifTrue: [ ^numerator ].

	^self new initializeWith: numerator over: denominator
	! !
