!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'aSentenceFinderByPrefix'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'manuel urko 9/17/2023 08:34:04'!
test01SearchOnEmptyStackShouldReturnEmptyCollection
	|stack sentencesWithPrefixMatch|
	
	stack := OOStack new.
	
	sentencesWithPrefixMatch := aSentenceFinderByPrefix findSentencesWithPrefix: 'a' inStack: stack.
	
	self assert: [sentencesWithPrefixMatch size = 0].
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'manuel urko 9/17/2023 08:36:18'!
test02SearchOnStackWithNoMatchingPrefixShouldReturnEmptyCollection
	|stack sentencesWithPrefixMatch|
	
	stack := OOStack new.
	stack push: 'holiwi'.
	
	sentencesWithPrefixMatch := aSentenceFinderByPrefix findSentencesWithPrefix: 'a' inStack: stack.
	
	self assert: [sentencesWithPrefixMatch size = 0].
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'manuel urko 9/17/2023 09:29:48'!
test03SearchOnStackWithMatchingPrefixShouldReturnCollectionWithSentence
	|stack sentencesWithPrefixMatch expectedStackSize expectedTop|
	
	stack := OOStack new.
	stack push: 'aloha'.
	expectedStackSize := stack size.
	expectedTop := stack top.
	
	sentencesWithPrefixMatch := aSentenceFinderByPrefix findSentencesWithPrefix: 'a' inStack: stack.
	
	self assert: [sentencesWithPrefixMatch size = 1].
	self assertThatOrderedCollection: sentencesWithPrefixMatch containsElements: #('aloha').
	self assertThatStack: stack hasExpectedSize: expectedStackSize andExpectedTop: expectedTop.
	
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'manuel urko 9/17/2023 09:29:40'!
test04SearchOnStackWithMultipleMatchingPrefixShouldReturnCollectionWithSentences
	|stack sentencesWithPrefixMatch expectedStackSize expectedTop|
	
	stack := OOStack new.
	stack push: 'aloha'.
	stack push: 'arrivederci'.
	expectedStackSize := stack size.
	expectedTop := stack top.
	
	sentencesWithPrefixMatch := aSentenceFinderByPrefix findSentencesWithPrefix: 'a' inStack: stack.
	
	self assert: [sentencesWithPrefixMatch size = 2].
	self assertThatOrderedCollection: sentencesWithPrefixMatch containsElements: #('aloha' 'arrivederci').
	self assertThatStack: stack hasExpectedSize: expectedStackSize andExpectedTop: expectedTop .
	
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'manuel urko 9/17/2023 09:25:17'!
test05SearchOnStackWithMultipleMatchingPrefixShouldReturnCollectionWithOnlyMatchingSentences
	|stack sentencesWithPrefixMatch expectedStackSize expectedTop|
	
	stack := OOStack new.
	stack push: 'aloha'.
	stack push: 'arrivederci'.
	stack push: 'ciao'.
	expectedStackSize := stack size.
	expectedTop := stack top.
	
	sentencesWithPrefixMatch := aSentenceFinderByPrefix findSentencesWithPrefix: 'a' inStack: stack.
	
	self assert: [sentencesWithPrefixMatch size = 2].
	self assertThatOrderedCollection: sentencesWithPrefixMatch containsElements: #('aloha' 'arrivederci').
	self assertThatStack: stack hasExpectedSize: expectedStackSize andExpectedTop: expectedTop .
	
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'manuel urko 9/17/2023 09:47:43'!
test06SearchOnStackWithMatchingPrefixesShouldAlsoMatchCasing
	|stack sentencesWithPrefixMatch expectedStackSize expectedTop|
	
	stack := OOStack new.
	stack push: 'aloha'.
	stack push: 'Arrivederci'.
	stack push: 'ciao'.
	expectedStackSize := stack size.
	expectedTop := stack top.
	
	sentencesWithPrefixMatch := aSentenceFinderByPrefix findSentencesWithPrefix: 'a' inStack: stack.
	
	self assert: [sentencesWithPrefixMatch size = 1].
	self assertThatOrderedCollection: sentencesWithPrefixMatch containsElements: #('aloha').
	self assertThatStack: stack hasExpectedSize: expectedStackSize andExpectedTop: expectedTop .
	
	
	! !


!SentenceFinderByPrefixTest methodsFor: 'setUp' stamp: 'manuel urko 9/17/2023 08:31:37'!
setUp
	aSentenceFinderByPrefix := SentenceFinderByPrefix new
	! !


!SentenceFinderByPrefixTest methodsFor: 'assertions' stamp: 'manuel urko 9/17/2023 09:07:22'!
assertThatOrderedCollection: anOrderedCollection containsElement: anElement
	self assert: [(anOrderedCollection occurrencesOf: anElement) = 1]! !

!SentenceFinderByPrefixTest methodsFor: 'assertions' stamp: 'manuel urko 9/17/2023 09:24:14'!
assertThatOrderedCollection: anOrderedCollection containsElements: collectionOfElements
	collectionOfElements do: [:anElement | self assert: [(anOrderedCollection occurrencesOf: anElement) = 1]].! !

