!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'mm uu 11/7/2023 17:44:08'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart class invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'mm uu 11/7/2023 17:43:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart class invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #InterfazEntradaTests category: 'TusLibros'!
TestCase subclass: #InterfazEntradaTests
	instanceVariableNames: 'factory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InterfazEntradaTests methodsFor: 'setup' stamp: 'mm uu 11/6/2023 20:19:48'!
setUp
	factory := StoreTestObjectsFactory new! !


!InterfazEntradaTests methodsFor: 'support' stamp: 'mm uu 11/8/2023 14:25:42'!
createCartForClient: aClient with: aPassword add: anItem withOcurrences: ocurrences with: anInterface
	|cartId card merchantProcessor |
	card := factory notExpiredCreditCard .
	merchantProcessor := MerchantProcessorStub withDefaultBehavior: [:anAmount :aCreditCard|].
	
	cartId := anInterface 
		createCartFor: aClient
		withPassword: aPassword.
	anInterface addToCartWithId: cartId 
			item: anItem
			withOcurrences: ocurrences.
	^ anInterface 
		checkoutCartId: cartId
		charging: card
		through: merchantProcessor
		on: factory today.! !


!InterfazEntradaTests methodsFor: 'tests' stamp: 'mm uu 11/8/2023 16:58:47'!
test00CannotCreateCartWithInvalidPassword
	|interfaz |
	interfaz := factory defaultInterface .
	
	self 
		should: [ interfaz createCartFor: 'e' withPassword: 'pass']
		raise: Error
		withExceptionDo: [:anError | self assert: anError messageText equals: InterfazEntrada invalidCredentialsErrorMessage].! !

!InterfazEntradaTests methodsFor: 'tests' stamp: 'mm uu 11/8/2023 16:21:18'!
test01CannotCreateCartWithInvalidUser
	|interfaz |
	interfaz := factory defaultInterface .
	
	self 
		should: [ interfaz createCartFor: 'pepe' withPassword: 'a']
		raise: Error
		withExceptionDo: [:anError | self assert: anError messageText equals: InterfazEntrada invalidCredentialsErrorMessage].! !

!InterfazEntradaTests methodsFor: 'tests' stamp: 'mm uu 11/8/2023 17:01:48'!
test02CanCreateCartWithValidUserAndPassword
	|interfaz cartId|
	
	interfaz := factory defaultInterface .
	cartId := factory createCartForDefaultUserWith: interfaz.
	
	self assert: (interfaz listCartWithId: cartId) equals: Bag new.
	
	! !

!InterfazEntradaTests methodsFor: 'tests' stamp: 'mm uu 11/8/2023 17:02:03'!
test03CanAddItemToCart
	|interfaz cartId|
	
	interfaz := factory defaultInterface .
	cartId := factory createCartForDefaultUserWith: interfaz.
	
	interfaz addToCartWithId: cartId item: factory itemSellByTheStore withOcurrences: 1.
	
	self 
		assert: (interfaz listCartWithId: cartId) 
		equals: (Bag with: factory itemSellByTheStore) .
	
	! !

!InterfazEntradaTests methodsFor: 'tests' stamp: 'mm uu 11/8/2023 17:02:07'!
test04CanAddMultipleItemsToCart
	|interfaz cartId|
	interfaz := factory defaultInterface .
	cartId := factory createCartForDefaultUserWith: interfaz.
	
	interfaz addToCartWithId: cartId item: factory itemSellByTheStore withOcurrences: 2.
	
	self 
		assert: (interfaz listCartWithId: cartId) 
		equals: (Bag with: factory itemSellByTheStore with: factory itemSellByTheStore) .
	
	! !

!InterfazEntradaTests methodsFor: 'tests' stamp: 'mm uu 11/8/2023 16:21:27'!
test05CannotAddItemsToInvalidCart
	|interfaz |
	interfaz := factory defaultInterface .
	
	self
		should: [interfaz addToCartWithId: 9 item: factory itemSellByTheStore withOcurrences: 2]
		raise: Error
		withExceptionDo: [:anError | self assert: anError messageText equals: InterfazEntrada invalidCartId].
	! !

