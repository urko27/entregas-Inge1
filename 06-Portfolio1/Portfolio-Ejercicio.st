!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'h 10/13/2023 20:29:45'!
test01EmptyPortfolioBalanceEqualsZero

	|portfolio|
	
	portfolio := Portfolio new.
	
	self assert: portfolio balance equals: 0.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'h 10/13/2023 20:32:42'!
test02PortfolioWithOneAccountBalanceEqualsAccountBalance

	|portfolio firstAccount|
	
	firstAccount := ReceptiveAccount new.
	portfolio := Portfolio new.
	
	Deposit register: 100 on: firstAccount .
	portfolio addAccount: firstAccount.
	
	self assert: portfolio balance equals: firstAccount balance.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'h 10/13/2023 20:36:56'!
test03BalanceOfPortfolioWithMultipleAccountsIsTheSumOfTheAccountsBalances

	|portfolio firstAccount secondAccount|
	
	firstAccount := ReceptiveAccount new.
	secondAccount := ReceptiveAccount new.
	portfolio := Portfolio new.
	
	Deposit register: 100 on: firstAccount .
	Deposit register: 50 on: secondAccount .
	portfolio addAccount: firstAccount.
	portfolio addAccount: secondAccount.
	
	self assert: portfolio balance equals: firstAccount balance + secondAccount balance.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'h 10/14/2023 00:50:52'!
test04PortfolioWithOnePortfolioHaveSameBalance

	|portfolio firstIncludedPortfolio firstAccount|
	
	firstAccount := ReceptiveAccount new.
	firstIncludedPortfolio := Portfolio new.
	portfolio := Portfolio new.
	
	Deposit register: 100 on: firstAccount .
	firstIncludedPortfolio addAccount: firstAccount .
	portfolio addPortfolio: firstIncludedPortfolio .
	
	self assert: portfolio balance equals: firstIncludedPortfolio balance.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'h 10/14/2023 01:00:17'!
test05BalanceOfPortfolioWithMultiplePortfoliosIsTheSumOfThePortfoliosBalances

	|portfolio firstIncludedPortfolio secondIncludedPortfolio secondAccount firstAccount|
	
	firstAccount := ReceptiveAccount new.
	secondAccount := ReceptiveAccount new.
	firstIncludedPortfolio := Portfolio new.
	secondIncludedPortfolio := Portfolio new.
	portfolio := Portfolio new.
	
	Deposit register: 100 on: firstAccount .
	Deposit register: 200 on: secondAccount .
	firstIncludedPortfolio addAccount: firstAccount .
	secondIncludedPortfolio addAccount: secondAccount .
	portfolio addPortfolio: firstIncludedPortfolio .
	portfolio addPortfolio: secondIncludedPortfolio .
	
	self assert: portfolio balance equals: firstIncludedPortfolio balance + secondIncludedPortfolio balance.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'h 10/14/2023 01:06:00'!
test06BalanceOfPortfolioWithAccountsAndPortfoliosIsTheSumOfTheBalances

	|portfolio firstIncludedPortfolio secondIncludedPortfolio secondAccount firstAccount thirdAccount|
	
	firstAccount := ReceptiveAccount new.
	secondAccount := ReceptiveAccount new.
	thirdAccount := ReceptiveAccount new.
	firstIncludedPortfolio := Portfolio new.
	secondIncludedPortfolio := Portfolio new.
	portfolio := Portfolio new.
	
	Deposit register: 100 on: firstAccount .
	Deposit register: 200 on: secondAccount .
	Deposit register: 100 on: thirdAccount .
	firstIncludedPortfolio addAccount: firstAccount .
	secondIncludedPortfolio addAccount: secondAccount .
	portfolio addPortfolio: firstIncludedPortfolio .
	portfolio addPortfolio: secondIncludedPortfolio .
	portfolio addAccount: thirdAccount .
	
	self assert: portfolio balance equals: 400.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'h 10/14/2023 01:21:37'!
test07EmptyPortfolioDoesNotHaveRegisteredTransactions

	|portfolio anAccount aDeposit|
	
	anAccount := ReceptiveAccount new.
	portfolio := Portfolio new.
	aDeposit := Deposit register: 100 on: anAccount.
	
	self deny: (portfolio hasRegistered: aDeposit ).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'h 10/14/2023 01:33:57'!
test08PortfolioWithOneAccounthasRegisteredTransaction

	|portfolio firstAccount aDeposit|
	
	firstAccount := ReceptiveAccount new.
	portfolio := Portfolio new.
	aDeposit := Deposit register: 100 on: firstAccount.
	portfolio addAccount: firstAccount .
	
	self assert: (portfolio hasRegistered: aDeposit ).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'h 10/14/2023 01:33:25'!
