!classDefinition: #MineFieldGameTests category: 'ISW1-2023-2C-2doParcial'!
TestCase subclass: #MineFieldGameTests
	instanceVariableNames: 'randomNumbers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2doParcial'!

!MineFieldGameTests methodsFor: 'tests' stamp: 'mm uu 11/30/2023 18:13:01'!
test01playerStartsAtStartingPositionWithInitialLifes
	|game|
	game := MineFieldGame
		startAt: 3@0
		withBounds: 5@5
		withLifes: 5.
		
	self assert: (game playerIsAt: 3@0).
	self assert: (game numberOfLifesIs: 5).! !

!MineFieldGameTests methodsFor: 'tests' stamp: 'mm uu 11/30/2023 18:15:32'!
test02onInitialPositionNotFirstRowThrowsError

	self 
		should:[ MineFieldGame
			startAt: 2@1
			withBounds: 5@5
			withLifes: 5]
		raise: Error
		withMessageText: MineFieldGame invalidStartingPointErrorDescription.! !

!MineFieldGameTests methodsFor: 'tests' stamp: 'mm uu 11/30/2023 18:15:17'!
test03onStartingPositionOutOfBoundsThrowsError

	self 
		should:[ MineFieldGame
			startAt: 3@-1
			withBounds: 5@5
			withLifes: 5]
		raise: Error
		withMessageText: MineFieldGame startingPointOutOfBoundsErrorDescription .! !

!MineFieldGameTests methodsFor: 'tests' stamp: 'mm uu 11/30/2023 18:15:05'!
test04onStartingPositionOutOfBoundsInXAxisThrowsError

	self 
		should:[ MineFieldGame
			startAt: 6@0
			withBounds: 5@5
			withLifes: 5]
		raise: Error
		withMessageText: MineFieldGame startingPointOutOfBoundsErrorDescription.! !

!MineFieldGameTests methodsFor: 'tests' stamp: 'mm uu 11/30/2023 18:33:57'!
test05onMineOnInitialPositionThrowsError

	self 
		should:[ MineFieldGame
			startAt: 2@0
			withBounds: 5@5 
			withLifes: 5
			mines: (OrderedCollection with: 2@0 with: 3@3) lightArmors: OrderedCollection new heavyArmors: OrderedCollection new tunnels: OrderedCollection new randomPointGenerator: self
		]
		raise: Error 
		withMessageText: MineFieldGame startingPointNotEmptyErrorDescription.! !

!MineFieldGameTests methodsFor: 'tests' stamp: 'mm uu 11/30/2023 18:33:57'!
test06onLightArmorOnInitialPositionThrowsError

	self 
		should:[ MineFieldGame
			startAt: 2@0
			withBounds: 5@5 
			withLifes: 5
			mines: (OrderedCollection new) 
			lightArmors: (OrderedCollection with: 2@0) heavyArmors: OrderedCollection new tunnels: OrderedCollection new randomPointGenerator: self
		]
		raise: Error 
		withMessageText: MineFieldGame startingPointNotEmptyErrorDescription.! !

!MineFieldGameTests methodsFor: 'tests' stamp: 'mm uu 11/30/2023 20:55:33'!
test07onHeavyArmorOnInitialPositionThrowsError

	self 
		should:[ MineFieldGame
			startAt: 2@0
			withBounds: 5@5 
			withLifes: 5
			mines: OrderedCollection new 
			lightArmors: OrderedCollection new 
			heavyArmors: (OrderedCollection with: 2@0) tunnels: OrderedCollection new randomPointGenerator: self
		]
		raise: Error 
		withMessageText: MineFieldGame startingPointNotEmptyErrorDescription.! !

!MineFieldGameTests methodsFor: 'tests' stamp: 'mm uu 11/30/2023 20:55:45'!
test08onTunnelOnInitialPositionThrowsError

	self 
		should:[ MineFieldGame
			startAt: 2@0
			withBounds: 5@5 
			withLifes: 5
			mines: OrderedCollection new 
			lightArmors: OrderedCollection new 
			heavyArmors: OrderedCollection new 
			tunnels: (OrderedCollection with: (Tunnel from: 2@0 to: 3@3)) randomPointGenerator: self
		]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineFieldGame startingPointNotEmptyErrorDescription.! !

!MineFieldGameTests methodsFor: 'tests' stamp: 'mm uu 11/30/2023 21:24:06'!
test08_01_onMultipleMinesOnSamePositionThrowsError

	self 
		should:[ MineFieldGame
			startAt: 2@0
			withBounds: 5@5 
			withLifes: 5
			mines: (OrderedCollection with: (HeavyMine at: 2@2) with: (HeavyMine at: 2@2))
			lightArmors: OrderedCollection new 
			heavyArmors: OrderedCollection new 
			tunnels: OrderedCollection new 
			randomPointGenerator: self
		]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineFieldGame multipleItemsOnSamePositionErrorDescription.! !

!MineFieldGameTests methodsFor: 'tests' stamp: 'mm uu 11/30/2023 21:31:45'!
test08_02_onMultipleLightArmorsOnSamePositionThrowsError

	self 
		should:[ MineFieldGame
			startAt: 2@0
			withBounds: 5@5 
			withLifes: 5
			mines: (OrderedCollection new)
			lightArmors: (OrderedCollection with: 2@2 with: 2@2)
			heavyArmors: OrderedCollection new 
			tunnels: OrderedCollection new 
			randomPointGenerator: self
		]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineFieldGame multipleItemsOnSamePositionErrorDescription.! !

!MineFieldGameTests methodsFor: 'tests' stamp: 'mm uu 11/30/2023 21:38:53'!
test08_03_onMultipleHeavyArmorsOnSamePositionThrowsError

	self 
		should:[ MineFieldGame
			startAt: 2@0
			withBounds: 5@5 
			withLifes: 5
			mines: (OrderedCollection new)
			lightArmors: OrderedCollection new
			heavyArmors: (OrderedCollection with: 2@2 with: 2@2)
			tunnels: OrderedCollection new 
			randomPointGenerator: self
		]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineFieldGame multipleItemsOnSamePositionErrorDescription.! !

!MineFieldGameTests methodsFor: 'tests' stamp: 'mm uu 11/30/2023 21:40:01'!
test08_04_onMultipleItemsOnSamePositionThrowsError

	self 
		should:[ MineFieldGame
			startAt: 2@0
			withBounds: 5@5 
			withLifes: 5
			mines: (OrderedCollection new)
			lightArmors: (OrderedCollection with: 2@2 )
			heavyArmors: (OrderedCollection with: 2@2 )
			tunnels: OrderedCollection new 
			randomPointGenerator: self
		]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineFieldGame multipleItemsOnSamePositionErrorDescription.! !

!MineFieldGameTests methodsFor: 'tests' stamp: 'mm uu 11/30/2023 21:42:52'!
test08_05_onMultipleItemsOnSamePositionThrowsError

	self 
		should:[ MineFieldGame
			startAt: 2@0
			withBounds: 5@5 
			withLifes: 5
			mines: (OrderedCollection with: (LightMine at: 2@2 ))
			lightArmors: (OrderedCollection with: 2@2 )
			heavyArmors: (OrderedCollection new)
			tunnels: OrderedCollection new 
			randomPointGenerator: self
		]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineFieldGame multipleItemsOnSamePositionErrorDescription.! !

!MineFieldGameTests methodsFor: 'tests' stamp: 'mm uu 11/30/2023 21:47:19'!
test08_06_onMultipleItemsOnSamePositionThrowsError

	self 
		should:[ MineFieldGame
			startAt: 2@0
			withBounds: 5@5 
			withLifes: 5
			mines: (OrderedCollection with: (LightMine at: 2@2 ))
			lightArmors: OrderedCollection new
			heavyArmors: (OrderedCollection with: 2@2)
			tunnels: OrderedCollection new 
			randomPointGenerator: self
		]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineFieldGame multipleItemsOnSamePositionErrorDescription.! !

!MineFieldGameTests methodsFor: 'tests' stamp: 'mm uu 11/30/2023 18:33:57'!
test09playerCanMoveLeft
	|game|
	game := MineFieldGame
		startAt: 2@0
		withBounds: 5@5 
		withLifes: 5
		mines: OrderedCollection new 
		lightArmors: OrderedCollection new 
		heavyArmors: OrderedCollection new 
		tunnels: OrderedCollection new randomPointGenerator: self.
	
	game moveLeft.
	
	self assert: (game playerIsAt: 1@0).
	self assert: (game numberOfLifesIs: 5)
		! !

!MineFieldGameTests methodsFor: 'tests' stamp: 'mm uu 11/30/2023 18:33:57'!
test10onPlayerMovesLeftWhenOnBorderStaysAtPosition
	|game|
	game := MineFieldGame
		startAt: 0@0
		withBounds: 5@5 
		withLifes: 5
		mines: OrderedCollection new 
		lightArmors: OrderedCollection new 
		heavyArmors: OrderedCollection new 
		tunnels: OrderedCollection new randomPointGenerator: self.
	
	game moveLeft.
	
	self assert: (game playerIsAt: 0@0).
	self assert: (game numberOfLifesIs: 5)! !

!MineFieldGameTests methodsFor: 'tests' stamp: 'mm uu 11/30/2023 18:33:57'!
test11playerCanMoveRight
	|game|
	game := MineFieldGame
		startAt: 2@0
		withBounds: 5@5 
		withLifes: 5
		mines: OrderedCollection new 
		lightArmors: OrderedCollection new 
		heavyArmors: OrderedCollection new 
		tunnels: OrderedCollection new randomPointGenerator: self.
	
	game moveRight.
	
	self assert: (game playerIsAt: 3@0).
	self assert: (game numberOfLifesIs: 5)! !

!MineFieldGameTests methodsFor: 'tests' stamp: 'mm uu 11/30/2023 18:33:57'!
test12onPlayerMovesRightWhenOnBorderStaysAtPosition
	|game|
	game := MineFieldGame
		startAt: 5@0
		withBounds: 5@5 
		withLifes: 5
		mines: OrderedCollection new 
		lightArmors: OrderedCollection new 
		heavyArmors: OrderedCollection new 
		tunnels: OrderedCollection new randomPointGenerator: self.
	
	game moveRight.
	
	self assert: (game playerIsAt: 5@0).
	self assert: (game numberOfLifesIs: 5)! !

!MineFieldGameTests methodsFor: 'tests' stamp: 'mm uu 11/30/2023 18:33:57'!
test13playerMovesUp
	|game|
	game := MineFieldGame
		startAt: 5@0
		withBounds: 5@5 
		withLifes: 5
		mines: OrderedCollection new 
		lightArmors: OrderedCollection new 
		heavyArmors: OrderedCollection new 
		tunnels: OrderedCollection new randomPointGenerator: self.
	
	game moveUp.
	
	self assert: (game playerIsAt: 5@1).
	self assert: (game numberOfLifesIs: 5)! !

!MineFieldGameTests methodsFor: 'tests' stamp: 'mm uu 11/30/2023 21:15:08'!
test15playerMovesDown
	|game|
	game := MineFieldGame
		startAt: 2@0
		withBounds: 5@5 
		withLifes: 5
		mines: OrderedCollection new 
		lightArmors: OrderedCollection new 
		heavyArmors: OrderedCollection new 
		tunnels: OrderedCollection new randomPointGenerator: self.
	
	game moveUp; moveUp; moveDown.
	
	self assert: (game playerIsAt: 2@1).
	self assert: (game numberOfLifesIs: 5)! !

!MineFieldGameTests methodsFor: 'tests' stamp: 'mm uu 11/30/2023 18:33:57'!
test16onPlayerMovesDownWhenOnBorderStaysAtPosition
	|game|
	game := MineFieldGame
		startAt: 2@0
		withBounds: 2@2 
		withLifes: 5
		mines: OrderedCollection new 
		lightArmors: OrderedCollection new 
		heavyArmors: OrderedCollection new 
		tunnels: OrderedCollection new randomPointGenerator: self.
	
	game moveDown.
	
	self assert: (game playerIsAt: 2@0).
	self assert: (game numberOfLifesIs: 5)! !

!MineFieldGameTests methodsFor: 'tests' stamp: 'mm uu 11/30/2023 18:40:46'!
test17onPlayerStepsOnMineLosesLife
	|game|
	game := MineFieldGame
		startAt: 2@0
		withBounds: 5@5
		withLifes: 5
		mines: (OrderedCollection with: (LightMine at: 2@1))
		lightArmors: OrderedCollection new 
		heavyArmors: OrderedCollection new 
		tunnels: OrderedCollection new randomPointGenerator: self.
	
	game moveUp; moveUp.
	
	self assert: (game playerIsAt: 2@2).
	self assert: (game numberOfLifesIs: 4)! !

