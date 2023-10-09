!classDefinition: #MarsRoversTests category: 'MarsRovers'!
TestCase subclass: #MarsRoversTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRovers'!

!MarsRoversTests methodsFor: 'tests' stamp: 'm u 10/9/2023 16:06:50'!
test01RoversStartsWithPositionAndDirection

	|rovers|
	
	rovers := Rovers atPosition: 0@0 withDirection: North new.
	
	rovers processInstructions: ''. 
	
	self assert: (rovers isAt: 0@0 withDirection: North new)! !

!MarsRoversTests methodsFor: 'tests' stamp: 'h 10/7/2023 19:26:07'!
test03RoversCanMoveForward

	|rovers|
	
	rovers := Rovers atPosition: 0@0 withDirection: North new.
	
	rovers processInstructions: 'f'. 
	
	self assert: (rovers isAt: 0@1 withDirection: North new)! !

!MarsRoversTests methodsFor: 'tests' stamp: 'h 10/7/2023 19:26:19'!
test04RoversCanMoveBackwards

	|rovers|
	
	rovers := Rovers atPosition: 0@0 withDirection: North new.
	
	rovers processInstructions: 'b'.
	
	self assert: (rovers isAt: 0@-1 withDirection: North new)! !

!MarsRoversTests methodsFor: 'tests' stamp: 'h 10/7/2023 19:26:41'!
test05RoversCanRotateToTheLeft

	|rovers|
	
	rovers := Rovers atPosition: 0@0 withDirection: North new.
	
	rovers processInstructions: 'l'.
	
	self assert: (rovers isAt: 0@0 withDirection: West new)! !

!MarsRoversTests methodsFor: 'tests' stamp: 'm u 10/9/2023 10:35:54'!
test06RoversCanRotateToTheLeftWhenFacingEast

	|rovers|
	
	rovers := Rovers atPosition: 0@0 withDirection: East new.
	
	rovers processInstructions: 'l'.
	
	self assert: (rovers isAt: 0@0 withDirection: North new)! !

!MarsRoversTests methodsFor: 'tests' stamp: 'h 10/7/2023 19:28:10'!
test07RoversCanRotateToTheRight

	|rovers|
	
	rovers := Rovers atPosition: 0@0 withDirection: North new.
	
	rovers processInstructions: 'r'.
	
	self assert: (rovers isAt: 0@0 withDirection: East new)! !

!MarsRoversTests methodsFor: 'tests' stamp: 'm u 10/9/2023 10:35:45'!
test08RoversCanRotateToTheRightWhenFacingWest

	|rovers|
	
	rovers := Rovers atPosition: 0@0 withDirection: West new.
	
	rovers processInstructions: 'r'.
	
	self assert: (rovers isAt: 0@0 withDirection: North new)! !

!MarsRoversTests methodsFor: 'tests' stamp: 'm u 10/9/2023 10:37:16'!
test09RoversCanRotateAndMoveWhenFacingNorth

	|rovers|
	
	rovers := Rovers atPosition: 0@0 withDirection: North new.
	
	rovers processInstructions: 'rffb'.
	
	self assert: (rovers isAt: 1@0 withDirection: East new)! !

!MarsRoversTests methodsFor: 'tests' stamp: 'm u 10/9/2023 10:42:13'!
test10RoversCanRotateAndMoveWhenFacingEast

	|rovers|
	
	rovers := Rovers atPosition: 0@0 withDirection: East new.
	
	rovers processInstructions: 'rffb'.
	
	self assert: (rovers isAt: 0@-1 withDirection: South new)! !

!MarsRoversTests methodsFor: 'tests' stamp: 'm u 10/9/2023 10:43:19'!
test11RoversCanRotateAndMoveWhenFacingSouth

	|rovers|
	
	rovers := Rovers atPosition: 0@0 withDirection: South new.
	
	rovers processInstructions: 'rffb'.
	
	self assert: (rovers isAt: -1@0 withDirection: West new)! !