test09PortfolioWithAccountsDoesNotHaveRegisteredTransaction

	|portfolio firstAccount secondAccount aDeposit|
	
	firstAccount := ReceptiveAccount new.
	secondAccount := ReceptiveAccount new.
	portfolio := Portfolio new.
	aDeposit := Deposit register: 100 on: firstAccount.
	portfolio addAccount: secondAccount .
	
	self deny: (portfolio hasRegistered: aDeposit ).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'h 10/14/2023 01:47:40'!
test10PortfolioWithPortfoliosDetectsRegisteredTransactions

	|portfolio firstIncludedPortfolio secondIncludedPortfolio firstAccount secondAccount firstDeposit secondDeposit|
	
	firstIncludedPortfolio := Portfolio new.
	secondIncludedPortfolio := Portfolio new.
	portfolio := Portfolio new.
	firstAccount := ReceptiveAccount new.
	secondAccount := ReceptiveAccount new.
	
	firstDeposit := Deposit register: 100 on: firstAccount.
	secondDeposit := Deposit register: 100 on: secondAccount .
	
	firstIncludedPortfolio addAccount: firstAccount .
	secondIncludedPortfolio addAccount: secondAccount .
	
	portfolio addPortfolio: firstIncludedPortfolio.
	portfolio addPortfolio: secondIncludedPortfolio.
	
	self assert: (portfolio hasRegistered: firstDeposit ).
	self assert: (portfolio hasRegistered: secondDeposit ).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'h 10/19/2023 15:04:05'!
test11PortfolioWithOneAccountKnowsItsTransactions

	|portfolio anAccount aTransaction|
	
	anAccount := ReceptiveAccount new.
	portfolio := Portfolio new.
	aTransaction := Deposit register: 100 on: anAccount.
	
	portfolio addAccount: anAccount .
	
	self assert: (portfolio transactions includes: aTransaction ).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'h 10/19/2023 15:03:25'!
test12EmptyPortfolioDoesNotHaveTransactions

	|portfolio|
	
	portfolio := Portfolio new.
	
	self assert: portfolio transactions isEmpty.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'h 10/14/2023 02:19:54'!
test13PortfolioWithMultipleAccountsKnowsItsTransactions

	|portfolio firstAccount secondAccount firstTransaction secondTransaction|
	
	firstAccount := ReceptiveAccount new.
	secondAccount := ReceptiveAccount new.
	portfolio := Portfolio new.
	
	firstTransaction := Deposit register: 100 on: firstAccount. 
	secondTransaction := Deposit register: 100 on: secondAccount .
	
	portfolio addAccount: firstAccount. portfolio addAccount: secondAccount .
	
	self assert: (portfolio transactions includes: firstTransaction ).
	self assert: (portfolio transactions includes: secondTransaction ).
	self assert: portfolio transactions size equals: 2 .! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'h 10/14/2023 15:33:26'!
test14PortfolioWithPortfolioKnowsItsTransactions

	|portfolio firstAccount firstTransaction firstIncludedPortfolio|
	
	firstAccount := ReceptiveAccount new.
	portfolio := Portfolio new.
	firstIncludedPortfolio := Portfolio new.
	
	firstTransaction := Deposit register: 100 on: firstAccount. 
	firstIncludedPortfolio addAccount: firstAccount .
	
	portfolio addPortfolio: firstIncludedPortfolio . 
	
	self assert: (portfolio transactions includes: firstTransaction ).
	self assert: portfolio transactions size equals: 1 .! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'h 10/14/2023 15:40:06'!
test15PortfolioWithPortfoliosAndAccountsKnowsItsTransactions

	|portfolio firstAccount secondAccount thirdAccount firstTransaction secondTransaction thirdTransaction firstIncludedPortfolio secondIncludedPortfolio|
	
	firstAccount := ReceptiveAccount new.
	secondAccount := ReceptiveAccount new.
	thirdAccount := ReceptiveAccount new.
	portfolio := Portfolio new.
	firstIncludedPortfolio := Portfolio new.
	secondIncludedPortfolio := Portfolio new.	
	
	firstTransaction := Deposit register: 100 on: firstAccount. 
	secondTransaction := Deposit register: 50 on: secondAccount.
	thirdTransaction := Deposit register: 100 on: thirdAccount.  
	
	firstIncludedPortfolio addAccount: firstAccount .
	secondIncludedPortfolio addAccount: secondAccount .
	
	portfolio addPortfolio: firstIncludedPortfolio . 
	portfolio addPortfolio: secondIncludedPortfolio .
	portfolio addAccount: thirdAccount .
	
	self assert: (portfolio transactions includes: firstTransaction ).
	self assert: (portfolio transactions includes: secondTransaction ).
	self assert: (portfolio transactions includes: thirdTransaction ).
	self assert: portfolio transactions size equals: 3 .! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'h 10/14/2023 15:50:40'!
