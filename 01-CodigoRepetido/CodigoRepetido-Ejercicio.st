!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'manuel urko 9/6/2023 10:54:41'!
assertThatAClosure: aClosure in: customerBook takesLessThan: milliseconds

	| millisecondsBeforeRunning millisecondsAfterRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aClosure value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < (milliseconds)! !

!CustomerBookTest methodsFor: 'testing' stamp: 'manuel urko 9/6/2023 08:38:06'!
assertThatAClosure: aClosure throws: expected andAssert: assertions	
	[aClosure value. self fail] on: expected do: [:anError | assertions value: anError].! !

!CustomerBookTest methodsFor: 'testing' stamp: 'manuel urko 9/6/2023 12:40:11'!
assertThatCustomerBook: customerBook hasNumberOfActiveCustomers: expectedNumberOfActiveCustomers hasNumberOfSuspendedCustomers: expectedNumberOfSuspendedCustomers hasNumberOfCustomers: expectedNumberOfCustomers 
	self assert: expectedNumberOfActiveCustomers equals: customerBook numberOfActiveCustomers.
	self assert: expectedNumberOfSuspendedCustomers equals: customerBook numberOfSuspendedCustomers.
	self assert: expectedNumberOfCustomers equals: customerBook numberOfCustomers.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'manuel urko 9/5/2023 21:49:25'!
assertThatCustomerBook: customerBook hasNumberOfActiveCustomers: expectedNumberOfActiveCustomers hasNumberOfSuspendedCustomers: expectedNumberOfSuspendedCustomers hasNumberOfCustomers: expectedNumberOfCustomers andDoesNotIncludeCustomerNamed: customerNamed
	self assert: expectedNumberOfActiveCustomers equals: customerBook numberOfActiveCustomers.
	self assert: expectedNumberOfSuspendedCustomers equals: customerBook numberOfSuspendedCustomers.
	self assert: expectedNumberOfCustomers equals: customerBook numberOfCustomers.
	self deny: (customerBook includesCustomerNamed: customerNamed).! !

!CustomerBookTest methodsFor: 'testing' stamp: 'manuel urko 9/5/2023 21:41:45'!
assertThatCustomerBook: customerBook hasNumberOfActiveCustomers: expectedNumberOfActiveCustomers hasNumberOfSuspendedCustomers: expectedNumberOfSuspendedCustomers hasNumberOfCustomers: expectedNumberOfCustomers andIncludesCustomerNamed: customerNamed
	self assert: expectedNumberOfActiveCustomers equals: customerBook numberOfActiveCustomers.
	self assert: expectedNumberOfSuspendedCustomers equals: customerBook numberOfSuspendedCustomers.
	self assert: expectedNumberOfCustomers equals: customerBook numberOfCustomers.
	self assert: (customerBook includesCustomerNamed: customerNamed).! !

!CustomerBookTest methodsFor: 'testing' stamp: 'manuel urko 9/6/2023 10:54:41'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds
	| customerBook |
	
	customerBook := CustomerBook new.
	
	self assertThatAClosure: [customerBook addCustomerNamed: 'John Lennon'.] in: customerBook  takesLessThan: 50*millisecond.
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'manuel urko 9/6/2023 10:54:41'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds
	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	customerBook addCustomerNamed: paulMcCartney.
	  
	self assertThatAClosure: [customerBook removeCustomerNamed: paulMcCartney.] in: customerBook takesLessThan: 100*millisecond.
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'manuel urko 9/6/2023 08:38:06'!
test03CanNotAddACustomerWithEmptyName 
	| customerBook |
	customerBook := CustomerBook new.
	self 
		assertThatAClosure: [customerBook addCustomerNamed: ''] 
		throws: Error
		andAssert: [:anError | self assert: anError messageText = 'Customer name cannot be empty!!!!!!'].! !

!CustomerBookTest methodsFor: 'testing' stamp: 'manuel urko 9/6/2023 08:38:06'!
test04CanNotRemoveAnInvalidCustomer
	| customerBook johnLennon |
	
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	
	customerBook addCustomerNamed: johnLennon.
	
	self 
	assertThatAClosure:  [customerBook removeCustomerNamed: 'Paul McCartney'.] 
	throws: NotFound 
	andAssert: [:anError | self assert: customerBook numberOfCustomers = 1.self assert: (customerBook includesCustomerNamed: johnLennon) ] .
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'manuel urko 9/6/2023 12:41:35'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook
	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	self 
		assertThatCustomerBook: customerBook  
		hasNumberOfActiveCustomers: 0
		hasNumberOfSuspendedCustomers: 1 
		hasNumberOfCustomers: 1.
		
	self assert: (customerBook includesCustomerNamed: paulMcCartney).! !

!CustomerBookTest methodsFor: 'testing' stamp: 'manuel urko 9/6/2023 12:42:10'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook
	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self 
		assertThatCustomerBook: customerBook
		hasNumberOfActiveCustomers: 0
		hasNumberOfSuspendedCustomers: 0
		hasNumberOfCustomers: 0.
		
	self deny: (customerBook includesCustomerNamed: paulMcCartney).! !

!CustomerBookTest methodsFor: 'testing' stamp: 'manuel urko 9/6/2023 08:38:06'!
test07CanNotSuspendAnInvalidCustomer
	| customerBook johnLennon |
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self 
		assertThatAClosure: [customerBook suspendCustomerNamed: 'George Harrison'.]
		throws: CantSuspend
		andAssert: [:anError | self assert: customerBook numberOfCustomers = 1. self assert: (customerBook includesCustomerNamed: johnLennon)].
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'manuel urko 9/6/2023 08:38:06'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	| customerBook johnLennon |
	customerBook := CustomerBook new.
	
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	self 
		assertThatAClosure: [customerBook suspendCustomerNamed: johnLennon.]
		throws: CantSuspend
		andAssert: [:anError | self assert: customerBook numberOfCustomers = 1. self assert: (customerBook includesCustomerNamed: johnLennon)].! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'h 9/6/2023 09:52:49'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'h 9/5/2023 14:47:51'!
removeCustomerNamed: aName 

	(self removeIfItExists: aName from: active) = aName ifTrue: [^aName].
 
	(self removeIfItExists: aName from: suspended) = aName ifTrue: [^aName].
	
	^ NotFound signal.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'h 9/5/2023 14:53:03'!
removeIfItExists: aName from: aCollection
 	"este metodo deberia ser implementado en colecciones"
	1 to: aCollection size do: 
	[ :index |
		aName = (aCollection at: index)
			ifTrue: [
				aCollection removeAt: index.
				^ aName 
			]
	].
	
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/4/2023 17:02:48'!
customerAlreadyExistsErrorMessage

	^'Customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/4/2023 17:02:52'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty!!!!!!'! !