!MineFieldGameTests methodsFor: 'tests' stamp: 'mm uu 11/30/2023 18:44:01'!
test18onPlayerStepsOnMineMineDissapearsOnYAxis
	|game|
	game := MineFieldGame
		startAt: 2@0
		withBounds: 5@5
		withLifes: 5
		mines: (OrderedCollection with: (LightMine at: 2@1))
		lightArmors: OrderedCollection new 
		heavyArmors: OrderedCollection new 
		tunnels: OrderedCollection new randomPointGenerator: self.
	
	game moveUp; moveUp; moveDown.
	
	self assert: (game playerIsAt: 2@1).
	self assert: (game numberOfLifesIs: 4)! !

!MineFieldGameTests methodsFor: 'tests' stamp: 'mm uu 11/30/2023 18:44:20'!
test19onPlayerStepsOnMineMineDissapearsOnXAxis
	|game|
	game := MineFieldGame
		startAt: 2@0
		withBounds: 5@5
		withLifes: 5
		mines: (OrderedCollection with: (LightMine at: 3@0) with: (LightMine at: 1@0))
		lightArmors: OrderedCollection new 
		heavyArmors: OrderedCollection new 
		tunnels: OrderedCollection new randomPointGenerator: self.
	
	game moveRight; moveLeft; moveLeft.
	
	self assert: (game playerIsAt: 1@0).
	self assert: (game numberOfLifesIs: 3)! !

!MineFieldGameTests methodsFor: 'tests' stamp: 'mm uu 11/30/2023 19:01:19'!
test20onPlayerStepsOnHeavyMineLosesLifeAndFliesAway
	|game|
	self returnRandomNumbers: {6 . 6}.
	game := MineFieldGame
		startAt: 2@0
		withBounds: 5@5
		withLifes: 5
		mines: (OrderedCollection with: (HeavyMine at: 2@1))
		lightArmors: OrderedCollection new 
		heavyArmors: OrderedCollection new 
		tunnels: OrderedCollection new 
		randomPointGenerator: self.
	
	game moveUp.
	
	self assert: (game playerIsAt: 4@3).
	self assert: (game numberOfLifesIs: 3)! !

!MineFieldGameTests methodsFor: 'tests' stamp: 'mm uu 11/30/2023 19:02:42'!
test21onPlayerStepsOnHeavyMineAndFliesToFarAwayLosesLifeAndDoesNotFliesAway
	|game|
	self returnRandomNumbers: {1 . 1}.
	game := MineFieldGame
		startAt: 2@0
		withBounds: 5@5
		withLifes: 5
		mines: (OrderedCollection with: (HeavyMine at: 2@1))
		lightArmors: OrderedCollection new 
		heavyArmors: OrderedCollection new 
		tunnels: OrderedCollection new 
		randomPointGenerator: self.
	
	game moveUp.
	
	self assert: (game playerIsAt: 2@1).
	self assert: (game numberOfLifesIs: 3)! !

!MineFieldGameTests methodsFor: 'tests' stamp: 'mm uu 11/30/2023 19:07:47'!
test22onPlayerStepsOnHeavyMineMineDissapears
	|game|
	self returnRandomNumbers: {1 . 1}.
	game := MineFieldGame
		startAt: 2@0
		withBounds: 5@5
		withLifes: 5
		mines: (OrderedCollection with: (HeavyMine at: 2@1))
		lightArmors: OrderedCollection new 
		heavyArmors: OrderedCollection new 
		tunnels: OrderedCollection new 
		randomPointGenerator: self.
	
	game moveUp; moveDown; moveUp.
	
	self assert: (game playerIsAt: 2@1).
	self assert: (game numberOfLifesIs: 3).! !

!MineFieldGameTests methodsFor: 'tests' stamp: 'mm uu 11/30/2023 19:11:26'!
test23onPlayerStepsOnHeavyAndLandsOnAnotherExplodes
	|game|
	self returnRandomNumbers: {6 . 6 . 3 . 6}.
	game := MineFieldGame
		startAt: 2@0
		withBounds: 5@5
		withLifes: 5
		mines: (OrderedCollection with: (HeavyMine at: 2@1) with: (HeavyMine at: 4@3))
		lightArmors: OrderedCollection new 
		heavyArmors: OrderedCollection new 
		tunnels: OrderedCollection new 
		randomPointGenerator: self.
	
	game moveUp.
	
	self assert: (game playerIsAt: 3@5).
	self assert: (game numberOfLifesIs: 1).! !

!MineFieldGameTests methodsFor: 'tests' stamp: 'mm uu 11/30/2023 20:08:15'!
test24onPlayerStepsOnLightMineWithLightArmorDoesNotLoseLife
	|game|
	
	game := MineFieldGame
		startAt: 2@0
		withBounds: 5@5
		withLifes: 5
		mines: (OrderedCollection with: (LightMine at: 2@2))
		lightArmors: (OrderedCollection with: 2@1)
		heavyArmors: OrderedCollection new 
		tunnels: OrderedCollection new 
		randomPointGenerator: self.
	
	game moveUp; moveUp.
	
	self assert: (game playerIsAt: 2@2).
	self assert: (game numberOfLifesIs: 5).! !

!MineFieldGameTests methodsFor: 'tests' stamp: 'mm uu 11/30/2023 20:08:46'!
test25onPlayerStepsOnHeavyMineWithLightArmorDoesNotLoseLifeButFliesAway
	|game|
	self returnRandomNumbers: { 7 . 7 }.
	game := MineFieldGame
		startAt: 2@0
		withBounds: 5@5
		withLifes: 5
		mines: (OrderedCollection with: (HeavyMine at: 2@2))
		lightArmors: (OrderedCollection with: 2@1)
		heavyArmors: OrderedCollection new 
		tunnels: OrderedCollection new 
		randomPointGenerator: self.
	
	game moveUp; moveUp.
	
	self assert: (game playerIsAt: 2@2).
	self assert: (game numberOfLifesIs: 5).! !

!MineFieldGameTests methodsFor: 'tests' stamp: 'mm uu 11/30/2023 20:08:51'!
test26onPlayerStepsOnMineArmorDissapears
	|game|
	self returnRandomNumbers: { 7 . 7 }.
	game := MineFieldGame
		startAt: 2@0
		withBounds: 5@5
		withLifes: 5
		mines: (OrderedCollection with: (LightMine at: 2@2) with: (LightMine at: 2@3))
		lightArmors: (OrderedCollection with: 2@1)
		heavyArmors: OrderedCollection new 
		tunnels: OrderedCollection new 
		randomPointGenerator: self.
	
	game moveUp; moveUp; moveUp.
	
	self assert: (game playerIsAt: 2@3).
	self assert: (game numberOfLifesIs: 4).! !