test16CannotAddAlreadyAddedAccount

	|portfolio anAccount|
	
	anAccount := ReceptiveAccount new.
	portfolio := Portfolio new.
	
	portfolio addAccount: anAccount .
	
	self should: [portfolio addAccount: anAccount ]
		raise: Error
		withExceptionDo: [:anError | self assert: anError messageText = Portfolio errorCannotAddAlreadyAddedAccount ]! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'h 10/14/2023 15:53:14'!
test17PortfolioCannotAddAccountIncludedInAnIncludedPortfolio

	|portfolio includedPortfolio anAccount|
	
	anAccount := ReceptiveAccount new.
	includedPortfolio := Portfolio new.
	portfolio := Portfolio new.
	
	includedPortfolio addAccount: anAccount .
	portfolio addPortfolio: includedPortfolio.
	
	self should: [portfolio addAccount: anAccount ]
		raise: Error
		withExceptionDo: [:anError | self assert: anError messageText = Portfolio errorCannotAddAlreadyAddedAccount ]! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'h 10/14/2023 16:04:22'!
test18PortfolioWithMultiplePortfoliosCannotAddAccountIncludedInOneOfThosePortfolios

	|portfolio firstIncludedPortfolio secondIncludedPortfolio firstAccount |
	
	firstAccount := ReceptiveAccount new.
	firstIncludedPortfolio := Portfolio new.
	secondIncludedPortfolio := Portfolio new.
	portfolio := Portfolio new.
	
	secondIncludedPortfolio addAccount: firstAccount.
	portfolio addPortfolio: firstIncludedPortfolio.
	portfolio addPortfolio: secondIncludedPortfolio .
	
	self should: [portfolio addAccount: firstAccount ]
		raise: Error
		withExceptionDo: [:anError | self assert: anError messageText = Portfolio errorCannotAddAlreadyAddedAccount ]! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'h 10/14/2023 16:25:46'!
test19CannotAddPortfolioAlreadyAdded

	|portfolio firstIncludedPortfolio |
	
	portfolio := Portfolio new.
	firstIncludedPortfolio := Portfolio new.
	
	portfolio addPortfolio: firstIncludedPortfolio .
	
	self should: [portfolio addPortfolio: firstIncludedPortfolio ]
		raise: Error
		withExceptionDo: [:anError | self assert: anError messageText = Portfolio errorCannotAddAlreadyAddedPortfolio ]! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'h 10/14/2023 16:34:44'!
test20PortfolioWithMultiplePortfoliosCannotAddPortfolioIncludedInOneOfThosePortfolios

	|portfolio firstIncludedPortfolio secondIncludedPortfolio thirdIncludedPortfolio|
	
	firstIncludedPortfolio := Portfolio new.
	secondIncludedPortfolio := Portfolio new.
	thirdIncludedPortfolio := Portfolio new.
	portfolio := Portfolio new.
	
	secondIncludedPortfolio addPortfolio: thirdIncludedPortfolio.
	portfolio addPortfolio: firstIncludedPortfolio .
	portfolio addPortfolio: secondIncludedPortfolio .
	
	self should: [portfolio addPortfolio: thirdIncludedPortfolio ]
		raise: Error
		withExceptionDo: [:anError | self assert: anError messageText = Portfolio errorCannotAddAlreadyAddedPortfolio ]! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'h 10/18/2023 16:38:55'!
test21CannotAddAccountThatFatherPortfolioAlreadyHas

	|portfolio fatherPortfolio anAccount|
	
	anAccount := ReceptiveAccount new.
	portfolio := Portfolio new.
	fatherPortfolio := Portfolio new.
	
	fatherPortfolio addPortfolio: portfolio .
	fatherPortfolio addAccount: anAccount .
	
	self should: [portfolio addAccount: anAccount ]
		raise: Error
		withExceptionDo: [:anError | 
			self assert: anError messageText = Portfolio errorCannotAddAccountOfFatherPortfolio 
			]! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'h 10/18/2023 16:39:57'!
test22CannotAddAccountAlreadyAddedOnOneOfMultipleFatherPortfolios

	|portfolio fatherPortfolio  secondFatherPortfolio anAccount|
	
	anAccount := ReceptiveAccount new.
	portfolio := Portfolio new.
	fatherPortfolio := Portfolio new.
	secondFatherPortfolio := Portfolio new.
	
	fatherPortfolio addPortfolio: portfolio .
	secondFatherPortfolio addPortfolio: portfolio .
	
	secondFatherPortfolio addAccount: anAccount .
	
	self should: [portfolio addAccount: anAccount ]
		raise: Error
		withExceptionDo: [:anError | 
			self assert: anError messageText = Portfolio errorCannotAddAccountOfFatherPortfolio 
			]! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'h 10/18/2023 16:40:28'!
