Class {
	#name : #FRAMModelTest,
	#superclass : #TestCase,
	#instVars : [
		'model'
	],
	#category : #'FRAM-Models-Tests'
}

{ #category : #running }
FRAMModelTest >> setUp [

	super setUp.
	model := FRAMModel new
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
FRAMModelTest >> testNewControlDo [

	| c |
	c := model newControlDo: [ :control | 
		     control
			     name: 'business trip workflow';
			     yourself ].
	self assert: (model controls includes: c)
]

{ #category : #tests }
FRAMModelTest >> testNewInputDo [

	| i |
	i := model newInputDo: [ :input | 
		     input
			     name: 'travel plan';
			     yourself ].
	self assert: (model inputs includes: i)
]

{ #category : #tests }
FRAMModelTest >> testNewOutputDo [

	| o |
	o := model newOutputDo: [ :output | 
		     output
			     name: 'travel plan';
			     yourself ].
	self assert: (model outputs includes: o)
]

{ #category : #tests }
FRAMModelTest >> testNewPreconditionDo [

	| p |
	p := model newPreconditionDo: [ :precondition | 
		     precondition
			     name: 'product schedule';
			     yourself ].
	self assert: (model preconditions includes: p)
]

{ #category : #tests }
FRAMModelTest >> testNewResourceDo [

	| r |
	r := model newResourceDo: [ :resource | 
		     resource
			     name: 'product schedule';
			     yourself ].
	self assert: (model resources includes: r)
]

{ #category : #tests }
FRAMModelTest >> testNewTimeDo [

	| t |
	t := model newTimeDo: [ :time | 
		     time
			     name: 'product schedule';
			     yourself ].
	self assert: (model times includes: t)
]
