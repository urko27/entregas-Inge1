!classDefinition: #AccountSummaryTest category: 'Portfolio-Solucion'!
TestCase subclass: #AccountSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'hh 10/26/2023 01:59:09'!
test01AccountSummaryWithNoTransactionsHasCeroAsBalance

	|anAccount accountSummary|
	
	anAccount := ReceptiveAccount new.
	accountSummary := AccountSummary for: anAccount.
	
	self assert: accountSummary makeReport equals: (OrderedCollection new add: 'Balance = 0';yourself).! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'hh 10/26/2023 01:59:09'!
test02AccountSummaryProcessDepositsCorrectlyAndModifiesBalance

	|anAccount accountSummary|
	
	anAccount := ReceptiveAccount new.
	Deposit register: 100 on: anAccount .
	accountSummary := AccountSummary for: anAccount.
	
	self assert: accountSummary makeReport first equals: 'Deposit for 100'.
	self assert: accountSummary makeReport second equals: 'Balance = 100'.! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'hh 10/26/2023 01:59:09'!
test03AccountSummaryProcessWithdrawCorrectlyAndModifiesBalance

	|anAccount accountSummary|
	
	anAccount := ReceptiveAccount new.
	Withdraw register: 50 on: anAccount .
	accountSummary := AccountSummary for: anAccount.
	
	self assert: accountSummary makeReport first equals: 'Withdraw for 50'.
	self assert: accountSummary makeReport second equals: 'Balance = -50'.! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'hh 10/26/2023 01:59:09'!
test04AccountSummaryProcessWithdrawLegCorrectlyAndModifiesBalance

	|anAccount accountSummary|
	
	anAccount := ReceptiveAccount new.
	Transference from: anAccount to: ReceptiveAccount new withValue: 50.
	accountSummary := AccountSummary for: anAccount.
	
	self assert: accountSummary makeReport first equals: 'Exit by transference of 50'.
	self assert: accountSummary makeReport second equals: 'Balance = -50'.! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'hh 10/26/2023 01:59:09'!
test05AccountSummaryProcessDepositLegCorrectlyAndModifiesBalance

	|anAccount accountSummary|
	
	anAccount := ReceptiveAccount new.
	Transference from: ReceptiveAccount new to: anAccount withValue: 50.
	accountSummary := AccountSummary for: anAccount.
	
	self assert: accountSummary makeReport first equals: 'Entrance by transference of 50'.
	self assert: accountSummary makeReport second equals: 'Balance = 50'.! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'hh 10/26/2023 01:59:09'!
test06AccountSummaryProcessCorrectlyMultipleInstructionsAndReturnsCorrectBalance

	|anAccount accountSummary|
	
	anAccount := ReceptiveAccount new.
	Deposit register: 100 on: anAccount .
	Withdraw register: 50 on: anAccount .
	Transference from: anAccount to: ReceptiveAccount new withValue: 50.
	Transference from: ReceptiveAccount new to: anAccount withValue: 50.
	accountSummary := AccountSummary for: anAccount.
	
	self assert: accountSummary makeReport first equals: 'Deposit for 100'.
	self assert: accountSummary makeReport second equals: 'Withdraw for 50'.
	self assert: accountSummary makeReport third equals: 'Exit by transference of 50'.
	self assert: accountSummary makeReport fourth equals: 'Entrance by transference of 50'.
	self assert: accountSummary makeReport fifth equals: 'Balance = 50'.! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'hh 10/26/2023 01:59:09'!
test07AccountSummaryOfEmptyPortfolioReturnesCeroAsBalance

	|portfolio accountSummary|
	
	portfolio := Portfolio new.
	accountSummary := AccountSummary for: portfolio .
	
	self assert: accountSummary makeReport first equals: 'Balance = 0'.
	self assert: accountSummary makeReport size equals: 1.! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'hh 10/26/2023 01:59:09'!
test08AccountSummaryProcessCorrectlyPortfolioWithOneAccount

	|portfolio anAccount accountSummary|
	
	portfolio := Portfolio new.
	anAccount := ReceptiveAccount new.
	accountSummary := AccountSummary for: portfolio .
	Deposit register: 50 on: anAccount.
	portfolio add: anAccount .
	
	
	self assert: accountSummary makeReport first equals: 'Deposit for 50'.
	self assert: accountSummary makeReport second equals: 'Balance = 50'.
	self assert: accountSummary makeReport size equals: 2! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'hh 10/26/2023 01:59:09'!
test09AccountSummaryProcessCorrectlyPortfolioWithMultipleAccounts

	|composedPortfolio includedPortfolio includedAccount secondIncludedAccount accountSummary|
	
	composedPortfolio := Portfolio new.
	includedPortfolio := Portfolio new.
	includedAccount := ReceptiveAccount new.
	secondIncludedAccount := ReceptiveAccount new.
	accountSummary := AccountSummary for: composedPortfolio .
	Deposit register: 50 on: includedAccount.
	Withdraw register: 50 on: secondIncludedAccount.
	composedPortfolio add: includedPortfolio .
	includedPortfolio add: includedAccount .
	composedPortfolio add: secondIncludedAccount .
	
	self assert: accountSummary makeReport first equals: 'Deposit for 50'.
	self assert: accountSummary makeReport second equals: 'Withdraw for 50'.
	self assert: accountSummary makeReport third equals: 'Balance = 0'.
	self assert: accountSummary makeReport size equals: 3! !


!classDefinition: #PortfolioSpecialTreeStructureTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioSpecialTreeStructureTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioSpecialTreeStructureTest methodsFor: 'as yet unclassified' stamp: 'mm uu 10/26/2023 16:08:53'!
test01TreeStructureOfEmptyPortfolioOnlyHasItsName

	|portfolio treeStructure|
	
	portfolio := Portfolio named: 'mio'.
	treeStructure := PortfolioSpecialTreeStructure for: portfolio .
	
	self assert: treeStructure makeReport first equals: 'mio'.
	self assert: treeStructure makeReport second equals: '    Balance = 0'.
	self assert: treeStructure makeReport size equals: 2.! !

!PortfolioSpecialTreeStructureTest methodsFor: 'as yet unclassified' stamp: 'mm uu 10/26/2023 16:09:30'!
test02SpecialReportOfPortfolioWithAccount

	|portfolio account treeStructure |
	
	portfolio := Portfolio named: 'mio'.
	account := ReceptiveAccount named: 'ac'.
	treeStructure := PortfolioSpecialTreeStructure for: portfolio .
	
	portfolio add: account.
	
	self assert: treeStructure makeReport first equals: 'mio'.
	self assert: treeStructure makeReport second equals: '    ac'.
	self assert: treeStructure makeReport third equals: '        Balance = 0'.
	self assert: treeStructure makeReport fourth equals: '    Balance = 0'.
	self assert: treeStructure makeReport size equals: 4.! !

!PortfolioSpecialTreeStructureTest methodsFor: 'as yet unclassified' stamp: 'mm uu 10/26/2023 16:09:57'!
test03SpecialReportForPortfolioWithAccount

	|portfolio account treeStructure |
	
	portfolio := Portfolio named: 'mio'.
	account := ReceptiveAccount named: 'ac'.
	treeStructure := PortfolioSpecialTreeStructure for: portfolio .
	
	portfolio add: account.
	Deposit register: 200 on: account.
	
	self assert: treeStructure makeReport first equals: 'mio'.
	self assert: treeStructure makeReport second equals: '    ac'.
	self assert: treeStructure makeReport third equals: '        Deposit for 200'.
	self assert: treeStructure makeReport fourth equals: '        Balance = 200'.
	self assert: (treeStructure makeReport at: 5) equals: '    Balance = 200'.
	self assert: treeStructure makeReport size equals: 5.! !

!PortfolioSpecialTreeStructureTest methodsFor: 'as yet unclassified' stamp: 'mm uu 10/26/2023 16:10:16'!
test04SpecialReportForPortfolioWithPortfolio

	|portfolio portfolio2 treeStructure |
	
	portfolio := Portfolio named: 'mio'.
	portfolio2 := Portfolio named: 'hijo'.
	treeStructure := PortfolioSpecialTreeStructure for: portfolio .
	
	portfolio add: portfolio2.
	
	self assert: treeStructure makeReport first equals: 'mio'.
	self assert: treeStructure makeReport second equals: '    hijo'.
	self assert: treeStructure makeReport third equals: '        Balance = 0'.
	self assert: treeStructure makeReport fourth equals: '    Balance = 0'.
	self assert: treeStructure makeReport size equals: 4.! !

!PortfolioSpecialTreeStructureTest methodsFor: 'as yet unclassified' stamp: 'mm uu 10/26/2023 16:10:31'!
test05SpecialReportForPortfolioWithReportWithAccount

	|portfolio portfolio2 account treeStructure |
	
	portfolio := Portfolio named: 'mio'.
	portfolio2 := Portfolio named: 'hijo'.
	account := ReceptiveAccount named: 'cuentaHijo'.
	treeStructure := PortfolioSpecialTreeStructure for: portfolio .
	
	Deposit register: 200 on: account.
	
	portfolio2 add: account.
	portfolio add: portfolio2.
	
	self assert: treeStructure makeReport first equals: 'mio'.
	self assert: treeStructure makeReport second equals: '    hijo'.
	self assert: treeStructure makeReport third equals: '        cuentaHijo'.
	self assert: treeStructure makeReport fourth equals: '            Deposit for 200'.
	self assert:(treeStructure makeReport at: 5) equals: '            Balance = 200'.
	self assert:(treeStructure makeReport at: 6) equals: '        Balance = 200'.
	self assert:(treeStructure makeReport at: 7) equals: '    Balance = 200'.
	self assert: treeStructure makeReport size equals: 7.! !


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


