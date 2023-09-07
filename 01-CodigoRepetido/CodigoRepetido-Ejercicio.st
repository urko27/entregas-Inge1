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
	instanceVariableNames: 'customerBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'h 9/7/2023 14:00:58'!
assertThatAMethod: aClosure takesLessThan: milliseconds

	| millisecondsBeforeRunning millisecondsAfterRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aClosure value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < (milliseconds)! !

!CustomerBookTest methodsFor: 'testing' stamp: 'h 9/7/2023 14:01:36'!
assertThatAMethod: aClosure throws: expected andAssert: assertions	
	[aClosure value. self fail] on: expected do: [:anError | assertions value: anError].! !

!CustomerBookTest methodsFor: 'testing' stamp: 'manuel urko 9/6/2023 13:06:30'!
assertThatCustomerBookHasNumberOfActiveCustomers: expectedNumberOfActiveCustomers hasNumberOfSuspendedCustomers: expectedNumberOfSuspendedCustomers hasNumberOfCustomers: expectedNumberOfCustomers 

	self assert: expectedNumberOfActiveCustomers equals: customerBook numberOfActiveCustomers.
	self assert: expectedNumberOfSuspendedCustomers equals: customerBook numberOfSuspendedCustomers.
	self assert: expectedNumberOfCustomers equals: customerBook numberOfCustomers.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'manuel urko 9/6/2023 13:16:42'!
assertThatCustomerBookHasNumberOfCustomers: expectedNumberOfCustomers andIncludesCustomerNamed: aCustomer.
	self assert: customerBook numberOfCustomers = expectedNumberOfCustomers. self assert: (customerBook includesCustomerNamed: aCustomer).! !

!CustomerBookTest methodsFor: 'testing' stamp: 'h 9/7/2023 14:01:15'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds
	self assertThatAMethod: [customerBook addCustomerNamed: 'John Lennon'.] takesLessThan: 50*millisecond.
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'h 9/7/2023 14:03:36'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds
	| paulMcCartney |
	paulMcCartney := 'Paul McCartney'.
	customerBook addCustomerNamed: paulMcCartney.
	self assertThatAMethod: [customerBook removeCustomerNamed: paulMcCartney.] takesLessThan: 100*millisecond.
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'h 9/7/2023 14:01:58'!
test03CanNotAddACustomerWithEmptyName 	self 
		assertThatAMethod: [customerBook addCustomerNamed: ''] 
		throws: Error
		andAssert: [:anError | self assert: anError messageText = 'Customer name cannot be empty!!!!!!'].! !

!CustomerBookTest methodsFor: 'testing' stamp: 'h 9/7/2023 14:02:05'!
test04CanNotRemoveAnInvalidCustomer
	| johnLennon |
	johnLennon := 'John Lennon'.
	
	customerBook addCustomerNamed: johnLennon.
	self 
		assertThatAMethod:  [customerBook removeCustomerNamed: 'Paul McCartney'.] 
		throws: NotFound 
		andAssert: [:anError | self 
			assertThatCustomerBookHasNumberOfCustomers: 1 
			andIncludesCustomerNamed: johnLennon] .
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'manuel urko 9/6/2023 13:08:11'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook
	| paulMcCartney|
	paulMcCartney := 'Paul McCartney'.
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self 
		assertThatCustomerBookHasNumberOfActiveCustomers: 0
		hasNumberOfSuspendedCustomers: 1 
		hasNumberOfCustomers: 1.
		
	self assert: (customerBook includesCustomerNamed: paulMcCartney).! !

!CustomerBookTest methodsFor: 'testing' stamp: 'manuel urko 9/6/2023 13:06:30'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook
	| paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	self 
		assertThatCustomerBookHasNumberOfActiveCustomers: 0
		hasNumberOfSuspendedCustomers: 0
		hasNumberOfCustomers: 0.
		
	self deny: (customerBook includesCustomerNamed: paulMcCartney).! !

!CustomerBookTest methodsFor: 'testing' stamp: 'h 9/7/2023 14:02:12'!
test07CanNotSuspendAnInvalidCustomer
	| johnLennon |
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self 
		assertThatAMethod: [customerBook suspendCustomerNamed: 'George Harrison'.]
		throws: CantSuspend
		andAssert: [:anError | self
			assertThatCustomerBookHasNumberOfCustomers: 1
			andIncludesCustomerNamed: johnLennon].
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'h 9/7/2023 14:02:18'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	| johnLennon |
	
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	self 
		assertThatAMethod: [customerBook suspendCustomerNamed: johnLennon.]
		throws: CantSuspend
		andAssert: [:anError | self 
			assertThatCustomerBookHasNumberOfCustomers: 1 
			andIncludesCustomerNamed: johnLennon].! !


!CustomerBookTest methodsFor: 'initialization' stamp: 'manuel urko 9/6/2023 13:06:30'!
setUp
	customerBook := CustomerBook new.
	! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'h 9/7/2023 13:51:04'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'h 9/7/2023 13:50:58'!
isEmpty

	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'h 9/7/2023 13:50:50'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'h 9/7/2023 14:38:17'!
IfIncludedIn:  aCollection removeIt: aName andDo: aClosure
	1 to: aCollection size do: 
	[ :index |
		aName = (aCollection at: index)
			ifTrue: [
				aCollection removeAt: index.
				^ aClosure value.
			]
	].
	
! !

!CustomerBook methodsFor: 'customer management' stamp: 'h 9/7/2023 13:51:16'!
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

!CustomerBook methodsFor: 'customer management' stamp: 'h 9/7/2023 14:39:08'!
removeCustomerNamed: aName 

	self IfIncludedIn: active removeIt: aName andDo: [^aName].

	self IfIncludedIn: suspended removeIt: aName andDo: [^aName].
	
	^ NotFound signal.
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