!MarsRoversTests methodsFor: 'tests' stamp: 'm u 10/9/2023 16:07:39'!
test12RoversStopsAfterInvalidCommand

	|rovers|
	
	rovers := Rovers atPosition: 0@0 withDirection: South new.
	rovers processInstructions: 'fffbrrxr'.
	"self 
		should: [rovers processInstructions: 'fffbrrxr'] 
		raise: Error
		withExceptionDo: [:error | self assert: error messageText equals: Rovers invalidInstructionMessage]."
	
	self assert: (rovers isAt: 0@-2 withDirection: North new)! !


!classDefinition: #CardinalDirection category: 'MarsRovers'!
Object subclass: #CardinalDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRovers'!

!CardinalDirection methodsFor: 'movement' stamp: 'm u 10/9/2023 10:47:22'!
backwardPositionForCurrentPosition: aPosition
	self subclassResponsibility ! !

!CardinalDirection methodsFor: 'movement' stamp: 'h 10/7/2023 19:32:34'!
cardinalInTheLeft

	self subclassResponsibility! !

!CardinalDirection methodsFor: 'movement' stamp: 'h 10/7/2023 19:32:42'!
cardinalInTheRight

	self subclassResponsibility! !

!CardinalDirection methodsFor: 'movement' stamp: 'm u 10/9/2023 10:47:27'!
forwardPositionForCurrentPosition: aPosition
	self subclassResponsibility ! !


!classDefinition: #East category: 'MarsRovers'!
CardinalDirection subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRovers'!

!East methodsFor: 'movement' stamp: 'm u 10/9/2023 10:50:25'!
backwardPositionForCurrentPosition: aPosition
	^(aPosition x - 1) @ aPosition y! !

!East methodsFor: 'movement' stamp: 'h 10/7/2023 19:18:48'!
cardinalInTheLeft

	^North new! !

!East methodsFor: 'movement' stamp: 'h 10/7/2023 19:30:10'!
cardinalInTheRight

	^South new! !

!East methodsFor: 'movement' stamp: 'm u 10/9/2023 10:50:17'!
forwardPositionForCurrentPosition: aPosition
	^(aPosition x + 1) @ aPosition y! !


!classDefinition: #North category: 'MarsRovers'!
CardinalDirection subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRovers'!

!North methodsFor: 'movement' stamp: 'm u 10/9/2023 10:48:12'!
backwardPositionForCurrentPosition: aPosition
	^aPosition x @ (aPosition y - 1)! !

!North methodsFor: 'movement' stamp: 'h 10/7/2023 19:18:42'!
cardinalInTheLeft

	^West new! !

!North methodsFor: 'movement' stamp: 'h 10/7/2023 19:28:29'!
cardinalInTheRight

	^East new! !

!North methodsFor: 'movement' stamp: 'm u 10/9/2023 10:48:02'!
forwardPositionForCurrentPosition: aPosition
	^aPosition x @ (aPosition y + 1)! !


!classDefinition: #South category: 'MarsRovers'!
CardinalDirection subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRovers'!

!South methodsFor: 'movement' stamp: 'm u 10/9/2023 10:50:57'!
backwardPositionForCurrentPosition: aPosition
	^aPosition x @ (aPosition y +1)! !

!South methodsFor: 'movement' stamp: 'h 10/7/2023 19:25:01'!
cardinalInTheLeft

	^East new! !

!South methodsFor: 'movement' stamp: 'h 10/7/2023 19:29:45'!
cardinalInTheRight

	^West new! !

!South methodsFor: 'movement' stamp: 'm u 10/9/2023 10:50:49'!
forwardPositionForCurrentPosition: aPosition
	^aPosition x @ (aPosition y -1)! !


!classDefinition: #West category: 'MarsRovers'!
CardinalDirection subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRovers'!

!West methodsFor: 'movement' stamp: 'm u 10/9/2023 10:51:32'!
backwardPositionForCurrentPosition: aPosition
	^(aPosition x + 1) @ aPosition y! !

!West methodsFor: 'movement' stamp: 'h 10/7/2023 19:25:11'!
cardinalInTheLeft

	^South new! !