!classDefinition: #PortfolioTreeStructureTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioTreeStructureTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTreeStructureTest methodsFor: 'as yet unclassified' stamp: 'hh 10/26/2023 03:48:43'!
test01TreeStructureOfEmptyPortfolioOnlyHasItsName

	|portfolio treeStructure|
	
	portfolio := Portfolio named: 'mio'.
	treeStructure := PortfolioTreeStructure for: portfolio .
	
	self assert: treeStructure makeReport first equals: 'mio'.
	self assert: treeStructure makeReport size equals: 1.! !

!PortfolioTreeStructureTest methodsFor: 'as yet unclassified' stamp: 'hh 10/26/2023 03:51:08'!
test02TreeStructureOfPortfolioWithOneAccountIsCorrect

	|composedPortfolio1 composedPortfolio2 includedAccount includedPortfolio treeStructure|
	
	composedPortfolio1 := Portfolio named: 'cp1'.
	composedPortfolio2 := Portfolio named: 'cp2'.
	includedPortfolio := Portfolio named: 'p1'.
	includedAccount := ReceptiveAccount named: 'a1'.
	
	composedPortfolio1 add: includedAccount .
	composedPortfolio2 add: includedPortfolio .
	
	treeStructure := PortfolioTreeStructure for: composedPortfolio1 .
	self assert: treeStructure makeReport  first equals: 'cp1'.
	self assert: treeStructure makeReport second equals: '    a1'.
	self assert: treeStructure makeReport size equals: 2.
	
	treeStructure := PortfolioTreeStructure for: composedPortfolio2 .
	
	self assert: treeStructure makeReport first equals: 'cp2'.
	self assert: treeStructure makeReport second equals: '    p1'.
	self assert: treeStructure makeReport size equals: 2.! !

!PortfolioTreeStructureTest methodsFor: 'as yet unclassified' stamp: 'hh 10/26/2023 03:55:57'!
test03AccountsWithNoNameHaveUnnamedAsName

	|portfolio treeStructure|
	
	portfolio := Portfolio new.
	portfolio add: ReceptiveAccount new.
	treeStructure := PortfolioTreeStructure for: portfolio .
	
	self assert: treeStructure makeReport first equals: 'Unnamed'.
	self assert: treeStructure makeReport second equals: '    Unnamed'.
	self assert: treeStructure makeReport size equals: 2.! !

!PortfolioTreeStructureTest methodsFor: 'as yet unclassified' stamp: 'hh 10/26/2023 03:52:23'!
test04TreeStructureOfPortfolioWithMultipleAccountsIsCorrect

	|composedPortfolio includedAccount includedPortfolio treeStructure|
	
	composedPortfolio := Portfolio named: 'cp1'.
	includedPortfolio := Portfolio named: 'p1'.
	includedAccount := ReceptiveAccount named: 'a1'.
	treeStructure := PortfolioTreeStructure for: composedPortfolio .
	
	composedPortfolio add: includedAccount .
	composedPortfolio add: includedPortfolio .
	
	self assert: treeStructure makeReport first equals: 'cp1'.
	self assert: treeStructure makeReport second equals: '    a1'.
	self assert: treeStructure makeReport third equals: '    p1'.
	self assert: treeStructure makeReport size equals: 3.! !

!PortfolioTreeStructureTest methodsFor: 'as yet unclassified' stamp: 'hh 10/26/2023 03:52:51'!
test05TreeStructureOfPortfolioWithAccountAndWithPortfolioWithAccountsIsIndentedCorrectly

	|composedPortfolio includedAccount includedPortfolio secondIncludedAccount treeStructure|
	
	composedPortfolio := Portfolio named: 'cp1'.
	includedPortfolio := Portfolio named: 'p1'.
	secondIncludedAccount := ReceptiveAccount named: 'a2'.
	includedAccount := ReceptiveAccount named: 'a1'.
	treeStructure := PortfolioTreeStructure for: composedPortfolio .
	
	composedPortfolio add: includedPortfolio .
	composedPortfolio add: secondIncludedAccount .
	includedPortfolio add: includedAccount .
	
	self assert: treeStructure makeReport first equals: 'cp1'.
	self assert: treeStructure makeReport second equals: '    p1'.
	self assert: treeStructure makeReport third equals: '        a1'.
	self assert: treeStructure makeReport fourth equals: '    a2'.
	self assert: treeStructure makeReport size equals: 4.! !


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

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'hh 10/26/2023 01:59:09'!
test01TransferNetWithNoTransactionsEqualsCero

	|anAccount transferNet|
	
	anAccount := ReceptiveAccount new.
	transferNet := TransferNet for: anAccount .
	
	self assert: transferNet makeReport equals: 0.! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'hh 10/26/2023 01:59:09'!
test02TransferNetProcessDepositLegCorrectly

	|anAccount transferNet|
	
	anAccount := ReceptiveAccount new.
	transferNet := TransferNet for: anAccount .
	
	Transference from: anAccount to: ReceptiveAccount new withValue: 50.
	
	self assert: transferNet makeReport equals: -50.! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'hh 10/26/2023 01:59:09'!
