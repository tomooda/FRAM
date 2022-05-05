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

{ #category : #enumerating }
FRAMModel >> aspectsOf: aFRAMFunctionOrStringOrInteger do: aBlock [

	| id |
	id := aFRAMFunctionOrStringOrInteger isInteger
		      ifTrue: [ aFRAMFunctionOrStringOrInteger ]
		      ifFalse: [ 
			      aFRAMFunctionOrStringOrInteger isString
				      ifTrue: [ 
				      self idOfFunctionNamed: aFRAMFunctionOrStringOrInteger ]
				      ifFalse: [ aFRAMFunctionOrStringOrInteger id ] ].
	{ 
		times.
		inputs.
		outputs.
		preconditions.
		resources.
		times } do: [ :aspects | 
		aspects do: [ :aspect | 
			aspect function = id ifTrue: [ aBlock value: aspect ] ] ]
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

	^ controls
		  detect: [ :control | control id = anInteger ]
		  ifNone: errorBlock
]

{ #category : #'accessing-control' }
FRAMModel >> controlAt: anInteger ifPresent: aBlock [

	^ (controls
		   detect: [ :control | control id = anInteger ]
		   ifNone: [ nil ]) ifNotNil: aBlock
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

{ #category : #enumerating }
FRAMModel >> controlsOf: aFRAMFunctionOrStringOrInteger do: aBlock [

	| id |
	id := aFRAMFunctionOrStringOrInteger isInteger
		      ifTrue: [ aFRAMFunctionOrStringOrInteger ]
		      ifFalse: [ 
			      aFRAMFunctionOrStringOrInteger isString
				      ifTrue: [ 
				      self idOfFunctionNamed: aFRAMFunctionOrStringOrInteger ]
				      ifFalse: [ aFRAMFunctionOrStringOrInteger id ] ].
	controls do: [ :control | 
		control function = id ifTrue: [ aBlock value: control ] ]
]

{ #category : #'accessing-function' }
FRAMModel >> functionAt: anInteger ifAbsent: errorBlock [

	^ functions
		  detect: [ :function | function id = anInteger ]
		  ifNone: errorBlock
]

{ #category : #'accessing-function' }
FRAMModel >> functionAt: anInteger ifPresent: aBlock [

	^ (functions
		   detect: [ :function | function id = anInteger ]
		   ifNone: [ nil ]) ifNotNil: aBlock
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

{ #category : #enumerating }
FRAMModel >> functionsDo: aBlock [

	functions do: aBlock
]

{ #category : #private }
FRAMModel >> idOf: aFRAMComponent [

	^ aFRAMComponent rawId
		  ifNotNil: [ :id | id ]
		  ifNil: [ aFRAMComponent getIdFromModel: self ]
]

{ #category : #'accessing-control' }
FRAMModel >> idOfControl: aFRAMControl [

	^ aFRAMControl rawId ifNotNil: [ :id | id ] ifNil: [ 
		  | ids |
		  ids := (1 to: controls size + 1) asSet.
		  controls do: [ :control | 
			  control rawId ifNotNil: [ :id | ids remove: id ] ].
		  aFRAMControl setId: ids min ]
]

{ #category : #'accessing-control' }
FRAMModel >> idOfControlNamed: aString [

	self controlNamed: aString ifPresent: [ :control | ^ control id ].
	^ KeyNotFound signal: aString
]

{ #category : #'accessing-function' }
FRAMModel >> idOfFunction: aFRAMFunction [

	^ aFRAMFunction rawId ifNotNil: [ :id | id ] ifNil: [ 
		  | ids |
		  ids := (0 to: functions size) asSet.
		  functions do: [ :function | 
			  function rawId ifNotNil: [ :id | ids remove: id ] ].
		  aFRAMFunction setId: ids min ]
]

{ #category : #'accessing-function' }
FRAMModel >> idOfFunctionNamed: aString [

	self functionNamed: aString ifPresent: [ :function | ^ function id ].
	^ KeyNotFound signal: aString
]

{ #category : #'accessing-function' }
FRAMModel >> idOfFunctionNamed: aString ifAbsentNew: errorBlock [

	| newFunc |
	self functionNamed: aString ifPresent: [ :function | ^ function id ].
	newFunc := self newFunctionDo: [ :f | f name: aString ].
	errorBlock cull: newFunc.
	^ newFunc id
]

{ #category : #'accessing-input' }
FRAMModel >> idOfInput: aFRAMInput [

	^ aFRAMInput rawId ifNotNil: [ :id | id ] ifNil: [ 
		  | ids |
		  ids := (1 to: inputs size + 1) asSet.
		  inputs do: [ :input | 
			  input rawId ifNotNil: [ :id | ids remove: id ] ].
		  aFRAMInput setId: ids min ]
]

{ #category : #'accessing-input' }
FRAMModel >> idOfInputNamed: aString [

	self inputNamed: aString ifPresent: [ :input | ^ input id ].
	^ KeyNotFound signal: aString
]

{ #category : #'accessing-output' }
FRAMModel >> idOfOutput: aFRAMOutput [

	^ aFRAMOutput rawId ifNotNil: [ :id | id ] ifNil: [ 
		  | ids |
		  ids := (1 to: outputs size + 1) asSet.
		  outputs do: [ :output | 
			  output rawId ifNotNil: [ :id | ids remove: id ] ].
		  aFRAMOutput setId: ids min ]
]

{ #category : #'accessing-output' }
FRAMModel >> idOfOutputNamed: aString [

	self outputNamed: aString ifPresent: [ :output | ^ output id ].
	^ KeyNotFound signal: aString
]

{ #category : #'accessing-precondition' }
FRAMModel >> idOfPrecondition: aFRAMPrecondition [

	^ aFRAMPrecondition rawId ifNotNil: [ :id | id ] ifNil: [ 
		  | ids |
		  ids := (1 to: preconditions size + 1) asSet.
		  preconditions do: [ :precondition | 
			  precondition rawId ifNotNil: [ :id | ids remove: id ] ].
		  aFRAMPrecondition setId: ids min ]
]

{ #category : #'accessing-precondition' }
FRAMModel >> idOfPreconditionNamed: aString [

	self
		preconditionNamed: aString
		ifPresent: [ :precondition | ^ precondition id ].
	^ KeyNotFound signal: aString
]

{ #category : #'accessing-resources' }
FRAMModel >> idOfResource: aFRAMResource [

	^ aFRAMResource rawId ifNotNil: [ :id | id ] ifNil: [ 
		  | ids |
		  ids := (1 to: resources size + 1) asSet.
		  resources do: [ :resource | 
			  resource rawId ifNotNil: [ :id | ids remove: id ] ].
		  aFRAMResource setId: ids min ]
]

{ #category : #'accessing-resources' }
FRAMModel >> idOfResourceNamed: aString [

	self resourceNamed: aString ifPresent: [ :resource | ^ resource id ].
	^ KeyNotFound signal: aString
]

{ #category : #'accessing-time' }
FRAMModel >> idOfTime: aFRAMTime [

	^ aFRAMTime rawId ifNotNil: [ :id | id ] ifNil: [ 
		  | ids |
		  ids := (1 to: times size + 1) asSet.
		  times do: [ :time | time rawId ifNotNil: [ :id | ids remove: id ] ].
		  aFRAMTime setId: ids min ]
]

{ #category : #'accessing-time' }
FRAMModel >> idOfTimeNamed: aString [

	self timeNamed: aString ifPresent: [ :time | ^ time id ].
	^ KeyNotFound signal: aString
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

	^ inputs detect: [ :input | input id = anInteger ] ifNone: errorBlock
]

{ #category : #'accessing-input' }
FRAMModel >> inputAt: anInteger ifPresent: aBlock [

	^ (inputs detect: [ :input | input id = anInteger ] ifNone: [ nil ]) 
		  ifNotNil: aBlock
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

{ #category : #enumerating }
FRAMModel >> inputsOf: aFRAMFunctionOrStringOrInteger do: aBlock [

	| id |
	id := aFRAMFunctionOrStringOrInteger isInteger
		      ifTrue: [ aFRAMFunctionOrStringOrInteger ]
		      ifFalse: [ 
			      aFRAMFunctionOrStringOrInteger isString
				      ifTrue: [ 
				      self idOfFunctionNamed: aFRAMFunctionOrStringOrInteger ]
				      ifFalse: [ aFRAMFunctionOrStringOrInteger id ] ].
	inputs do: [ :input | 
		input function = id ifTrue: [ aBlock value: input ] ]
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

	^ outputs
		  detect: [ :output | output id = anInteger ]
		  ifNone: errorBlock
]

{ #category : #'accessing-output' }
FRAMModel >> outputAt: anInteger ifPresent: aBlock [

	^ (outputs
		   detect: [ :output | output id = anInteger ]
		   ifNone: [ nil ]) ifNotNil: aBlock
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

{ #category : #enumerating }
FRAMModel >> outputsOf: aFRAMFunctionOrStringOrInteger do: aBlock [

	| id |
	id := aFRAMFunctionOrStringOrInteger isInteger
		      ifTrue: [ aFRAMFunctionOrStringOrInteger ]
		      ifFalse: [ 
			      aFRAMFunctionOrStringOrInteger isString
				      ifTrue: [ 
				      self idOfFunctionNamed: aFRAMFunctionOrStringOrInteger ]
				      ifFalse: [ aFRAMFunctionOrStringOrInteger id ] ].
	outputs do: [ :output | 
		output function = id ifTrue: [ aBlock value: output ] ]
]

{ #category : #'accessing-precondition' }
FRAMModel >> preconditionAt: anInteger ifAbsent: errorBlock [

	^ preconditions
		  detect: [ :precondition | precondition id = anInteger ]
		  ifNone: errorBlock
]

{ #category : #'accessing-precondition' }
FRAMModel >> preconditionAt: anInteger ifPresent: aBlock [

	^ (preconditions
		   detect: [ :precondition | precondition id = anInteger ]
		   ifNone: [ nil ]) ifNotNil: aBlock
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

{ #category : #enumerating }
FRAMModel >> preconditionsOf: aFRAMFunctionOrStringOrInteger do: aBlock [

	| id |
	id := aFRAMFunctionOrStringOrInteger isInteger
		      ifTrue: [ aFRAMFunctionOrStringOrInteger ]
		      ifFalse: [ 
			      aFRAMFunctionOrStringOrInteger isString
				      ifTrue: [ 
				      self idOfFunctionNamed: aFRAMFunctionOrStringOrInteger ]
				      ifFalse: [ aFRAMFunctionOrStringOrInteger id ] ].
	preconditions do: [ :precondition | 
		precondition function = id ifTrue: [ aBlock value: precondition ] ]
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

	(self
		 newControlOf:
		 (aControlNode elementAt: 'FunctionIDNr') strings first asInteger
		 named: ((aControlNode elementAt: 'IDName' ifAbsent: [ nil ])
				  ifNotNil: [ :idNameNode | idNameNode strings first ]
				  ifNil: [ '' ])) setId:
		(aControlNode elementAt: 'IDNr') strings first asInteger
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
	controlNodes do: [ :assoc | self readXMLControlNode: assoc value ]
]

{ #category : #xml }
FRAMModel >> readXMLFunctionNode: aFunctionNode [

	self newFunctionDo: [ :function | 
		(aFunctionNode elementAt: 'IDName' ifAbsent: [ nil ]) ifNotNil: [ 
			:nameNode | function name: nameNode strings first ].
		(aFunctionNode elementAt: 'IDNr' ifAbsent: [ nil ]) ifNotNil: [ 
			:idNode | function setId: idNode strings first asInteger ].
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
	functionNodes do: [ :assoc | self readXMLFunctionNode: assoc value ]
]

{ #category : #xml }
FRAMModel >> readXMLInputNode: anInputNode [

	(self
		 newInputOf:
		 (anInputNode elementAt: 'FunctionIDNr') strings first asInteger
		 named: ((anInputNode elementAt: 'IDName' ifAbsent: [ nil ])
				  ifNotNil: [ :idNameNode | idNameNode strings first ]
				  ifNil: [ '' ])) setId:
		(anInputNode elementAt: 'IDNr') strings first asInteger
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
	inputNodes do: [ :assoc | self readXMLInputNode: assoc value ]
]

{ #category : #xml }
FRAMModel >> readXMLOutputNode: anOutputNode [

	(self
		 newOutputOf:
		 (anOutputNode elementAt: 'FunctionIDNr') strings first asInteger
		 named: ((anOutputNode elementAt: 'IDName' ifAbsent: [ nil ])
				  ifNotNil: [ :idNameNode | idNameNode strings first ]
				  ifNil: [ '' ])) setId:
		(anOutputNode elementAt: 'IDNr') strings first asInteger
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
	outputNodes do: [ :assoc | self readXMLOutputNode: assoc value ]
]

{ #category : #xml }
FRAMModel >> readXMLPreconditionNode: aPreconditionNode [

	(self
		 newPreconditionOf:
		 (aPreconditionNode elementAt: 'FunctionIDNr') strings first
			 asInteger
		 named: ((aPreconditionNode elementAt: 'IDName' ifAbsent: [ nil ])
				  ifNotNil: [ :idNameNode | idNameNode strings first ]
				  ifNil: [ '' ])) setId:
		(aPreconditionNode elementAt: 'IDNr') strings first asInteger
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
	preconditionNodes do: [ :assoc | 
		self readXMLPreconditionNode: assoc value ]
]

{ #category : #xml }
FRAMModel >> readXMLResourceNode: aResourceNode [

	(self
		 newResourceOf:
		 (aResourceNode elementAt: 'FunctionIDNr') strings first asInteger
		 named: ((aResourceNode elementAt: 'IDName' ifAbsent: [ nil ])
				  ifNotNil: [ :idNameNode | idNameNode strings first ]
				  ifNil: [ '' ])) setId:
		(aResourceNode elementAt: 'IDNr') strings first asInteger
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
	resourceNodes do: [ :assoc | self readXMLResourceNode: assoc value ]
]

{ #category : #xml }
FRAMModel >> readXMLTimeNode: aTimeNode [

	(self
		 newTimeOf:
		 (aTimeNode elementAt: 'FunctionIDNr') strings first asInteger
		 named: ((aTimeNode elementAt: 'IDName' ifAbsent: [ nil ])
				  ifNotNil: [ :idNameNode | idNameNode strings first ]
				  ifNil: [ '' ])) setId:
		(aTimeNode elementAt: 'IDNr') strings first asInteger
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
	timeNodes do: [ :assoc | self readXMLTimeNode: assoc value ]
]

{ #category : #'accessing-resources' }
FRAMModel >> resourceAt: anInteger ifAbsent: errorBlock [

	^ resources
		  detect: [ :resource | resource id = anInteger ]
		  ifNone: errorBlock
]

{ #category : #'accessing-resources' }
FRAMModel >> resourceAt: anInteger ifPresent: aBlock [

	^ (resources
		   detect: [ :resource | resource id = anInteger ]
		   ifNone: [ nil ]) ifNotNil: aBlock
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

{ #category : #enumerating }
FRAMModel >> resourcesOf: aFRAMFunctionOrStringOrInteger do: aBlock [

	| id |
	id := aFRAMFunctionOrStringOrInteger isInteger
		      ifTrue: [ aFRAMFunctionOrStringOrInteger ]
		      ifFalse: [ 
			      aFRAMFunctionOrStringOrInteger isString
				      ifTrue: [ 
				      self idOfFunctionNamed: aFRAMFunctionOrStringOrInteger ]
				      ifFalse: [ aFRAMFunctionOrStringOrInteger id ] ].
	resources do: [ :resource | 
		resource function = id ifTrue: [ aBlock value: resource ] ]
]

{ #category : #'accessing-time' }
FRAMModel >> timeAt: anInteger ifAbsent: errorBlock [

	^ times detect: [ :time | time id = anInteger ] ifNone: errorBlock
]

{ #category : #'accessing-time' }
FRAMModel >> timeAt: anInteger ifPresent: aBlock [

	^ (times detect: [ :time | time id = anInteger ] ifNone: [ nil ]) 
		  ifNotNil: aBlock
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

{ #category : #enumerating }
FRAMModel >> timesOf: aFRAMFunctionOrStringOrInteger do: aBlock [

	| id |
	id := aFRAMFunctionOrStringOrInteger isInteger
		      ifTrue: [ aFRAMFunctionOrStringOrInteger ]
		      ifFalse: [ 
			      aFRAMFunctionOrStringOrInteger isString
				      ifTrue: [ 
				      self idOfFunctionNamed: aFRAMFunctionOrStringOrInteger ]
				      ifFalse: [ aFRAMFunctionOrStringOrInteger id ] ].
	times do: [ :time | 
		time function = id ifTrue: [ aBlock value: time ] ]
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