!West methodsFor: 'movement' stamp: 'h 10/7/2023 19:30:02'!
cardinalInTheRight

	^North new! !

!West methodsFor: 'movement' stamp: 'm u 10/9/2023 10:51:20'!
forwardPositionForCurrentPosition: aPosition
	^(aPosition x - 1) @ aPosition y! !


!classDefinition: #Rovers category: 'MarsRovers'!
Object subclass: #Rovers
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRovers'!

!Rovers methodsFor: 'process' stamp: 'm u 10/9/2023 11:05:34'!
assertInstructionIsValid: anInstruction
	^ (self class validInstructions includes: anInstruction) ifFalse: [self error: self class invalidInstructionMessage]! !

!Rovers methodsFor: 'process' stamp: 'm u 10/9/2023 16:05:08'!
isMoveBackwardsInstruction: anInstruction

	^ anInstruction = $b! !

!Rovers methodsFor: 'process' stamp: 'm u 10/9/2023 16:04:52'!
isMoveForwardInstruction: instruction

	^ instruction = $f! !

!Rovers methodsFor: 'process' stamp: 'm u 10/9/2023 16:09:44'!
isNotValidInstruction: instruction

	^ self class validInstructions includes: instruction! !

!Rovers methodsFor: 'process' stamp: 'm u 10/9/2023 16:05:23'!
isRotateLeftInstruction: anInstruction

	^ anInstruction = $l! !

!Rovers methodsFor: 'process' stamp: 'm u 10/9/2023 16:05:38'!
isRotateRightInstruction: instruction

	^ instruction = $r! !

!Rovers methodsFor: 'process' stamp: 'm u 10/9/2023 10:53:02'!
moveBackwards

	^ position := direction backwardPositionForCurrentPosition: position! !

!Rovers methodsFor: 'process' stamp: 'm u 10/9/2023 10:52:55'!
moveForward

	^ position := direction forwardPositionForCurrentPosition: position! !

!Rovers methodsFor: 'process' stamp: 'm u 10/9/2023 16:09:44'!
processInstructions: instructions
	instructions do: [:instruction |
		(self isNotValidInstruction: instruction) 
			ifFalse: [^self].
		
		(self isMoveForwardInstruction: instruction) ifTrue: [self moveForward].
		(self isMoveBackwardsInstruction: instruction) ifTrue: [self moveBackwards].
		(self isRotateLeftInstruction: instruction) ifTrue: [self rotateLeft].
		(self isRotateRightInstruction: instruction) ifTrue: [self rotateRight].
	].
	
	
	! !

!Rovers methodsFor: 'process' stamp: 'm u 10/9/2023 10:53:08'!
rotateLeft

	^ direction := direction cardinalInTheLeft! !

!Rovers methodsFor: 'process' stamp: 'm u 10/9/2023 10:53:16'!
rotateRight

	^ direction := direction cardinalInTheRight! !


!Rovers methodsFor: 'test' stamp: 'h 10/7/2023 19:23:39'!
isAt: posiblePosition withDirection: posibleDirection
	
	^position = posiblePosition and: [posibleDirection class = direction class ]! !


!Rovers methodsFor: 'initialize' stamp: 'h 10/7/2023 18:43:28'!
initializeAtPosition: startingPosition withDirection: startingDirection

	position := startingPosition .
	direction := startingDirection .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Rovers class' category: 'MarsRovers'!
Rovers class
	instanceVariableNames: ''!

!Rovers class methodsFor: 'instance creation' stamp: 'h 10/7/2023 18:45:22'!
atPosition: startingPosition withDirection: startingDirection
	
	^self new initializeAtPosition: startingPosition withDirection: startingDirection! !

!Rovers class methodsFor: 'instance creation' stamp: 'm u 10/9/2023 11:04:50'!
invalidInstructionMessage
	^'Invalid instruction'! !

!Rovers class methodsFor: 'instance creation' stamp: 'm u 10/9/2023 11:04:08'!
validInstructions
	^'fbrl'! !