test03TransferNetProcessWithdrawLegCorrectly

	|anAccount transferNet|
	
	anAccount := ReceptiveAccount new.
	transferNet := TransferNet for: anAccount .
	
	Transference from: ReceptiveAccount new to: anAccount withValue: 50.
	
	self assert: transferNet makeReport equals: 50.! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'hh 10/26/2023 01:59:09'!
test04TransferNetGivesCorrectTransferNetForMultipleTransferences

	|anAccount transferNet|
	
	anAccount := ReceptiveAccount new.
	transferNet := TransferNet for: anAccount .
	
	Transference from: ReceptiveAccount new to: anAccount withValue: 50.
	Transference from: anAccount to: ReceptiveAccount new withValue: 20.
	Transference from: ReceptiveAccount new to: anAccount withValue: 10.
	
	self assert: transferNet makeReport equals: 40.! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'hh 10/26/2023 01:59:09'!
test05TransactionsOtherThanTransferencesDoNotAffectTransferNet

	|anAccount transferNet|
	
	anAccount := ReceptiveAccount new.
	transferNet := TransferNet for: anAccount.
	Deposit register: 50 on: anAccount .
	Withdraw register: 20 on: anAccount.
	
	Transference from: ReceptiveAccount new to: anAccount withValue: 50.
	
	self assert: transferNet makeReport equals: 50.! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'hh 10/26/2023 01:59:09'!
test06TransferNetOfEmptyPortfoloEqualsCero

	|portfolio transferNet|
	
	portfolio := ReceptiveAccount new.
	transferNet := TransferNet for: portfolio.
	
	self assert: transferNet makeReport equals: 0.! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'hh 10/26/2023 01:59:09'!
test07CorrectTransferNetForPortfolioWithOneAccount

	|portfolio anAccount transferNet|
	portfolio := Portfolio new.
	anAccount := ReceptiveAccount new.
	
	portfolio add: anAccount .
	transferNet := TransferNet for: portfolio.
	Transference from: ReceptiveAccount new to: anAccount withValue: 50.
	
	self assert: transferNet makeReport equals: 50.	! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'hh 10/26/2023 01:59:08'!
test08CorrectTransferNetForPortfolioWithMultipleAccount

	|composedPortfolio includedAccount includedPortfolio secondIncludedAccount transferNet|
	
	composedPortfolio := Portfolio new.
	includedPortfolio := Portfolio new.
	includedAccount := ReceptiveAccount new.
	secondIncludedAccount := ReceptiveAccount new.
	
	composedPortfolio add: includedAccount .
	composedPortfolio add: includedPortfolio .
	includedPortfolio add: secondIncludedAccount .
	
	transferNet := TransferNet for: composedPortfolio.
	Transference  from: ReceptiveAccount new to: secondIncludedAccount withValue: 30.
	Transference  from: includedAccount to: ReceptiveAccount new withValue: 10.
	
	self assert: transferNet makeReport equals: 20.	! !


!classDefinition: #TransferenceTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferenceTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferenceTest methodsFor: 'as yet unclassified' stamp: 'hh 10/22/2023 19:09:15'!
test01TransferenceChangesAccountsBalance

	|senderAccount receiverAccount|
	
	senderAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.
	Deposit register: 100 on: senderAccount .
	
	Transference from: senderAccount to: receiverAccount withValue: 100.
	
	self assert: senderAccount balance equals: 0.
	self assert: receiverAccount balance equals: 100.! !

!TransferenceTest methodsFor: 'as yet unclassified' stamp: 'hh 10/22/2023 23:31:26'!
test02TransferenceAccountsHaveTransferenceLegRegistered

	|senderAccount receiverAccount transference|
	
	senderAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.
	Deposit register: 100 on: senderAccount .
	
	transference := Transference from: senderAccount to: receiverAccount withValue: 100.
	
	self assert: (transference accountHasWithdrawLegRegistered: senderAccount ).
	self assert: (transference accountHasDepositLegRegistered: receiverAccount ).! !

!TransferenceTest methodsFor: 'as yet unclassified' stamp: 'hh 10/22/2023 23:25:02'!
test03WithdrawLegCanNagivateToTransference

	|senderAccount receiverAccount transference|
	
	senderAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.
	
	transference := Transference from: senderAccount to: receiverAccount withValue: 100.
	
	self assert: (transference withdrawLeg transference ) equals: transference .! !

!TransferenceTest methodsFor: 'as yet unclassified' stamp: 'hh 10/22/2023 23:26:10'!
test04DepositLegCanNagivateToTransference

	|senderAccount receiverAccount transference|
	
	senderAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.
	
	transference := Transference from: senderAccount to: receiverAccount withValue: 100.
	
	self assert: (transference depositLeg transference ) equals: transference .! !