!MineFieldGameTests methodsFor: 'tests' stamp: 'mm uu 11/30/2023 20:08:58'!
test27onPlayerStepsOnMineTwiceWithHeavyArmorDoesNotLoseLife
	|game|
	
	game := MineFieldGame
		startAt: 2@0
		withBounds: 5@5
		withLifes: 5
		mines: (OrderedCollection with: (LightMine at: 2@2) with: (LightMine at: 2@3))
		lightArmors: OrderedCollection new
		heavyArmors: (OrderedCollection with: 2@1)
		tunnels: OrderedCollection new 
		randomPointGenerator: self.
	
	game moveUp; moveUp; moveUp.
	
	self assert: (game playerIsAt: 2@3).
	self assert: (game numberOfLifesIs: 5).! !

!MineFieldGameTests methodsFor: 'tests' stamp: 'mm uu 11/30/2023 20:18:22'!
test28onPlayerStepsOnLightMineThreeTimesWithHeavyArmorLosesLife
	|game|
	
	game := MineFieldGame
		startAt: 2@0
		withBounds: 5@5
		withLifes: 5
		mines: (OrderedCollection 
			with: (LightMine at: 2@2) 
			with: (LightMine at: 2@3)
			with: (LightMine at: 3@3))
		lightArmors: OrderedCollection new
		heavyArmors: (OrderedCollection with: 2@1)
		tunnels: OrderedCollection new 
		randomPointGenerator: self.
	
	game moveUp; moveUp; moveUp; moveRight.
	
	self assert: (game playerIsAt: 3@3).
	self assert: (game numberOfLifesIs: 4).! !

!MineFieldGameTests methodsFor: 'tests' stamp: 'mm uu 11/30/2023 20:19:26'!
test29onPlayerStepsOnHeavyMineLosesArmor
	|game|
	
	game := MineFieldGame
		startAt: 2@0
		withBounds: 5@5
		withLifes: 5
		mines: (OrderedCollection 
			with: (HeavyMine at: 2@2) 
			with: (LightMine at: 2@3))
		lightArmors: OrderedCollection new
		heavyArmors: (OrderedCollection with: 2@1)
		tunnels: OrderedCollection new 
		randomPointGenerator: self.
	
	game moveUp; moveUp; moveUp; moveRight.
	
	self assert: (game playerIsAt: 3@3).
	self assert: (game numberOfLifesIs: 4).! !

!MineFieldGameTests methodsFor: 'tests' stamp: 'mm uu 11/30/2023 20:22:04'!
test30onPlayerStepsOnLightMineAndHeavyMineDoesNotLoseLife
	|game|
	
	game := MineFieldGame
		startAt: 2@0
		withBounds: 5@5
		withLifes: 5
		mines: (OrderedCollection 
			with: (LightMine at: 2@2) 
			with: (HeavyMine at: 2@3))
		lightArmors: OrderedCollection new
		heavyArmors: (OrderedCollection with: 2@1)
		tunnels: OrderedCollection new 
		randomPointGenerator: self.
	
	game moveUp; moveUp; moveUp; moveRight.
	
	self assert: (game playerIsAt: 3@3).
	self assert: (game numberOfLifesIs: 5).! !

!MineFieldGameTests methodsFor: 'tests' stamp: 'mm uu 11/30/2023 20:24:35'!
test31playerCantPickupLightArmorTwice
	|game|
	
	game := MineFieldGame
		startAt: 2@0
		withBounds: 5@5
		withLifes: 5
		mines: (OrderedCollection 
			with: (LightMine at: 2@2) 
			with: (LightMine at: 2@3))
		lightArmors: (OrderedCollection with: 2@1)
		heavyArmors: OrderedCollection new
		tunnels: OrderedCollection new 
		randomPointGenerator: self.
	
	game moveUp; moveUp; moveDown; moveUp; moveUp.
	
	self assert: (game playerIsAt: 2@3).
	self assert: (game numberOfLifesIs: 4).! !

!MineFieldGameTests methodsFor: 'tests' stamp: 'mm uu 11/30/2023 20:26:13'!
test32playerCantPickupHeavyArmorTwice
	|game|
	
	game := MineFieldGame
		startAt: 2@0
		withBounds: 5@5
		withLifes: 5
		mines: (OrderedCollection 
			with: (HeavyMine at: 2@2) 
			with: (LightMine at: 2@3))
		lightArmors: OrderedCollection new
		heavyArmors: (OrderedCollection with: 2@1)
		tunnels: OrderedCollection new 
		randomPointGenerator: self.
	
	game moveUp; moveUp; moveDown; moveUp; moveUp.
	
	self assert: (game playerIsAt: 2@3).
	self assert: (game numberOfLifesIs: 4).! !

!MineFieldGameTests methodsFor: 'tests' stamp: 'mm uu 11/30/2023 20:34:53'!
test33onNewArmorArmorGetsReplaced
	|game|
	self returnRandomNumbers: {7 . 7}.
	game := MineFieldGame
		startAt: 2@0
		withBounds: 5@5
		withLifes: 5
		mines: (OrderedCollection 
			with: (HeavyMine at: 1@2))
		lightArmors: (OrderedCollection with: 2@2)
		heavyArmors: (OrderedCollection with: 2@1)
		tunnels: OrderedCollection new 
		randomPointGenerator: self.
	
	game moveUp; moveUp; moveLeft.
	
	self assert: (game playerIsAt: 2@2).
	self assert: (game numberOfLifesIs: 5).! !

!MineFieldGameTests methodsFor: 'tests' stamp: 'mm uu 11/30/2023 20:39:16'!
test34onTunnelPlayerGetsTransported
	|game|
	self returnRandomNumbers: {7 . 7}.
	game := MineFieldGame
		startAt: 2@0
		withBounds: 5@5
		withLifes: 5
		mines: (OrderedCollection new)
		lightArmors: (OrderedCollection new)
		heavyArmors: (OrderedCollection new)
		tunnels: (OrderedCollection with: (Tunnel from: 2@2 to: 4@4))
		randomPointGenerator: self.
	
	game moveUp; moveUp; moveRight.
	
	self assert: (game playerIsAt: 5@4).
	self assert: (game numberOfLifesIs: 5).! !