!SentenceFinderByPrefixTest methodsFor: 'assertions' stamp: 'manuel urko 9/17/2023 08:45:53'!
assertThatStack: aStack hasExpectedSize: expectedStackSize andExpectedTop: expectedTop.
	self assert: [aStack size = expectedStackSize ].
	self assert: [aStack top = expectedTop].! !

!SentenceFinderByPrefixTest methodsFor: 'assertions' stamp: 'manuel urko 9/17/2023 08:38:00'!
assertThatStackHasNotChanged: aStack
	! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialization' stamp: 'h 9/15/2023 15:34:32'!
initialize
	stack := OrderedCollection new.! !


!OOStack methodsFor: 'testing' stamp: 'h 9/15/2023 14:00:39'!
isEmpty
	^stack isEmpty! !


!OOStack methodsFor: 'operations' stamp: 'h 9/15/2023 15:28:07'!
pop
	|stackState|
	stackState := StackState from: self.
	^ stackState popFrom: self! !

!OOStack methodsFor: 'operations' stamp: 'h 9/15/2023 14:01:24'!
push: anElementToPush
	^stack addLast: anElementToPush! !

!OOStack methodsFor: 'operations' stamp: 'h 9/15/2023 14:09:26'!
size
	^stack size! !

!OOStack methodsFor: 'operations' stamp: 'h 9/15/2023 15:30:34'!
top
	|stackState|
	stackState := StackState from: self.
	^stackState topOf: self! !


!OOStack methodsFor: 'operations - private' stamp: 'h 9/15/2023 15:04:08'!
popEmptyStack
	self error: self class stackEmptyErrorDescription ! !

!OOStack methodsFor: 'operations - private' stamp: 'h 9/15/2023 15:09:00'!
popNonEmptyStack
	^stack removeLast ! !

!OOStack methodsFor: 'operations - private' stamp: 'h 9/15/2023 15:29:57'!
topOfEmptyStack
	self error: self class stackEmptyErrorDescription! !

!OOStack methodsFor: 'operations - private' stamp: 'h 9/15/2023 15:29:39'!
topOfNonEmptyStack
	^stack last! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/14/2023 08:12:21'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'manuel urko 9/17/2023 09:43:57'!
findSentencesWithPrefix: aPrefix inStack: aStack
	|stackSentences matchingPrefixes|
	stackSentences := OOStack new.
	matchingPrefixes := OrderedCollection new.
	
	aPrefix isEmpty ifTrue: [^self error: self class prefixCannotBeEmptyError].
	
	aStack size timesRepeat: 
	[ stackSentences push: aStack pop. 
	self includeSentence: (stackSentences top) in: matchingPrefixes ifPrefixMatches: aPrefix ].
				
	stackSentences size timesRepeat: [aStack push: stackSentences pop].
	^matchingPrefixes! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'h 9/16/2023 20:23:40'!
includeSentence: aSentece in: aCollection ifPrefixMatches: aPrefix
	
	(aSentece beginsWith: aPrefix) ifTrue: [^aCollection addFirst: aSentece]
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'h 9/16/2023 20:39:32'!
prefixCannotBeEmptyError
	^'prefijo no puede ser vacio'! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'h 9/16/2023 20:40:02'!
prefixCannotHaveEmptySpacesError
	^'prefijo no puede tener espacios vacios'! !


!classDefinition: #StackState category: 'Stack-Exercise'!
Object subclass: #StackState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackState methodsFor: 'as yet unclassified' stamp: 'h 9/15/2023 15:33:35'!
popFrom: aStack
	^self subclassResponsibility ! !

!StackState methodsFor: 'as yet unclassified' stamp: 'h 9/15/2023 15:33:46'!
topOf: aStack
	^self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StackState class' category: 'Stack-Exercise'!
StackState class
	instanceVariableNames: ''!

!StackState class methodsFor: 'as yet unclassified' stamp: 'h 9/15/2023 14:58:22'!
from: aStack
	aStack isEmpty ifTrue: [^EmptyStack new].
	^NotEmptyStack new
	! !


!classDefinition: #EmptyStack category: 'Stack-Exercise'!
StackState subclass: #EmptyStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!EmptyStack methodsFor: 'as yet unclassified' stamp: 'h 9/15/2023 15:32:47'!
popFrom: anEmptyStack
	^anEmptyStack popEmptyStack! !

!EmptyStack methodsFor: 'as yet unclassified' stamp: 'h 9/15/2023 15:32:39'!
topOf: anEmptyStack
	^anEmptyStack topOfEmptyStack! !


!classDefinition: #NotEmptyStack category: 'Stack-Exercise'!
StackState subclass: #NotEmptyStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!NotEmptyStack methodsFor: 'as yet unclassified' stamp: 'h 9/15/2023 15:26:19'!
popFrom: aStackToPop
	^aStackToPop popNonEmptyStack
	! !

!NotEmptyStack methodsFor: 'as yet unclassified' stamp: 'h 9/15/2023 15:32:22'!
topOf: aNonEmptyStack
	^aNonEmptyStack topOfNonEmptyStack
	! !
