!classDefinition: #PersistentSet category: 'CustomerImporter'!
Set subclass: #PersistentSet
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!PersistentSet methodsFor: 'initialization' stamp: 'HAW 11/14/2023 08:25:31'!
initializeOn: aSession from: aNonPersistentSet

	session := aSession.
	self addAll: aNonPersistentSet ! !


!PersistentSet methodsFor: 'adding' stamp: 'HAW 11/14/2023 08:23:40'!
add: newObject

	super add: newObject.
	session persist: newObject.
	
	^newObject! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PersistentSet class' category: 'CustomerImporter'!
PersistentSet class
	instanceVariableNames: ''!

!PersistentSet class methodsFor: 'instance creation' stamp: 'HAW 11/14/2023 08:24:32'!
on: aSession

	^self on: aSession from: #()! !

!PersistentSet class methodsFor: 'instance creation' stamp: 'HAW 11/14/2023 08:25:00'!
on: aSession from: aNonPersistentSet

	^self new initializeOn: aSession from: aNonPersistentSet
! !


!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'system'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 21:15:52'!
test01ValidDataIsImportedCorrectly

	CustomerImporter valueFrom: self validImportData into: system..

	self assertImportedRightNumberOfCustomers.
	self assertPepeSanchezWasImportedCorrecty.
	self assertJuanPerezWasImportedCorrectly ! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 21:15:52'!
test02CanNotImportAddressWithoutCustomer

	self
		should: [ CustomerImporter valueFrom: self addressWithoutCustomerData into: system. ]
		raise: Error - MessageNotUnderstood
		withMessageText: CustomerImporter canNotImportAddressWithoutCustomerErrorDescription

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 19:56:58'!
test03DoesNotImportRecordsStartingWithCButMoreCharacters

	self
		shouldFailImporting: self invalidCustomerRecordStartData
		messageText: CustomerImporter invalidRecordTypeErrorDescription
		asserting: [ self assertNoCustomerWasImported ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 19:49:03'!
test04DoesNotImportRecordsStartingWithAButMoreCharacters

	self
		shouldFailImporting: self invalidAddressRecordStartData
		messageText: CustomerImporter invalidRecordTypeErrorDescription
		asserting: [ self assertImportedOneCustomerWithoutAddress ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 19:49:36'!
test05CanNotImportAddressRecordWithLessThanSixFields

	self
		shouldFailImporting: self addressRecordWithLessThanSixFields
		messageText: CustomerImporter invalidAddressRecordErrorDescription
		asserting: [ self assertImportedOneCustomerWithoutAddress ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 19:51:14'!
test06CanNotImportAddressRecordWithMoreThanSixFields

	self
		shouldFailImporting: self addressRecordWithMoreThanSixFields
		messageText: CustomerImporter invalidAddressRecordErrorDescription
		asserting: [ self assertImportedOneCustomerWithoutAddress ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 19:56:58'!
test07CanNotImportCustomerRecordWithLessThanFiveFields

	self
		shouldFailImporting: self customerRecordWithLessThanFiveFields
		messageText: CustomerImporter invalidCustomerRecordErrorDescription
		asserting: [ self assertNoCustomerWasImported ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 19:56:58'!
test08CanNotImportCustomerRecordWithMoreThanFiveFields

	self
		shouldFailImporting: self customerRecordWithMoreThanFiveFields
		messageText: CustomerImporter invalidCustomerRecordErrorDescription
		asserting: [ self assertNoCustomerWasImported ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 20:01:43'!
test09CannotImportEmptyLine

	self
		shouldFailImporting: self emptyLine
		messageText: CustomerImporter invalidRecordTypeErrorDescription
		asserting: [ self assertNoCustomerWasImported ]

	! !


!ImportTest methodsFor: 'assertions' stamp: 'H 11/27/2023 02:35:11'!
assertAddressOf: importedCustomer at: aStreetName hasNumber: aNumber town: aTown zipCode: aZipCode province: aProvince

	| importedAddress |

	importedAddress := importedCustomer addressAt: aStreetName ifNone: [ self fail ].
	self assert: aStreetName equals: importedAddress streetName.
	self assert: aNumber equals: importedAddress streetNumber.
	self assert: aTown equals: importedAddress town.
	self assert: aZipCode equals: importedAddress zipCode.
	self assert: aProvince equals: importedAddress province.

	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 21:34:30'!
assertCustomerWithIdentificationType: anIdType number: anIdNumber hasFirstName: aFirstName lastName: aLastName

	| importedCustomer |

	importedCustomer := system customerWithIdentificationType: anIdType number: anIdNumber.

	self assert: aFirstName equals: importedCustomer firstName.
	self assert: aLastName equals: importedCustomer lastName.
	self assert: anIdType equals: importedCustomer identificationType.
	self assert: anIdNumber equals: importedCustomer identificationNumber.

	^importedCustomer

	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 21:34:37'!
assertImportedOneCustomerWithoutAddress

	| importedCustomer |

	self assert: 1 equals: system numberOfCustomers.
	importedCustomer := system customerWithIdentificationType: 'D' number: '22333444'.
	self assert: importedCustomer isAddressesEmpty
	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 21:33:18'!
assertImportedRightNumberOfCustomers

	^ self assert: 2 equals: system numberOfCustomers! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:45'!
assertJuanPerezWasImportedCorrectly

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'C' number: '23-25666777-9' hasFirstName: 'Juan' lastName: 'Perez'.
	self assertAddressOf: importedCustomer at: 'Alem' hasNumber: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'
	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 21:33:24'!
assertNoCustomerWasImported

	^ self assert: 0 equals: system numberOfCustomers! !

!ImportTest methodsFor: 'assertions' stamp: 'H 11/27/2023 04:03:56'!
assertNoSupplierWasImported
	
	self assert: system numberOfSuppliers equals: 0! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:05'!
assertPepeSanchezWasImportedCorrecty

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.
	self assertAddressOf: importedCustomer at: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.
	self assertAddressOf: importedCustomer at: 'Maipu' hasNumber: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'.


	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 21:15:52'!
shouldFailImporting: aReadStream messageText: anErrorMessageText asserting: anAssertionBlock

	self
		should: [ CustomerImporter valueFrom: aReadStream into: system. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anErrorMessageText equals: anError messageText.
			anAssertionBlock value ]

	! !


!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 21:36:16'!
setUp

	system := Environment current createCustomerSystem.
	system start.
	system beginTransaction.
! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 20:12:16'!
tearDown

	system commit.
	system stop
	! !


!ImportTest methodsFor: 'supplier tests' stamp: 'h 11/23/2023 18:40:41'!
test01SupplierRecordIsImportedCorrectly

	|stream supplier |

	stream := ReadStream on: 'S,supplier1,D,123'.
	SupplierImporter valueFrom: stream into: system.
	
	self assert: system numberOfSuppliers equals: 1.
	supplier := system supplierWithIdentificationType: 'D'  number: 123.
	self assert: (supplier isNamed: 'supplier1').
	self assert: (supplier isIdentifiedAs: 'D' number: '123').
	self assert: supplier isAddressesEmpty .
	self assert: supplier isCustomersEmpty.! !

!ImportTest methodsFor: 'supplier tests' stamp: 'H 11/27/2023 02:01:34'!
test02MultipleSupplierRecordsAreImportedCorrectly

	|stream supplier |

	stream := ReadStream on: 
'S,supplier1,D,123
S,supplier2,D,124'.
	SupplierImporter valueFrom: stream into: system.
	
	self assert: system numberOfSuppliers equals: 2.
	
	supplier := system supplierWithIdentificationType: 'D'  number: 123.
	self assert: (supplier isNamed: 'supplier1').
	self assert: (supplier isIdentifiedAs: 'D' number: '123').
	self assert: supplier isAddressesEmpty .
	self assert: supplier isCustomersEmpty.
	
	supplier := system supplierWithIdentificationType: 'D'  number: 124.
	self assert: (supplier isNamed: 'supplier2').
	self assert: (supplier isIdentifiedAs: 'D' number: '124').
	self assert: supplier isAddressesEmpty .
	self assert: supplier isCustomersEmpty.! !

!ImportTest methodsFor: 'supplier tests' stamp: 'H 11/27/2023 02:28:03'!
test03SupplierCustomerRecordIsImportedCorrectly

	|stream supplier customer|

	stream := ReadStream on: 
'S,supplier1,D,123
NC,Pepe,Sanchez,D,22333444'.
	SupplierImporter valueFrom: stream into: system.
	
	supplier := system supplierWithIdentificationType: 'D'  number: 123.
	self assert: (supplier customerCountIs: 1).
	
	customer := self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'. 
	self assert: customer equals: (supplier customerWithIdType: 'D' andIdNumber:'22333444')! !

!ImportTest methodsFor: 'supplier tests' stamp: 'H 11/27/2023 02:29:12'!
test04MultipleSupplierCustomerRecordAreImportedCorrectly

	|stream supplier customer|

	stream := ReadStream on: 
'S,supplier1,D,123
NC,Pepe,Sanchez,D,22333444
NC,Pep,Sancho,D,444'.
	SupplierImporter valueFrom: stream into: system.
	
	supplier := system supplierWithIdentificationType: 'D'  number: 123.
	self assert: (supplier customerCountIs: 2).
	
	customer := self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'. 
	self assert: customer equals: (supplier customerWithIdType: 'D' andIdNumber:'22333444').
	
	customer := self assertCustomerWithIdentificationType: 'D' number: '444' hasFirstName: 'Pep' lastName: 'Sancho'.
	self assert: customer equals: (supplier customerWithIdType: 'D' andIdNumber:'444')! !

!ImportTest methodsFor: 'supplier tests' stamp: 'H 11/27/2023 02:29:49'!
test05ExistingCustomerRecordIsImportedCorrectly

	|stream supplier customer|

	stream := ReadStream on: 'C,Pepe,Sanchez,D,22333444'.
	CustomerImporter valueFrom: stream into: system.
	
	stream := ReadStream on: 
'S,supplier1,D,123
EC,D,22333444'.
	SupplierImporter valueFrom: stream into: system.
	
	supplier := system supplierWithIdentificationType: 'D'  number: 123.
	self assert: (supplier customerCountIs: 1).
	
	customer := self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'. 
	self assert: customer equals: (supplier customerWithIdType: 'D' andIdNumber:'22333444')! !

!ImportTest methodsFor: 'supplier tests' stamp: 'H 11/27/2023 02:30:35'!
test06MultipleExistingCustomerRecordAreImportedCorrectly

	|stream supplier customer|

	stream := ReadStream on: 
'C,Pepe,Sanchez,D,22333444
C,Pep,Sancho,D,444'.
	CustomerImporter valueFrom: stream into: system.
	
	stream := ReadStream on: 
'S,supplier1,D,123
EC,D,22333444
EC,D,444'.
	SupplierImporter valueFrom: stream into: system.
	
	supplier := system supplierWithIdentificationType: 'D'  number: 123.
	self assert: (supplier customerCountIs: 2).
	
	customer := self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'. 
	self assert: customer equals: (supplier customerWithIdType: 'D' andIdNumber:'22333444' ).

	customer := self assertCustomerWithIdentificationType: 'D' number: '444' hasFirstName: 'Pep' lastName: 'Sancho'. 
	self assert: customer equals: (supplier customerWithIdType: 'D' andIdNumber:'444')! !

!ImportTest methodsFor: 'supplier tests' stamp: 'H 11/27/2023 02:44:18'!
test07SupplierAddressRecordIsImportedCorrectly

	|stream supplier |
	
	stream := ReadStream on: 
'S,supplier1,D,123
A,San Martin,3322,Olivos,1636,BsAs'.
	SupplierImporter valueFrom: stream into: system.
	
	supplier := system supplierWithIdentificationType: 'D'  number: 123.
	self assert: supplier adressessCount equals: 1.
	self assertAddressOf: supplier at: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 1636 province:  'BsAs'! !

!ImportTest methodsFor: 'supplier tests' stamp: 'H 11/27/2023 02:44:30'!
test08MultipleSupplierAddressRecordIsImportedCorrectly

	|stream supplier |
	
	stream := ReadStream on: 
'S,supplier1,D,123
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires'.
	SupplierImporter valueFrom: stream into: system.
	
	supplier := system supplierWithIdentificationType: 'D'  number: 123.
	self assert: supplier adressessCount equals: 2.
	self assertAddressOf: supplier at: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 1636 province:  'BsAs'.
	self assertAddressOf: supplier at: 'Maipu' hasNumber: 888 town: 'Florida' zipCode: 1122 province:  'Buenos Aires'.! !

!ImportTest methodsFor: 'supplier tests' stamp: 'H 11/27/2023 03:56:40'!
test09CannotImportAddressWithoutSupplier

	|stream |
	
	stream := ReadStream on: 
'A,San Martin,3322,Olivos,1636,BsAs'.

	self should:[SupplierImporter valueFrom: stream into: system.]
		raise: Error
		withMessageText: SupplierImporter cannotImportRecordsWithoutSupplierError.! !

!ImportTest methodsFor: 'supplier tests' stamp: 'H 11/27/2023 04:00:00'!
test10CannotImportNewCustomerWithoutSupplier

	|stream |
	
	stream := ReadStream on: 
'NC,Pepe,Sanchez,D,444'.

	self should:[SupplierImporter valueFrom: stream into: system.]
		raise: Error
		withMessageText: SupplierImporter cannotImportRecordsWithoutSupplierError .! !

!ImportTest methodsFor: 'supplier tests' stamp: 'H 11/27/2023 03:59:46'!
test11CannotImportExistingCustomerWithoutSupplier

	|stream |

	stream := ReadStream on: 'C,Pepe,Sanchez,D,444'.
	CustomerImporter valueFrom: stream into: system.
	
	stream := ReadStream on: 
'EC,D,444'.

	self should:[SupplierImporter valueFrom: stream into: system.]
		raise: Error
		withMessageText: SupplierImporter cannotImportRecordsWithoutSupplierError .! !

!ImportTest methodsFor: 'supplier tests' stamp: 'H 11/27/2023 04:03:21'!
test12CannotImportEmptyLine

	self
		shouldFailImporting: self emptyLine
		messageText: SupplierImporter invalidRecordTypeErrorDescription
		asserting: [ self assertNoSupplierWasImported ]

! !

!ImportTest methodsFor: 'supplier tests' stamp: 'H 11/27/2023 04:53:11'!
test13CanNotImportAddressRecordWithLessThanSixFields
		
	|stream supplier|
	
	stream := ReadStream on: 'S,Supplier1,D,123
A,San Martin,3322,Olivos,1636'.

	self
		should: [SupplierImporter valueFrom: stream into:system ]
		raise: Error
		withExceptionDo: [:anError |
			self assert: anError messageText = SupplierImporter invalidAddressRecordErrorDescription.
			self assert: system numberOfSuppliers equals:1.
			supplier := system supplierWithIdentificationType: 'D' number: '123'.
			self assert: supplier isAddressesEmpty.
			 ]! !

!ImportTest methodsFor: 'supplier tests' stamp: 'H 11/27/2023 04:53:16'!
test14CanNotImportAddressRecordWithMoreThanSixFields
		
	|stream supplier|
	
	stream := ReadStream on: 'S,Supplier1,D,123
A,San Martin,3322,Olivos,1636,ss,x'.

	self
		should: [SupplierImporter valueFrom: stream into:system ]
		raise: Error
		withExceptionDo: [:anError | 
			self assert: anError messageText = SupplierImporter invalidAddressRecordErrorDescription.
			self assert: system numberOfSuppliers equals:1.
			supplier := system supplierWithIdentificationType: 'D' number: '123'.
			self assert: supplier isAddressesEmpty.
			 ]! !

!ImportTest methodsFor: 'supplier tests' stamp: 'H 11/27/2023 04:53:05'!
test15CanNotImportSuplierRecordWithMoreThanFourFields
		
	|stream |
	
	stream := ReadStream on: 'S,Supplier1,D,123,x'.

	self
		should: [SupplierImporter valueFrom: stream into:system ]
		raise: Error
		withExceptionDo: [:anError | 
			self assert: anError messageText = SupplierImporter invalidSupplierRecordErrorDescription.
			self assert: system numberOfSuppliers equals:0.
			 ]! !

!ImportTest methodsFor: 'supplier tests' stamp: 'H 11/27/2023 04:52:59'!
test16CanNotImportSuplierRecordWithLessThanFourFields
		
	|stream |
	
	stream := ReadStream on: 'S,Supplier1,D'.

	self
		should: [SupplierImporter valueFrom: stream into:system ]
		raise: Error
		withExceptionDo: [:anError |
			self assert: anError messageText = SupplierImporter invalidSupplierRecordErrorDescription.
			self assert: system numberOfSuppliers equals:0.
			 ]! !

!ImportTest methodsFor: 'supplier tests' stamp: 'H 11/27/2023 05:09:54'!
test17CanNotImportNewCustomerRecordWithLessThanFiveFields
		
	|stream supplier|
	
	stream := ReadStream on: 'S,Supplier1,D,123
NC,Pepe,Sanchez,D'.

	self
		should: [SupplierImporter valueFrom: stream into:system ]
		raise: Error
		withExceptionDo: [:anError |
			self assert: anError messageText = SupplierImporter invalidNewCustomerRecordErrorDescription .
			self assert: system numberOfSuppliers equals:1.
			supplier := system supplierWithIdentificationType: 'D' number: '123'.
			self assert: supplier isCustomersEmpty.
			 ]! !

!ImportTest methodsFor: 'supplier tests' stamp: 'H 11/27/2023 05:10:02'!
test18CanNotImportNewCustomerRecordWithMoreThanFiveFields
		
	|stream supplier|
	
	stream := ReadStream on: 'S,Supplier1,D,123
NC,Pepe,Sanchez,D,444,x'.

	self
		should: [SupplierImporter valueFrom: stream into:system ]
		raise: Error
		withExceptionDo: [:anError |
			self assert: anError messageText = SupplierImporter invalidNewCustomerRecordErrorDescription .
			self assert: system numberOfSuppliers equals:1.
			supplier := system supplierWithIdentificationType: 'D' number: '123'.
			self assert: supplier isCustomersEmpty.
			 ]! !

!ImportTest methodsFor: 'supplier tests' stamp: 'H 11/27/2023 05:03:25'!
test19CanNotImportExistingCustomerRecordWithMoreThanThreeFields
		
	|stream supplier|
	
	stream := ReadStream on: 'C,Pepe,Sanchez,D,22333444	'.
	CustomerImporter valueFrom: stream into: system.
	
	stream := ReadStream on: 'S,Supplier1,D,123
EC,D,22333444,x'.

	self
		should: [SupplierImporter valueFrom: stream into:system ]
		raise: Error
		withExceptionDo: [:anError |
			self assert: anError messageText = SupplierImporter invalidExistingCustomerRecordErrorDescription .
			self assert: system numberOfSuppliers equals:1.
			supplier := system supplierWithIdentificationType: 'D' number: '123'.
			self assert: supplier isCustomersEmpty.
			 ]! !

!ImportTest methodsFor: 'supplier tests' stamp: 'H 11/27/2023 05:04:54'!
test20CanNotImportExistingCustomerRecordWithLessThanThreeFields
		
	|stream supplier|
	
	stream := ReadStream on: 'C,Pepe,Sanchez,D,22333444	'.
	CustomerImporter valueFrom: stream into: system.
	
	stream := ReadStream on: 'S,Supplier1,D,123
EC,D'.

	self
		should: [SupplierImporter valueFrom: stream into:system ]
		raise: Error
		withExceptionDo: [:anError |
			self assert: anError messageText = SupplierImporter invalidExistingCustomerRecordErrorDescription .
			self assert: system numberOfSuppliers equals:1.
			supplier := system supplierWithIdentificationType: 'D' number: '123'.
			self assert: supplier isCustomersEmpty.
			 ]! !


!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:41:20'!
addressRecordWithLessThanSixFields

	^ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:51:35'!
addressRecordWithMoreThanSixFields

	^ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs,x'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:14:13'!
addressWithoutCustomerData

	^ReadStream on: 'A,San Martin,3322,Olivos,1636,BsAs'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:53:41'!
customerRecordWithLessThanFiveFields

	^ReadStream on: 'C,Pepe,Sanchez,D'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:55:59'!
customerRecordWithMoreThanFiveFields

	^ReadStream on: 'C,Pepe,Sanchez,D,22333444,x'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 20:02:57'!
emptyLine

	^ReadStream on: '
'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:34:25'!
invalidAddressRecordStartData

	^ReadStream on: 'C,Pepe,Sanchez,D,22333444
AA,San Martin,3322,Olivos,1636,BsAs'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:22:55'!
invalidCustomerRecordStartData

	^ReadStream on: 'CC,Pepe,Sanchez,D,22333444'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 18:08:08'!
validImportData

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !


!classDefinition: #Address category: 'CustomerImporter'!
Object subclass: #Address
	instanceVariableNames: 'id streetName streetNumber town zipCode province'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province

	^province! !

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province: aProvince

	province := aProvince
	! !


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 17:55:46'!
isAt: aStreetName

	^streetName = aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName

	^streetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName: aStreetName

	streetName := aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber

	^streetNumber ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber: aStreetNumber

	streetNumber := aStreetNumber ! !


!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town

	^town! !

!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town: aTown

	town := aTown! !


!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode

	^zipCode! !

!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode: aZipCode

	zipCode := aZipCode! !


!classDefinition: #CsvCustomerMapper category: 'CustomerImporter'!
Object subclass: #CsvCustomerMapper
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CsvCustomerMapper methodsFor: 'as yet unclassified' stamp: 'H 11/27/2023 05:06:40'!
mapFrom: record
	| newCustomer |

	newCustomer := Customer new.
	newCustomer firstName: record second.
	newCustomer lastName: record third.
	newCustomer identificationType: record fourth.
	newCustomer identificationNumber: record fifth.
	^newCustomer! !


!classDefinition: #CsvImporter category: 'CustomerImporter'!
Object subclass: #CsvImporter
	instanceVariableNames: 'line system readStream record csvCustomerMapper'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CsvImporter methodsFor: 'initialization' stamp: 'H 11/27/2023 03:36:29'!
initializeFrom: aReadStream into: aCustomerSystem

	readStream := aReadStream.
	system := aCustomerSystem .! !


!CsvImporter methodsFor: 'evaluating' stamp: 'h 11/23/2023 17:50:42'!
value

	[ self hasLineToImport ] whileTrue: [
		self createRecord.
		self importRecord ].

	! !


!CsvImporter methodsFor: 'evaluating - private' stamp: 'h 11/23/2023 17:51:25'!
assertRecordNotEmpty

	record isEmpty ifTrue: [ self error: self class invalidRecordTypeErrorDescription ]! !

!CsvImporter methodsFor: 'evaluating - private' stamp: 'h 11/23/2023 17:51:29'!
createRecord

	^ record := line findTokens: $,! !

!CsvImporter methodsFor: 'evaluating - private' stamp: 'h 11/23/2023 17:51:32'!
hasLineToImport

	line := readStream nextLine.
	^line notNil! !

!CsvImporter methodsFor: 'evaluating - private' stamp: 'h 11/23/2023 17:51:45'!
importRecord

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CsvImporter class' category: 'CustomerImporter'!
CsvImporter class
	instanceVariableNames: ''!

!CsvImporter class methodsFor: 'instance creation' stamp: 'h 11/23/2023 17:52:04'!
from: aReadStream into: aCustomerSystem

	^self new initializeFrom: aReadStream into: aCustomerSystem! !


!CsvImporter class methodsFor: 'importing' stamp: 'h 11/23/2023 17:52:10'!
valueFrom: aReadStream into: aCustomerSystem

	^(self from: aReadStream into: aCustomerSystem) value! !


!CsvImporter class methodsFor: 'error messages' stamp: 'h 11/23/2023 17:52:24'!
invalidRecordTypeErrorDescription

	^'Invalid record type'! !


!classDefinition: #PartyImporter category: 'CustomerImporter'!
CsvImporter subclass: #PartyImporter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!PartyImporter methodsFor: 'address' stamp: 'h 11/23/2023 18:03:42'!
assertValidAddressRecord

	^ record size ~= 6 ifTrue: [ self error: self class invalidAddressRecordErrorDescription ]! !

!PartyImporter methodsFor: 'address' stamp: 'h 11/23/2023 18:02:52'!
isAddressRecord

	^ record first = 'A'! !

!PartyImporter methodsFor: 'address' stamp: 'H 11/27/2023 03:43:33'!
mapRecordToAddress: aRecord
	|newAddress|
	
	self assertValidAddressRecord.

	newAddress := Address new.
	newAddress streetName: record second.
	newAddress streetNumber: record third asNumber .
	newAddress town: record fourth.
	newAddress zipCode: record fifth asNumber .
	newAddress province: record sixth.
	
	^newAddress ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PartyImporter class' category: 'CustomerImporter'!
PartyImporter class
	instanceVariableNames: ''!

!PartyImporter class methodsFor: 'error messages' stamp: 'H 11/27/2023 04:36:01'!
invalidAddressRecordErrorDescription

	^'Address record has to have six fields'! !


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
PartyImporter subclass: #CustomerImporter
	instanceVariableNames: 'newCustomer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'customer' stamp: 'H 11/27/2023 05:07:05'!
assertValidCustomerRecord

	^ record size ~= 5 ifTrue: [ self error: self class invalidCustomerRecordErrorDescription ]! !

!CustomerImporter methodsFor: 'customer' stamp: 'H 11/27/2023 05:06:52'!
importCustomer
	self assertValidCustomerRecord.
	newCustomer := (CsvCustomerMapper new) mapFrom: record.
	system add: newCustomer.! !

!CustomerImporter methodsFor: 'customer' stamp: 'HAW 5/22/2022 19:23:55'!
isCustomerRecord

	^ record first = 'C'! !


!CustomerImporter methodsFor: 'address' stamp: 'HAW 5/22/2022 19:58:41'!
assertCustomerWasImported

	^ newCustomer ifNil: [ self error: self class canNotImportAddressWithoutCustomerErrorDescription ]! !

!CustomerImporter methodsFor: 'address' stamp: 'H 11/27/2023 03:41:37'!
importAddress

	| newAddress |
	self assertCustomerWasImported.
	newAddress := self mapRecordToAddress: record.
	
	newCustomer addAddress: newAddress.! !


!CustomerImporter methodsFor: 'evaluating - private' stamp: 'HAW 5/22/2022 20:04:06'!
importRecord

	self assertRecordNotEmpty.

	self isCustomerRecord ifTrue: [ ^self importCustomer ].
	self isAddressRecord ifTrue: [ ^self importAddress ].

	self error: self class invalidRecordTypeErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!



!CustomerImporter class methodsFor: 'error messages' stamp: 'HAW 5/22/2022 19:13:48'!
canNotImportAddressWithoutCustomerErrorDescription

	^'Cannot import address without customer'! !

!CustomerImporter class methodsFor: 'error messages' stamp: 'HAW 5/22/2022 19:53:56'!
invalidCustomerRecordErrorDescription

	^'Invalid Customer record'! !


!classDefinition: #SupplierImporter category: 'CustomerImporter'!
PartyImporter subclass: #SupplierImporter
	instanceVariableNames: 'newSupplier'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!SupplierImporter methodsFor: 'customer' stamp: 'H 11/27/2023 05:05:25'!
importExistingCustomer

	self assertSupplierWasImported .
	self assertValidExistingCustomer.
	^ newSupplier addCustomer: (system customerWithIdentificationType: record second number: record third)! !

!SupplierImporter methodsFor: 'customer' stamp: 'H 11/27/2023 05:09:32'!
importNewCustomer

	|newCustomer| 
	
	self assertSupplierWasImported .
	self assertValidNewCustomerRecord.
	newCustomer := (CsvCustomerMapper new) mapFrom: record.
	newSupplier addCustomer: newCustomer .
	system add: newCustomer! !

!SupplierImporter methodsFor: 'customer' stamp: 'H 11/27/2023 02:47:03'!
isExistingCustomerRecord

	^ record first = 'EC'! !

!SupplierImporter methodsFor: 'customer' stamp: 'H 11/27/2023 02:46:54'!
isNewCustomerRecord

	^ record first = 'NC'! !


!SupplierImporter methodsFor: 'supplier' stamp: 'H 11/27/2023 04:55:22'!
importSupplier

	self assertValidSupplierRecord.
	newSupplier := Supplier named: record second identificationType: record third number: record fourth.
		system addSupplier: newSupplier! !

!SupplierImporter methodsFor: 'supplier' stamp: 'H 11/27/2023 02:46:46'!
isSupplierRecord

	^ record first = 'S'! !


!SupplierImporter methodsFor: 'asserts' stamp: 'H 11/27/2023 03:56:28'!
assertSupplierWasImported

	^ newSupplier ifNil: [ self error: self class cannotImportRecordsWithoutSupplierError ]! !

!SupplierImporter methodsFor: 'asserts' stamp: 'H 11/27/2023 05:05:25'!
assertValidExistingCustomer

	^ record size = 3 ifFalse: [self error: self class invalidExistingCustomerRecordErrorDescription ]! !

!SupplierImporter methodsFor: 'asserts' stamp: 'H 11/27/2023 05:09:32'!
assertValidNewCustomerRecord.

	^ record size = 5 ifFalse:  [self error: self class invalidNewCustomerRecordErrorDescription]! !

!SupplierImporter methodsFor: 'asserts' stamp: 'H 11/27/2023 04:55:22'!
assertValidSupplierRecord

	^ record size = 4 ifFalse:  [self error: self class invalidSupplierRecordErrorDescription]! !


!SupplierImporter methodsFor: 'address' stamp: 'H 11/27/2023 03:51:10'!
importAddress

	|newAddress|
	
	self assertSupplierWasImported.
	
	newAddress := self mapRecordToAddress: record.
	newSupplier addAddress: newAddress.
		! !


!SupplierImporter methodsFor: 'importRecord' stamp: 'H 11/27/2023 02:50:29'!
importRecord

	self isSupplierRecord ifTrue: [self importSupplier].
	
	self isNewCustomerRecord ifTrue: [ self importNewCustomer.].
	
	self isExistingCustomerRecord ifTrue: [ self importExistingCustomer.].
	
	self isAddressRecord ifTrue: [ self importAddress]
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SupplierImporter class' category: 'CustomerImporter'!
SupplierImporter class
	instanceVariableNames: ''!

!SupplierImporter class methodsFor: 'error messages' stamp: 'H 11/27/2023 03:56:40'!
cannotImportRecordsWithoutSupplierError
	
	^'cannot import address without supplier'! !

!SupplierImporter class methodsFor: 'error messages' stamp: 'H 11/27/2023 05:03:46'!
invalidExistingCustomerRecordErrorDescription
	^'Existing customer record should have 3 fields'! !

!SupplierImporter class methodsFor: 'error messages' stamp: 'H 11/27/2023 04:57:02'!
invalidNewCustomerRecordErrorDescription
	^'New customer record should have 5 fields'! !

!SupplierImporter class methodsFor: 'error messages' stamp: 'H 11/27/2023 04:51:05'!
invalidSupplierRecordErrorDescription
	
	^'supplier record has to have four fields'! !


!classDefinition: #DataBaseSession category: 'CustomerImporter'!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id inTransaction closed'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 11/14/2023 08:52:25'!
beginTransaction

	inTransaction := true.! !

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 11/14/2023 08:52:18'!
commit

	inTransaction := false.! !


!DataBaseSession methodsFor: 'closing' stamp: 'HAW 11/14/2023 08:52:30'!
close

	closed := true.! !


!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:49:30'!
assertCanUseDatabase

	self assertIsOpen.
	self assertInTransaction ! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:48:43'!
assertInTransaction

	inTransaction ifFalse: [ self error: 'Not in transaction' ].! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:48:16'!
assertIsOpen

	closed ifTrue: [ self error: 'Connection with database closed' ].! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 09:09:07'!
assertTypeIsPersisted: aType

	(configuration includes: aType) ifFalse: [ self error: 'Object of type ', aType name, ' are not configured to be persisted' ].! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:58:59'!
isRelationToPersist: possibleRelation

	^ possibleRelation class = Set! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:58:59'!
persistPossibleRelationOf: anObject at: anInstVarOffset

	| possibleRelation |
		
	possibleRelation := anObject instVarAt: anInstVarOffset.
	(self isRelationToPersist: possibleRelation) ifTrue: [ self persistRelationOf: anObject at: anInstVarOffset with: possibleRelation ]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:58:03'!
persistRelationOf: anObject at: anInstVarOffset with: aRelation

	| persistentRelation |
	
	persistentRelation := PersistentSet on: self from: aRelation.
	anObject instVarAt: anInstVarOffset put: persistentRelation! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:58:34'!
persistRelationsOf: anObject

	anObject class instVarNamesAndOffsetsDo: [ :anInstVarName :anInstVarOffset | self persistPossibleRelationOf: anObject at: anInstVarOffset]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 09:06:24'!
tableOfType: aType

	^ tables at: aType ifAbsentPut: [ Set new ]! !


!DataBaseSession methodsFor: 'initialization' stamp: 'HAW 11/14/2023 08:44:19'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.
	inTransaction := false.
	closed := false.! !


!DataBaseSession methodsFor: 'id' stamp: 'HAW 5/22/2022 00:19:29'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance' stamp: 'HAW 11/14/2023 09:06:24'!
persist: anObject

	| table |

	self assertCanUseDatabase.
	self assertTypeIsPersisted: anObject class.
	self delay.
	
	table := self tableOfType: anObject class.
	self defineIdOf: anObject.
	table add: anObject.
	self persistRelationsOf: anObject.
! !


!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 11/14/2023 09:06:56'!
select: aCondition ofType: aType

	self assertCanUseDatabase.
	self assertTypeIsPersisted: aType.
	self delay.
	
	^(self tableOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 11/14/2023 09:07:12'!
selectAllOfType: aType

	self assertCanUseDatabase.
	self assertTypeIsPersisted: aType.
	self delay.
	
	^(self tableOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: 'CustomerImporter'!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 00:19:29'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !


!classDefinition: #Environment category: 'CustomerImporter'!
Object subclass: #Environment
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Environment methodsFor: 'customer system' stamp: 'HAW 5/22/2022 21:41:06'!
createCustomerSystem

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Environment class' category: 'CustomerImporter'!
Environment class
	instanceVariableNames: ''!

!Environment class methodsFor: 'current' stamp: 'HAW 5/22/2022 21:37:10'!
current

	^(self subclasses detect: [ :anEnvironmentClass | anEnvironmentClass isCurrent ]) new! !

!Environment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:44:46'!
environmentKey

	^ #ENV! !

!Environment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:44:46'!
environmentVariable

	^ Smalltalk at: self environmentKey! !

!Environment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:44:09'!
identifier

	self subclassResponsibility! !

!Environment class methodsFor: 'current' stamp: 'HAW 5/22/2022 21:41:36'!
isCurrent

	self subclassResponsibility ! !

!Environment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:46:01'!
makeCurrent

	"
	Tener en cuenta que en Smalltalk se podría poner directamente la clase de environment,
	esto es DevelopmentEnvironment o IntegrationEnvironmet o hasta una instancia de ellas,
	pero se está simulando el hecho de que esto esté definido por fuera del sistema, como una
	variable del sistema operativo - Hernan"
	
	Smalltalk at: self environmentKey put: self identifier! !


!classDefinition: #DevelopmentEnvironment category: 'CustomerImporter'!
Environment subclass: #DevelopmentEnvironment
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DevelopmentEnvironment methodsFor: 'customer system' stamp: 'h 11/23/2023 17:48:07'!
createCustomerSystem

	^TransientErpSystem new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DevelopmentEnvironment class' category: 'CustomerImporter'!
DevelopmentEnvironment class
	instanceVariableNames: ''!

!DevelopmentEnvironment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:42:50'!
identifier

	^ #DEV! !

!DevelopmentEnvironment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:43:52'!
isCurrent

	"
	self makeCurrent
	"
	^self environmentVariable = self identifier! !


!classDefinition: #IntegrationEnvironment category: 'CustomerImporter'!
Environment subclass: #IntegrationEnvironment
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!IntegrationEnvironment methodsFor: 'customer system' stamp: 'h 11/23/2023 17:47:55'!
createCustomerSystem

	^PersistentErpSystem new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IntegrationEnvironment class' category: 'CustomerImporter'!
IntegrationEnvironment class
	instanceVariableNames: ''!

!IntegrationEnvironment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:43:07'!
identifier

	^ #INT! !

!IntegrationEnvironment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:44:04'!
isCurrent

	"
	self makeCurrent
	"
	^self environmentVariable = self identifier! !


!classDefinition: #ErpSystem category: 'CustomerImporter'!
Object subclass: #ErpSystem
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ErpSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:17:57'!
add: aCustomer

	self subclassResponsibility ! !

!ErpSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:18:38'!
customerWithIdentificationType: anIdType number: anIdNumber

	self subclassResponsibility ! !

!ErpSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:18:51'!
numberOfCustomers

	self subclassResponsibility ! !

!ErpSystem methodsFor: 'customers' stamp: 'h 11/23/2023 18:25:00'!
numberOfSuppliers

	self subclassResponsibility ! !


!ErpSystem methodsFor: 'transactions' stamp: 'HAW 5/22/2022 21:18:04'!
beginTransaction

	self subclassResponsibility ! !

!ErpSystem methodsFor: 'transactions' stamp: 'HAW 5/22/2022 21:18:16'!
commit

	self subclassResponsibility ! !


!ErpSystem methodsFor: 'system lifecycle' stamp: 'HAW 5/22/2022 21:18:10'!
start

	self subclassResponsibility ! !

!ErpSystem methodsFor: 'system lifecycle' stamp: 'HAW 5/22/2022 21:18:13'!
stop

	self subclassResponsibility ! !


!classDefinition: #PersistentErpSystem category: 'CustomerImporter'!
ErpSystem subclass: #PersistentErpSystem
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!PersistentErpSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:14:14'!
add: aCustomer

	^session persist: aCustomer ! !

!PersistentErpSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:09:50'!
customerWithIdentificationType: anIdType number: anIdNumber

	^(session
		select: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]]
		ofType: Customer) anyOne! !

!PersistentErpSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:08:47'!
numberOfCustomers

	^(session selectAllOfType: Customer) size! !

!PersistentErpSystem methodsFor: 'customers' stamp: 'h 11/23/2023 18:24:40'!
numberOfSuppliers

	^(session selectAllOfType: Supplier) size! !


!PersistentErpSystem methodsFor: 'transactions' stamp: 'HAW 5/22/2022 20:12:39'!
beginTransaction

	session beginTransaction.
! !

!PersistentErpSystem methodsFor: 'transactions' stamp: 'HAW 5/22/2022 20:13:00'!
commit

	session commit ! !


!PersistentErpSystem methodsFor: 'system lifecycle' stamp: 'HAW 11/14/2023 09:21:54'!
start

	session := DataBaseSession for: (Array with: Address with: Customer).
	! !

!PersistentErpSystem methodsFor: 'system lifecycle' stamp: 'HAW 5/22/2022 20:13:10'!
stop

	session close! !


!classDefinition: #TransientErpSystem category: 'CustomerImporter'!
ErpSystem subclass: #TransientErpSystem
	instanceVariableNames: 'customers suppliers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!TransientErpSystem methodsFor: 'system lifecycle' stamp: 'h 11/23/2023 18:28:35'!
start

	customers := OrderedCollection new.
	suppliers := OrderedCollection new.! !

!TransientErpSystem methodsFor: 'system lifecycle' stamp: 'h 11/23/2023 18:28:54'!
stop

	customers := nil.
	suppliers := nil.! !


!TransientErpSystem methodsFor: 'transactions' stamp: 'HAW 5/22/2022 21:21:20'!
beginTransaction

	! !

!TransientErpSystem methodsFor: 'transactions' stamp: 'HAW 5/22/2022 21:23:01'!
commit

	! !


!TransientErpSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:21:32'!
add: aCustomer

	customers add: aCustomer ! !

!TransientErpSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:22:52'!
customerWithIdentificationType: anIdType number: anIdNumber

	^customers detect: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]]! !

!TransientErpSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:21:43'!
numberOfCustomers

	^customers size! !


!TransientErpSystem methodsFor: 'suppliers' stamp: 'h 11/23/2023 18:26:32'!
addSupplier: aSupplier

	suppliers add: aSupplier ! !

!TransientErpSystem methodsFor: 'suppliers' stamp: 'h 11/23/2023 18:26:50'!
numberOfSuppliers

	^suppliers size! !

!TransientErpSystem methodsFor: 'suppliers' stamp: 'h 11/23/2023 18:32:37'!
supplierWithIdentificationType: type number: number
	
	^suppliers detect: [ :aSupplier | aSupplier isIdentifiedAs: type number: number]! !


!classDefinition: #Party category: 'CustomerImporter'!
Object subclass: #Party
	instanceVariableNames: 'addresses identificationNumber identificationType'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Party methodsFor: 'addresses' stamp: 'h 11/23/2023 18:09:23'!
addAddress: anAddress

	addresses add: anAddress ! !

!Party methodsFor: 'addresses' stamp: 'h 11/23/2023 18:09:20'!
addressAt: aStreetName ifNone: aNoneBlock

	^addresses detect: [ :address | address isAt: aStreetName ] ifNone: aNoneBlock ! !

!Party methodsFor: 'addresses' stamp: 'h 11/23/2023 18:09:06'!
addresses

	^ addresses! !

!Party methodsFor: 'addresses' stamp: 'h 11/23/2023 18:09:03'!
isAddressesEmpty

	^addresses isEmpty ! !


!Party methodsFor: 'initialization' stamp: 'h 11/23/2023 18:12:12'!
initialize

	super initialize.
	addresses := OrderedCollection new.! !


!Party methodsFor: 'identification' stamp: 'h 11/23/2023 18:12:27'!
identificationNumber

	^identificationNumber ! !

!Party methodsFor: 'identification' stamp: 'h 11/23/2023 18:12:23'!
identificationNumber: anIdentificationNumber

	identificationNumber := anIdentificationNumber! !

!Party methodsFor: 'identification' stamp: 'h 11/23/2023 18:12:16'!
identificationType

	^identificationType ! !

!Party methodsFor: 'identification' stamp: 'h 11/23/2023 18:12:19'!
identificationType: anIdentificationType

	identificationType := anIdentificationType! !


!classDefinition: #Customer category: 'CustomerImporter'!
Party subclass: #Customer
	instanceVariableNames: 'firstName lastName id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!


!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName

	^firstName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName: aName

	firstName := aName! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName

	^lastName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName: aLastName

	lastName := aLastName
! !




!Customer methodsFor: 'tests' stamp: 'H 11/27/2023 01:16:10'!
isIdentifiedAs: type number: number 
	
	^identificationNumber = number asString and: [identificationType = type].! !


!classDefinition: #Supplier category: 'CustomerImporter'!
Party subclass: #Supplier
	instanceVariableNames: 'name customers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Supplier methodsFor: 'initialize' stamp: 'h 11/23/2023 18:44:38'!
initializeNamed: aName identificationType: type number: number 
	
	name := aName.
	identificationType := type.
	identificationNumber := number.
	customers := OrderedCollection new.! !


!Supplier methodsFor: 'test' stamp: 'h 11/23/2023 19:26:39'!
addCustomer: customer
	
	customers add: customer ! !

!Supplier methodsFor: 'test' stamp: 'h 11/23/2023 18:54:19'!
customerCountIs: count
	
	^customers size = count! !

!Supplier methodsFor: 'test' stamp: 'h 11/23/2023 18:44:22'!
isCustomersEmpty
	
	^customers isEmpty! !

!Supplier methodsFor: 'test' stamp: 'h 11/23/2023 18:42:35'!
isIdentifiedAs: type number: number 
	
	^identificationNumber = number asString and: [identificationType = type].! !

!Supplier methodsFor: 'test' stamp: 'h 11/23/2023 18:43:58'!
isNamed: aName
	
	^name = aName .! !


!Supplier methodsFor: 'customer' stamp: 'h 11/23/2023 20:23:43'!
customerWithIdType: type andIdNumber: number
	
	^customers detect: [:aCustomer | aCustomer identificationType = type and: [aCustomer identificationNumber = number]]! !


!Supplier methodsFor: 'addresses' stamp: 'H 11/27/2023 02:44:12'!
adressessCount
	
	^addresses size! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Supplier class' category: 'CustomerImporter'!
Supplier class
	instanceVariableNames: ''!

!Supplier class methodsFor: 'instance creation' stamp: 'h 11/23/2023 17:41:59'!
named: aName identificationType: type number: number 
	
	^self new initializeNamed: aName identificationType: type number: number .! !