!InterfazEntradaTests methodsFor: 'tests' stamp: 'mm uu 11/8/2023 16:21:36'!
test06CannotListItemsForInvalidCart
	|interfaz |
	interfaz := factory defaultInterface .
	
	self
		should: [interfaz listCartWithId: 9]
		raise: Error
		withExceptionDo: [:anError | self assert: anError messageText equals: InterfazEntrada invalidCartId].
	! !

!InterfazEntradaTests methodsFor: 'tests' stamp: 'mm uu 11/8/2023 17:02:29'!
test07CanCreateMultipleCartsForDifferentUsers
	|interfaz users cartIdOne cartIdTwo|
	users := factory defaultUsers .
	users add: #pp -> #holi.
	interfaz := factory createInterfaceWithUsers: users.
	
	cartIdOne := factory createCartForDefaultUserWith: interfaz.
	cartIdTwo := interfaz createCartFor: 'pp' withPassword: 'holi'.
	
	interfaz addToCartWithId: cartIdOne item: factory itemSellByTheStore withOcurrences: 2.
	interfaz addToCartWithId: cartIdTwo item: factory itemSellByTheStore withOcurrences: 1.
	
	self 
		assert: (interfaz listCartWithId: cartIdOne ) 
		equals: (Bag with: factory itemSellByTheStore with: factory itemSellByTheStore) .

	self 
		assert: (interfaz listCartWithId: cartIdTwo ) 
		equals: (Bag with: factory itemSellByTheStore) .	
	! !

!InterfazEntradaTests methodsFor: 'tests' stamp: 'mm uu 11/8/2023 17:02:56'!
test08CannotCheckoutEmptyCart
	|interfaz cartId card merchantProcessor|
	interfaz := factory defaultInterface .
		
	card := factory notExpiredCreditCard .
	merchantProcessor := factory merchantProcessorWithNoBehaviour .
	cartId := factory createCartForDefaultUserWith: interfaz.
	
	self 
		should: [interfaz 
			checkoutCartId: cartId 
			charging: card 
			through: merchantProcessor 
			on: factory today
		]
		raise: Error
		withExceptionDo: [:anError | self assert: anError messageText equals: Cashier cartCanNotBeEmptyErrorMessage ]! !

!InterfazEntradaTests methodsFor: 'tests' stamp: 'mm uu 11/8/2023 17:03:09'!
test09CannotAddItemThatIsNotInCatalog
	|interface cartId |
	
	interface := factory defaultInterface .
	cartId := factory createCartForDefaultUserWith: interface.
	
	self 
		should: [
			interface addToCartWithId: cartId 
			item: factory itemNotSellByTheStore 
			withOcurrences: 1.]
		raise: Error
		withExceptionDo: [
			:anError | self assert: anError messageText equals: Cart invalidItemErrorMessage ]! !

!InterfazEntradaTests methodsFor: 'tests' stamp: 'mm uu 11/8/2023 16:58:31'!
test11InterfaceShowsPurchaseAfterCheckout
	|interface|
	
	interface := factory defaultInterface .
	
	self 
		createCartForClient: factory defaultUsername 
		with: factory defaultPassword 
		add: factory itemSellByTheStore 
		withOcurrences: 1
		with: interface.
		
	self 
		assert:  (interface listPurchasesFor: factory defaultUsername and: factory defaultPassword )
		equals: (OrderedCollection 
			with: factory itemSellByTheStore with: 1
			with: factory itemSellByTheStorePrice )! !

