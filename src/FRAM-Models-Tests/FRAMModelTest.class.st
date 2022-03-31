Class {
	#name : #FRAMModelTest,
	#superclass : #TestCase,
	#instVars : [
		'model',
		'function0'
	],
	#category : #'FRAM-Models-Tests'
}

{ #category : #running }
FRAMModelTest >> setUp [

	super setUp.
	model := FRAMModel new.
	function0 := model newFunctionDo: [ :f | 
		             f
			             name: 'book a hotel';
			             beHuman;
			             yourself ]
]

{ #category : #tests }
FRAMModelTest >> testAddControl [

	| control |
	control := FRAMControl new.
	model addControl: control.
	self assert: (model controls includes: control)
]

{ #category : #tests }
FRAMModelTest >> testAddFunction [

	| function |
	function := FRAMFunction new.
	model addFunction: function.
	self assert: (model functions includes: function)
]

{ #category : #tests }
FRAMModelTest >> testAddInput [

	| input |
	input := FRAMInput new.
	model addInput: input.
	self assert: (model inputs includes: input)
]

{ #category : #tests }
FRAMModelTest >> testAddOutput [

	| output |
	output := FRAMOutput new.
	model addOutput: output.
	self assert: (model outputs includes: output)
]

{ #category : #tests }
FRAMModelTest >> testAddPrecondition [

	| precondition |
	precondition := FRAMPrecondition new.
	model addPrecondition: precondition.
	self assert: (model preconditions includes: precondition)
]

{ #category : #tests }
FRAMModelTest >> testAddResource [

	| resource |
	resource := FRAMResource new.
	model addResource: resource.
	self assert: (model resources includes: resource)
]

{ #category : #tests }
FRAMModelTest >> testAddTime [

	| time |
	time := FRAMTime new.
	model addTime: time.
	self assert: (model times includes: time)
]

{ #category : #tests }
FRAMModelTest >> testNewControlOfNamed [

	| name c |
	name := 'business trip workflow'.
	c := model newControlOf: function0 named: name.
	self assert: (model controls includes: c).
	self assert: c id equals: 1.
	self assert: c name equals: name
]

{ #category : #tests }
FRAMModelTest >> testNewFunctionDo [

	| function |
	function := model newFunctionDo: [ :f | 
		            f
			            name: 'book a flight';
			            yourself ].
	self assert: (model functions includes: function)
]

{ #category : #tests }
FRAMModelTest >> testNewFunctionNamed [

	| name function |
	name := 'book a flight'.
	function := model newFunctionNamed: name.
	self assert: (model functions includes: function).
	self assert: function name equals: name
]

{ #category : #tests }
FRAMModelTest >> testNewInputOfNamed [

	| name i |
	name := 'travel plan'.
	i := model newInputOf: function0 named: name.
	self assert: (model inputs includes: i).
	self assert: i id equals: 1.
	self assert: i name equals: name
]

{ #category : #tests }
FRAMModelTest >> testNewOutputOfNamed [

	| name o |
	name := 'travel plan'.
	o := model newOutputOf: function0 named: name.
	self assert: (model outputs includes: o).
	self assert: o id equals: 1.
	self assert: o name equals: name
]

{ #category : #tests }
FRAMModelTest >> testNewPreconditionOfNamed [

	| name p |
	name := 'product schedule'.
	p := model newPreconditionOf: function0 named: name.
	self assert: (model preconditions includes: p).
	self assert: p id equals: 1.
	self assert: p name equals: name
]

{ #category : #tests }
FRAMModelTest >> testNewResourceOfNamed [

	| name r |
	name := 'product schedule'.
	r := model newResourceOf: function0 named: name.
	self assert: (model resources includes: r).
	self assert: r id equals: 1.
	self assert: r name equals: name
]

{ #category : #tests }
FRAMModelTest >> testNewTimeOfNamed [

	| name t |
	name := 'product schedule'.
	t := model newTimeOf: function0 named: name.
	self assert: (model times includes: t).
	self assert: t id equals: 1.
	self assert: t name equals: name
]
