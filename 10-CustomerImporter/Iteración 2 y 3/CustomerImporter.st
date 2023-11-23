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
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests' stamp: 'mm uu 11/22/2023 17:56:45'!
test01Import

	CustomerImporter valueFrom: self validImportData into: session.

	self assertImportedRightNumberOfCustomers.
	self assertPepeSanchezWasImportedCorrecty.
	self assertJuanPerezWasImportedCorrectly ! !

!ImportTest methodsFor: 'tests' stamp: 'h 11/20/2023 03:58:34'!
test02CannoImportCustomerRecordWithLessThan5Records

	self should: [CustomerImporter valueFrom: self dataWithCustomerRecordWith4Fields into: session]
		raise: Error
		withExceptionDo: [:anError| 
			self assert: anError messageText = CustomerImporter customerRecordWithout5FieldsError .
			self assert: (session selectAllOfType: Customer) size equals: 0. ]! !

!ImportTest methodsFor: 'tests' stamp: 'h 11/20/2023 03:58:40'!
test03CannotImportCustomerRecordWithMoreThan5Records

	self should: [CustomerImporter valueFrom: self dataWithCustomerWith6Fields into: session]
		raise: Error
		withExceptionDo: [:anError| 
			self assert: anError messageText = CustomerImporter customerRecordWithout5FieldsError .
			self assert: (session selectAllOfType: Customer) size equals: 0. ]! !

!ImportTest methodsFor: 'tests' stamp: 'h 11/20/2023 03:58:45'!
test04CannotImportAddressRecordWithMoreThan6Records

	self should: [CustomerImporter valueFrom: self dataWithAddressWith7Fields into: session]
		raise: Error
		withExceptionDo: [:anError| 
			self assert: anError messageText = CustomerImporter addressRecordWithout6FieldsError .
			self deny: ((session selectAllOfType: Customer) anySatisfy: [:aCustomer | 
				aCustomer addresses size > 0]) 
			].! !

!ImportTest methodsFor: 'tests' stamp: 'h 11/20/2023 03:58:50'!
test05CannotImportAddressRecordWithLessThan6Records

	self should: [CustomerImporter valueFrom: self dataWithAddressWith5Fields into: session]
		raise: Error
		withExceptionDo: [:anError| 
			self assert: anError messageText = CustomerImporter addressRecordWithout6FieldsError .
			self deny: ((session selectAllOfType: Customer) anySatisfy: [:aCustomer | 
				aCustomer addresses size > 0]) 
			].! !

!ImportTest methodsFor: 'tests' stamp: 'h 11/20/2023 03:59:01'!
test06CannotImportRecordWhichIsNotACustomerNorAnAddress

	self
		should: [CustomerImporter valueFrom: self dataWithInvalidRecord into: session ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = CustomerImporter invalidRecordError.
			self
				assert: (session selectAllOfType: Customer) size
				equals: 0 ].
	
	self
		should: [CustomerImporter valueFrom: self moreDataWithInvalidRecord into: session ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = CustomerImporter invalidRecordError.
			self
				assert: (session selectAllOfType: Customer) size
				equals: 0 ].
			
	self
		should: [CustomerImporter valueFrom: self evenMoreDataWithInvalidRecord into: session ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = CustomerImporter invalidRecordError.
			self deny: ((session selectAllOfType: Customer) anySatisfy: [:aCustomer | 
				aCustomer addresses size > 0]) 
				].! !

!ImportTest methodsFor: 'tests' stamp: 'h 11/20/2023 03:59:16'!
test07CannotImportAddressRecordWithNoCustomer

			
	self
		should: [CustomerImporter valueFrom: self addressWithNoCustomer into: session ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = CustomerImporter addressWithNoCustomerError .
			self assert: (session selectAllOfType: Customer) size
				equals: 0.
			self deny: ((session selectAllOfType: Customer) anySatisfy: [:aCustomer | 
				aCustomer addresses size > 0]) 
				].! !


!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:22:05'!
assertAddressOf: importedCustomer at: aStreetName hasNumber: aNumber town: aTown zipCode: aZipCode province: aProvince

	| importedAddress |

	importedAddress := importedCustomer addressAt: aStreetName ifNone: [ self fail ].
	self assert: aStreetName equals: importedAddress streetName.
	self assert: aNumber equals: importedAddress streetNumber.
	self assert: aTown equals: importedAddress town.
	self assert: aZipCode equals: importedAddress zipCode.
	self assert: aProvince equals: importedAddress province.

	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:27:57'!
assertCustomerWithIdentificationType: anIdType number: anIdNumber hasFirstName: aFirstName lastName: aLastName

	| importedCustomer |

	importedCustomer := self customerWithIdentificationType: anIdType number: anIdNumber.

	self assert: aFirstName equals: importedCustomer firstName.
	self assert: aLastName equals: importedCustomer lastName.
	self assert: anIdType equals: importedCustomer identificationType.
	self assert: anIdNumber equals: importedCustomer identificationNumber.

	^importedCustomer

	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:12:18'!
assertImportedRightNumberOfCustomers

	^ self assert: 2 equals: (session selectAllOfType: Customer) size! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:45'!
assertJuanPerezWasImportedCorrectly

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'C' number: '23-25666777-9' hasFirstName: 'Juan' lastName: 'Perez'.
	self assertAddressOf: importedCustomer at: 'Alem' hasNumber: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'
	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:05'!
assertPepeSanchezWasImportedCorrecty

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.
	self assertAddressOf: importedCustomer at: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.
	self assertAddressOf: importedCustomer at: 'Maipu' hasNumber: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'.


	! !


!ImportTest methodsFor: 'setUp/tearDown' stamp: 'mm uu 11/23/2023 16:10:13'!
buildEnv
	self env = 'dev' ifTrue: [^TransientCustomerSystem new.].
	self env = 'prod' ifTrue: [^PersistentCustomerSystem new].
! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'mm uu 11/23/2023 16:10:18'!
env
	^'prod'
! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'mm uu 11/23/2023 16:08:01'!
setUp

	session := self buildEnv
! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'mm uu 11/22/2023 18:27:31'!
tearDown
	session close
	"session commit.
	session close."
	! !


!ImportTest methodsFor: 'customer' stamp: 'mm uu 11/22/2023 18:08:51'!
customerWithIdentificationType: anIdType number: anIdNumber

	^ (session customerWithIdType: anIdType idNumber: anIdNumber).
		"select: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]]
		ofType: Customer) anyOne"! !


!ImportTest methodsFor: 'test data' stamp: 'h 11/20/2023 03:48:09'!
addressWithNoCustomer

	^ ReadStream on:
'A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9'! !

!ImportTest methodsFor: 'test data' stamp: 'h 11/19/2023 18:39:53'!
dataWithAddressWith5Fields

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'h 11/19/2023 18:39:47'!
dataWithAddressWith7Fields

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs,x
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'h 11/19/2023 18:34:21'!
dataWithCustomerRecordWith4Fields

	^ ReadStream on:
'C,Pepe,Sanchez,D
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'h 11/19/2023 18:35:54'!
dataWithCustomerWith6Fields

	^ ReadStream on:
'C,Pepe,Sanchez,D,1,x
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'h 11/19/2023 18:46:27'!
dataWithInvalidRecord

	^ ReadStream on: 'F,Pepe,Sanchez,D,22333444
C,Juan,Perez,C,23-25666777-9'.! !

!ImportTest methodsFor: 'test data' stamp: 'h 11/19/2023 19:04:58'!
evenMoreDataWithInvalidRecord

	^ ReadStream on: 'C,Pepe,Sanchez,D,22333444
Address,San Martin,3322,Olivos,1636,BsAs'.! !

!ImportTest methodsFor: 'test data' stamp: 'h 11/19/2023 18:52:55'!
moreDataWithInvalidRecord

	^ ReadStream on: 'Casa,Pepe,Sanchez,D,22333444
C,Juan,Perez,C,23-25666777-9'.! !

!ImportTest methodsFor: 'test data' stamp: 'h 11/20/2023 04:05:31'!
trailingBlanksImportData

	^ ReadStream on:
'C,Pepe     ,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

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


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 17:55:17'!
addressAt: aStreetName ifNone: aNoneBlock

	^addresses detect: [ :address | address isAt: aStreetName ] ifNone: aNoneBlock ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addresses

	^ addresses! !


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


!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber

	^identificationNumber ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber: anIdentificationNumber

	identificationNumber := anIdentificationNumber! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType

	^identificationType ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType: anIdentificationType

	identificationType := anIdentificationType! !


!Customer methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initialize

	super initialize.
	addresses := OrderedCollection new.! !


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
Object subclass: #CustomerImporter
	instanceVariableNames: 'session readStream line newCustomer record customerSystem'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'HAW 5/22/2022 18:06:47'!
initializeFrom: aReadStream into: aSession
	session := aSession.
	readStream := aReadStream.! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'h 11/19/2023 18:29:35'!
getRecord

	^ record := line findTokens: $,! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'h 11/20/2023 03:55:06'!
importAddress

	|newAddress |
	
	record size = 6 ifFalse: [ self error: self class addressRecordWithout6FieldsError ].
	
	newAddress := Address new.
	newCustomer ifNotNil: [newCustomer addAddress: newAddress] 
				ifNil: [self error: self class addressWithNoCustomerError].
	newAddress streetName: record second.
	newAddress streetNumber: record third asNumber .
	newAddress town: record fourth.
	newAddress zipCode: record fifth asNumber .
	newAddress province: record sixth! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'mm uu 11/22/2023 18:10:24'!
importCustomer

	record size = 5 ifFalse: [ self error: self class customerRecordWithout5FieldsError ].
	
	newCustomer := Customer new.
	newCustomer firstName: record second.
	newCustomer lastName: record third.
	newCustomer identificationType: record fourth.
	newCustomer identificationNumber: record fifth.
	session add: newCustomer.! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'h 11/19/2023 18:47:56'!
importRecord

	( self isCustomerRecord) ifTrue: [ ^self importCustomer ].
	(self isAddressRecord) ifTrue: [ ^self importAddress ].
	
	self error: self class invalidRecordError.! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'h 11/19/2023 19:05:19'!
isAddressRecord

	^ (line beginsWith: 'A') and: [record first size = 1]! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'h 11/19/2023 19:02:19'!
isCustomerRecord

	^ (line beginsWith: 'C') and: [record first size = 1]! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'h 11/19/2023 18:35:23'!
readNextLine

	line := readStream nextLine.  
	^line notNil! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'h 11/19/2023 18:32:49'!
value

	"
	self importCustomers
	"
	
	[ self readNextLine ] whileTrue: [
		self getRecord.
		self importRecord.
		].

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 18:06:47'!
from: aReadStream into: aSession
	^self new initializeFrom: aReadStream into: aSession! !


!CustomerImporter class methodsFor: 'errors' stamp: 'h 11/19/2023 18:40:12'!
addressRecordWithout6FieldsError

	^'Address record should have 6 fields'! !

!CustomerImporter class methodsFor: 'errors' stamp: 'h 11/20/2023 03:54:44'!
addressWithNoCustomerError

	^'Address does not belong to a customer'! !

!CustomerImporter class methodsFor: 'errors' stamp: 'h 11/19/2023 18:34:49'!
customerRecordWithout5FieldsError

	^'Customer record should have 5 fields'! !

!CustomerImporter class methodsFor: 'errors' stamp: 'h 11/19/2023 18:46:41'!
invalidRecordError
	^ 'Record is not a customer nor an address'.! !


!CustomerImporter class methodsFor: 'importing' stamp: 'HAW 5/22/2022 18:11:27'!
valueFrom: aReadStream into: aSession

	^(self from: aReadStream into: aSession) value! !


!classDefinition: #CustomerSystem category: 'CustomerImporter'!
Object subclass: #CustomerSystem
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!


!classDefinition: #PersistentCustomerSystem category: 'CustomerImporter'!
CustomerSystem subclass: #PersistentCustomerSystem
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!PersistentCustomerSystem methodsFor: 'operations' stamp: 'mm uu 11/22/2023 18:18:16'!
add: aNewCustomer 
	session persist: aNewCustomer .! !

!PersistentCustomerSystem methodsFor: 'operations' stamp: 'mm uu 11/22/2023 18:27:24'!
close
	session commit.
	session close! !

!PersistentCustomerSystem methodsFor: 'operations' stamp: 'mm uu 11/22/2023 18:29:18'!
customerWithIdType: anIdType idNumber: anIdNumber 
	^(session 
		select: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]]
		ofType: Customer) anyOne! !

!PersistentCustomerSystem methodsFor: 'operations' stamp: 'mm uu 11/22/2023 18:14:57'!
initialize
	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction ! !

!PersistentCustomerSystem methodsFor: 'operations' stamp: 'mm uu 11/22/2023 18:26:26'!
selectAllOfType: aType 
	^session selectAllOfType: aType! !


!classDefinition: #TransientCustomerSystem category: 'CustomerImporter'!
CustomerSystem subclass: #TransientCustomerSystem
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!TransientCustomerSystem methodsFor: 'operations' stamp: 'mm uu 11/22/2023 19:29:47'!
add: aNewCustomer
	session add: aNewCustomer! !

!TransientCustomerSystem methodsFor: 'operations' stamp: 'mm uu 11/22/2023 19:31:15'!
close! !

!TransientCustomerSystem methodsFor: 'operations' stamp: 'mm uu 11/22/2023 19:34:44'!
customerWithIdType: anIdType idNumber: anIdNumber 
	^(session select: [:aCustomer | 
		aCustomer identificationType = anIdType and: 
		[aCustomer identificationNumber = anIdNumber ]] ) first! !

!TransientCustomerSystem methodsFor: 'operations' stamp: 'mm uu 11/22/2023 19:27:56'!
initialize
	session := OrderedCollection new! !

!TransientCustomerSystem methodsFor: 'operations' stamp: 'mm uu 11/22/2023 19:33:25'!
selectAllOfType: aType 
	^session copy! !


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