!MineFieldGameTests methodsFor: 'tests' stamp: 'mm uu 11/30/2023 20:45:07'!
test35onTunnelPlayerGetsTransportedFromBothWays
	|game|
	
	game := MineFieldGame
		startAt: 2@0
		withBounds: 5@5
		withLifes: 5
		mines: (OrderedCollection new)
		lightArmors: (OrderedCollection new)
		heavyArmors: (OrderedCollection new)
		tunnels: (OrderedCollection with: (Tunnel from: 2@2 to: 4@4))
		randomPointGenerator: self.
	
	game moveUp; moveUp; moveRight; moveLeft.
	
	self assert: (game playerIsAt: 2@2).
	self assert: (game numberOfLifesIs: 5).! !

!MineFieldGameTests methodsFor: 'tests' stamp: 'mm uu 11/30/2023 20:49:44'!
test36onHeavyMineWhenPlayerLandsOnTunnelGetsTransported
	|game|
	self returnRandomNumbers: {6 . 6}.
	game := MineFieldGame
		startAt: 2@0
		withBounds: 5@5
		withLifes: 5
		mines: (OrderedCollection with: (HeavyMine at: 2@1))
		lightArmors: (OrderedCollection new)
		heavyArmors: (OrderedCollection new)
		tunnels: (OrderedCollection with: (Tunnel from: 4@3 to: 0@5))
		randomPointGenerator: self.
	
	game moveUp.
	
	self assert: (game playerIsAt: 0@5).
	self assert: (game numberOfLifesIs: 3).! !

!MineFieldGameTests methodsFor: 'tests' stamp: 'mm uu 11/30/2023 21:08:26'!
test37onPlayerLosesAllLifesWhenTriesToMoveThrowsError
	|game|
	self returnRandomNumbers: {4}.
	game := MineFieldGame
		startAt: 2@0
		withBounds: 5@5
		withLifes: 5
		mines: (OrderedCollection 
			with: (HeavyMine at: 2@1)
			with: (HeavyMine at: 3@1)
			with: (HeavyMine at: 3@0))
		lightArmors: (OrderedCollection new)
		heavyArmors: (OrderedCollection new)
		tunnels: (OrderedCollection new)
		randomPointGenerator: self.
	
	game moveUp; moveRight; moveDown.
	
	self 
		should: [game moveRight]
		raise: Error
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: game class cantMoveWhenPlayerIsDeadErrorDescription .
			self assert: (game playerIsDead)
		]! !

!MineFieldGameTests methodsFor: 'tests' stamp: 'mm uu 11/30/2023 21:17:18'!
test38onPlayerWinsThrowsErrorWhenTriesToMove
	|game|
	
	game := MineFieldGame
		startAt: 2@0
		withBounds: 3@3
		withLifes: 5
		mines: (OrderedCollection new)
		lightArmors: (OrderedCollection new)
		heavyArmors: (OrderedCollection new)
		tunnels: (OrderedCollection new)
		randomPointGenerator: self.
	
	game moveUp; moveUp; moveUp.
	
	self 
		should: [game moveRight]
		raise: Error
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: game class cantMoveWhenPlayerHasWonErrorDescription .
			self assert: (game playerWon)
		]! !

!MineFieldGameTests methodsFor: 'tests' stamp: 'mm uu 11/30/2023 21:20:24'!
test39onPlayerLandsOnMineAndFliesAwayWins
	|game|
	self returnRandomNumbers: {7. 7}.
	game := MineFieldGame
		startAt: 2@0
		withBounds: 5@5
		withLifes: 5
		mines: (OrderedCollection with: (HeavyMine at: 2@2))
		lightArmors: (OrderedCollection new)
		heavyArmors: (OrderedCollection new)
		tunnels: (OrderedCollection new)
		randomPointGenerator: self.
	
	game moveUp; moveUp.
	self assert: (game playerWon)! !


!MineFieldGameTests methodsFor: 'random number generator' stamp: 'mm uu 11/30/2023 18:58:41'!
nextInteger: anInteger 
	|randomNumber|
	randomNumber := randomNumbers current.
	randomNumbers next.
	^randomNumber ! !

!MineFieldGameTests methodsFor: 'random number generator' stamp: 'mm uu 11/30/2023 18:57:26'!
returnRandomNumbers: aCollectionOfRandomNumbers
	randomNumbers := CircularReadStream 
		on: aCollectionOfRandomNumbers 
		moving: NullUnit new! !


!classDefinition: #Armor category: 'ISW1-2023-2C-2doParcial'!
Object subclass: #Armor
	instanceVariableNames: 'position'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2doParcial'!


!Armor methodsFor: 'explotions' stamp: 'mm uu 11/30/2023 21:21:06'!
heavyMineExplotionOn: aMineFieldGame

	self subclassResponsibility! !

!Armor methodsFor: 'explotions' stamp: 'mm uu 11/30/2023 21:21:11'!
lightMineExplotionOn: aMineFieldGame

	self subclassResponsibility! !


!classDefinition: #HeavyArmor category: 'ISW1-2023-2C-2doParcial'!
Armor subclass: #HeavyArmor
	instanceVariableNames: 'armorUses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2doParcial'!

!HeavyArmor methodsFor: 'initialization' stamp: 'mm uu 11/30/2023 20:14:32'!
initialize
	armorUses := 0.! !


!HeavyArmor methodsFor: 'explotions' stamp: 'mm uu 11/30/2023 20:19:48'!
heavyMineExplotionOn: aMineFieldGame 
	aMineFieldGame heavyArmorBroke ! !

!HeavyArmor methodsFor: 'explotions' stamp: 'mm uu 11/30/2023 20:14:14'!
lightMineExplotionOn: aMineFieldGame 
	armorUses := armorUses + 1.
	armorUses = 2 ifTrue: [aMineFieldGame heavyArmorBroke].
	! !


!classDefinition: #LightArmor category: 'ISW1-2023-2C-2doParcial'!
Armor subclass: #LightArmor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2doParcial'!


!LightArmor methodsFor: 'explotion' stamp: 'mm uu 11/30/2023 19:59:42'!
heavyMineExplotionOn: aMineFieldGame 
	aMineFieldGame heavyMineExplotionWithLightArmor! !

