Class {
	#name : #FRAMModel,
	#superclass : #Object,
	#instVars : [
		'functions',
		'controls',
		'inputs',
		'outputs',
		'preconditions',
		'resources',
		'times',
		'aspects',
		'playbacks',
		'groups'
	],
	#category : #'FRAM-Models-Core'
}

{ #category : #adding }
FRAMModel >> addFunction: aFRAMFunction [

	(functions anySatisfy: [ :function | 
		 function name = aFRAMFunction name ]) ifTrue: [ 
		^ self duplicatedNameError: aFRAMFunction name ].
	functions add: aFRAMFunction.
	^ aFRAMFunction
]

{ #category : #adding }
FRAMModel >> addFunctionNamed: aString do: aBlock [

	| newFunction |
	newFunction := (FRAMFunction on: self)
		               name: aString;
		               yourself.
	aBlock value: newFunction.
	^ self addFunction: newFunction
]

{ #category : #errors }
FRAMModel >> duplicatedNameError: aString [
	^ self error: 'Duplicated name: ', aString asString
]

{ #category : #accessing }
FRAMModel >> functionAt: anInteger ifAbsent: errorBlock [

	^ functions at: anInteger ifAbsent: errorBlock
]

{ #category : #accessing }
FRAMModel >> functionAt: anInteger ifPresent: aBlock [

	^ functions at: anInteger ifPresent: aBlock
]

{ #category : #accessing }
FRAMModel >> functionNamed: aString ifAbsent: errorBlock [

	^ functions
		  detect: [ :function | function name = aString ]
		  ifNone: errorBlock
]

{ #category : #accessing }
FRAMModel >> functionNamed: aString ifPresent: aBlock [

	^ (functions
		   detect: [ :function | function name = aString ]
		   ifNone: [ nil ]) ifNotNil: aBlock
]

{ #category : #accessing }
FRAMModel >> idOfFunction: aFRAMFunction [

	| id |
	^ (id := (functions indexOf: aFRAMFunction) - 1) >= 0
		  ifTrue: [ id ]
		  ifFalse: [ KeyNotFound signal: aFRAMFunction ]
]

{ #category : #accessing }
FRAMModel >> idOfFunctionNamed: aFRAMFunction [

	| id |
	^ (id := (functions findFirst: [ :function | 
		          function name = aFRAMFunction ]) - 1) >= 0
		  ifTrue: [ id ]
		  ifFalse: [ KeyNotFound signal: aFRAMFunction ]
]

{ #category : #initialization }
FRAMModel >> initialize [

	super initialize.
	functions := OrderedCollection new.
	controls := OrderedCollection new.
	inputs := OrderedCollection new.
	outputs := OrderedCollection new.
	preconditions := OrderedCollection new.
	resources := OrderedCollection new.
	times := OrderedCollection new.
	aspects := OrderedCollection new.
	playbacks := OrderedCollection new.
	groups := OrderedCollection new
]
