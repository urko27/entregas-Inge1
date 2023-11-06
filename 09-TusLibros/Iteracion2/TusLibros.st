!classDefinition: #CardTest category: 'TusLibros'!
TestCase subclass: #CardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CardTest methodsFor: 'tests' stamp: 'h 11/6/2023 14:00:21'!
test01CardNumberIdCannotHaveLessThan16Digits
	self
		should: [Card withNumber: 0 expiration: GregorianMonthOfYear current cardHolder: 'manu']
		raise: Error
		withExceptionDo: [:anError | self assert: anError messageText equals: Card invalidCardNumber ]! !

!CardTest methodsFor: 'tests' stamp: 'h 11/6/2023 14:00:37'!
test02CardNumberIdCannotHaveMoreThan16Digits
	self
		should: [Card withNumber: 11111111111111111 expiration: GregorianMonthOfYear current cardHolder: 'manu']
		raise: Error
		withExceptionDo: [:anError | self assert: anError messageText equals: Card invalidCardNumber ]! !

!CardTest methodsFor: 'tests' stamp: 'h 11/6/2023 14:01:08'!
test03CardNameCannotBeEmpty
	self
		should: [Card withNumber: self validCardNumber expiration: GregorianMonthOfYear current cardHolder: '']
		raise: Error
		withExceptionDo: [:anError | self assert: anError messageText equals: Card invalidCardHolder ]! !


!CardTest methodsFor: 'support' stamp: 'mm uu 11/5/2023 14:19:03'!
validCardNumber

	^ 1111111111111111! !


!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HAW 11/2/2023 17:12:35'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: self itemSellByTheStore withOcurrences: 0  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HAW 11/2/2023 17:12:46'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add:  self itemNotSellByTheStore withOcurrences: 2  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HAW 11/2/2023 17:12:59'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore withOcurrences: 2.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'mm uu 11/5/2023 13:40:46'!
defaultCatalog
	|catalog|
	catalog := Dictionary new.
	catalog add: self itemSellByTheStore -> 5.
	^catalog! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'support' stamp: 'h 11/6/2023 14:29:20'!
checkoutWithValidCartWhenMerchantProcessorReturnsErrorShouldReturnSameErrorMessage: anErrorMessage

	|cashier cart catalog card mockedMerchantProcessor|
	catalog := Dictionary new.
	catalog add: #validBook -> 7.
	catalog add: #anotherValidBook -> 9.
	
	mockedMerchantProcessor := MockedMerchantProcessor returns: [self error: anErrorMessage].
	card := self createValidCard .
	
	cart := Cart acceptingItemsOf: (catalog).
	cart add: 'validBook'.
	cart add: 'anotherValidBook'.
	cashier := Cashier for: cart withCard: card forMonthOfYear: GregorianMonthOfYear current andMerchantProcessor: mockedMerchantProcessor .
	
	self 
		should: [cashier checkout]
		raise: Error
		withExceptionDo: [:anError | self assert: anError messageText equals: anErrorMessage].
	! !

!CashierTest methodsFor: 'support' stamp: 'mm uu 11/5/2023 14:20:35'!
createValidCard
	^ Card withNumber: self validCardNumber expiration: GregorianMonthOfYear current cardHolder: 'm'.! !

!CashierTest methodsFor: 'support' stamp: 'mm uu 11/5/2023 14:20:30'!
validCardNumber
	^ 1111111111111111! !


!CashierTest methodsFor: 'tests' stamp: 'h 11/6/2023 14:29:20'!
test01CannotCheckoutAnEmptyCart
	|cart card mockedMerchantProcessor|
	
	mockedMerchantProcessor := MockedMerchantProcessor new.
	card := self createValidCard.
	cart := Cart acceptingItemsOf: (Dictionary new).
	
	self should: [Cashier for: cart withCard: card forMonthOfYear: GregorianMonthOfYear current andMerchantProcessor: mockedMerchantProcessor ]
		raise: Error
		withExceptionDo: [:anError | self assert: anError messageText equals: Cashier cartIsEmptyErrorMessage ].! !

!CashierTest methodsFor: 'tests' stamp: 'h 11/6/2023 14:29:20'!
test02CannotCheckoutACartWithAnExpiredCreditCart
	|cart catalog card mockedMerchantProcessor|
	
	catalog := Dictionary new.
	catalog add: #book -> 3.
	mockedMerchantProcessor := MockedMerchantProcessor new.
	card := Card 
		withNumber: self validCardNumber 
		expiration: GregorianMonthOfYear current previous
		cardHolder: 'manucho'.
		
	cart := Cart acceptingItemsOf: (catalog).
	cart add: 'book'.
	
	self should: [Cashier for: cart withCard: card forMonthOfYear: GregorianMonthOfYear current andMerchantProcessor: mockedMerchantProcessor ]
		raise: Error
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: Cashier cardIsExpiredErrorMessage . ].
	! !