!InterfazEntradaTests methodsFor: 'tests' stamp: 'mm uu 11/8/2023 16:58:20'!
test12InterfaceShowsMultiplePurchasesAfterMultipleCheckouts
	|interface|
	interface := factory defaultInterface.
		
	self 
		createCartForClient: factory defaultUsername 
		with: factory defaultPassword 
		add: factory itemSellByTheStore 
		withOcurrences: 1
		with: interface.
	self 
		createCartForClient: factory defaultUsername 
		with: factory defaultPassword 
		add: factory anotherItemSellByTheStore 
		withOcurrences: 1
		with: interface.
					
	self 
		assert:  (interface listPurchasesFor: factory defaultUsername and: factory defaultPassword )
		equals: (OrderedCollection 
			with: factory itemSellByTheStore with: 1 
			with: factory anotherItemSellByTheStore with: 1
			with: factory itemSellByTheStorePrice + factory itemSellByTheStorePrice)! !

!InterfazEntradaTests methodsFor: 'tests' stamp: 'mm uu 11/8/2023 16:58:16'!
test13InterfaceShowsMultiplePurchasesForDifferentClients
	|interface users transactionId anotherTransactionId|
	users := factory defaultUsers .
	users at: 'juan' put: 'pepito' .
	
	interface := InterfazEntrada withUsers: users withCatalog: factory defaultCatalog withDateTime: (DateTimeSimulator startingAt: factory today).
	
	transactionId := self 
		createCartForClient: factory defaultUsername 
		with: factory defaultPassword 
		add: factory itemSellByTheStore 
		withOcurrences: 1
		with: interface.
	
	anotherTransactionId := self
		createCartForClient: 'juan'
		with: 'pepito' 
		add: factory anotherItemSellByTheStore 
		withOcurrences: 2
		with: interface.
		
	self deny: transactionId = anotherTransactionId .
	self 
		assert:  (interface listPurchasesFor: factory defaultUsername and: factory defaultPassword )
		equals: (OrderedCollection 
			with: factory itemSellByTheStore with: 1 
			with: factory itemSellByTheStorePrice ).
	self assert: (interface listPurchasesFor: 'juan' and: 'pepito')
		equals:(OrderedCollection 
			with: factory anotherItemSellByTheStore with: 2
			with: factory itemSellByTheStorePrice * 2)! !

!InterfazEntradaTests methodsFor: 'tests' stamp: 'mm uu 11/8/2023 16:58:11'!
test14CanNotOperateWithExpiredCart
	|interface users dateTimeSimulator cartId|
	users := factory defaultUsers .
	dateTimeSimulator := DateTimeSimulator startingAt: factory today.
	
	interface := InterfazEntrada 
		withUsers: users 
		withCatalog: factory defaultCatalog
		withDateTime: dateTimeSimulator.
	
	cartId := interface createCartFor: factory defaultUsername withPassword: factory defaultPassword .
		
	dateTimeSimulator forward: 31 minutes.
	
	self 
		should: [interface addToCartWithId: cartId item: factory itemSellByTheStore withOcurrences: 1]
		raise: Error
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: interface class cartIsExpiredErrorMessage.
		].
	self 
		should: [interface addToCartWithId: cartId item: factory itemSellByTheStore withOcurrences: 1]
		raise: Error
		withExceptionDo: [:anError |
			self assert: anError messageText equals: interface class invalidCartId .
		]! !

!InterfazEntradaTests methodsFor: 'tests' stamp: 'mm uu 11/8/2023 16:58:06'!
test15OperationRefreshesSession
	|interface dateTimeSimulator cartId|
	dateTimeSimulator := DateTimeSimulator startingAt: factory today.
	interface := InterfazEntrada 
		withUsers: factory defaultUsers 
		withCatalog: factory defaultCatalog
		withDateTime: dateTimeSimulator.
	
	cartId := interface createCartFor: factory defaultUsername withPassword: factory defaultPassword .
		
	dateTimeSimulator forward: 28 minutes.
	
	interface addToCartWithId: cartId item: factory itemSellByTheStore withOcurrences: 1.
	
	dateTimeSimulator forward: 5 minutes.
	
	self 
		shouldnt: [interface addToCartWithId: cartId item: factory itemSellByTheStore withOcurrences: 1.]
		raise: Error.! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'mm uu 11/7/2023 17:43:35'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self class invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'mm uu 11/6/2023 21:05:35'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := Bag new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'mm uu 11/6/2023 20:03:15'!
