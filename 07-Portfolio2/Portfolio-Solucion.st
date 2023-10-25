!classDefinition: #AccountSummaryTest category: 'Portfolio-Solucion'!
TestCase subclass: #AccountSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'mmuu 10/22/2023 18:40:42'!
test01
	|account accountSummary|
	
	account := ReceptiveAccount new.
	accountSummary := AccountSummary for: account.
	
	self assert: accountSummary entries size equals: 1.
	self assert: accountSummary entries first equals: 'balance = 0'! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'mmuu 10/22/2023 19:04:42'!
test02
	|account accountSummary|
	
	account := ReceptiveAccount new.
	accountSummary := AccountSummary for: account .
	
	Deposit register: 100 on: account.
	
	self assert: accountSummary entries size equals: 2.
	self assert: accountSummary entries first equals: 'deposito por 100'.
	self assert: accountSummary entries last equals: 'balance = 100'! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'mmuu 10/23/2023 15:27:29'!
test03
	|account accountSummary|
	
	account := ReceptiveAccount new.
	accountSummary := AccountSummary for: account .
	
	Withdraw register: 300 on: account.
	Deposit register: 100 on: account.
	
	self assert: accountSummary entries size equals: 3.
	self assert: accountSummary entries first equals: 'extraccion por 300'.
	self assert: accountSummary entries last equals: 'balance = -200'! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'mmuu 10/23/2023 15:36:08'!
test04
	|senderAccount receiverAccount accountSummary|
	
	senderAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.
	accountSummary := AccountSummary for: senderAccount .
	
	Transference with: 300 from: senderAccount to: receiverAccount.
	
	self assert: accountSummary entries first equals: 'salida por transferencia de 300'.
	self assert: accountSummary entries last equals: 'balance = -300'! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'mmuu 10/23/2023 15:38:17'!
test05
	|senderAccount receiverAccount accountSummary|
	
	senderAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.
	accountSummary := AccountSummary for: receiverAccount .
	
	Transference with: 300 from: senderAccount to: receiverAccount.
	
	self assert: accountSummary entries first equals: 'entrada por transferencia de 300'.
	self assert: accountSummary entries last equals: 'balance = 300'! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'mmuu 10/24/2023 19:30:06'!
test06
	|portfolio accountSummary|
	portfolio := Portfolio new.
	
	accountSummary := AccountSummary for: portfolio .
	
	self assert: accountSummary entries size equals: 1.
	self assert: accountSummary entries first equals: 'balance = 0'! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'mmuu 10/24/2023 19:36:56'!
test07
	|portfolio account accountSummary|
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	
	Deposit register: 200 on: account.
		
	accountSummary := AccountSummary for: portfolio .
	portfolio add: account.
	
	self assert: accountSummary entries size equals: 2.
	self assert: accountSummary entries first equals: 'deposito por 200'.
	self assert: accountSummary entries last equals: 'balance = 200'! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'mmuu 10/24/2023 19:52:31'!
test08
	|portfolio account1 account2 accountSummary|
	portfolio := Portfolio new.
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Deposit register: 200 on: account1.
	Withdraw register: 100 on: account2.
		
	accountSummary := AccountSummary for: portfolio .
	portfolio add: account1.
	portfolio add: account2.
	
	self assert: accountSummary entries size equals: 3.
	self assert: accountSummary entries first equals: 'deposito por 200'.
	self assert: accountSummary entries second equals: 'extraccion por 100'.
	self assert: accountSummary entries last equals: 'balance = 100'! !


!classDefinition: #PortfolioTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #TransferNetTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferNetTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'mmuu 10/23/2023 21:29:56'!
test01
	|account transferNet|
	account := ReceptiveAccount new.
	transferNet := TransferNet for: account.
	self assert: transferNet transferNet equals: 0.	! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'mmuu 10/23/2023 21:33:56'!
test02
	|senderAccount receptiveAccount transferNet|
	senderAccount := ReceptiveAccount new.
	receptiveAccount := ReceptiveAccount new.
	transferNet := TransferNet for: senderAccount.
	
	Transference with: 2 from: senderAccount to: receptiveAccount.
	
	self assert: transferNet transferNet equals: -2.	! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'mmuu 10/23/2023 21:34:39'!
test03
	|senderAccount receptiveAccount transferenceNet|
	senderAccount := ReceptiveAccount new.
	receptiveAccount := ReceptiveAccount new.
	transferenceNet := TransferNet for: receptiveAccount .
	Transference with: 2 from: senderAccount to: receptiveAccount.
	
	self assert: transferenceNet transferNet equals: 2.	! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'mmuu 10/23/2023 21:35:01'!