test23CannotAddAccountAlreadyAddedInRootPortfolio

	|portfolio fatherPortfolio  rootPortfolio anAccount|
	
	anAccount := ReceptiveAccount new.
	portfolio := Portfolio new.
	fatherPortfolio := Portfolio new.
	rootPortfolio := Portfolio new.
	
	fatherPortfolio addPortfolio: portfolio .
	rootPortfolio addPortfolio: fatherPortfolio .
	
	rootPortfolio addAccount: anAccount .
	
	self should: [portfolio addAccount: anAccount ]
		raise: Error
		withExceptionDo: [:anError | 
			self assert: anError messageText = Portfolio errorCannotAddAccountOfFatherPortfolio 
			]! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'h 10/18/2023 16:41:03'!
test24CannotAddAccountAlreadyAddedInOneOfTheRootsOfThePortfoliosTree

	|portfolio fatherPortfolio rootPortfolio secondRootPortfolio anAccount|
	
	anAccount := ReceptiveAccount new.
	portfolio := Portfolio new.
	fatherPortfolio := Portfolio new.
	rootPortfolio := Portfolio new.
	secondRootPortfolio := Portfolio new.
	

	fatherPortfolio addPortfolio: portfolio .
	rootPortfolio addPortfolio: fatherPortfolio .
	secondRootPortfolio addPortfolio: fatherPortfolio .
	
	secondRootPortfolio addAccount: anAccount .
	
	self should: [portfolio addAccount: anAccount ]
		raise: Error
		withExceptionDo: [:anError | 
			self assert: anError messageText = Portfolio errorCannotAddAccountOfFatherPortfolio 
			]! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'h 10/18/2023 16:43:23'!
test25CannotAddPortfolioThatFatherPortfolioAlreadyHas

	|portfolio fatherPortfolio anAddedPortfolio|
	
	anAddedPortfolio := Portfolio new.
	portfolio := Portfolio new.
	fatherPortfolio := Portfolio new.
	
	fatherPortfolio addPortfolio: portfolio .
	fatherPortfolio addPortfolio: anAddedPortfolio .
	
	self should: [portfolio addPortfolio: anAddedPortfolio ]
		raise: Error
		withExceptionDo: [:anError | 
			self assert: anError messageText = Portfolio errorCannotAddPortfolioOfFatherPortfolio 
			]! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'h 10/18/2023 16:52:41'!
test26CannotAddPortfolioAlreadyAddedInOneOfMultipleFatherPortfolios

	|portfolio fatherPortfolio  secondFatherPortfolio anAddedPortfolio|
	
	anAddedPortfolio := Portfolio new.
	portfolio := Portfolio new.
	fatherPortfolio := Portfolio new.
	secondFatherPortfolio := Portfolio new.
	
	fatherPortfolio addPortfolio: portfolio .
	secondFatherPortfolio addPortfolio: portfolio .
	
	secondFatherPortfolio addPortfolio: anAddedPortfolio .
	
	self should: [portfolio addPortfolio: anAddedPortfolio ]
		raise: Error
		withExceptionDo: [:anError | 
			self assert: anError messageText = Portfolio errorCannotAddPortfolioOfFatherPortfolio 
			]! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'h 10/18/2023 16:56:09'!
test27CannotAddPortfolioAlreadyAddedInOneOfTheRootsOfThePortfoliosTree

	|portfolio fatherPortfolio rootPortfolio secondRootPortfolio anAddedPortfolio|
	
	anAddedPortfolio := Portfolio new.
	portfolio := Portfolio new.
	fatherPortfolio := Portfolio new.
	rootPortfolio := Portfolio new.
	secondRootPortfolio := Portfolio new.
	

	fatherPortfolio addPortfolio: portfolio .
	rootPortfolio addPortfolio: fatherPortfolio .
	secondRootPortfolio addPortfolio: fatherPortfolio .
	
	secondRootPortfolio addPortfolio: anAddedPortfolio .
	
	self should: [portfolio addPortfolio: anAddedPortfolio ]
		raise: Error
		withExceptionDo: [:anError | 
			self assert: anError messageText = Portfolio errorCannotAddPortfolioOfFatherPortfolio 
			]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'balance' stamp: 'h 10/13/2023 20:24:26'!
calculateBalance: balanceToUpdate

	^self subclassResponsibility! !


!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'h 10/13/2023 20:24:36'!
calculateBalance: balanceToUpdate

	^balanceToUpdate+ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'balance' stamp: 'h 10/13/2023 20:24:51'!
calculateBalance: balanceToUpdate

	^balanceToUpdate - value! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


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


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'h 10/13/2023 20:27:14'!
balance
	
	|currentBalance|
	
	currentBalance := 0.
	
	transactions do: [ :aTransaction | 
		currentBalance := aTransaction calculateBalance: currentBalance
		].
	
	^currentBalance ! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !
