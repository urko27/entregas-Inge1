!classDefinition: #LogsTest category: 'MarsRover-WithHeading'!
TestCase subclass: #LogsTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!LogsTest methodsFor: 'as yet unclassified' stamp: 'h 10/30/2023 14:36:14'!
test01LoggerOfRoverAtCreationDoesNotHaveRegisteredChanges
	|marsRover logger|
	marsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth .
	logger := Logger for: marsRover.
	logger observeChangesForPosition.
	
	marsRover process: ''.
	
	self assert: logger showLogs size equals: 0.! !

!LogsTest methodsFor: 'as yet unclassified' stamp: 'h 10/30/2023 14:36:43'!
test02LoggerRegistersRoversMovements
	|marsRover logger|
	marsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth .
	logger := Logger for: marsRover.
	logger observeChangesForPosition .
	
	marsRover process: 'f'.
	
	self assert: logger showLogs first equals: 0@1.
	self assert: logger showLogs size equals: 1.! !

!LogsTest methodsFor: 'as yet unclassified' stamp: 'h 10/30/2023 14:37:47'!
test03PositionOnlyLoggerDoesNotRegisterRotations
	|marsRover logger|
	marsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth .
	logger := Logger for: marsRover.
	logger observeChangesForPosition .
	
	marsRover process: 'fr'.
	
	self assert: logger showLogs first equals: 0@1.
	self assert: logger showLogs size equals: 1.! !

!LogsTest methodsFor: 'as yet unclassified' stamp: 'h 10/30/2023 14:38:09'!
test04LoggerRegistersMultipleMovements
	|marsRover logger logs|
	marsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth .
	logger := Logger for: marsRover.
	logger observeChangesForPosition .
	
	marsRover process: 'frffrb'.
	
	logs := logger showLogs .
	
	self assert: logs first equals: 0@1.
	self assert: logs second equals: 1@1.
	self assert: logs third equals: 2@1.
	self assert: logs fourth equals: 2@2.
	self assert: logger showLogs size equals: 4.! !

!LogsTest methodsFor: 'as yet unclassified' stamp: 'h 10/30/2023 14:38:32'!
test05LoggerRegistersRotations
	|marsRover logger|
	marsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth .
	logger := Logger for: marsRover.
	logger observeChangesForHead.
	
	marsRover process: 'r'.
	
	self assert: logger showLogs first equals: 'East'.
	self assert: logger showLogs size equals: 1.! !

!LogsTest methodsFor: 'as yet unclassified' stamp: 'h 10/30/2023 14:38:42'!
test06LoggerRegistersMultipleRotations
	|marsRover logger|
	marsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth .
	logger := Logger for: marsRover.
	logger observeChangesForHead .
	
	marsRover process: 'rlll'.

	self assert: logger showLogs first equals: 'East'.
	self assert: logger showLogs second equals: 'North'.
	self assert: logger showLogs third equals: 'West'.
	self assert: logger showLogs fourth equals: 'South'.
	self assert: logger showLogs size equals: 4.! !

!LogsTest methodsFor: 'as yet unclassified' stamp: 'h 10/30/2023 14:40:25'!
test07HeadingOnlyLoggerDoesNotRegisterPositionChange
	|marsRover logger|
	marsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth .
	logger := Logger for: marsRover.
	logger observeChangesForHead .
	
	marsRover process: 'rlllf'.

	self assert: logger showLogs first equals: 'East'.
	self assert: logger showLogs second equals: 'North'.
	self assert: logger showLogs third equals: 'West'.
	self assert: logger showLogs fourth equals: 'South'.
	self assert: logger showLogs size equals: 4.! !

!LogsTest methodsFor: 'as yet unclassified' stamp: 'h 10/30/2023 14:41:03'!
test08LoggerCanRegisterPositionAndHeadChangesSimultaneously
	|marsRover logger|
	marsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth .
	logger := Logger for: marsRover.
	logger observeChangesForPosition .
	logger observeChangesForHead .
	
	marsRover process: 'rllfb'.

	self assert: logger showLogs first equals: 'East'.
	self assert: logger showLogs second equals: 'North'.
	self assert: logger showLogs third equals: 'West'.
	self assert: logger showLogs fourth equals: -1@0.
	self assert: logger showLogs fifth equals: 0@0.
	self assert: logger showLogs size equals: 5.! !


!classDefinition: #MarsRoverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:21:23'!
test01DoesNotMoveWhenNoCommand

	self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: '' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:12'!
test02IsAtFailsForDifferentPosition

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@2 heading: self north)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:31'!
test03IsAtFailsForDifferentHeading

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@1 heading: self south)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:17'!
test04IncrementsYAfterMovingForwardWhenHeadingNorth

	self 
		assertIsAt: 1@3 
		heading: self north 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:11'!
test06DecrementsYAfterMovingBackwardsWhenHeadingNorth

	self 
		assertIsAt: 1@1 
		heading: self north 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:59'!
test07PointToEashAfterRotatingRightWhenHeadingNorth

	self 
		assertIsAt: 1@2 
		heading: self east 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:51'!
test08PointsToWestAfterRotatingLeftWhenPointingNorth

	self 
		assertIsAt: 1@2 
		heading: self west 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:45'!
test09DoesNotProcessInvalidCommand

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: self north.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: self north) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:39'!
test10CanProcessMoreThanOneCommand

	self 
		assertIsAt: 1@4 
		heading: self north 
		afterProcessing: 'ff' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:31'!
test11IncrementsXAfterMovingForwareWhenHeadingEast

	self 
		assertIsAt: 2@2 
		heading: self east 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:19'!
test12DecrementsXAfterMovingBackwardWhenHeadingEast

	self 
		assertIsAt: 0@2 
		heading: self east 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:14'!
test13PointsToSouthAfterRotatingRightWhenHeadingEast

		self 
		assertIsAt: 1@2 
		heading: self south 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:05'!
test14PointsToNorthAfterRotatingLeftWhenPointingEast

		self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:00'!
test15ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingSouth

	self 
		assertIsAt: 1@1 
		heading: self west 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self south 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:52'!
test16ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingWest

	self 
		assertIsAt: 0@2 
		heading: self north 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self west 
! !


!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:31'!
east

	^ MarsRoverHeadingEast ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:38'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:45'!
south

	^ MarsRoverHeadingSouth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:54'!
west

	^ MarsRoverHeadingWest ! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'HAW 10/7/2021 20:20:47'!
assertIsAt: newPosition heading: newHeadingType afterProcessing: commands whenStartingAt: startPosition heading: startHeadingType

	| marsRover |
	
	marsRover := MarsRover at: startPosition heading: startHeadingType. 
	
	marsRover process: commands.
	
	self assert: (marsRover isAt: newPosition heading: newHeadingType)! !


!classDefinition: #WindowTest category: 'MarsRover-WithHeading'!
TestCase subclass: #WindowTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!WindowTest methodsFor: 'as yet unclassified' stamp: 'h 10/30/2023 14:43:33'!
test01WindowIsEmptyWithoutRoverChanges

	|windowLog rover|
	
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth .
	windowLog := WindowLog for: rover.
	windowLog observeChangesForPosition.	
	self assert: windowLog showWindow first equals: ''.
	self assert: windowLog showWindow second equals: ''.! !

!WindowTest methodsFor: 'as yet unclassified' stamp: 'h 10/30/2023 14:44:03'!
test02WindowRegistersPositionChanges

	|windowLog rover|
	
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth .
	windowLog := WindowLog for: rover.
	windowLog observeChangesForPosition .
	
	rover process: 'f'.
	
	self assert: windowLog showWindow first equals: 0@1.
	self assert: windowLog showWindow second equals: ''.! !

!WindowTest methodsFor: 'as yet unclassified' stamp: 'h 10/30/2023 14:47:41'!
test03PositionOnlyWindowDoesNotRegistersHeadChanges

	|windowLog rover|
	
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth .
	windowLog := WindowLog for: rover.
	windowLog observeChangesForPosition .
	
	rover process: 'fr'.
	
	self assert: windowLog showWindow first equals: 0@1.
	self assert: windowLog showWindow second equals: ''.! !

!WindowTest methodsFor: 'as yet unclassified' stamp: 'h 10/30/2023 14:47:48'!
test04WindowRegistesRoverRotations

	|windowLog rover|
	
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth .
	windowLog := WindowLog for: rover.
	windowLog observeChangesForHead.
	
	rover process: 'r'.
	
	self assert: windowLog showWindow first equals: ''.
	self assert: windowLog showWindow second equals: 'Advancing towards East'.! !

!WindowTest methodsFor: 'as yet unclassified' stamp: 'h 10/30/2023 14:49:38'!
test05HeadOnlyWindowDoesNotRegisterPositionChanges

	|windowLog rover|
	
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth .
	windowLog := WindowLog for: rover.
	windowLog observeChangesForHead.
	
	rover process: 'rf'.
	
	self assert: windowLog showWindow first equals: ''.
	self assert: windowLog showWindow second equals: 'Advancing towards East'.! !