test04
	|senderAccount receptiveAccount transferNet|
	senderAccount := ReceptiveAccount new.
	receptiveAccount := ReceptiveAccount new.
	transferNet := TransferNet for: senderAccount .
	Transference with: 2 from: senderAccount to: receptiveAccount.
	Transference with: 8 from: receptiveAccount to: senderAccount.
	
	self assert: transferNet transferNet equals: 6.	! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'mmuu 10/24/2023 21:58:34'!
test05
	|senderAccount receptiveAccount transferNet|
	senderAccount := ReceptiveAccount new.
	receptiveAccount := ReceptiveAccount new.
	transferNet := TransferNet for: senderAccount .
	
	Transference with: 2 from: senderAccount to: receptiveAccount.
	Deposit register: 100 on: senderAccount .
	Withdraw register: 100 on: senderAccount .
	
	self assert: transferNet transferNet equals: -2.	! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'mmuu 10/24/2023 21:57:19'!
test06
	|portfolio transferNet|
	portfolio := Portfolio new.
	
	transferNet := TransferNet for: portfolio.
	
	self assert: transferNet transferNet equals: 0.	! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'mmuu 10/24/2023 21:57:14'!
test07
	|portfolio senderAccount receptiveAccount transferNet|
	portfolio := Portfolio new.
	senderAccount := ReceptiveAccount new.
	receptiveAccount := ReceptiveAccount new.
	
	portfolio add: senderAccount .
	transferNet := TransferNet for: portfolio.
	Transference with: 2 from: senderAccount to: receptiveAccount.
	
	self assert: transferNet transferNet equals: -2.	! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'mmuu 10/24/2023 21:57:09'!
test08
	|portfolio senderAccount receptiveAccount transferNet|
	portfolio := Portfolio new.
	senderAccount := ReceptiveAccount new.
	receptiveAccount := ReceptiveAccount new.
	
	portfolio add: receptiveAccount .
	transferNet := TransferNet for: portfolio.
	Transference with: 2 from: senderAccount to: receptiveAccount.
	
	self assert: transferNet transferNet equals: 2.	! !


!classDefinition: #TransferenceTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferenceTest
	instanceVariableNames: 'senderAccount receiverAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferenceTest methodsFor: 'setup' stamp: 'mmuu 10/20/2023 16:47:04'!
setUp
	senderAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.! !


!TransferenceTest methodsFor: 'tests' stamp: 'mmuu 10/20/2023 16:47:31'!
test01transferenceShouldAffectBalanceOfSenderAndReceiver
	Deposit register: 100 on: senderAccount.
	Transference with: 100 from: senderAccount to: receiverAccount.
	
	self assert: receiverAccount balance equals: 100.
	self assert: senderAccount balance equals: 0.! !

!TransferenceTest methodsFor: 'tests' stamp: 'mmuu 10/23/2023 19:47:18'!
test02transferenceShouldAffectRegisteredTransactionsOfBothParts
	|transference|
	Deposit register: 100 on: senderAccount.
	transference := Transference with: 100 from: senderAccount to: receiverAccount.
	
	self assert: (senderAccount hasRegistered: transference withdrawLeg).
	self assert: (receiverAccount hasRegistered: transference depositLeg)! !

!TransferenceTest methodsFor: 'tests' stamp: 'mmuu 10/23/2023 19:50:02'!
test03withdrawLegCanGetTransference
	|transference|
	transference := Transference with: 100 from: senderAccount to: receiverAccount.
	
	self assert: (transference withdrawLeg transference) equals: transference.! !

!TransferenceTest methodsFor: 'tests' stamp: 'mmuu 10/23/2023 19:50:06'!
test04depositLegCanGetTransference
	|transference|
	transference := Transference with: 100 from: senderAccount to: receiverAccount.
	
	self assert: (transference depositLeg transference) equals: transference.! !

!TransferenceTest methodsFor: 'tests' stamp: 'mmuu 10/23/2023 19:47:45'!
test05depositLegCanGetWithdrawLeg
	|transference|
	
	transference := Transference with: 100 from: senderAccount to: receiverAccount.
	
	self assert: (transference depositLeg withdrawLeg) equals: transference withdrawLeg.! !

!TransferenceTest methodsFor: 'tests' stamp: 'mmuu 10/23/2023 19:47:57'!
test06withdrawLegCanGetDepositLeg
	|transference|
	
	transference := Transference with: 100 from: senderAccount to: receiverAccount.
	
	self assert: (transference withdrawLeg depositLeg) equals: transference depositLeg.! !


!classDefinition: #Account category: 'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'reports' stamp: 'mmuu 10/24/2023 21:55:28'!
makeReportFor: aReport
	accounts do: [ :anAccount |
		anAccount makeReportFor: aReport 
	].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'reports' stamp: 'mmuu 10/24/2023 21:51:28'!
makeReportFor: aReport
	transactions do: [ :anAccount |
		anAccount handleReport: aReport 
	].! !


!classDefinition: #AccountTransaction category: 'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'account summary' stamp: 'mmuu 10/24/2023 21:49:48'!
handleReport: aReport 
	aReport handleReportForDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferLegs category: 'Portfolio-Solucion'!
AccountTransaction subclass: #TransferLegs
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!


!classDefinition: #DepositLeg category: 'Portfolio-Solucion'!
TransferLegs subclass: #DepositLeg
	instanceVariableNames: 'transference'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!DepositLeg methodsFor: 'as yet unclassified' stamp: 'mmuu 10/23/2023 19:59:44'!
affectBalance: aBalance

	^aBalance + transference value! !

!DepositLeg methodsFor: 'as yet unclassified' stamp: 'mmuu 10/24/2023 21:54:07'!
handleReport: aReport 
	aReport handleReportForDepositLeg: self! !

!DepositLeg methodsFor: 'as yet unclassified' stamp: 'mmuu 10/20/2023 13:11:12'!
initializeFor: aTransference of: anAmount 
	transference := aTransference.
	value := anAmount! !

!DepositLeg methodsFor: 'as yet unclassified' stamp: 'mmuu 10/23/2023 19:49:51'!
transference
	^transference ! !

!DepositLeg methodsFor: 'as yet unclassified' stamp: 'mmuu 10/23/2023 20:20:34'!
value
	^transference value! !

!DepositLeg methodsFor: 'as yet unclassified' stamp: 'mmuu 10/23/2023 19:48:37'!
withdrawLeg
	^transference withdrawLeg ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DepositLeg class' category: 'Portfolio-Solucion'!
DepositLeg class
	instanceVariableNames: ''!

!DepositLeg class methodsFor: 'as yet unclassified' stamp: 'mmuu 10/20/2023 13:10:54'!
for: aTransference of: anAmount

	^ self new initializeFor: aTransference of: anAmount ! !


!classDefinition: #WithdrawLeg category: 'Portfolio-Solucion'!
TransferLegs subclass: #WithdrawLeg
	instanceVariableNames: 'transference'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!WithdrawLeg methodsFor: 'as yet unclassified' stamp: 'mmuu 10/23/2023 19:59:52'!
affectBalance: aBalance

	^aBalance - transference value! !

!WithdrawLeg methodsFor: 'as yet unclassified' stamp: 'mmuu 10/23/2023 19:48:42'!
depositLeg
	^transference depositLeg ! !

!WithdrawLeg methodsFor: 'as yet unclassified' stamp: 'mmuu 10/24/2023 21:53:10'!
handleReport: aReport 
	aReport handleReportForWithdrawLeg: self! !

!WithdrawLeg methodsFor: 'as yet unclassified' stamp: 'mmuu 10/23/2023 20:21:08'!
initializeFor: aTransference of: anAmount 
	transference := aTransference.! !

!WithdrawLeg methodsFor: 'as yet unclassified' stamp: 'mmuu 10/23/2023 19:49:37'!
transference
	^transference! !

!WithdrawLeg methodsFor: 'as yet unclassified' stamp: 'mmuu 10/23/2023 20:22:43'!
value
	^transference value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WithdrawLeg class' category: 'Portfolio-Solucion'!
WithdrawLeg class
	instanceVariableNames: ''!

!WithdrawLeg class methodsFor: 'as yet unclassified' stamp: 'mmuu 10/20/2023 13:08:58'!
for: aTransference of: anAmount

	^ self new initializeFor: aTransference of: anAmount ! !


!classDefinition: #Withdraw category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'account summary' stamp: 'mmuu 10/24/2023 21:52:31'!
handleReport: aReport 
	aReport handleReportForWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Reports category: 'Portfolio-Solucion'!
Object subclass: #Reports
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Reports methodsFor: 'as yet unclassified' stamp: 'mmuu 10/24/2023 22:05:32'!
handleReportForDeposit: aDeposit

	self subclassResponsibility! !


!Reports methodsFor: 'account summary' stamp: 'mmuu 10/24/2023 22:06:05'!
handleReportForDepositLeg: aDepositLeg

	self subclassResponsibility! !

!Reports methodsFor: 'account summary' stamp: 'mmuu 10/24/2023 22:06:10'!
handleReportForWithdraw: aWithdraw

	self subclassResponsibility! !

!Reports methodsFor: 'account summary' stamp: 'mmuu 10/24/2023 22:06:15'!
handleReportForWithdrawLeg: aWithdrawLeg

	self subclassResponsibility! !


!classDefinition: #AccountSummary category: 'Portfolio-Solucion'!
Reports subclass: #AccountSummary
	instanceVariableNames: 'account accountSummary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummary methodsFor: 'initialization' stamp: 'mmuu 10/23/2023 21:55:10'!
initializeFor: anAccount 
	account := anAccount.
	accountSummary := OrderedCollection new! !


!AccountSummary methodsFor: 'account summary' stamp: 'mmuu 10/24/2023 21:51:50'!
entries
	account makeReportFor: self.
	accountSummary add: 'balance = ', account balance asString.
	^accountSummary ! !

!AccountSummary methodsFor: 'account summary' stamp: 'mmuu 10/24/2023 21:50:09'!
handleReportForDeposit: aDeposit 
	accountSummary add: ('deposito por ', aDeposit value asString)! !

!AccountSummary methodsFor: 'account summary' stamp: 'mmuu 10/24/2023 21:53:50'!
handleReportForDepositLeg: aDepositLeg 
	accountSummary add: ('entrada por transferencia de ', aDepositLeg value asString)! !

!AccountSummary methodsFor: 'account summary' stamp: 'mmuu 10/24/2023 21:52:52'!
handleReportForWithdraw: aWithdraw 
	accountSummary add: ('extraccion por ', aWithdraw value asString)! !

!AccountSummary methodsFor: 'account summary' stamp: 'mmuu 10/24/2023 21:53:36'!
handleReportForWithdrawLeg: aWithdrawLeg 
	accountSummary add: ('salida por transferencia de ', aWithdrawLeg value asString)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: 'Portfolio-Solucion'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'instance creation' stamp: 'mmuu 10/22/2023 18:37:58'!
for: anAccount 
	^self new initializeFor: anAccount ! !


!classDefinition: #TransferNet category: 'Portfolio-Solucion'!
Reports subclass: #TransferNet
	instanceVariableNames: 'account transferNet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNet methodsFor: 'as yet unclassified' stamp: 'mmuu 10/24/2023 22:02:25'!
handleReportForDeposit: aDeposit ! !

!TransferNet methodsFor: 'as yet unclassified' stamp: 'mmuu 10/24/2023 22:01:53'!
handleReportForDepositLeg: aDepositLeg 
	transferNet := transferNet + aDepositLeg value! !

!TransferNet methodsFor: 'as yet unclassified' stamp: 'mmuu 10/24/2023 22:02:35'!
handleReportForWithdraw: aWithdraw ! !

!TransferNet methodsFor: 'as yet unclassified' stamp: 'mmuu 10/24/2023 22:00:56'!
handleReportForWithdrawLeg: aWithdrawLeg 
	transferNet := transferNet - aWithdrawLeg value! !

!TransferNet methodsFor: 'as yet unclassified' stamp: 'mmuu 10/23/2023 21:43:56'!
initializeFor: anAccount
	account := anAccount.
	transferNet := 0.! !

!TransferNet methodsFor: 'as yet unclassified' stamp: 'mmuu 10/24/2023 22:00:15'!
transferNet
	account makeReportFor: self.
	^transferNet! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNet class' category: 'Portfolio-Solucion'!
TransferNet class
	instanceVariableNames: ''!

!TransferNet class methodsFor: 'as yet unclassified' stamp: 'mmuu 10/23/2023 21:33:25'!
for: anAccount
	^self new initializeFor: anAccount.! !


!classDefinition: #Transference category: 'Portfolio-Solucion'!
Object subclass: #Transference
	instanceVariableNames: 'senderAccount receiverAccount value deposit withdraw'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transference methodsFor: 'initialization' stamp: 'mmuu 10/23/2023 19:46:45'!
depositLeg
	^deposit! !

!Transference methodsFor: 'initialization' stamp: 'mmuu 10/23/2023 19:59:37'!
value
	^value! !

!Transference methodsFor: 'initialization' stamp: 'mmuu 10/23/2023 19:59:29'!
with: anAmount from: aSenderAccount to: aReceiverAccount
	value := anAmount.
	deposit := DepositLeg for: self of: anAmount.
	withdraw := WithdrawLeg for: self of: anAmount.
	aSenderAccount register: withdraw.
	aReceiverAccount register: deposit.! !

!Transference methodsFor: 'initialization' stamp: 'mmuu 10/23/2023 19:46:56'!
withdrawLeg
	^withdraw! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transference class' category: 'Portfolio-Solucion'!
Transference class
	instanceVariableNames: ''!

!Transference class methodsFor: 'instance creation' stamp: 'mmuu 10/19/2023 21:37:54'!
with: anAmount from: aSenderAccount to: aReceiverAccount 
	
	^self new with: anAmount from: aSenderAccount to: aReceiverAccount ! !
