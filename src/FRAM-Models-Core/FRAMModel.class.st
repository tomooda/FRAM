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

{ #category : #examples }
FRAMModel class >> example [

	<script: 'FRAMModel example inspect'>
	| model |
	model := FRAMModel new.
	(model newFunctionNamed: 'Function Name') description: 'Description'.
	model newFunctionNamed: ''.
	model newControlOf: 0 named: 'Control'.
	model newInputOf: 0 named: 'Input'.
	model newInputOf: 1 named: 'Output'.
	model newOutputOf: 0 named: 'Output'.
	model newPreconditionOf: 0 named: 'Precondition'.
	model newResourceOf: 0 named: 'Resource'.
	model newTimeOf: 0 named: 'Time'.
	^ model
]

{ #category : #'instance creation' }
FRAMModel class >> fromFile [

	<script: 'FRAMModel fromFile inspect'>
	^ (UIManager default chooseFullFileNameMatching: #( '*.xfmv' )) 
		  ifNotNil: [ :ref | self fromXML: ref asFileReference ]
]

{ #category : #'instance creation' }
FRAMModel class >> fromFile: aFileReference [

	^ aFileReference readStreamDo: [ :stream | self fromXML: stream ]
]

{ #category : #'instance creation' }
FRAMModel class >> fromXML: aStreamOrString [

	^ self fromXMLDocument:
		  (XMLDOMParser parse: aStreamOrString) document
]

{ #category : #'instance creation' }
FRAMModel class >> fromXMLDocument: aXMLDocument [

	| fmNode model |
	fmNode := aXMLDocument root.
	fmNode name = 'FM' ifFalse: [ ^ nil ].
	model := self new.
	^ model
		  readXMLFunctionsNode: fmNode;
		  readXMLControlsNode: fmNode;
		  readXMLInputsNode: fmNode;
		  readXMLOutputsNode: fmNode;
		  readXMLPreconditionsNode: fmNode;
		  readXMLResourcesNode: fmNode;
		  readXMLTimesNode: fmNode;
		  yourself
]

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

{ #category : #xml }
FRAMModel >> buildXml: aXenq [

	^ aXenq addElement: 'FM' with: [ :model | 
		  model addElement: 'Functions' with: [ :functionsNode | 
			  functions do: [ :function | function buildXml: functionsNode ] ].
		  model addElement: 'Controls' with: [ :controlsNode | 
			  controls do: [ :control | control buildXml: controlsNode ] ].
		  model
			  addElement: 'Inputs'
			  with: [ :inputsNode | 
			  inputs do: [ :input | input buildXml: inputsNode ] ].
		  model addElement: 'Outputs' with: [ :outputsNode | 
			  outputs do: [ :output | output buildXml: outputsNode ] ].
		  model addElement: 'Preconditions' with: [ :preconditionsNode | 
			  preconditions do: [ :precondition | 
				  precondition buildXml: preconditionsNode ] ].
		  model addElement: 'Resources' with: [ :resourcesNode | 
			  resources do: [ :resource | resource buildXml: resourcesNode ] ].
		  model
			  addElement: 'Times'
			  with: [ :timesNode | 
			  times do: [ :function | function buildXml: timesNode ] ].

		  model addElement: 'Aspects' with: [ :aspects |  ].
		  model addElement: 'Playbacks' with: [ :playbacks |  ].
		  model addElement: 'Groups' with: [ :groups |  ] ]
]

{ #category : #'accessing-control' }
FRAMModel >> controlAt: anInteger ifAbsent: errorBlock [

	^ controls at: anInteger ifAbsent: errorBlock
]

{ #category : #'accessing-control' }
FRAMModel >> controlAt: anInteger ifPresent: aBlock [

	^ controls at: anInteger ifPresent: aBlock
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
	^ (id := controls indexOf: aFRAMControl) >= 1
		  ifTrue: [ id ]
		  ifFalse: [ KeyNotFound signal: aFRAMControl ]
]

{ #category : #'accessing-control' }
FRAMModel >> idOfControlNamed: aFRAMControl [

	| id |
	^ (id := controls findFirst: [ :control | 
		         control name = aFRAMControl ]) >= 1
		  ifTrue: [ id ]
		  ifFalse: [ KeyNotFound signal: aFRAMControl ]
]

{ #category : #'accessing-function' }
FRAMModel >> idOfFunction: aFRAMFunction [

	| id |
	^ (id := (functions indexOf: aFRAMFunction) - 1) >= 0
		  ifTrue: [ id ]
		  ifFalse: [ KeyNotFound signal: aFRAMFunction printString]
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
FRAMModel >> idOfFunctionNamed: aString ifAbsentNew: errorBlock [

	| id |
	^ (id := (functions findFirst: [ :function | function name = aString ])
	         - 1) >= 0
		  ifTrue: [ id ]
		  ifFalse: [ 
			  | newFunc |
			  newFunc := self newFunctionDo: [ :f | f name: aString ].
			  errorBlock cull: newFunc.
			  (functions indexOf: newFunc) - 1 ]
]

{ #category : #'accessing-input' }
FRAMModel >> idOfInput: aFRAMInput [

	| id |
	^ (id := inputs indexOf: aFRAMInput) >= 1
		  ifTrue: [ id ]
		  ifFalse: [ KeyNotFound signal: aFRAMInput ]
]

{ #category : #'accessing-input' }
FRAMModel >> idOfInputNamed: aFRAMInput [

	| id |
	^ (id := inputs findFirst: [ :input | input name = aFRAMInput ]) >= 1
		  ifTrue: [ id ]
		  ifFalse: [ KeyNotFound signal: aFRAMInput ]
]

{ #category : #'accessing-output' }
FRAMModel >> idOfOutput: aFRAMOutput [

	| id |
	^ (id := outputs indexOf: aFRAMOutput) >= 1
		  ifTrue: [ id ]
		  ifFalse: [ KeyNotFound signal: aFRAMOutput ]
]

{ #category : #'accessing-output' }
FRAMModel >> idOfOutputNamed: aFRAMOutput [

	| id |
	^ (id := outputs findFirst: [ :Output | Output name = aFRAMOutput ])
	  >= 1
		  ifTrue: [ id ]
		  ifFalse: [ KeyNotFound signal: aFRAMOutput ]
]

{ #category : #'accessing-precondition' }
FRAMModel >> idOfPrecondition: aFRAMPrecondition [

	| id |
	^ (id := preconditions indexOf: aFRAMPrecondition) >= 1
		  ifTrue: [ id ]
		  ifFalse: [ KeyNotFound signal: aFRAMPrecondition ]
]

{ #category : #'accessing-precondition' }
FRAMModel >> idOfPreconditionNamed: aFRAMPrecondition [

	| id |
	^ (id := preconditions findFirst: [ :precondition | 
		         precondition name = aFRAMPrecondition ]) >= 1
		  ifTrue: [ id ]
		  ifFalse: [ KeyNotFound signal: aFRAMPrecondition ]
]

{ #category : #'accessing-resources' }
FRAMModel >> idOfResource: aFRAMResource [

	| id |
	^ (id := resources indexOf: aFRAMResource) >= 1
		  ifTrue: [ id ]
		  ifFalse: [ KeyNotFound signal: aFRAMResource ]
]

{ #category : #'accessing-resources' }
FRAMModel >> idOfResourceNamed: aFRAMResource [

	| id |
	^ (id := resources findFirst: [ :resource | 
		         resource name = aFRAMResource ]) >= 1
		  ifTrue: [ id ]
		  ifFalse: [ KeyNotFound signal: aFRAMResource ]
]

{ #category : #'accessing-time' }
FRAMModel >> idOfTime: aFRAMTime [

	| id |
	^ (id := times indexOf: aFRAMTime) >= 1
		  ifTrue: [ id ]
		  ifFalse: [ KeyNotFound signal: aFRAMTime ]
]

{ #category : #'accessing-time' }
FRAMModel >> idOfTimeNamed: aFRAMTime [

	| id |
	^ (id := times findFirst: [ :time | time name = aFRAMTime ]) >= 1
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

	^ inputs at: anInteger ifAbsent: errorBlock
]

{ #category : #'accessing-input' }
FRAMModel >> inputAt: anInteger ifPresent: aBlock [

	^ inputs at: anInteger ifPresent: aBlock
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
FRAMModel >> newControlOf: aStringOrFRAMFunction named: aString [

	^ (FRAMControl on: self)
		  function: aStringOrFRAMFunction;
		  name: aString;
		  yourself
]

{ #category : #'instance creation' }
FRAMModel >> newFunctionDo: aBlock [

	^ aBlock value: (FRAMFunction on: self)
]

{ #category : #'instance creation' }
FRAMModel >> newFunctionNamed: aString [

	^ (FRAMFunction on: self)
		  name: aString;
		  yourself
]

{ #category : #'instance creation' }
FRAMModel >> newInputOf: aStringOrFRAMFunction named: aString [

	^ (FRAMInput on: self)
		  function: aStringOrFRAMFunction;
		  name: aString;
		  yourself
]

{ #category : #'instance creation' }
FRAMModel >> newOutputOf: aStringOrFRAMFunction named: aString [

	^ (FRAMOutput on: self)
		  function: aStringOrFRAMFunction;
		  name: aString;
		  yourself
]

{ #category : #'instance creation' }
FRAMModel >> newPreconditionOf: aStringOrFRAMFunction named: aString [

	^ (FRAMPrecondition on: self)
		  function: aStringOrFRAMFunction;
		  name: aString;
		  yourself
]

{ #category : #'instance creation' }
FRAMModel >> newResourceOf: aStringOrFRAMFunction named: aString [

	^ (FRAMResource on: self)
		  function: aStringOrFRAMFunction;
		  name: aString;
		  yourself
]

{ #category : #'instance creation' }
FRAMModel >> newTimeOf: aStringOrFRAMFunction named: aString [

	^ (FRAMTime on: self)
		  function: aStringOrFRAMFunction;
		  name: aString;
		  yourself
]

{ #category : #xml }
FRAMModel >> openInExternalViewer [

	| ref |
	ref := FileLocator localDirectory / 'FRAM'
	       / (String streamContents: [ :stream | 
			        10 timesRepeat: [ 
				        stream nextPut:
					        '0123456789abcdefghijklmnopqrstuvwxyz' atRandom ] ]) 
		       withExtension: 'xfmv'.
	ref parent ensureCreateDirectory.
	ref writeStreamDo: [ :stream | self printXmlOn: stream ].
	[ 
	LibC system: 'open ' , ref pathString.
	1 minute wait.
	ref delete ] forkAt: Processor userBackgroundPriority
]

{ #category : #'accessing-output' }
FRAMModel >> outputAt: anInteger ifAbsent: errorBlock [

	^ outputs at: anInteger ifAbsent: errorBlock
]

{ #category : #'accessing-output' }
FRAMModel >> outputAt: anInteger ifPresent: aBlock [

	^ outputs at: anInteger ifPresent: aBlock
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

	^ preconditions at: anInteger ifAbsent: errorBlock
]

{ #category : #'accessing-precondition' }
FRAMModel >> preconditionAt: anInteger ifPresent: aBlock [

	^ preconditions at: anInteger ifPresent: aBlock
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

{ #category : #xml }
FRAMModel >> printXml [

	^ String streamContents: [ :stream | self printXmlOn: stream ]
]

{ #category : #xml }
FRAMModel >> printXmlOn: aStream [

	(self buildXml: XenqXML) printWithPrologOn: aStream
]

{ #category : #xml }
FRAMModel >> readXMLControlNode: aControlNode [

	self
		newControlOf:
		(aControlNode elementAt: 'FunctionIDNr') strings first asInteger
		named: ((aControlNode elementAt: 'IDName' ifAbsent: [ nil ])
				 ifNotNil: [ :idNameNode | idNameNode strings first ]
				 ifNil: [ '' ])
]

{ #category : #xml }
FRAMModel >> readXMLControlsNode: aFMNode [

	| controlNodes |
	controlNodes := OrderedCollection new.
	aFMNode elementsAt: 'Controls' do: [ :controlsNode | 
		controlsNode elementsAt: 'Control' do: [ :controlNode | 
			controlNodes add:
				(controlNode elementsAt: 'IDNr') first strings first asInteger
				-> controlNode ] ].
	controlNodes := controlNodes asSortedCollection: [ :less :more | 
		                less key <= more key ].
	(controlNodes collect: #key) asArray
	= (1 to: controlNodes size) asArray ifFalse: [ 
		^ self error: 'Control IDNr should be sequential from 0' ].
	controlNodes do: [ :assoc | self readXMLControlNode: assoc value ]
]

{ #category : #xml }
FRAMModel >> readXMLFunctionNode: aFunctionNode [

	self newFunctionDo: [ :function | 
		(aFunctionNode elementAt: 'IDName' ifAbsent: [ nil ]) ifNotNil: [ 
			:nameNode | function name: nameNode strings first ].
		(aFunctionNode elementAt: 'FunctionType' ifAbsent: [ nil ]) 
			ifNotNil: [ :typeNode | 
			function type: typeNode strings first asInteger ].
		(aFunctionNode elementAt: 'Description' ifAbsent: [ nil ]) 
			ifNotNil: [ :descriptionNode | 
				function description: descriptionNode strings first ].
		(aFunctionNode elementAt: 'metadata' ifAbsent: [  ]) ifNotNil: [ 
			:metadataNode | 
			metadataNode elementsDo: [ :metadataElementNode | 
				metadataNode
					metadataAt: metadataElementNode name
					put: metadataElementNode strings first ] ].

		(aFunctionNode attributeAt: 'x' ifAbsent: [ nil ]) ifNotNil: [ :x | 
			function x: x ].
		(aFunctionNode attributeAt: 'y' ifAbsent: [ nil ]) ifNotNil: [ :y | 
			function y: y ].
		(aFunctionNode
			 attributeAt: 'color'
			 ifAbsent: [ aFunctionNode attributeAt: 'style' ifAbsent: [ nil ] ]) 
			ifNotNil: [ :color | function color: color ].
		(aFunctionNode attributeAt: 'fnType' ifAbsent: [ nil ]) ifNotNil: [ 
			:fnType | function variabilityType: fnType ] ]
]

{ #category : #xml }
FRAMModel >> readXMLFunctionsNode: aFMNode [

	| functionNodes |
	functionNodes := OrderedCollection new.
	aFMNode elementsAt: 'Functions' do: [ :functionsNode | 
		functionsNode elementsAt: 'Function' do: [ :functionNode | 
			functionNodes add:
				(functionNode elementsAt: 'IDNr') first strings first asInteger
				-> functionNode ] ].
	functionNodes := functionNodes asSortedCollection: [ :less :more | 
		                 less key <= more key ].
	(functionNodes collect: #key) asArray
	= (0 to: functionNodes size - 1) asArray ifFalse: [ 
		^ self error: 'Function IDNr should be sequential from 0' ].
	functionNodes do: [ :assoc | self readXMLFunctionNode: assoc value ]
]

{ #category : #xml }
FRAMModel >> readXMLInputNode: anInputNode [

	self
		newInputOf:
		(anInputNode elementAt: 'FunctionIDNr') strings first asInteger
		named: ((anInputNode elementAt: 'IDName' ifAbsent: [ nil ])
				 ifNotNil: [ :idNameNode | idNameNode strings first ]
				 ifNil: [ '' ])
]

{ #category : #xml }
FRAMModel >> readXMLInputsNode: aFMNode [

	| inputNodes |
	inputNodes := OrderedCollection new.
	aFMNode elementsAt: 'Inputs' do: [ :inputsNode | 
		inputsNode elementsAt: 'Input' do: [ :inputNode | 
			inputNodes add:
				(inputNode elementsAt: 'IDNr') first strings first asInteger
				-> inputNode ] ].
	inputNodes := inputNodes asSortedCollection: [ :less :more | 
		              less key <= more key ].
	(inputNodes collect: #key) asArray = (1 to: inputNodes size) asArray 
		ifFalse: [ ^ self error: 'Input IDNr should be sequential from 0' ].
	inputNodes do: [ :assoc | self readXMLInputNode: assoc value ]
]

{ #category : #xml }
FRAMModel >> readXMLOutputNode: anOutputNode [

	self
		newOutputOf:
		(anOutputNode elementAt: 'FunctionIDNr') strings first asInteger
		named: ((anOutputNode elementAt: 'IDName' ifAbsent: [ nil ])
				 ifNotNil: [ :idNameNode | idNameNode strings first ]
				 ifNil: [ '' ])
]

{ #category : #xml }
FRAMModel >> readXMLOutputsNode: aFMNode [

	| outputNodes |
	outputNodes := OrderedCollection new.
	aFMNode elementsAt: 'Outputs' do: [ :outputsNode | 
		outputsNode elementsAt: 'Output' do: [ :outputNode | 
			outputNodes add:
				(outputNode elementsAt: 'IDNr') first strings first asInteger
				-> outputNode ] ].
	outputNodes := outputNodes asSortedCollection: [ :less :more | 
		               less key <= more key ].
	(outputNodes collect: #key) asArray
	= (1 to: outputNodes size) asArray ifFalse: [ 
		^ self error: 'Output IDNr should be sequential from 0' ].
	outputNodes do: [ :assoc | self readXMLOutputNode: assoc value ]
]

{ #category : #xml }
FRAMModel >> readXMLPreconditionNode: aPreconditionNode [

	self
		newPreconditionOf:
		(aPreconditionNode elementAt: 'FunctionIDNr') strings first
			asInteger
		named: ((aPreconditionNode elementAt: 'IDName' ifAbsent: [ nil ])
				 ifNotNil: [ :idNameNode | idNameNode strings first ]
				 ifNil: [ '' ])
]

{ #category : #xml }
FRAMModel >> readXMLPreconditionsNode: aFMNode [

	| preconditionNodes |
	preconditionNodes := OrderedCollection new.
	aFMNode elementsAt: 'Preconditions' do: [ :preconditionsNode | 
		preconditionsNode
			elementsAt: 'Precondition'
			do: [ :preconditionNode | 
				preconditionNodes add:
					(preconditionNode elementsAt: 'IDNr') first strings first
						asInteger -> preconditionNode ] ].
	preconditionNodes := preconditionNodes asSortedCollection: [ 
		                     :less 
		                     :more | less key <= more key ].
	(preconditionNodes collect: #key) asArray
	= (1 to: preconditionNodes size) asArray ifFalse: [ 
		^ self error: 'Precondition IDNr should be sequential from 0' ].
	preconditionNodes do: [ :assoc | 
		self readXMLPreconditionNode: assoc value ]
]

{ #category : #xml }
FRAMModel >> readXMLResourceNode: aResourceNode [

	self
		newResourceOf:
		(aResourceNode elementAt: 'FunctionIDNr') strings first asInteger
		named: ((aResourceNode elementAt: 'IDName' ifAbsent: [ nil ])
				 ifNotNil: [ :idNameNode | idNameNode strings first ]
				 ifNil: [ '' ])
]

{ #category : #xml }
FRAMModel >> readXMLResourcesNode: aFMNode [

	| resourceNodes |
	resourceNodes := OrderedCollection new.
	aFMNode elementsAt: 'Resources' do: [ :resourcesNode | 
		resourcesNode elementsAt: 'Resource' do: [ :resourceNode | 
			resourceNodes add:
				(resourceNode elementsAt: 'IDNr') first strings first asInteger
				-> resourceNode ] ].
	resourceNodes := resourceNodes asSortedCollection: [ :less :more | 
		                 less key <= more key ].
	(resourceNodes collect: #key) asArray
	= (1 to: resourceNodes size) asArray ifFalse: [ 
		^ self error: 'Resource IDNr should be sequential from 0' ].
	resourceNodes do: [ :assoc | self readXMLResourceNode: assoc value ]
]

{ #category : #xml }
FRAMModel >> readXMLTimeNode: aTimeNode [

	self
		newTimeOf:
		(aTimeNode elementAt: 'FunctionIDNr') strings first asInteger
		named: ((aTimeNode elementAt: 'IDName' ifAbsent: [ nil ])
				 ifNotNil: [ :idNameNode | idNameNode strings first ]
				 ifNil: [ '' ])
]

{ #category : #xml }
FRAMModel >> readXMLTimesNode: aFMNode [

	| timeNodes |
	timeNodes := OrderedCollection new.
	aFMNode elementsAt: 'Times' do: [ :timesNode | 
		timesNode elementsAt: 'Time' do: [ :timeNode | 
			timeNodes add:
				(timeNode elementsAt: 'IDNr') first strings first asInteger
				-> timeNode ] ].
	timeNodes := timeNodes asSortedCollection: [ :less :more | 
		             less key <= more key ].
	(timeNodes collect: #key) asArray = (1 to: timeNodes size) asArray 
		ifFalse: [ ^ self error: 'Time IDNr should be sequential from 0' ].
	timeNodes do: [ :assoc | self readXMLTimeNode: assoc value ]
]

{ #category : #'accessing-resources' }
FRAMModel >> resourceAt: anInteger ifAbsent: errorBlock [

	^ resources at: anInteger ifAbsent: errorBlock
]

{ #category : #'accessing-resources' }
FRAMModel >> resourceAt: anInteger ifPresent: aBlock [

	^ resources at: anInteger ifPresent: aBlock
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

	^ times at: anInteger ifAbsent: errorBlock
]

{ #category : #'accessing-time' }
FRAMModel >> timeAt: anInteger ifPresent: aBlock [

	^ times at: anInteger ifPresent: aBlock
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

{ #category : #xml }
FRAMModel >> writeXMLFile [

	(UIManager default
		 chooseForSaveFileReference: nil
		 extensions: #( 'xfmv' )
		 path: FileLocator localDirectory / 'no name.xfmv') ifNotNil: [ :ref | 
		self writeXMLFile: ref ]
]

{ #category : #xml }
FRAMModel >> writeXMLFile: aFileReference [

	aFileReference writeStreamDo: [ :stream | self writeXMLOn: stream ]
]

{ #category : #xml }
FRAMModel >> writeXMLOn: aStream [

	(self buildXml: XenqXML) printWithPrologOn: aStream
]