items
	^items copy! !

!Cart methodsFor: 'total' stamp: 'mm uu 11/6/2023 21:36:57'!
total

	^ items sum: [ :anItem | catalog at: anItem ] ifEmpty: [0]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!Cart class methodsFor: 'error messages' stamp: 'mm uu 11/7/2023 17:43:27'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total client'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'mm uu 11/8/2023 13:02:16'!
createSale

	^ Sale of: total for: client with: cart items
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

!Cashier methodsFor: 'initialization' stamp: 'mm uu 11/8/2023 12:38:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook for: aClient
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook.
	client := aClient.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !

!Cashier class methodsFor: 'instance creation' stamp: 'mm uu 11/8/2023 12:38:38'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook for: aClient
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook for: aClient.! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #DateTimeSimulator category: 'TusLibros'!
Object subclass: #DateTimeSimulator
	instanceVariableNames: 'dateTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!DateTimeSimulator methodsFor: 'time' stamp: 'mm uu 11/8/2023 15:22:36'!
forward: anAmount
	dateTime := dateTime + anAmount! !

!DateTimeSimulator methodsFor: 'time' stamp: 'mm uu 11/8/2023 15:11:05'!
now
	^dateTime! !


!DateTimeSimulator methodsFor: 'initialization' stamp: 'mm uu 11/8/2023 15:10:29'!
initializeStartingAt: aDateTime 
	dateTime := aDateTime.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DateTimeSimulator class' category: 'TusLibros'!
DateTimeSimulator class
	instanceVariableNames: ''!

!DateTimeSimulator class methodsFor: 'instance creation' stamp: 'mm uu 11/8/2023 15:10:17'!
startingAt: aDateTime 
	^self new initializeStartingAt: aDateTime ! !


!classDefinition: #InterfazEntrada category: 'TusLibros'!
Object subclass: #InterfazEntrada
	instanceVariableNames: 'usersList userList catalog lastCartId salesBook sessions lastTransactionId dateTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InterfazEntrada methodsFor: 'assertions' stamp: 'mm uu 11/8/2023 16:25:25'!
checkCredentialsFor: aClientId with: aPassword
	|password |
	
	password := usersList 
		at: aClientId 
		ifAbsent: [self error: self class invalidCredentialsErrorMessage].	
	password = aPassword 
		ifFalse: [self error: self class invalidCredentialsErrorMessage].
	! !


!InterfazEntrada methodsFor: 'initialization' stamp: 'mm uu 11/8/2023 16:20:47'!
initializeWithUsers: aUserList withCatalog: aCatalog withDateTime: aDateTime
	usersList := aUserList.
	catalog := aCatalog.
	lastCartId := 1.
	lastTransactionId := 1.
	salesBook := OrderedCollection new.
	sessions := Dictionary new.
	dateTime := aDateTime.! !


!InterfazEntrada methodsFor: 'create cart' stamp: 'mm uu 11/8/2023 16:28:29'!
createCartFor: aClientId withPassword: aPassword 
	|cartId|
	self checkCredentialsFor: aClientId with: aPassword.
	cartId := self createCartId .
	
	sessions add: cartId -> (Session 
		for: aClientId 
		createdAt: dateTime now 
		withCart: (Cart acceptingItemsOf: catalog)).
	
	^cartId! !


!InterfazEntrada methodsFor: 'list cart' stamp: 'mm uu 11/6/2023 20:41:23'!
listCartWithId: cartId 
	|cart|
	cart := self retrieveCartWith: cartId.
	^cart items! !


!InterfazEntrada methodsFor: 'add to cart' stamp: 'mm uu 11/6/2023 20:41:00'!
addToCartWithId: cartId item: anItem withOcurrences: ocurrences 
	|cart|
	cart := self retrieveCartWith: cartId.
	cart add: ocurrences of: anItem ! !