!TransferenceTest methodsFor: 'as yet unclassified' stamp: 'hh 10/22/2023 23:28:53'!
test05DepositLegCanNagivateToWithdrawLeg

	|senderAccount receiverAccount transference|
	
	senderAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.
	
	transference := Transference from: senderAccount to: receiverAccount withValue: 100.
	
	self assert: (transference depositLeg withdrawLeg ) equals: transference withdrawLeg .! !

!TransferenceTest methodsFor: 'as yet unclassified' stamp: 'hh 10/22/2023 23:29:25'!
test06WithdrawLegCanNagivateToDepositLeg

	|senderAccount receiverAccount transference|
	
	senderAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.
	
	transference := Transference from: senderAccount to: receiverAccount withValue: 100.
	
	self assert: (transference withdrawLeg depositLeg ) equals: transference depositLeg .! !

!TransferenceTest methodsFor: 'as yet unclassified' stamp: 'hh 10/22/2023 23:33:59'!
test07WithdrawLegKnowsTransferenceValue

	|senderAccount receiverAccount transference|
	
	senderAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.
	
	transference := Transference from: senderAccount to: receiverAccount withValue: 100.
	
	self assert: (transference withdrawLeg value ) equals: transference value .! !

!TransferenceTest methodsFor: 'as yet unclassified' stamp: 'hh 10/22/2023 23:34:30'!
test08DepositLegKnowsTransferenceValue

	|senderAccount receiverAccount transference|
	
	senderAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.
	
	transference := Transference from: senderAccount to: receiverAccount withValue: 100.
	
	self assert: (transference depositLeg value ) equals: transference value .! !


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
	instanceVariableNames: 'accounts parents name'
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


!Portfolio methodsFor: 'initialization' stamp: 'hh 10/26/2023 03:55:23'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.
	name := 'Unnamed'.! !

!Portfolio methodsFor: 'initialization' stamp: 'hh 10/26/2023 02:27:51'!
initializeNamed: portfolioName

	accounts := OrderedCollection new.
	parents := OrderedCollection new.
	name := portfolioName .! !


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


!Portfolio methodsFor: 'name' stamp: 'hh 10/26/2023 02:46:17'!
name

	^name! !


!Portfolio methodsFor: 'reports' stamp: 'hh 10/26/2023 03:42:13'!
handleReportFor: aPortfolioOnlyReport
	
	aPortfolioOnlyReport portfolioReportOperation: self! !

!Portfolio methodsFor: 'reports' stamp: 'hh 10/26/2023 14:48:31'!
makeReportFor: aReport
	
	accounts do: [:anAccount |
		anAccount handleReportFor: aReport
		].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'hh 10/26/2023 02:27:26'!
named: accountName
	
	^self new initializeNamed: accountName! !

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
	instanceVariableNames: 'transactions name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'hh 10/26/2023 03:55:30'!
initialize

	super initialize.
	transactions := OrderedCollection new.
	name := 'Unnamed'.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'hh 10/26/2023 02:40:34'!
initializeNamed: accountName

	transactions := OrderedCollection new.
	name := accountName .! !


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


!ReceptiveAccount methodsFor: 'reports' stamp: 'hh 10/26/2023 03:41:46'!
handleReportFor: aPortfolioOnlyReport
	
	aPortfolioOnlyReport receptiveAccountReportOperation: self.! !

!ReceptiveAccount methodsFor: 'reports' stamp: 'hh 10/26/2023 01:18:53'!
makeReportFor: aReport
	
	transactions do: [:aTransaction |
			aTransaction handleReportFor: aReport 
		].! !


!ReceptiveAccount methodsFor: 'name' stamp: 'hh 10/26/2023 02:45:44'!
name

	^name.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'Portfolio-Solucion'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'as yet unclassified' stamp: 'hh 10/26/2023 02:40:04'!
named: accountName
	
	^self new initializeNamed: accountName! !


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


!AccountTransaction methodsFor: 'reportOperation' stamp: 'hh 10/26/2023 01:17:55'!
handleReportFor: aReport

	self subclassResponsibility! !

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



!Deposit methodsFor: 'reportOperation' stamp: 'hh 10/26/2023 01:18:08'!
handleReportFor: aReport

	aReport depositOperation: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferenceLegs category: 'Portfolio-Solucion'!
AccountTransaction subclass: #TransferenceLegs
	instanceVariableNames: 'transference'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferenceLegs methodsFor: 'initialize' stamp: 'hh 10/22/2023 19:17:35'!
initializeFor: aTransference

	transference := aTransference .! !




!TransferenceLegs methodsFor: 'reportOperation' stamp: 'hh 10/26/2023 01:18:14'!
handleReportFor: aReport

	self subclassResponsibility! !


!TransferenceLegs methodsFor: 'transference' stamp: 'mm uu 10/26/2023 16:10:51'!
transference
	^transference ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferenceLegs class' category: 'Portfolio-Solucion'!
TransferenceLegs class
	instanceVariableNames: ''!

!TransferenceLegs class methodsFor: 'as yet unclassified' stamp: 'hh 10/22/2023 19:16:09'!
for: transference

	^self new initializeFor: transference .! !