!CashierTest methodsFor: 'tests' stamp: 'h 11/6/2023 14:29:20'!
test03CashierCheckoutsCartWithOneItem
	|cashier cart catalog card mockedMerchantProcessor|
	
	catalog := Dictionary new.
	catalog add: #validBook -> 7.
	
	cart := Cart acceptingItemsOf: (catalog).
	cart add: 'validBook'.
	
	mockedMerchantProcessor := MockedMerchantProcessor returns: ['transactionID'] whenItReceives: [:anAmount | anAmount = 7].
	card := self createValidCard.
	cashier := Cashier for: cart withCard: card forMonthOfYear: GregorianMonthOfYear current andMerchantProcessor: mockedMerchantProcessor .
	
	self assert: cashier checkout equals: 'transactionID'
	! !

!CashierTest methodsFor: 'tests' stamp: 'h 11/6/2023 14:29:20'!
test04CashierCheckoutsCartWithMultipleItems
	|cashier cart catalog card mockedMerchantProcessor|
	
	catalog := Dictionary new.
	catalog add: #validBook -> 7.
	catalog add: #anotherValidBook -> 9.
	
	mockedMerchantProcessor := MockedMerchantProcessor returns: 'transactionID' whenItReceives: [:anAmount | anAmount = 16].
	card := self createValidCard.
	
	cart := Cart acceptingItemsOf: (catalog).
	cart add: 'validBook'.
	cart add: 'anotherValidBook'.
	cashier := Cashier for: cart withCard: card forMonthOfYear: GregorianMonthOfYear current andMerchantProcessor: mockedMerchantProcessor .
	
	self assert: cashier checkout equals: 'transactionID'
	! !

!CashierTest methodsFor: 'tests' stamp: 'h 11/6/2023 14:17:14'!
test05CannotChekoutWhenCardHasInsufficientFunds
	
	self 
	checkoutWithValidCartWhenMerchantProcessorReturnsErrorShouldReturnSameErrorMessage: 'insufficient funds'.
	! !

!CashierTest methodsFor: 'tests' stamp: 'h 11/6/2023 14:17:35'!
test06CannotCheckoutWhitAStolenCard

	self checkoutWithValidCartWhenMerchantProcessorReturnsErrorShouldReturnSameErrorMessage: 'stolen card'.
	! !


!classDefinition: #Card category: 'TusLibros'!
Object subclass: #Card
	instanceVariableNames: 'creditCardNumber creditCardExpiration cardHolder'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Card methodsFor: 'initialization' stamp: 'mm uu 11/2/2023 19:05:21'!
initializeWithNumber: aCreditCardNumber expiration: aCreditCardExpiration cardHolder: aCardHolder 
	creditCardNumber := aCreditCardNumber.
	creditCardExpiration := aCreditCardExpiration.
	cardHolder := aCardHolder.! !

!Card methodsFor: 'initialization' stamp: 'mm uu 11/3/2023 16:22:28'!
isExpirationLessThan: aMonthDate
	^creditCardExpiration < aMonthDate! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Card class' category: 'TusLibros'!
Card class
	instanceVariableNames: ''!

!Card class methodsFor: 'instance creation' stamp: 'mm uu 11/5/2023 14:22:05'!
assertCardHolderIsValid: cardHolder

	^ cardHolder isEmpty ifTrue: [self error: self invalidCardHolder ]! !

!Card class methodsFor: 'instance creation' stamp: 'mm uu 11/5/2023 14:22:18'!
assertCardNumberIsValid: creditCardNumber

	^ (creditCardNumber decimalDigitLength < 16 or: [creditCardNumber decimalDigitLength > 16]) ifTrue: [self error: self invalidCardNumber]! !

!Card class methodsFor: 'instance creation' stamp: 'mm uu 11/5/2023 14:00:30'!
invalidCardNumber
	^'invalid card number'! !

!Card class methodsFor: 'instance creation' stamp: 'mm uu 11/5/2023 14:22:19'!
withNumber: creditCardNumber expiration: creditCardExpiration cardHolder: cardHolder 
	self assertCardNumberIsValid: creditCardNumber.
	self assertCardHolderIsValid: cardHolder. 
	
	^self new initializeWithNumber: creditCardNumber expiration: creditCardExpiration cardHolder: cardHolder ! !


!Card class methodsFor: 'errors' stamp: 'mm uu 11/5/2023 14:13:11'!
invalidCardHolder
	^'invalid card holder'! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'mm uu 11/2/2023 21:12:42'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'mm uu 11/2/2023 19:51:46'!
items
	^items copy! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HAW 11/2/2023 17:13:30'!
add: anItem

	^ self add: anItem withOcurrences: 1 ! !