!WindowTest methodsFor: 'as yet unclassified' stamp: 'h 10/30/2023 14:49:42'!
test06WindowRegistersPositionAndHeadChanges

	|windowLog rover|
	
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth .
	windowLog := WindowLog for: rover.
	windowLog observeChangesForHead .
	windowLog observeChangesForPosition .
	
	rover process: 'fr'.
	
	self assert: windowLog showWindow first equals: 0@1.
	self assert: windowLog showWindow second equals: 'Advancing towards East'.! !

!WindowTest methodsFor: 'as yet unclassified' stamp: 'h 10/30/2023 14:48:36'!
test07WindowRegistersMultipleChanges

	|windowLog rover|
	
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth .
	windowLog := WindowLog for: rover.
	windowLog observeChangesForHead .
	windowLog observeChangesForPosition .
	
	rover process: 'fbrl'.
	
	self assert: windowLog showWindow first equals: 0@0.
	self assert: windowLog showWindow second equals: 'Advancing towards North'.! !


!classDefinition: #Logger category: 'MarsRover-WithHeading'!
Object subclass: #Logger
	instanceVariableNames: 'marsRover logs'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!Logger methodsFor: 'initialization' stamp: 'mm uu 10/29/2023 19:04:58'!
initializeFor: MarsRover 
	marsRover := MarsRover.
	logs := OrderedCollection new.! !


!Logger methodsFor: 'observe' stamp: 'mm uu 10/30/2023 13:27:43'!
observeChangesForHead
	marsRover subscribeTo: #head with: [:aHead | logs add: aHead directionName ]! !

!Logger methodsFor: 'observe' stamp: 'mm uu 10/30/2023 13:25:11'!
observeChangesForPosition
	marsRover subscribeTo: #position with: [:aPosition | logs add: aPosition ] .! !


!Logger methodsFor: 'logs' stamp: 'mm uu 10/26/2023 21:19:31'!
showLogs
	^logs! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Logger class' category: 'MarsRover-WithHeading'!
Logger class
	instanceVariableNames: ''!

!Logger class methodsFor: 'instance creation' stamp: 'mm uu 10/26/2023 21:07:51'!
for: MarsRover
	^self new initializeFor: MarsRover ! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'mm uu 10/26/2023 21:11:55'!
attach: aLogger 
	observers add: aLogger! !

!MarsRover methodsFor: 'initialization' stamp: 'h 10/30/2023 02:44:33'!
initializeAt: aPosition heading: aHeadingType

	position := SubscriptableColaborator for: aPosition.
	head := SubscriptableColaborator for: (aHeadingType for: self) .! !


!MarsRover methodsFor: 'heading' stamp: 'h 10/30/2023 02:48:20'!
headEast
	head updateWith: (MarsRoverHeadingEast for: self)! !

!MarsRover methodsFor: 'heading' stamp: 'h 10/30/2023 02:48:26'!
headNorth
	
	head updateWith: (MarsRoverHeadingNorth for: self )! !

!MarsRover methodsFor: 'heading' stamp: 'h 10/30/2023 02:48:30'!
headSouth
	
	head updateWith: (MarsRoverHeadingSouth for: self)! !

!MarsRover methodsFor: 'heading' stamp: 'h 10/30/2023 02:48:33'!
headWest
	
	head updateWith: (MarsRoverHeadingWest for: self)! !

!MarsRover methodsFor: 'heading' stamp: 'mm uu 10/29/2023 19:15:58'!
rotateLeft
	
	head value rotateLeft! !

!MarsRover methodsFor: 'heading' stamp: 'mm uu 10/29/2023 19:16:02'!
rotateRight
	
	head value rotateRight! !


!MarsRover methodsFor: 'testing' stamp: 'mm uu 10/29/2023 19:13:31'!
isAt: aPosition heading: aHeadingType

	^position value = aPosition and: [ head value isHeading: aHeadingType ]! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:51'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:19'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:51'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:21'!
isRotateRightCommand: aCommand

	^aCommand = $r! !


!MarsRover methodsFor: 'moving' stamp: 'mm uu 10/29/2023 19:15:40'!
moveBackward
	
	head value moveBackward! !

!MarsRover methodsFor: 'moving' stamp: 'h 10/30/2023 02:48:43'!
moveEast
	position updateWith: (position value) + (1@0)! !

!MarsRover methodsFor: 'moving' stamp: 'mm uu 10/29/2023 19:15:46'!
moveForward
	
	head value moveForward! !

!MarsRover methodsFor: 'moving' stamp: 'h 10/30/2023 02:48:48'!
moveNorth
	position updateWith: (position value) + (0@1)! !