!LightArmor methodsFor: 'explotion' stamp: 'mm uu 11/30/2023 20:00:19'!
lightMineExplotionOn: aGame
	aGame lightMineExplotionWithLightArmor.! !


!classDefinition: #NoArmor category: 'ISW1-2023-2C-2doParcial'!
Armor subclass: #NoArmor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2doParcial'!

!NoArmor methodsFor: 'explotions' stamp: 'mm uu 11/30/2023 20:04:25'!
heavyMineExplotionOn: aMineFieldGame 
	aMineFieldGame heavyMineExplotionWithNoArmor! !

!NoArmor methodsFor: 'explotions' stamp: 'mm uu 11/30/2023 20:02:19'!
lightMineExplotionOn: aMineFieldGame 
	aMineFieldGame lightMineExplotionWithNoArmor! !


!classDefinition: #Mine category: 'ISW1-2023-2C-2doParcial'!
Object subclass: #Mine
	instanceVariableNames: 'position'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2doParcial'!

!Mine methodsFor: 'initialization' stamp: 'mm uu 11/30/2023 18:41:41'!
initializeAt: aPosition 
	position := aPosition.! !


!Mine methodsFor: 'testing' stamp: 'mm uu 11/30/2023 21:28:49'!
collidesWith: anotherMine 
	^anotherMine position = position! !

!Mine methodsFor: 'testing' stamp: 'mm uu 11/30/2023 21:45:26'!
isIn: aPosition 
	^position = aPosition ! !


!Mine methodsFor: 'explotion' stamp: 'mm uu 11/30/2023 21:21:25'!
explodeOn: aMineFieldGame

	self subclassResponsibility! !


!Mine methodsFor: 'accesing' stamp: 'mm uu 11/30/2023 21:29:44'!
position
	^position! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Mine class' category: 'ISW1-2023-2C-2doParcial'!
Mine class
	instanceVariableNames: ''!

!Mine class methodsFor: 'as yet unclassified' stamp: 'mm uu 11/30/2023 18:41:29'!
at: aPosition
	^self new initializeAt: aPosition! !


!classDefinition: #HeavyMine category: 'ISW1-2023-2C-2doParcial'!
Mine subclass: #HeavyMine
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2doParcial'!



!HeavyMine methodsFor: 'explotion' stamp: 'mm uu 11/30/2023 18:43:40'!
explodeOn: aMineFieldGame 
	aMineFieldGame heavyMineExplotion.! !



!classDefinition: #LightMine category: 'ISW1-2023-2C-2doParcial'!
Mine subclass: #LightMine
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2doParcial'!

!LightMine methodsFor: 'explotion' stamp: 'mm uu 11/30/2023 18:42:23'!
explodeOn: aMineFieldGame 
	aMineFieldGame lightMineExplotion.! !


!classDefinition: #MineFieldGame category: 'ISW1-2023-2C-2doParcial'!
Object subclass: #MineFieldGame
	instanceVariableNames: 'playerPosition lifes bounds mines lightArmors randomPointGenerator armor heavyArmors tunnels won'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2doParcial'!

!MineFieldGame methodsFor: 'initialization' stamp: 'mm uu 11/30/2023 21:13:49'!
initializeStartAt: aPosition withBounds: aBound withLifes: anAmountOfLifes mines: aCollectionOfMines lightArmors: aCollectionOfLightArmors heavyArmors: aCollectionOfHeavyArmors tunnels: aCollectionOfTunnels randomPointGenerator: aRandomPointGenerator  
	playerPosition := aPosition.
	bounds := aBound.
	lifes := anAmountOfLifes.
	mines := aCollectionOfMines .
	lightArmors := aCollectionOfLightArmors .
	heavyArmors := aCollectionOfHeavyArmors .
	tunnels := aCollectionOfTunnels .
	randomPointGenerator := aRandomPointGenerator .
	won := false.
	armor := NoArmor new.! !


!MineFieldGame methodsFor: 'testing' stamp: 'mm uu 11/30/2023 17:26:36'!
numberOfLifesIs: anAmountOfLIfes 
	^lifes = anAmountOfLIfes ! !

!MineFieldGame methodsFor: 'testing' stamp: 'mm uu 11/30/2023 18:02:49'!
playerIsAt: aPoint 
	^playerPosition = aPoint! !

!MineFieldGame methodsFor: 'testing' stamp: 'mm uu 11/30/2023 21:08:26'!
playerIsDead
	^lifes <= 0! !

!MineFieldGame methodsFor: 'testing' stamp: 'mm uu 11/30/2023 21:17:50'!
playerWon
	^playerPosition y = bounds y! !


!MineFieldGame methodsFor: 'move' stamp: 'mm uu 11/30/2023 21:18:25'!
assertPlayerHasNotWon

	^ won ifTrue: [self error: self class cantMoveWhenPlayerHasWonErrorDescription ]! !

!MineFieldGame methodsFor: 'move' stamp: 'mm uu 11/30/2023 21:07:55'!
assertPlayerIsNotDead

	^ lifes <= 0 ifTrue: [self error: self class cantMoveWhenPlayerIsDeadErrorDescription]! !

!MineFieldGame methodsFor: 'move' stamp: 'mm uu 11/30/2023 20:30:53'!
checkHeavyArmors
	self detect: heavyArmors ifFoundCreate: HeavyArmor .! !

!MineFieldGame methodsFor: 'move' stamp: 'mm uu 11/30/2023 20:30:53'!
checkLightArmors
	self detect: lightArmors ifFoundCreate: LightArmor .! !

!MineFieldGame methodsFor: 'move' stamp: 'mm uu 11/30/2023 19:15:00'!
checkMineCollisions

	^ mines do: [:aMine |
		(aMine isIn: playerPosition) ifTrue: [mines remove: aMine. aMine explodeOn: self.]
	]! !

!MineFieldGame methodsFor: 'move' stamp: 'mm uu 11/30/2023 21:13:35'!
checkPlayerHasWon
	playerPosition y = bounds y ifTrue: [won := true]! !

!MineFieldGame methodsFor: 'move' stamp: 'mm uu 11/30/2023 20:53:22'!
checkTunnels

	^ tunnels 
		detect: [:aTunnel |aTunnel hasEntranceIn: playerPosition ]
		ifFound: [:aTunnel | playerPosition := aTunnel exitPositionFrom: playerPosition ]
		ifNone: []! !

