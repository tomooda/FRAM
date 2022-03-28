Class {
	#name : #FRAMFunction,
	#superclass : #Object,
	#instVars : [
		'model',
		'type',
		'name',
		'description',
		'metadata',
		'color',
		'variabilityType'
	],
	#classVars : [
		'LastId'
	],
	#category : #'FRAM-Models-Core'
}

{ #category : #'instance creation' }
FRAMFunction class >> on: aFRAMModel [

	^ self new
		  setModel: aFRAMModel;
		  yourself
]

{ #category : #constants }
FRAMFunction >> background [

	^ 2
]

{ #category : #operations }
FRAMFunction >> beBackground [

	type := self backgroun
]

{ #category : #operations }
FRAMFunction >> beForeground [

	type := self foreground
]

{ #category : #operations }
FRAMFunction >> beForegroundVariable [

	type := self foregroundVariable
]

{ #category : #accessing }
FRAMFunction >> description [

	^ description
]

{ #category : #accessing }
FRAMFunction >> description: aString [

	description := aString
]

{ #category : #constants }
FRAMFunction >> foreground [

	^ 0
]

{ #category : #constants }
FRAMFunction >> foregroundVariable [

	^ 1
]

{ #category : #constants }
FRAMFunction >> human [

	^ 2
]

{ #category : #accessing }
FRAMFunction >> id [

	^ model idOfFunction: self
]

{ #category : #initialization }
FRAMFunction >> initialize [

	super initialize.
	type := self foreground.
	name := '' copy.
	description := '' copy.
	metadata := Dictionary new
]

{ #category : #constants }
FRAMFunction >> interface [

	^ 4
]

{ #category : #testing }
FRAMFunction >> isBackground [

	^ type = self background
]

{ #category : #testing }
FRAMFunction >> isForeground [

	^ type = self foreground
]

{ #category : #testing }
FRAMFunction >> isForegroundVariable [

	^ type = self foregroundVariable
]

{ #category : #accessing }
FRAMFunction >> metadata [

	^ metadata
]

{ #category : #accessing }
FRAMFunction >> metadata: aDictionary [

	metadata := aDictionary
]

{ #category : #operations }
FRAMFunction >> metadataAt: aString ifAbsent: errorBlock [

	^ metadata at: aString ifAbsent: errorBlock
]

{ #category : #operations }
FRAMFunction >> metadataAt: aString ifPresent: aBlock [

	^ metadata at: aString ifPresent: aBlock
]

{ #category : #operations }
FRAMFunction >> metadataAt: aString put: anObject [

	metadata at: aString put: anObject.
	^ anObject
]

{ #category : #accessing }
FRAMFunction >> model [

	^ model
]

{ #category : #accessing }
FRAMFunction >> name [

	^ name
]

{ #category : #accessing }
FRAMFunction >> name: aString [

	name := aString
]

{ #category : #constants }
FRAMFunction >> organisational [

	^ 3
]

{ #category : #private }
FRAMFunction >> setModel: aFRAMModel [

	model := aFRAMModel
]

{ #category : #constants }
FRAMFunction >> technological [

	^ 1
]

{ #category : #accessing }
FRAMFunction >> type [

	^ type
]

{ #category : #accessing }
FRAMFunction >> type: anInteger [

	type := anInteger
]

{ #category : #constants }
FRAMFunction >> undefined [

	^ 0
]