!InterfazEntrada methodsFor: 'checkout' stamp: 'mm uu 11/8/2023 16:35:49'!
checkoutCartId: aCartId charging: aCard through: aMerchantProcessor on: aDate
	|cart cashier transactionId|
	cart := self retrieveCartWith: aCartId.
	transactionId := self createTransactionId .
	cashier := Cashier 
		toCheckout: cart
		charging: aCard
		throught: aMerchantProcessor
		on: aDate
		registeringOn: salesBook
		for: ((sessions at: aCartId) clientId).
	cashier checkOut .
	^transactionId.! !


!InterfazEntrada methodsFor: 'support' stamp: 'mm uu 11/8/2023 16:27:05'!
createCartId
	|cartId |
	cartId := lastCartId.
	lastCartId := lastCartId + 1.
	^cartId! !

!InterfazEntrada methodsFor: 'support' stamp: 'mm uu 11/8/2023 16:35:33'!
createTransactionId
	|transactionId|
	transactionId := lastTransactionId.
	lastTransactionId := lastTransactionId + 1.
	^transactionId.! !

!InterfazEntrada methodsFor: 'support' stamp: 'mm uu 11/8/2023 16:57:23'!
retrieveCartWith: cartId
	|session |
	session := self retrieveSessionFor: cartId.
	
	(session isExpiredFrom: dateTime now) ifTrue: [
		sessions removeKey: cartId.
		self error: self class cartIsExpiredErrorMessage 
	].
	session accessedAt: dateTime now.
	^session cart.! !

!InterfazEntrada methodsFor: 'support' stamp: 'mm uu 11/8/2023 16:30:40'!
retrieveSessionFor: aCartId

	^ sessions at: aCartId ifAbsent: [self error: self class invalidCartId ]! !


!InterfazEntrada methodsFor: 'list purchases' stamp: 'mm uu 11/8/2023 17:06:14'!
listPurchasesFor: clientId and: password
	|clientPurchases summary|
	summary := OrderedCollection new.
	
	clientPurchases := salesBook select: [:aSale | aSale isFromClient: clientId ].
	clientPurchases inject: summary
		into: [:x :purchase| summary addAll: purchase itemsWithCount].
		
	summary add: (clientPurchases sum: [:aSale | aSale total]).
	^summary
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InterfazEntrada class' category: 'TusLibros'!
InterfazEntrada class
	instanceVariableNames: ''!

!InterfazEntrada class methodsFor: 'instance creation' stamp: 'mm uu 11/6/2023 20:15:19'!
invalidCredentialsErrorMessage
	^'Invalid credentials'! !

!InterfazEntrada class methodsFor: 'instance creation' stamp: 'mm uu 11/8/2023 15:04:03'!
withUsers: aUserList withCatalog: aCatalog withDateTime: aDateTime
	^self new initializeWithUsers: aUserList withCatalog: aCatalog withDateTime: aDateTime.! !


!InterfazEntrada class methodsFor: 'errors' stamp: 'mm uu 11/8/2023 15:30:19'!
cartIsExpiredErrorMessage
	^'Cart has expired'! !

!InterfazEntrada class methodsFor: 'errors' stamp: 'mm uu 11/6/2023 20:39:41'!
invalidCartId
	^'Invalid cart id'! !


!classDefinition: #MerchantProcessorStub category: 'TusLibros'!
Object subclass: #MerchantProcessorStub
	instanceVariableNames: 'defaultBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorStub methodsFor: 'initialization' stamp: 'mm uu 11/7/2023 19:31:27'!
initializeWithDefaultBehavior: aDefaultBehavior 
	defaultBehavior := aDefaultBehavior.! !


!MerchantProcessorStub methodsFor: 'operations' stamp: 'mm uu 11/7/2023 19:38:23'!
debit: anAmount from: aCreditCard 
	^defaultBehavior value: anAmount value: aCreditCard ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorStub class' category: 'TusLibros'!
MerchantProcessorStub class
	instanceVariableNames: ''!

!MerchantProcessorStub class methodsFor: 'instance creation' stamp: 'mm uu 11/7/2023 19:31:11'!
withDefaultBehavior: aDefaultBehavior
	^self new initializeWithDefaultBehavior: aDefaultBehavior ! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'total client items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'initialization' stamp: 'mm uu 11/8/2023 13:00:51'!