!MineFieldGame methodsFor: 'move' stamp: 'mm uu 11/30/2023 20:30:53'!
detect: anArmorsList ifFoundCreate: armorToCreate

	^ anArmorsList 
		detect: [:anArmor | anArmor = playerPosition]
		ifFound: [:anArmor | armor := armorToCreate new. anArmorsList remove: anArmor]
		ifNone: []! !

!MineFieldGame methodsFor: 'move' stamp: 'mm uu 11/30/2023 21:11:56'!
moveDown
	playerPosition := playerPosition - (0@1) max: (playerPosition x @0).
	
	self movePlayer.! !

!MineFieldGame methodsFor: 'move' stamp: 'mm uu 11/30/2023 21:11:56'!
moveLeft
	playerPosition := playerPosition - (1@0) max: (0@ playerPosition y).
	
	self movePlayer.! !

!MineFieldGame methodsFor: 'move' stamp: 'mm uu 11/30/2023 21:18:25'!
movePlayer
	self assertPlayerHasNotWon.
	self assertPlayerIsNotDead.
	
	self checkTunnels.
	self checkMineCollisions.
	self checkLightArmors.
	self checkHeavyArmors.
	
	self checkPlayerHasWon.! !

!MineFieldGame methodsFor: 'move' stamp: 'mm uu 11/30/2023 21:11:56'!
moveRight
	playerPosition := playerPosition + (1@0) min: (bounds x @ (playerPosition y)).
	
	self movePlayer.! !

!MineFieldGame methodsFor: 'move' stamp: 'mm uu 11/30/2023 21:11:56'!
moveUp
	playerPosition := playerPosition + (0@1) min: (playerPosition x @ bounds y).
	
	self movePlayer.
	
	
	! !


!MineFieldGame methodsFor: 'consequences' stamp: 'mm uu 11/30/2023 19:06:14'!
flyAwayPosition
	|flyAwayDeltaX flyAwayDeltaY flyAwayPosition|
	flyAwayDeltaX := (self getFlyAwayDelta ).
	flyAwayDeltaY := (self getFlyAwayDelta ).
	flyAwayPosition := playerPosition + (flyAwayDeltaX @ flyAwayDeltaY ).
	^flyAwayPosition 
	! !

!MineFieldGame methodsFor: 'consequences' stamp: 'mm uu 11/30/2023 19:01:04'!
getFlyAwayDelta

	^ (randomPointGenerator nextInteger: 7) - 4! !

!MineFieldGame methodsFor: 'consequences' stamp: 'mm uu 11/30/2023 20:15:59'!
heavyArmorBroke
	armor := NoArmor new! !

!MineFieldGame methodsFor: 'consequences' stamp: 'mm uu 11/30/2023 20:05:02'!
heavyMineExplotion
	armor heavyMineExplotionOn: self.
	
	
	! !

!MineFieldGame methodsFor: 'consequences' stamp: 'mm uu 11/30/2023 20:01:18'!
heavyMineExplotionWithLightArmor
	|flyAwayPosition|	
	flyAwayPosition := self flyAwayPosition .
	flyAwayPosition := (flyAwayPosition x // 2)@(flyAwayPosition y // 2).
		
	(self newPositionIsInBounds: flyAwayPosition) ifTrue: [
		playerPosition  := flyAwayPosition .
		self checkMineCollisions .
	].! !

!MineFieldGame methodsFor: 'consequences' stamp: 'mm uu 11/30/2023 21:11:56'!
heavyMineExplotionWithNoArmor
	| flyAwayPosition |
	
	flyAwayPosition := self flyAwayPosition .
	
	(self newPositionIsInBounds: flyAwayPosition) ifTrue: [
		playerPosition  := flyAwayPosition .
		self movePlayer .
	].

	lifes := lifes - 2.! !

!MineFieldGame methodsFor: 'consequences' stamp: 'mm uu 11/30/2023 20:00:19'!
lightMineExplotion
	armor lightMineExplotionOn: self.
	! !

!MineFieldGame methodsFor: 'consequences' stamp: 'mm uu 11/30/2023 20:10:04'!
lightMineExplotionWithHeavyArmor
	self shouldBeImplemented.! !

!MineFieldGame methodsFor: 'consequences' stamp: 'mm uu 11/30/2023 19:55:10'!
lightMineExplotionWithLightArmor
	armor := NoArmor new.! !

!MineFieldGame methodsFor: 'consequences' stamp: 'mm uu 11/30/2023 20:03:01'!
lightMineExplotionWithNoArmor
	lifes := lifes - 1! !

!MineFieldGame methodsFor: 'consequences' stamp: 'mm uu 11/30/2023 19:05:46'!
newPositionIsInBounds: newPosition

	^ newPosition between: 0@0 and: bounds! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MineFieldGame class' category: 'ISW1-2023-2C-2doParcial'!
MineFieldGame class
	instanceVariableNames: ''!

!MineFieldGame class methodsFor: 'assertions' stamp: 'mm uu 11/30/2023 17:51:43'!
assertItems: aCollectionOfItems doNotCollideWith: aStartingPosition
	aCollectionOfItems
		detect: [:anItem | anItem = aStartingPosition ]
		ifFound: [:anItem | self error: self startingPointNotEmptyErrorDescription ]
		ifNone: [].! !

!MineFieldGame class methodsFor: 'assertions' stamp: 'mm uu 11/30/2023 17:57:00'!
assertPlayerIsInside: aBound with: aPosition

	aPosition y < 0 ifTrue: [self error: self startingPointOutOfBoundsErrorDescription ].
	aPosition x > aBound x ifTrue: [self error: self startingPointOutOfBoundsErrorDescription ]! !

!MineFieldGame class methodsFor: 'assertions' stamp: 'mm uu 11/30/2023 17:56:08'!
assertPlayerStartsAtFirstRow: aPosition

	^ aPosition y > 0 ifTrue: [self error: self invalidStartingPointErrorDescription]! !


!MineFieldGame class methodsFor: 'instance creation' stamp: 'mm uu 11/30/2023 21:25:45'!
assert: aCollectionOfTunnels doesNotCollideWith: aPosition

	^ aCollectionOfTunnels do: [:aTunnel | aTunnel assertDoesNotCollideWith: aPosition]! !

!MineFieldGame class methodsFor: 'instance creation' stamp: 'mm uu 11/30/2023 21:42:10'!
assertHeavyArmors: aCollectionOfHeavyArmors dontCollideWithLightArmors: aCollectionOfLightArmors

	^ aCollectionOfLightArmors do: [:aLightArmor |
		aCollectionOfHeavyArmors do: [:aHeavyArmor |
			aLightArmor = aHeavyArmor ifTrue: [self error: self multipleItemsOnSamePositionErrorDescription ]]]! !

!MineFieldGame class methodsFor: 'instance creation' stamp: 'mm uu 11/30/2023 21:38:05'!
assertItemsAreNotInSamePosition: aCollectionOfItems

	^ aCollectionOfItems combinations: 2 atATimeDo: [:anItemCombination | 
		anItemCombination first = anItemCombination second ifTrue: [self error: self multipleItemsOnSamePositionErrorDescription ]]! !

!MineFieldGame class methodsFor: 'instance creation' stamp: 'mm uu 11/30/2023 21:30:45'!
assertItemsDontCollideWithEachother: anItemsCollection

	^ anItemsCollection do: [:aMine |
		anItemsCollection do: [:anotherMine |
			(aMine ~= anotherMine and: [aMine collidesWith: anotherMine]) ifTrue: [self error: self multipleItemsOnSamePositionErrorDescription ]]]! !

!MineFieldGame class methodsFor: 'instance creation' stamp: 'mm uu 11/30/2023 21:47:46'!
assertMines: aCollectionOfMines dontCollideWithItems: aCollectionOfItems

	^ aCollectionOfItems do: [:anItem | 
		aCollectionOfMines do: [:aMine |
			(aMine isIn: anItem) ifTrue: [self error: self multipleItemsOnSamePositionErrorDescription ]]]! !

!MineFieldGame class methodsFor: 'instance creation' stamp: 'mm uu 11/30/2023 18:33:57'!
startAt: aPosition withBounds: aBound withLifes: anAmountOfLifes 
	^self startAt: aPosition withBounds: aBound withLifes: anAmountOfLifes mines: #() lightArmors: OrderedCollection new heavyArmors: OrderedCollection new tunnels: OrderedCollection new randomPointGenerator: self! !

!MineFieldGame class methodsFor: 'instance creation' stamp: 'mm uu 11/30/2023 21:46:57'!
startAt: aPosition withBounds: aBound withLifes: anAmountOfLifes mines: aCollectionOfMines lightArmors: aCollectionOfLightArmors heavyArmors: aCollectionOfHeavyArmors tunnels: aCollectionOfTunnels randomPointGenerator: aRandomPointGenerator     
	self assertPlayerStartsAtFirstRow: aPosition.
	self assertPlayerIsInside: aBound with: aPosition.
	self assertItems: aCollectionOfMines doNotCollideWith: aPosition.
	self assertItems: aCollectionOfLightArmors doNotCollideWith: aPosition.
	self assertItems: aCollectionOfHeavyArmors doNotCollideWith: aPosition.
	self assert: aCollectionOfTunnels doesNotCollideWith: aPosition.
	self assertItemsDontCollideWithEachother: aCollectionOfMines.
	self assertItemsAreNotInSamePosition: aCollectionOfLightArmors.
	self assertItemsAreNotInSamePosition: aCollectionOfHeavyArmors.	
	self assertHeavyArmors: aCollectionOfHeavyArmors dontCollideWithLightArmors: aCollectionOfLightArmors.
	self assertMines: aCollectionOfMines dontCollideWithItems: aCollectionOfLightArmors.
	self assertMines: aCollectionOfMines dontCollideWithItems: aCollectionOfHeavyArmors.
	
	^self new 
		initializeStartAt: aPosition 
		withBounds: aBound 
		withLifes: anAmountOfLifes 
		mines: aCollectionOfMines 
		lightArmors: aCollectionOfLightArmors 
		heavyArmors: aCollectionOfHeavyArmors 
		tunnels: aCollectionOfTunnels 
		randomPointGenerator: aRandomPointGenerator ! !


!MineFieldGame class methodsFor: 'errors' stamp: 'mm uu 11/30/2023 21:16:32'!
cantMoveWhenPlayerHasWonErrorDescription
	^'cant move when player has won'! !

!MineFieldGame class methodsFor: 'errors' stamp: 'mm uu 11/30/2023 21:07:54'!
cantMoveWhenPlayerIsDeadErrorDescription

	^ 'cant move when game is over'! !

!MineFieldGame class methodsFor: 'errors' stamp: 'mm uu 11/30/2023 17:31:56'!
invalidStartingPointErrorDescription

	^ 'Invalid starting point'! !

!MineFieldGame class methodsFor: 'errors' stamp: 'mm uu 11/30/2023 21:24:23'!
multipleItemsOnSamePositionErrorDescription
	^'multiple items on same position'! !

!MineFieldGame class methodsFor: 'errors' stamp: 'mm uu 11/30/2023 17:37:59'!
startingPointNotEmptyErrorDescription
	^'starting point is not empty'! !

!MineFieldGame class methodsFor: 'errors' stamp: 'mm uu 11/30/2023 17:33:39'!
startingPointOutOfBoundsErrorDescription
	^'starting point out of bounds'! !


!classDefinition: #Tunnel category: 'ISW1-2023-2C-2doParcial'!
Object subclass: #Tunnel
	instanceVariableNames: 'from to'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2doParcial'!

!Tunnel methodsFor: 'initialization' stamp: 'mm uu 11/30/2023 17:58:51'!
initializeFrom: aFromPosition to: aToPosition 
	from := aFromPosition.
	to := aToPosition.! !


!Tunnel methodsFor: 'testing' stamp: 'mm uu 11/30/2023 17:59:48'!
assertDoesNotCollideWith: aPosition 
	(aPosition = from or: [aPosition = to]) ifTrue: [self error: MineFieldGame startingPointNotEmptyErrorDescription ]! !

!Tunnel methodsFor: 'testing' stamp: 'mm uu 11/30/2023 20:42:01'!
hasEntranceIn: aPosition
	^(aPosition = from or: [aPosition = to])! !


!Tunnel methodsFor: 'entrance' stamp: 'mm uu 11/30/2023 20:44:02'!
exitPositionFrom: aPlayerPosition 
	aPlayerPosition = from ifTrue: [^to].
	^from! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Tunnel class' category: 'ISW1-2023-2C-2doParcial'!
Tunnel class
	instanceVariableNames: ''!

!Tunnel class methodsFor: 'instance creation' stamp: 'mm uu 11/30/2023 17:58:34'!
from: aFromPosition to: aToPosition 
	^self new initializeFrom: aFromPosition to: aToPosition ! !
