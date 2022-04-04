Class {
	#name : #FRAMFunction,
	#superclass : #FRAMComponent,
	#instVars : [
		'type',
		'description',
		'metadata',
		'x',
		'y',
		'color',
		'variabilityType'
	],
	#category : #'FRAM-Models-Core'
}

{ #category : #'instance creation' }
FRAMFunction class >> on: aFRAMModel [

	^ self new
		  setModel: aFRAMModel;
		  yourself
]

{ #category : #xml }
FRAMFunction >> IDNr [

	^ model idOfFunction: self
]

{ #category : #private }
FRAMFunction >> addedTo: aFRAMModel [

	^ aFRAMModel addFunction: self
]

{ #category : #constants }
FRAMFunction >> background [

	^ 2
]

{ #category : #operations }
FRAMFunction >> beBackground [

	type := self background
]

{ #category : #operations }
FRAMFunction >> beForeground [

	type := self foreground
]

{ #category : #operations }
FRAMFunction >> beForegroundVariable [

	type := self foregroundVariable
]

{ #category : #operations }
FRAMFunction >> beHuman [

	variabilityType := self human
]

{ #category : #operations }
FRAMFunction >> beInterface [

	variabilityType := self interface
]

{ #category : #operations }
FRAMFunction >> beOrganisational [

	variabilityType := self organisational
]

{ #category : #operations }
FRAMFunction >> beTechnological [

	variabilityType := self technological
]

{ #category : #operations }
FRAMFunction >> beUndefined [

	variabilityType := self undefined
]

{ #category : #xml }
FRAMFunction >> buildXml: aXenq [

	^ aXenq addElement: 'Function' with: [ :function | 
		  x ifNotNil: [ function at: 'x' put: x asString ].
		  y ifNotNil: [ function at: 'y' put: y asString ].
		  color ifNotNil: [ 
			  | colorName |
			  colorName := color name.
			  (#( 'white' 'blue' 'green' 'grey' 'red' 'yellow' 'purple' ) 
				   includes: colorName)
				  ifTrue: [ function at: 'style' put: colorName ]
				  ifFalse: [ 
					  function
						  at: 'style' put: 'custom';
						  at: 'color'
						  put:
							  ((color basicPixelValueForDepth: 32) bitAnd: 16rffffff)
								  asString ] ].
		  variabilityType ifNotNil: [ 
			  function at: 'fnType' put: variabilityType asString ].
		  self
			  buildXmlIDNr: function;
			  buildXmlFunctionType: function;
			  buildXmlIDName: function;
			  buildXmlDescription: function;
			  buildXmlMetadata: function ]
]

{ #category : #xml }
FRAMFunction >> buildXmlDescription: aXenq [

	^ description ifNotNil: [ 
		  aXenq
			  addElement: 'Description'
			  with: [ :descriptionNode | descriptionNode addText: description ] ]
]

{ #category : #xml }
FRAMFunction >> buildXmlFunctionType: aXenq [

	^ aXenq
		  addElement: 'FunctionType'
		  with: [ :functionType | functionType addText: type ]
]

{ #category : #xml }
FRAMFunction >> buildXmlMetadata: aXenq [

	^ metadata ifNotEmpty: [ 
		  aXenq addElement: 'metadata' with: [ :metadataNode | 
			  metadata keysAndValuesDo: [ :key :value | 
				  metadataNode
					  addElement: key
					  with: [ :child | child addText: value ] ] ] ]
]

{ #category : #accessing }
FRAMFunction >> color [

	^ color ifNil: [ color := Color black ]
]

{ #category : #accessing }
FRAMFunction >> color: aStringOrColor [

	color := aStringOrColor isString
		         ifTrue: [ 
			         aStringOrColor first isDigit
				         ifTrue: [ 
					         Color
						         colorFromPixelValue:
						         aStringOrColor asInteger + 16rff000000
						         depth: 32 ]
				         ifFalse: [ Color fromString: aStringOrColor ] ]
		         ifFalse: [ aStringOrColor ]
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

{ #category : #testing }
FRAMFunction >> isFunction [

	^ true
]

{ #category : #testing }
FRAMFunction >> isHuman [

	^ variabilityType = self human
]

{ #category : #testing }
FRAMFunction >> isInterface [

	^ variabilityType = self interface
]

{ #category : #testing }
FRAMFunction >> isOrganisational [

	^ variabilityType = self organisational
]

{ #category : #testing }
FRAMFunction >> isTechnological [

	^ variabilityType = self technological
]

{ #category : #testing }
FRAMFunction >> isUndefined [

	^ variabilityType = self undefined
]

{ #category : #accessing }
FRAMFunction >> metadata [

	^ metadata
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

{ #category : #'instance creation' }
FRAMFunction >> newControlNamed: aString [

	^ model newControlOf: self named: aString
]

{ #category : #'instance creation' }
FRAMFunction >> newInputNamed: aString [

	^ model newInputOf: self named: aString
]

{ #category : #'instance creation' }
FRAMFunction >> newOutputNamed: aString [

	^ model newOutputOf: self named: aString
]

{ #category : #'instance creation' }
FRAMFunction >> newPreconditionNamed: aString [

	^ model newPreconditionOf: self named: aString
]

{ #category : #'instance creation' }
FRAMFunction >> newResourceNamed: aString [

	^ model newResourceOf: self named: aString
]

{ #category : #'instance creation' }
FRAMFunction >> newTimeNamed: aString [

	^ model newTimeOf: self named: aString
]

{ #category : #constants }
FRAMFunction >> organisational [

	^ 3
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

	type := anInteger asInteger
]

{ #category : #constants }
FRAMFunction >> undefined [

	^ 0
]

{ #category : #accessing }
FRAMFunction >> variabilityType [

	^ variabilityType
]

{ #category : #accessing }
FRAMFunction >> variabilityType: anInteger [

	variabilityType := anInteger asInteger
]

{ #category : #accessing }
FRAMFunction >> x [

	^ x
]

{ #category : #accessing }
FRAMFunction >> x: aNumberOrString [

	x := aNumberOrString asNumber
]

{ #category : #accessing }
FRAMFunction >> y [

	^ y
]

{ #category : #accessing }
FRAMFunction >> y: aNumberOrString [

	y := aNumberOrString asNumber
]
