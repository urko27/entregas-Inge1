'From Cuis 6.0 [latest update: #5981] on 19 October 2023 at 3:42:11 pm'!
!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accounts portfolios fatherPortfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'h 10/14/2023 01:46:49'!
balance
	
	|currentBalance|
	
	currentBalance := portfolios sum: [:aPortfolio | aPortfolio balance] ifEmpty: [0].
	
	currentBalance := currentBalance + (accounts sum: [:anAccount | anAccount balance] ifEmpty: [0]).
	
	^currentBalance .! !


!Portfolio methodsFor: 'initialize' stamp: 'h 10/18/2023 15:51:44'!
initialize

	accounts := OrderedCollection new.
	portfolios := OrderedCollection new.
	fatherPortfolios := OrderedCollection new.! !


!Portfolio methodsFor: 'transactions - private' stamp: 'h 10/19/2023 15:24:45'!
addTransactionsTo: transactions
	
	accounts inject: transactions into: [:currentTransactions :anAccount | 
		anAccount transactions do:[:aTransaction | currentTransactions add: aTransaction ]. currentTransactions
		].
	
	portfolios inject: transactions into: [:currentTransactions :aPortfolio | 
		aPortfolio transactions do:[:aTransaction | currentTransactions add: aTransaction ]. currentTransactions 
		].
	
	^transactions ! !


!Portfolio methodsFor: 'add' stamp: 'h 10/18/2023 17:07:59'!
addAccount: anAccountToAdd

	self assertAccountIsNotADuplicate: anAccountToAdd.
	
	self assertFathersDoNotHaveAccount: anAccountToAdd.
	
	accounts add: anAccountToAdd .! !

!Portfolio methodsFor: 'add' stamp: 'h 10/19/2023 14:54:34'!
addPortfolio: aPortfolioToBeAdded 

	self assertPortfolioIsNotDuplicated: aPortfolioToBeAdded.
	
	self assertFathersDoNotHavePortfolio: aPortfolioToBeAdded.
	
	portfolios add: aPortfolioToBeAdded.
	
	aPortfolioToBeAdded addFather: self.! !


!Portfolio methodsFor: 'test' stamp: 'h 10/19/2023 14:30:59'!
checkIfFatherPortfoliosHaveAccount: anAccountToCheck

	^self findRootFather anySatisfy: [:aRootPortfolio |
			aRootPortfolio hasAccount: anAccountToCheck
		]! !

!Portfolio methodsFor: 'test' stamp: 'h 10/19/2023 14:44:15'!
checkIfFatherPortfoliosHavePortfolio: aPortfolioToCheck
	
	^self findRootFather anySatisfy: [:aRootPortfolio | 
			aRootPortfolio hasPortfolio: aPortfolioToCheck 
		]
! !

!Portfolio methodsFor: 'test' stamp: 'h 10/19/2023 14:58:11'!
hasAccount: anAccountToFind
	
	^(accounts includes: anAccountToFind) or:[.
	
	(portfolios anySatisfy: [:aPortfolio | aPortfolio hasAccount: anAccountToFind ])].! !

!Portfolio methodsFor: 'test' stamp: 'h 10/19/2023 14:57:48'!
hasPortfolio: aPortfolioToFind

	^(portfolios includes: aPortfolioToFind ) or: [
	
	(portfolios anySatisfy: [:aPortfolio | aPortfolio hasPortfolio: aPortfolioToFind ])]! !

!Portfolio methodsFor: 'test' stamp: 'h 10/19/2023 14:57:00'!
hasRegistered: aTransaction
	
	^(accounts anySatisfy: [:anAccount | anAccount hasRegistered: aTransaction]) or:[
	
	(portfolios anySatisfy: [:aPortfolio | aPortfolio hasRegistered: aTransaction])].! !


!Portfolio methodsFor: 'transactions' stamp: 'h 10/19/2023 15:19:23'!
transactions

	|transactions|
	
	transactions := Set new.
	
	self addTransactionsTo: transactions .
	
	^transactions ! !


!Portfolio methodsFor: 'asserts' stamp: 'h 10/19/2023 15:00:06'!
assertAccountIsNotADuplicate: anAccountToCheck

	(accounts includes: anAccountToCheck) ifTrue: [self error: self class errorCannotAddAlreadyAddedAccount ].
	
	(portfolios anySatisfy: [:aPortfolio | aPortfolio hasAccount: anAccountToCheck]) ifTrue: [
		self error: self class errorCannotAddAlreadyAddedAccount 
		]! !

!Portfolio methodsFor: 'asserts' stamp: 'h 10/19/2023 14:59:35'!
assertFathersDoNotHaveAccount: anAccountToCheck

	^ (self checkIfFatherPortfoliosHaveAccount: anAccountToCheck) ifTrue:[
		self error: self class errorCannotAddAccountOfFatherPortfolio 
		]! !

!Portfolio methodsFor: 'asserts' stamp: 'h 10/19/2023 14:59:53'!
assertFathersDoNotHavePortfolio: aPortfolioToCheck

	^ (self checkIfFatherPortfoliosHavePortfolio: aPortfolioToCheck) ifTrue:[
		self error: self class errorCannotAddPortfolioOfFatherPortfolio
		]! !

!Portfolio methodsFor: 'asserts' stamp: 'h 10/19/2023 15:00:02'!
assertPortfolioIsNotDuplicated: aPortfolioToCheck

	(portfolios includes: aPortfolioToCheck) ifTrue: [self error: self class errorCannotAddAlreadyAddedPortfolio ].
	
	(portfolios anySatisfy: [:aPortfolio | aPortfolio hasPortfolio: aPortfolioToCheck ]) ifTrue: [
		self error: self class errorCannotAddAlreadyAddedPortfolio 
		]! !


!Portfolio methodsFor: 'add - private' stamp: 'h 10/18/2023 15:51:24'!
addFather: aFatherPortfolio

	fatherPortfolios add: aFatherPortfolio.! !


!Portfolio methodsFor: 'test - private' stamp: 'h 10/19/2023 14:42:29'!
findRootFather
	
	|roots|
	
	roots := Set new.

	fatherPortfolios ifEmpty:[^roots add: self;yourself].

	fatherPortfolios do: [:aFatherPortfolio | roots addAll: aFatherPortfolio findRootFather].
	
	^roots! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'errors' stamp: 'h 10/18/2023 15:38:21'!
errorCannotAddAccountOfFatherPortfolio

	^'Cannot add account of some father portfolio'! !

!Portfolio class methodsFor: 'errors' stamp: 'h 10/14/2023 15:47:38'!
errorCannotAddAlreadyAddedAccount

	^'Cannot add an already added account'! !

!Portfolio class methodsFor: 'errors' stamp: 'h 10/18/2023 15:38:25'!
errorCannotAddAlreadyAddedPortfolio

	^'Cannot add an already added portfolio'! !

!Portfolio class methodsFor: 'errors' stamp: 'h 10/18/2023 16:44:12'!
errorCannotAddPortfolioOfFatherPortfolio

	^'Cannot add an portfolio already added in some father portfolio'! !
