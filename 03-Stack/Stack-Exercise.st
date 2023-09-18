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
	instanceVariableNames: 'aSentenceFinderByPrefix stack stackBeforeSearch'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'manuel urko 9/18/2023 14:25:30'!
test01SearchOnEmptyStackShouldReturnEmptyCollection
	|sentencesWithPrefixMatch expectedStackSize |
	
	expectedStackSize := stack size.
	
	sentencesWithPrefixMatch := aSentenceFinderByPrefix findSentencesWithPrefix: 'a' inStack: stack.
	
	self assertThatStack: stack isTheSameAs: stackBeforeSearch .
	self assertThatCollection: sentencesWithPrefixMatch hasSize: expectedStackSize .
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'manuel urko 9/18/2023 14:26:56'!
test02SearchOnStackWithNoMatchingPrefixShouldReturnEmptyCollection
	|sentencesWithPrefixMatch  |
	self pushToTestStacks: 'holiwi'.
	
	sentencesWithPrefixMatch := aSentenceFinderByPrefix findSentencesWithPrefix: 'a' inStack: stack.
	
	self assertThatCollection: sentencesWithPrefixMatch hasSize: 0.
	self assertThatStack: stack isTheSameAs: stackBeforeSearch.
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'manuel urko 9/18/2023 14:27:43'!
test03SearchOnStackWithMatchingPrefixShouldReturnCollectionWithSentence
	| sentencesWithPrefixMatch |
	
	self pushToTestStacks: 'aloha'.
	
	sentencesWithPrefixMatch := aSentenceFinderByPrefix findSentencesWithPrefix: 'a' inStack: stack.
	
	self  assertThatCollection: sentencesWithPrefixMatch 
		hasSize: 1 
		andContainsElements: #('aloha').
	self assertThatStack: stack isTheSameAs: stackBeforeSearch .
	
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'manuel urko 9/18/2023 14:24:48'!
test04SearchOnStackWithMultipleMatchingPrefixShouldReturnCollectionWithSentences
	| sentencesWithPrefixMatch|
	self pushToTestStacks: 'aloha'.
	self pushToTestStacks: 'arrivederci'.
	
	sentencesWithPrefixMatch := aSentenceFinderByPrefix findSentencesWithPrefix: 'a' inStack: stack.
	
	self  assertThatCollection: sentencesWithPrefixMatch
		hasSize: 2
		andContainsElements: #('aloha' 'arrivederci').
	self assertThatStack: stack isTheSameAs: stackBeforeSearch. 
	
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'manuel urko 9/18/2023 14:29:15'!
test06SearchOnStackWithMultipleMatchingPrefixShouldReturnCollectionWithOnlyMatchingSentences
	|sentencesWithPrefixMatch|
	self pushToTestStacks: 'aloha'.
	self pushToTestStacks: 'arrivederci'.
	self pushToTestStacks: 'ciao'.
		
	sentencesWithPrefixMatch := aSentenceFinderByPrefix findSentencesWithPrefix: 'a' inStack: stack.
	
	self  assertThatCollection: sentencesWithPrefixMatch 
		hasSize: 2 
		andContainsElements: #('aloha' 'arrivederci').
	self assertThatStack: stack isTheSameAs: stackBeforeSearch.
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'manuel urko 9/18/2023 14:30:27'!
test07SearchOnStackWithMatchingPrefixesShouldAlsoMatchCasing
	|sentencesWithPrefixMatch|
	
	self pushToTestStacks: 'aloha'.
	self pushToTestStacks: 'Arrivederci'.
	self pushToTestStacks: 'ciao'.
	
	sentencesWithPrefixMatch := aSentenceFinderByPrefix findSentencesWithPrefix: 'a' inStack: stack.
	
	self  assertThatCollection: sentencesWithPrefixMatch 
		hasSize: 1 
		andContainsElements: #('aloha').
	self assertThatStack: stack isTheSameAs: stackBeforeSearch .
	
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'manuel urko 9/18/2023 14:31:16'!
test08SearchOnStackWithMatchingWordShouldReturnCollectionWithWord
	|sentencesWithPrefixMatch|

	self pushToTestStacks: 'aloha'.
	self pushToTestStacks: 'Arrivederci'.
	self pushToTestStacks: 'ciao'.	
	sentencesWithPrefixMatch := aSentenceFinderByPrefix findSentencesWithPrefix: 'Arrivederci' inStack: stack.
	
	self  assertThatCollection: sentencesWithPrefixMatch 
		hasSize: 1 
		andContainsElements: #('Arrivederci').
	self assertThatStack: stack isTheSameAs: stackBeforeSearch .
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'h 9/18/2023 13:04:57'!
test09SearchWithEmptyPrefixShouldThrowError

	self
		should: [ aSentenceFinderByPrefix findSentencesWithPrefix: '' inStack: stack]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixCannotBeEmptyError ]
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'h 9/18/2023 13:04:51'!
test10SearchWithWhiteSpaceShouldThrowError

	self
		should: [ aSentenceFinderByPrefix findSentencesWithPrefix: 'hola chau' inStack: stack]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixCannotHaveEmptySpacesError ]
	! !


!SentenceFinderByPrefixTest methodsFor: 'setUp' stamp: 'manuel urko 9/18/2023 14:24:48'!
setUp
	aSentenceFinderByPrefix := SentenceFinderByPrefix new.
	stack := OOStack new.
	stackBeforeSearch := OOStack new.
	! !


!SentenceFinderByPrefixTest methodsFor: 'assertions' stamp: 'h 9/18/2023 11:49:01'!
assertThatCollection: aCollection containsElements: collectionOfElements
	collectionOfElements do: [:anElement | self assert: [(aCollection occurrencesOf: anElement) = 1]].! !

!SentenceFinderByPrefixTest methodsFor: 'assertions' stamp: 'manuel urko 9/17/2023 09:52:03'!
assertThatCollection: aCollection hasSize: expectedSize
	self assert: [aCollection size = expectedSize].
! !

!SentenceFinderByPrefixTest methodsFor: 'assertions' stamp: 'h 9/18/2023 11:53:38'!
assertThatCollection: aCollection hasSize: expectedSize andContainsElements: arrayOfElements
	self assertThatCollection: aCollection hasSize: expectedSize.
	self assertThatCollection: aCollection containsElements: arrayOfElements.! !

!SentenceFinderByPrefixTest methodsFor: 'assertions' stamp: 'h 9/18/2023 12:51:05'!
assertThatStack: aStack isTheSameAs: anotherStack

	aStack size timesRepeat: [self assert: [aStack pop sameAs: anotherStack pop]]! !


!SentenceFinderByPrefixTest methodsFor: 'pushing' stamp: 'manuel urko 9/18/2023 14:24:48'!
pushToTestStacks: anElement
	stack push: anElement.
	stackBeforeSearch push: anElement.! !


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

!SentenceFinderByPrefix methodsFor: 'finders - private' stamp: 'h 9/18/2023 12:11:10'!
includeSentence: aSentece in: aCollection ifPrefixMatches: aPrefix
	
	(aSentece beginsWith: aPrefix) ifTrue: [^aCollection addFirst: aSentece]
	! !

!SentenceFinderByPrefix methodsFor: 'finders - private' stamp: 'h 9/18/2023 12:11:04'!
restoreStack: stackToRestore with: sentencesInStack
	
	sentencesInStack size timesRepeat: [stackToRestore push: sentencesInStack pop].

! !

!SentenceFinderByPrefix methodsFor: 'finders - private' stamp: 'h 9/18/2023 12:11:18'!
selectSentencesWithPrefix: aSentencePrefix from: aStackWithSentences 

	|stackSentences sentencesWithSamePrefix|
	
	stackSentences := OOStack new.
	sentencesWithSamePrefix := OrderedCollection new.
	
	aStackWithSentences size timesRepeat: [ 
		stackSentences push: aStackWithSentences pop.
		self includeSentence: (stackSentences top) in: sentencesWithSamePrefix ifPrefixMatches: aSentencePrefix
		].

	self restoreStack: aStackWithSentences with: stackSentences.
	^sentencesWithSamePrefix

! !


!SentenceFinderByPrefix methodsFor: 'tests' stamp: 'h 9/18/2023 11:37:54'!
checkIfPrefixHasBlankSpaces: aPrefix

	(aPrefix allSatisfy: [:aCharacter | aCharacter isSeparator not ]) ifFalse: [^self error: self class        	prefixCannotHaveEmptySpacesError ].! !


!SentenceFinderByPrefix methodsFor: 'finders' stamp: 'h 9/18/2023 12:09:09'!
findSentencesWithPrefix: aPrefix inStack: aStack
	
	aPrefix isEmpty ifTrue: [^self error: self class prefixCannotBeEmptyError].
	self checkIfPrefixHasBlankSpaces: aPrefix.
	
	^self selectSentencesWithPrefix: aPrefix from: aStack.! !

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

!StackState class methodsFor: 'handler' stamp: 'manuel urko 9/18/2023 10:13:11'!
canHandle: aStack
	self subclassResponsibility ! !


!StackState class methodsFor: 'instance creation' stamp: 'h 9/18/2023 11:22:16'!
from: aStack

	^(StackState allSubclasses detect:[:aClass | aClass canHandle: aStack]) new.
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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EmptyStack class' category: 'Stack-Exercise'!
EmptyStack class
	instanceVariableNames: ''!

!EmptyStack class methodsFor: 'handler' stamp: 'manuel urko 9/18/2023 10:13:51'!
canHandle: aStack
	^aStack isEmpty! !


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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NotEmptyStack class' category: 'Stack-Exercise'!
NotEmptyStack class
	instanceVariableNames: ''!

!NotEmptyStack class methodsFor: 'handler' stamp: 'manuel urko 9/18/2023 10:15:20'!
canHandle: aStack
	^aStack isEmpty not! !