initializeTotal: aTotal for: aClient with: anItemsList

	total := aTotal .
	client := aClient.
	items := anItemsList.! !


!Sale methodsFor: 'accesing' stamp: 'mm uu 11/8/2023 17:05:46'!
isFromClient: aClientId
	^aClientId = client ! !

!Sale methodsFor: 'accesing' stamp: 'mm uu 11/8/2023 13:04:23'!
items
	
	^ items! !

!Sale methodsFor: 'accesing' stamp: 'mm uu 11/8/2023 16:46:49'!
itemsWithCount
	|itemsWithCount|
	itemsWithCount := OrderedCollection new.
	items contents keys do: [ :anItem |
		itemsWithCount add: anItem.
		itemsWithCount add: (items contents at: anItem).
	].
	^itemsWithCount ! !

!Sale methodsFor: 'accesing' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'mm uu 11/8/2023 13:01:40'!
of: aTotal for: aClient with: anItemsList
	^self new initializeTotal: aTotal for: aClient with: anItemsList! !


!classDefinition: #Session category: 'TusLibros'!
Object subclass: #Session
	instanceVariableNames: 'clientId createdAt dateTime expiration lastAccessTime cart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Session methodsFor: 'initialization' stamp: 'mm uu 11/8/2023 16:13:09'!
initializeFor: aClientId createdAt: aDateTime withCart: aCart
	clientId := aClientId.
	lastAccessTime := aDateTime.
	cart := aCart.! !

!Session methodsFor: 'initialization' stamp: 'mm uu 11/8/2023 16:34:27'!
isExpiredFrom: aDateTime
	^(aDateTime - lastAccessTime) > 30 minutes! !


!Session methodsFor: 'access' stamp: 'mm uu 11/8/2023 16:57:47'!
accessedAt: aDateTime
	lastAccessTime := aDateTime! !

!Session methodsFor: 'access' stamp: 'mm uu 11/8/2023 16:13:31'!
cart
	^cart! !

!Session methodsFor: 'access' stamp: 'mm uu 11/8/2023 17:04:14'!
clientId
	^clientId ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Session class' category: 'TusLibros'!
Session class
	instanceVariableNames: ''!

!Session class methodsFor: 'instance creation' stamp: 'mm uu 11/8/2023 16:12:55'!
for: aClientId createdAt: aDateTime withCart: aCart
	^self new initializeFor: aClientId createdAt: aDateTime withCart: aCart ! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'mm uu 11/8/2023 13:45:58'!
anotherItemSellByTheStore
	
	^ 'anotherValidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'mm uu 11/8/2023 17:01:18'!
createCartForDefaultUserWith: interface
	
	^ interface createCartFor: self defaultUsername withPassword: self defaultPassword ! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'mm uu 11/7/2023 17:49:38'!
defaultPassword
	
	^ 'pass'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'mm uu 11/7/2023 17:49:29'!
defaultUsername
	
	^ 'pepe'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'mm uu 11/8/2023 14:22:02'!
merchantProcessorWithNoBehaviour
	
	^ MerchantProcessorStub withDefaultBehavior: [:anAmount :aCard |]! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'mm uu 11/8/2023 16:59:38'!
createInterfaceWithUsers: users.
	
	^ InterfazEntrada 
		withUsers: users
		withCatalog: self defaultCatalog 
		withDateTime: (DateTimeSimulator startingAt: self today).! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'mm uu 11/8/2023 13:46:09'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		at: self anotherItemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'mm uu 11/8/2023 15:13:08'!
defaultInterface
	
	^ InterfazEntrada 
		withUsers: self defaultUsers 
		withCatalog: self defaultCatalog 
		withDateTime: (DateTimeSimulator startingAt: self today).! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'mm uu 11/7/2023 17:50:01'!
defaultUsers
	^Dictionary new
		at: self defaultUsername put: self defaultPassword ; yourself! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !
