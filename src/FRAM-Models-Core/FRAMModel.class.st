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
		'times'
	],
	#category : #'FRAM-Models-Core'
}

{ #category : #private }
FRAMModel >> addControl: aFRAMControl [

	controls add: aFRAMControl.
	^ aFRAMControl
]

{ #category : #private }
FRAMModel >> addFunction: aFRAMFunction [

	functions add: aFRAMFunction.
	^ aFRAMFunction
]

{ #category : #private }
FRAMModel >> addInput: aFRAMInput [

	inputs add: aFRAMInput.
	^ aFRAMInput
]

{ #category : #private }
FRAMModel >> addOutput: aFRAMOutput [

	outputs add: aFRAMOutput.
	^ aFRAMOutput
]

{ #category : #private }
FRAMModel >> addPrecondition: aFRAMPrecondition [

	preconditions add: aFRAMPrecondition.
	^ aFRAMPrecondition
]

{ #category : #private }
FRAMModel >> addResource: aFRAMResource [

	resources add: aFRAMResource.
	^ aFRAMResource
]

{ #category : #private }
FRAMModel >> addTime: aFRAMTime [

	times add: aFRAMTime.
	^ aFRAMTime
]

{ #category : #'accessing-control' }
FRAMModel >> controlAt: anInteger ifAbsent: errorBlock [

	^ controls at: anInteger + 1 ifAbsent: errorBlock
]

{ #category : #'accessing-control' }
FRAMModel >> controlAt: anInteger ifPresent: aBlock [

	^ controls at: anInteger + 1 ifPresent: aBlock
]

{ #category : #'accessing-control' }
FRAMModel >> controlNamed: aString ifAbsent: errorBlock [

	^ controls
		  detect: [ :control | control name = aString ]
		  ifNone: errorBlock
]

{ #category : #'accessing-control' }
FRAMModel >> controlNamed: aString ifPresent: aBlock [

	^ (controls
		   detect: [ :control | control name = aString ]
		   ifNone: [ nil ]) ifNotNil: aBlock
]

{ #category : #private }
FRAMModel >> controls [

	^ controls
]

{ #category : #'accessing-function' }
FRAMModel >> functionAt: anInteger ifAbsent: errorBlock [

	^ functions at: anInteger + 1 ifAbsent: errorBlock
]

{ #category : #'accessing-function' }
FRAMModel >> functionAt: anInteger ifPresent: aBlock [

	^ functions at: anInteger + 1 ifPresent: aBlock
]

{ #category : #'accessing-function' }
FRAMModel >> functionNamed: aString ifAbsent: errorBlock [

	^ functions
		  detect: [ :function | function name = aString ]
		  ifNone: errorBlock
]

{ #category : #'accessing-function' }
FRAMModel >> functionNamed: aString ifPresent: aBlock [

	^ (functions
		   detect: [ :function | function name = aString ]
		   ifNone: [ nil ]) ifNotNil: aBlock
]

{ #category : #private }
FRAMModel >> functions [

	^ functions
]

{ #category : #'accessing-control' }
FRAMModel >> idOfControl: aFRAMControl [

	| id |
	^ (id := (controls indexOf: aFRAMControl) - 1) >= 0
		  ifTrue: [ id ]
		  ifFalse: [ KeyNotFound signal: aFRAMControl ]
]

{ #category : #'accessing-control' }
FRAMModel >> idOfControlNamed: aFRAMControl [

	| id |
	^ (id := (controls findFirst: [ :control | 
		          control name = aFRAMControl ]) - 1) >= 0
		  ifTrue: [ id ]
		  ifFalse: [ KeyNotFound signal: aFRAMControl ]
]

{ #category : #'accessing-function' }
FRAMModel >> idOfFunction: aFRAMFunction [

	| id |
	^ (id := (functions indexOf: aFRAMFunction) - 1) >= 0
		  ifTrue: [ id ]
		  ifFalse: [ KeyNotFound signal: aFRAMFunction ]
]

{ #category : #'accessing-function' }
FRAMModel >> idOfFunctionNamed: aFRAMFunction [

	| id |
	^ (id := (functions findFirst: [ :function | 
		          function name = aFRAMFunction ]) - 1) >= 0
		  ifTrue: [ id ]
		  ifFalse: [ KeyNotFound signal: aFRAMFunction ]
]

{ #category : #'accessing-function' }
FRAMModel >> idOfFunctionNamed: aFRAMFunction ifAbsentNew: errorBlock [

	| id |
	^ (id := (functions findFirst: [ :function | 
		          function name = aFRAMFunction ]) - 1) >= 0
		  ifTrue: [ id ]
		  ifFalse: [ 
			  | newFunc |
			  newFunc := self newFunctionDo: [ :f | f name: aFRAMFunction ].
			  errorBlock cull: newFunc.
			  (functions indexOf: newFunc) - 1 ]
]

{ #category : #'accessing-input' }
FRAMModel >> idOfInput: aFRAMInput [

	| id |
	^ (id := (inputs indexOf: aFRAMInput) - 1) >= 0
		  ifTrue: [ id ]
		  ifFalse: [ KeyNotFound signal: aFRAMInput ]
]

{ #category : #'accessing-input' }
FRAMModel >> idOfInputNamed: aFRAMInput [

	| id |
	^ (id := (inputs findFirst: [ :input | input name = aFRAMInput ]) - 1)
	  >= 0
		  ifTrue: [ id ]
		  ifFalse: [ KeyNotFound signal: aFRAMInput ]
]

{ #category : #'accessing-output' }
FRAMModel >> idOfOutput: aFRAMOutput [

	| id |
	^ (id := (outputs indexOf: aFRAMOutput) - 1) >= 0
		  ifTrue: [ id ]
		  ifFalse: [ KeyNotFound signal: aFRAMOutput ]
]

{ #category : #'accessing-output' }
FRAMModel >> idOfOutputNamed: aFRAMOutput [

	| id |
	^ (id := (outputs findFirst: [ :Output | Output name = aFRAMOutput ]) - 1)
	  >= 0
		  ifTrue: [ id ]
		  ifFalse: [ KeyNotFound signal: aFRAMOutput ]
]

{ #category : #'accessing-precondition' }
FRAMModel >> idOfPrecondition: aFRAMPrecondition [

	| id |
	^ (id := (preconditions indexOf: aFRAMPrecondition) - 1) >= 0
		  ifTrue: [ id ]
		  ifFalse: [ KeyNotFound signal: aFRAMPrecondition ]
]

{ #category : #'accessing-precondition' }
FRAMModel >> idOfPreconditionNamed: aFRAMPrecondition [

	| id |
	^ (id := (preconditions findFirst: [ :precondition | 
		          precondition name = aFRAMPrecondition ]) - 1) >= 0
		  ifTrue: [ id ]
		  ifFalse: [ KeyNotFound signal: aFRAMPrecondition ]
]

{ #category : #'accessing-resources' }
FRAMModel >> idOfResource: aFRAMResource [

	| id |
	^ (id := (resources indexOf: aFRAMResource) - 1) >= 0
		  ifTrue: [ id ]
		  ifFalse: [ KeyNotFound signal: aFRAMResource ]
]

{ #category : #'accessing-resources' }
FRAMModel >> idOfResourceNamed: aFRAMResource [

	| id |
	^ (id := (resources findFirst: [ :resource | 
		          resource name = aFRAMResource ]) - 1) >= 0
		  ifTrue: [ id ]
		  ifFalse: [ KeyNotFound signal: aFRAMResource ]
]

{ #category : #'accessing-time' }
FRAMModel >> idOfTime: aFRAMTime [

	| id |
	^ (id := (times indexOf: aFRAMTime) - 1) >= 0
		  ifTrue: [ id ]
		  ifFalse: [ KeyNotFound signal: aFRAMTime ]
]

{ #category : #'accessing-time' }
FRAMModel >> idOfTimeNamed: aFRAMTime [

	| id |
	^ (id := (times findFirst: [ :time | time name = aFRAMTime ]) - 1)
	  >= 0
		  ifTrue: [ id ]
		  ifFalse: [ KeyNotFound signal: aFRAMTime ]
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
	times := OrderedCollection new
]

{ #category : #'accessing-input' }
FRAMModel >> inputAt: anInteger ifAbsent: errorBlock [

	^ inputs at: anInteger + 1 ifAbsent: errorBlock
]

{ #category : #'accessing-input' }
FRAMModel >> inputAt: anInteger ifPresent: aBlock [

	^ inputs at: anInteger + 1 ifPresent: aBlock
]

{ #category : #'accessing-input' }
FRAMModel >> inputNamed: aString ifAbsent: errorBlock [

	^ inputs detect: [ :input | input name = aString ] ifNone: errorBlock
]

{ #category : #'accessing-input' }
FRAMModel >> inputNamed: aString ifPresent: aBlock [

	^ (inputs detect: [ :input | input name = aString ] ifNone: [ nil ]) 
		  ifNotNil: aBlock
]

{ #category : #private }
FRAMModel >> inputs [

	^ inputs
]

{ #category : #'instance creation' }
FRAMModel >> newControlDo: aBlock [

	^ aBlock value: (FRAMControl on: self)
]

{ #category : #'instance creation' }
FRAMModel >> newFunctionDo: aBlock [

	^ aBlock value: (FRAMFunction on: self)
]

{ #category : #'instance creation' }
FRAMModel >> newInputDo: aBlock [

	^ aBlock value: (FRAMInput on: self)
]

{ #category : #'instance creation' }
FRAMModel >> newOutputDo: aBlock [

	^ aBlock value: (FRAMOutput on: self)
]

{ #category : #'instance creation' }
FRAMModel >> newPreconditionDo: aBlock [

	^ aBlock value: (FRAMPrecondition on: self)
]

{ #category : #'instance creation' }
FRAMModel >> newResourceDo: aBlock [

	^ aBlock value: (FRAMResource on: self)
]

{ #category : #'instance creation' }
FRAMModel >> newTimeDo: aBlock [

	^ aBlock value: (FRAMTime on: self)
]

{ #category : #'accessing-output' }
FRAMModel >> outputAt: anInteger ifAbsent: errorBlock [

	^ outputs at: anInteger + 1 ifAbsent: errorBlock
]

{ #category : #'accessing-output' }
FRAMModel >> outputAt: anInteger ifPresent: aBlock [

	^ outputs at: anInteger + 1 ifPresent: aBlock
]

{ #category : #'accessing-output' }
FRAMModel >> outputNamed: aString ifAbsent: errorBlock [

	^ outputs
		  detect: [ :output | output name = aString ]
		  ifNone: errorBlock
]

{ #category : #'accessing-output' }
FRAMModel >> outputNamed: aString ifPresent: aBlock [

	^ (outputs
		   detect: [ :output | output name = aString ]
		   ifNone: [ nil ]) ifNotNil: aBlock
]

{ #category : #private }
FRAMModel >> outputs [

	^ outputs
]

{ #category : #'accessing-precondition' }
FRAMModel >> preconditionAt: anInteger ifAbsent: errorBlock [

	^ preconditions at: anInteger + 1 ifAbsent: errorBlock
]

{ #category : #'accessing-precondition' }
FRAMModel >> preconditionAt: anInteger ifPresent: aBlock [

	^ preconditions at: anInteger + 1 ifPresent: aBlock
]

{ #category : #'accessing-precondition' }
FRAMModel >> preconditionNamed: aString ifAbsent: errorBlock [

	^ preconditions
		  detect: [ :precondition | precondition name = aString ]
		  ifNone: errorBlock
]

{ #category : #'accessing-precondition' }
FRAMModel >> preconditionNamed: aString ifPresent: aBlock [

	^ (preconditions
		   detect: [ :precondition | precondition name = aString ]
		   ifNone: [ nil ]) ifNotNil: aBlock
]

{ #category : #private }
FRAMModel >> preconditions [

	^ preconditions
]

{ #category : #'accessing-resources' }
FRAMModel >> resourceAt: anInteger ifAbsent: errorBlock [

	^ resources at: anInteger + 1 ifAbsent: errorBlock
]

{ #category : #'accessing-resources' }
FRAMModel >> resourceAt: anInteger ifPresent: aBlock [

	^ resources at: anInteger + 1 ifPresent: aBlock
]

{ #category : #'accessing-resources' }
FRAMModel >> resourceNamed: aString ifAbsent: errorBlock [

	^ resources
		  detect: [ :resource | resource name = aString ]
		  ifNone: errorBlock
]

{ #category : #'accessing-resources' }
FRAMModel >> resourceNamed: aString ifPresent: aBlock [

	^ (resources
		   detect: [ :resource | resource name = aString ]
		   ifNone: [ nil ]) ifNotNil: aBlock
]

{ #category : #private }
FRAMModel >> resources [

	^ resources
]

{ #category : #'accessing-time' }
FRAMModel >> timeAt: anInteger ifAbsent: errorBlock [

	^ times at: anInteger + 1 ifAbsent: errorBlock
]

{ #category : #'accessing-time' }
FRAMModel >> timeAt: anInteger ifPresent: aBlock [

	^ times at: anInteger + 1 ifPresent: aBlock
]

{ #category : #'accessing-time' }
FRAMModel >> timeNamed: aString ifAbsent: errorBlock [

	^ times detect: [ :time | time name = aString ] ifNone: errorBlock
]

{ #category : #'accessing-time' }
FRAMModel >> timeNamed: aString ifPresent: aBlock [

	^ (times detect: [ :time | time name = aString ] ifNone: [ nil ]) 
		  ifNotNil: aBlock
]

{ #category : #private }
FRAMModel >> times [

	^ times
]