!Cart methodsFor: 'adding' stamp: 'HAW 11/2/2023 17:13:19'!
add: anItem withOcurrences: aQuantity

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	items add: anItem withOccurrences: aQuantity .
	! !


!Cart methodsFor: 'total' stamp: 'mm uu 11/2/2023 21:10:30'!
totalAmount
	|totalAmount|
	totalAmount := 0.
	items do: [: anItem | | itemPrice |
		itemPrice := catalog at: anItem ifAbsent: [self error: self class itemNonExistantErrorMessage ].
		totalAmount := totalAmount + itemPrice.
		"itemPrice :=  at: anItem ifAbsent: [self error: self class itemNonExistantErrorMessage].
		totalAmount := totalAmount + itemPrice"
	].
	^totalAmount ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !

!Cart class methodsFor: 'instance creation' stamp: 'mm uu 11/2/2023 21:15:49'!
itemNonExistantErrorMessage
	^'item does not exist'! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'acceptedItemsList mockedMerchantProcessor cart card'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout' stamp: 'mm uu 11/5/2023 13:31:11'!
checkout
	|totalAmount transactionId|
	totalAmount := cart totalAmount. 
	
	transactionId := mockedMerchantProcessor debit: totalAmount from: card.
	
	^transactionId.! !


!Cashier methodsFor: 'initialization' stamp: 'mm uu 11/5/2023 14:24:51'!
initializeFor: aCart withCard: aCard andMerchantProcessor: aMerchantProcessor
	cart := aCart .
	card := aCard .
	mockedMerchantProcessor := aMerchantProcessor ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'errors' stamp: 'mm uu 11/2/2023 19:21:27'!
cardIsExpiredErrorMessage
	^'card is expired'! !

!Cashier class methodsFor: 'errors' stamp: 'mm uu 11/2/2023 18:44:08'!
cartIsEmptyErrorMessage
	^'cart is empty'! !

!Cashier class methodsFor: 'errors' stamp: 'mm uu 11/2/2023 20:14:40'!
itemNonExistantErrorMessage
	'item does not exist'! !


!Cashier class methodsFor: 'instance creation' stamp: 'h 11/6/2023 14:26:34'!
assertCardIsNotExpired: aCard since: aMonthOfYear

	^ (aCard isExpirationLessThan: aMonthOfYear ) ifTrue: [self error: self cardIsExpiredErrorMessage ]! !

!Cashier class methodsFor: 'instance creation' stamp: 'mm uu 11/5/2023 14:24:28'!
assertCartIsNotEmpty: aCart

	^ aCart isEmpty ifTrue: [self error: self cartIsEmptyErrorMessage ]! !

!Cashier class methodsFor: 'instance creation' stamp: 'h 11/6/2023 14:29:32'!
for: aCart withCard: aCard forMonthOfYear: aMonthOfYear andMerchantProcessor: merchantProcessor
	self assertCartIsNotEmpty: aCart.
	self assertCardIsNotExpired: aCard since: aMonthOfYear .
	
	^self new initializeFor: aCart withCard: aCard andMerchantProcessor: merchantProcessor ! !


!classDefinition: #MerchantProcessor category: 'TusLibros'!
Object subclass: #MerchantProcessor
	instanceVariableNames: 'returnBlock conditionBlock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!


!classDefinition: #MockedMerchantProcessor category: 'TusLibros'!
MerchantProcessor subclass: #MockedMerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MockedMerchantProcessor methodsFor: 'initialization' stamp: 'h 11/6/2023 14:08:01'!
debit: anAmount from: aCard

	(conditionBlock value: anAmount) ifTrue: [^returnBlock value].
	
	^self error: 'condition for simulation was not met'.! !

!MockedMerchantProcessor methodsFor: 'initialization' stamp: 'mm uu 11/5/2023 13:29:34'!
initializeReturns: aReturnBlock 
	self initializeReturns: aReturnBlock whenItReceives: [:any | true]! !

!MockedMerchantProcessor methodsFor: 'initialization' stamp: 'mm uu 11/5/2023 13:48:18'!
initializeReturns: aReturnBlock whenItReceives: aConditionBlock 
	returnBlock := aReturnBlock.
	conditionBlock := aConditionBlock .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MockedMerchantProcessor class' category: 'TusLibros'!
MockedMerchantProcessor class
	instanceVariableNames: ''!

!MockedMerchantProcessor class methodsFor: 'instance creation' stamp: 'mm uu 11/2/2023 21:34:28'!
returns: aClosure
	^self new initializeReturns: aClosure ! !

!MockedMerchantProcessor class methodsFor: 'instance creation' stamp: 'mm uu 11/5/2023 13:27:55'!
returns: returnBlock whenItReceives: conditionBlock 
	^self new initializeReturns: returnBlock whenItReceives: conditionBlock ! !