!classDefinition: #DepositLeg category: 'Portfolio-Solucion'!
TransferenceLegs subclass: #DepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!DepositLeg methodsFor: 'affectBalance' stamp: 'hh 10/22/2023 19:20:48'!
affectBalance: currentBalance

	^currentBalance + transference value! !



!DepositLeg methodsFor: 'withdrawLeg' stamp: 'hh 10/22/2023 23:28:24'!
withdrawLeg
	
	^transference withdrawLeg ! !


!DepositLeg methodsFor: 'value' stamp: 'hh 10/22/2023 23:34:41'!
value
	
	^transference value! !



!DepositLeg methodsFor: 'reportOperation' stamp: 'hh 10/26/2023 01:18:22'!
handleReportFor: aReport

	aReport depositLegOperation: self! !


!classDefinition: #WithdrawLeg category: 'Portfolio-Solucion'!
TransferenceLegs subclass: #WithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!WithdrawLeg methodsFor: 'affectBalance' stamp: 'hh 10/22/2023 19:21:01'!
affectBalance: currentBalance

	^currentBalance + transference value negated! !


!WithdrawLeg methodsFor: 'transference' stamp: 'hh 10/22/2023 23:25:51'!
transference
	
	^transference! !


!WithdrawLeg methodsFor: 'depositLeg' stamp: 'hh 10/22/2023 23:29:44'!
depositLeg
	
	^transference depositLeg ! !


!WithdrawLeg methodsFor: 'value' stamp: 'hh 10/22/2023 23:34:15'!
value
	
	^transference value! !



!WithdrawLeg methodsFor: 'reportOperation' stamp: 'hh 10/26/2023 01:18:31'!
handleReportFor: aReport

	aReport withdrawLegOperation: self! !


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


!Withdraw methodsFor: 'reportOperation' stamp: 'hh 10/26/2023 01:18:40'!
handleReportFor: aReport

	aReport withdrawOperation: self! !


!Withdraw methodsFor: 'affectBalance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Report category: 'Portfolio-Solucion'!
Object subclass: #Report
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Report methodsFor: 'compute' stamp: 'hh 10/26/2023 01:58:35'!
makeReport

	self subclassResponsibility! !


!Report methodsFor: 'operations' stamp: 'hh 10/25/2023 16:16:32'!
depositLegOperation: aDepositLeg

	self subclassResponsibility! !

!Report methodsFor: 'operations' stamp: 'hh 10/25/2023 16:16:35'!
depositOperation: aDeposit

	self subclassResponsibility! !

!Report methodsFor: 'operations' stamp: 'hh 10/25/2023 16:16:38'!
withdrawLegOperation: aWithdrawLeg

	self subclassResponsibility! !

!Report methodsFor: 'operations' stamp: 'hh 10/25/2023 16:16:40'!
withdrawOperation: aWithdraw

	self subclassResponsibility! !


!classDefinition: #AccountRelatedReport category: 'Portfolio-Solucion'!
Report subclass: #AccountRelatedReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountRelatedReport methodsFor: 'as yet unclassified' stamp: 'mm uu 10/26/2023 16:14:16'!
initializeFor: aPortfolio

	self subclassResponsibility! !

!AccountRelatedReport methodsFor: 'as yet unclassified' stamp: 'mm uu 10/26/2023 16:13:18'!
makeReport

	self subclassResponsibility! !

!AccountRelatedReport methodsFor: 'as yet unclassified' stamp: 'mm uu 10/26/2023 16:13:22'!
portfolioReportOperation: aPortfolio

	self subclassResponsibility! !

!AccountRelatedReport methodsFor: 'as yet unclassified' stamp: 'mm uu 10/26/2023 16:13:25'!
receptiveAccountReportOperation: aReceptiveAccount

	self subclassResponsibility! !


!classDefinition: #PortfolioSpecialTreeStructure category: 'Portfolio-Solucion'!
AccountRelatedReport subclass: #PortfolioSpecialTreeStructure
	instanceVariableNames: 'portfolio treeStructure report'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioSpecialTreeStructure methodsFor: 'as yet unclassified' stamp: 'mm uu 10/26/2023 15:43:48'!
initializeFor: aPortfolio
	portfolio := aPortfolio .
	report := OrderedCollection new.! !

!PortfolioSpecialTreeStructure methodsFor: 'as yet unclassified' stamp: 'mm uu 10/26/2023 15:59:54'!
makeReport
	report := OrderedCollection new.
	report add: portfolio name.
	portfolio makeReportFor: self.
	report add: '    Balance = ', portfolio balance asString.
	^report ! !

!PortfolioSpecialTreeStructure methodsFor: 'as yet unclassified' stamp: 'mm uu 10/26/2023 16:03:54'!
portfolioReportOperation: aPortfolio 
	|portfolioTree|
	
	portfolioTree := PortfolioSpecialTreeStructure for: aPortfolio.
	
	report addAll: (portfolioTree makeReport collect: [:portfolioSpecialSummary | '    ',portfolioSpecialSummary])! !

!PortfolioSpecialTreeStructure methodsFor: 'as yet unclassified' stamp: 'mm uu 10/26/2023 15:52:31'!
receptiveAccountReportOperation: aReceptiveAccount 
	|accountSummary|
	report add: ('    ', aReceptiveAccount name).
	accountSummary := AccountSummary for: aReceptiveAccount .
	accountSummary makeReport do: [:transactionSummary |
		report add: '        ', transactionSummary
	].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioSpecialTreeStructure class' category: 'Portfolio-Solucion'!
PortfolioSpecialTreeStructure class
	instanceVariableNames: ''!

!PortfolioSpecialTreeStructure class methodsFor: 'instance creation' stamp: 'mm uu 10/26/2023 15:19:52'!
for: aPortfolio
	^self new initializeFor: aPortfolio ! !


!classDefinition: #PortfolioTreeStructure category: 'Portfolio-Solucion'!
AccountRelatedReport subclass: #PortfolioTreeStructure
	instanceVariableNames: 'portfolio treeStructure'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTreeStructure methodsFor: 'makeReport' stamp: 'hh 10/26/2023 14:59:30'!
makeReport

	treeStructure := OrderedCollection new.

	treeStructure add: portfolio name.
	portfolio makeReportFor: self.
	
	^treeStructure! !


!PortfolioTreeStructure methodsFor: 'initialize' stamp: 'hh 10/26/2023 03:22:39'!
initializeWith: aPortfolio 

	portfolio := aPortfolio .
	treeStructure := OrderedCollection new.! !


!PortfolioTreeStructure methodsFor: 'reportOperations' stamp: 'hh 10/26/2023 03:46:00'!
portfolioReportOperation: aPortfolio
	
	|portfolioTree|
	
	portfolioTree := PortfolioTreeStructure for: aPortfolio.
	
	treeStructure addAll: (portfolioTree makeReport collect: [:accountName | '    ',accountName])! !

!PortfolioTreeStructure methodsFor: 'reportOperations' stamp: 'hh 10/26/2023 03:43:19'!
receptiveAccountReportOperation: aReceptiveAccount

	treeStructure add: '    ',aReceptiveAccount name! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioTreeStructure class' category: 'Portfolio-Solucion'!
PortfolioTreeStructure class
	instanceVariableNames: ''!

!PortfolioTreeStructure class methodsFor: 'as yet unclassified' stamp: 'hh 10/26/2023 03:21:16'!
for: aPortfolio

	^self new initializeWith: aPortfolio .! !


!classDefinition: #TransactionsRelatedReport category: 'Portfolio-Solucion'!
Report subclass: #TransactionsRelatedReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransactionsRelatedReport methodsFor: 'operations' stamp: 'mm uu 10/26/2023 16:13:38'!
depositLegOperation: aDepositLeg

	self subclassResponsibility! !

!TransactionsRelatedReport methodsFor: 'operations' stamp: 'mm uu 10/26/2023 16:13:42'!
depositOperation: aDeposit

	self subclassResponsibility! !

!TransactionsRelatedReport methodsFor: 'operations' stamp: 'mm uu 10/26/2023 16:14:08'!
portfolioReportOperation: aPortfolio

	self subclassResponsibility! !

!TransactionsRelatedReport methodsFor: 'operations' stamp: 'mm uu 10/26/2023 16:13:52'!
receptiveAccountReportOperation: aReceptiveAccount

	self subclassResponsibility! !

!TransactionsRelatedReport methodsFor: 'operations' stamp: 'mm uu 10/26/2023 16:13:59'!
withdrawLegOperation: aWithdrawLeg

	self subclassResponsibility! !

!TransactionsRelatedReport methodsFor: 'operations' stamp: 'mm uu 10/26/2023 16:14:01'!
withdrawOperation: aWithdraw

	self subclassResponsibility! !


!TransactionsRelatedReport methodsFor: 'initialize' stamp: 'mm uu 10/26/2023 16:13:45'!
initializeFor: anAccount

	self subclassResponsibility! !


!TransactionsRelatedReport methodsFor: 'compute' stamp: 'mm uu 10/26/2023 16:13:49'!
makeReport

	self subclassResponsibility! !


!classDefinition: #AccountSummary category: 'Portfolio-Solucion'!
TransactionsRelatedReport subclass: #AccountSummary
	instanceVariableNames: 'account summary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummary methodsFor: 'initialize' stamp: 'hh 10/25/2023 15:15:50'!
initializeFor: anAccount 
	
	account := anAccount.
	summary := OrderedCollection new.! !


!AccountSummary methodsFor: 'compute' stamp: 'hh 10/26/2023 01:58:35'!
makeReport

	summary := OrderedCollection new.
	
	account makeReportFor: self.
	
	summary add: 'Balance = ',account balance asString.
	
	^summary! !


!AccountSummary methodsFor: 'operations' stamp: 'hh 10/25/2023 16:06:57'!
depositLegOperation: aDepositLeg

	^summary add: 'Entrance by transference of ',aDepositLeg value asString.! !

!AccountSummary methodsFor: 'operations' stamp: 'hh 10/25/2023 16:02:32'!
depositOperation: aDeposit

	^summary add: 'Deposit for ', aDeposit value asString! !

!AccountSummary methodsFor: 'operations' stamp: 'hh 10/26/2023 14:56:41'!
portfolioReportOperation: aPortfolio

	aPortfolio makeReportFor: self! !

!AccountSummary methodsFor: 'operations' stamp: 'hh 10/26/2023 14:54:46'!
receptiveAccountReportOperation: aReceptiveAccount

	aReceptiveAccount makeReportFor: self.! !

!AccountSummary methodsFor: 'operations' stamp: 'hh 10/25/2023 16:04:09'!
withdrawLegOperation: aWithdrawLeg

	^summary add: 'Exit by transference of ', aWithdrawLeg value asString! !

!AccountSummary methodsFor: 'operations' stamp: 'hh 10/25/2023 16:02:39'!
withdrawOperation: aWithdraw

	^summary add: 'Withdraw for ', aWithdraw value asString! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: 'Portfolio-Solucion'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'instance creation' stamp: 'hh 10/25/2023 14:26:56'!
for: anAccount 

	^self new initializeFor: anAccount.! !


!classDefinition: #TransferNet category: 'Portfolio-Solucion'!
TransactionsRelatedReport subclass: #TransferNet
	instanceVariableNames: 'account transferNet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNet methodsFor: 'initialize' stamp: 'hh 10/25/2023 15:37:49'!
initializeFor: anAccount 
	
	account := anAccount.
	transferNet := 0.! !


!TransferNet methodsFor: 'compute' stamp: 'hh 10/26/2023 01:58:35'!
makeReport
	
	transferNet := 0.
	
	account makeReportFor: self.
	
	^transferNet .! !


!TransferNet methodsFor: 'operations' stamp: 'hh 10/25/2023 16:11:28'!
depositLegOperation: aDepositLeg

	transferNet := transferNet + aDepositLeg value.
	
! !

!TransferNet methodsFor: 'operations' stamp: 'hh 10/25/2023 16:11:33'!
depositOperation: aDeposit! !

!TransferNet methodsFor: 'operations' stamp: 'hh 10/26/2023 14:57:30'!
portfolioReportOperation: aPortfolio

	aPortfolio makeReportFor: self
	
! !

!TransferNet methodsFor: 'operations' stamp: 'hh 10/26/2023 14:57:16'!
receptiveAccountReportOperation: aReceptiveAccount

	aReceptiveAccount makeReportFor: self
	
! !

!TransferNet methodsFor: 'operations' stamp: 'hh 10/25/2023 16:11:11'!
withdrawLegOperation: aWithdrawLeg

	transferNet := transferNet - aWithdrawLeg value.
	
! !

!TransferNet methodsFor: 'operations' stamp: 'hh 10/25/2023 16:10:44'!
withdrawOperation: aWithdraw
	
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNet class' category: 'Portfolio-Solucion'!
TransferNet class
	instanceVariableNames: ''!

!TransferNet class methodsFor: 'instance creation' stamp: 'hh 10/25/2023 15:28:01'!
for: anAccount 
	
	^self new initializeFor: anAccount.! !


!classDefinition: #Transference category: 'Portfolio-Solucion'!
Object subclass: #Transference
	instanceVariableNames: 'withdrawLeg depositLeg value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transference methodsFor: 'initialize' stamp: 'hh 10/22/2023 19:30:06'!
with: transferenceValue from: senderAccount to: receiverAccount

	withdrawLeg := WithdrawLeg register: self on: senderAccount .
	depositLeg := DepositLeg register: self on: receiverAccount .
	value := transferenceValue .! !


!Transference methodsFor: 'value' stamp: 'hh 10/22/2023 19:21:19'!
value

	^value! !


!Transference methodsFor: 'tests' stamp: 'hh 10/22/2023 23:31:17'!
accountHasDepositLegRegistered: anAccount 
	
	^anAccount hasRegistered: depositLeg .! !

!Transference methodsFor: 'tests' stamp: 'hh 10/22/2023 23:31:03'!
accountHasWithdrawLegRegistered: anAccount 
	
	^anAccount hasRegistered: withdrawLeg ! !


!Transference methodsFor: 'legs' stamp: 'hh 10/22/2023 23:26:18'!
depositLeg
	
	^depositLeg! !

!Transference methodsFor: 'legs' stamp: 'hh 10/22/2023 23:25:21'!
withdrawLeg
	
	^withdrawLeg! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transference class' category: 'Portfolio-Solucion'!
Transference class
	instanceVariableNames: ''!

!Transference class methodsFor: 'instance creation' stamp: 'hh 10/22/2023 19:21:55'!
from: senderAccount to: receiverAccount withValue: transferenceValue
	
	^self new with: transferenceValue from: senderAccount to: receiverAccount .! !