!MarsRover methodsFor: 'moving' stamp: 'h 10/30/2023 02:48:51'!
moveSouth
	position updateWith: (position value) + (0@-1)! !

!MarsRover methodsFor: 'moving' stamp: 'h 10/30/2023 02:48:54'!
moveWest
	position updateWith: (position value) + (-1@0)! !


!MarsRover methodsFor: 'command processing' stamp: 'mm uu 10/29/2023 18:49:28'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand]
! !

!MarsRover methodsFor: 'command processing' stamp: 'HAW 8/22/2019 12:08:50'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !


!MarsRover methodsFor: 'observers' stamp: 'h 10/30/2023 14:51:46'!
subscribeTo: instanceVariableName with: anObserverBlock
	(self instVarNamed: instanceVariableName) addObserverWith: anObserverBlock ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings observers'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:10:30'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !



!classDefinition: #MarsRoverHeading category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:15:38'!
isHeading: aHeadingType

	^self isKindOf: aHeadingType ! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'initialization' stamp: 'HAW 10/7/2021 20:11:59'!
initializeFor: aMarsRover 
	
	marsRover := aMarsRover.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: 'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:11:35'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverHeadingEast category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'mm uu 10/29/2023 19:31:28'!
directionName
	^'East'! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headSouth! !


!classDefinition: #MarsRoverHeadingNorth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'mm uu 10/29/2023 19:37:07'!
directionName
	^'North'! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headEast! !


!classDefinition: #MarsRoverHeadingSouth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'mm uu 10/29/2023 19:38:00'!
directionName
	^'South'! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headWest! !


!classDefinition: #MarsRoverHeadingWest category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	^marsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'mm uu 10/29/2023 19:37:21'!
directionName
	^'West'! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headNorth! !


!classDefinition: #SubscriptableColaborator category: 'MarsRover-WithHeading'!
Object subclass: #SubscriptableColaborator
	instanceVariableNames: 'colaborator observers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!SubscriptableColaborator methodsFor: 'update' stamp: 'h 10/30/2023 02:43:57'!
addObserverWith: aBlock 
	observers add: aBlock.! !

!SubscriptableColaborator methodsFor: 'update' stamp: 'h 10/30/2023 03:02:37'!
updateWith: newColaborator 
	colaborator := newColaborator .
	self notifyAll.! !


!SubscriptableColaborator methodsFor: 'initialization' stamp: 'h 10/30/2023 02:46:11'!
initializeFor: aColaborator 
	colaborator := aColaborator .
	observers := OrderedCollection new.! !

!SubscriptableColaborator methodsFor: 'initialization' stamp: 'h 10/30/2023 02:45:09'!
value
	^colaborator! !


!SubscriptableColaborator methodsFor: 'notify' stamp: 'h 10/30/2023 02:45:28'!
notifyAll
	observers do: [:observerBlock | observerBlock value: colaborator ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SubscriptableColaborator class' category: 'MarsRover-WithHeading'!
SubscriptableColaborator class
	instanceVariableNames: ''!

!SubscriptableColaborator class methodsFor: 'instance creation' stamp: 'h 10/30/2023 02:46:30'!
for: aColaborator
	^self new initializeFor: aColaborator ! !


!classDefinition: #WindowLog category: 'MarsRover-WithHeading'!
Object subclass: #WindowLog
	instanceVariableNames: 'marsRover window'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!WindowLog methodsFor: 'initialization' stamp: 'h 10/30/2023 03:37:41'!
initializeFor: MarsRover 
	marsRover := MarsRover.
	window := OrderedCollection new.
	window add: ''. window add: ''.! !


!WindowLog methodsFor: 'logs' stamp: 'h 10/30/2023 03:35:25'!
showWindow

	^window ! !


!WindowLog methodsFor: 'observe' stamp: 'mm uu 10/30/2023 13:33:32'!
observeChangesForHead
	marsRover subscribeTo: #head with: [:aHead | window at: 2 put: 'Advancing towards ',aHead directionName] ! !

!WindowLog methodsFor: 'observe' stamp: 'mm uu 10/30/2023 13:30:59'!
observeChangesForPosition
	marsRover subscribeTo: #position with: [:aPosition | window at: 1 put: aPosition].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WindowLog class' category: 'MarsRover-WithHeading'!
WindowLog class
	instanceVariableNames: ''!

!WindowLog class methodsFor: 'as yet unclassified' stamp: 'h 10/30/2023 03:14:02'!
for: MarsRover
	^self new initializeFor: MarsRover ! !
