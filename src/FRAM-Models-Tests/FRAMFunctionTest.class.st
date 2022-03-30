Class {
	#name : #FRAMFunctionTest,
	#superclass : #TestCase,
	#instVars : [
		'model',
		'function0',
		'function1'
	],
	#category : #'FRAM-Models-Tests'
}

{ #category : #running }
FRAMFunctionTest >> setUp [

	super setUp.
	model := FRAMModel new.
	function0 := model newFunctionDo: [ :f | f name: 'function0' ].
	function1 := model newFunctionDo: [ :f | f name: 'function1' ]
]

{ #category : #tests }
FRAMFunctionTest >> testBeBackground [

	function0 beBackground.
	self assert: function0 isBackground.
	self deny: function0 isForeground.
	self deny: function0 isForegroundVariable
]

{ #category : #tests }
FRAMFunctionTest >> testBeForeground [

	function0 beForeground.
	self deny: function0 isBackground.
	self assert: function0 isForeground.
	self deny: function0 isForegroundVariable
]

{ #category : #tests }
FRAMFunctionTest >> testBeForegroundVariable [

	function0 beForegroundVariable.
	self deny: function0 isBackground.
	self deny: function0 isForeground.
	self assert: function0 isForegroundVariable
]

{ #category : #tests }
FRAMFunctionTest >> testBeHuman [

	function0 beHuman.
	self deny: function0 isUndefined.
	self deny: function0 isOrganisational.
	self assert: function0 isHuman.
	self deny: function0 isInterface.
	self deny: function0 isTechnological
]

{ #category : #tests }
FRAMFunctionTest >> testBeInterface [

	function0 beInterface.
	self deny: function0 isUndefined.
	self deny: function0 isOrganisational.
	self deny: function0 isHuman.
	self assert: function0 isInterface.
	self deny: function0 isTechnological
]

{ #category : #tests }
FRAMFunctionTest >> testBeOrganisational [

	function0 beOrganisational.
	self deny: function0 isUndefined.
	self assert: function0 isOrganisational.
	self deny: function0 isHuman.
	self deny: function0 isInterface.
	self deny: function0 isTechnological
]

{ #category : #tests }
FRAMFunctionTest >> testBeTechnological [

	function0 beTechnological.
	self deny: function0 isUndefined.
	self deny: function0 isOrganisational.
	self deny: function0 isHuman.
	self deny: function0 isInterface.
	self assert: function0 isTechnological
]

{ #category : #tests }
FRAMFunctionTest >> testBeUndefined [

	function0 beUndefined.
	self assert: function0 isUndefined.
	self deny: function0 isOrganisational.
	self deny: function0 isHuman.
	self deny: function0 isInterface.
	self deny: function0 isTechnological	
]

{ #category : #tests }
FRAMFunctionTest >> testBuildXml [

	| xml tags |
	function0
		name: 'blah';
		beBackground;
		description: 'whatever'.
	xml := function0 buildXml: XenqXML.
	self assert: xml name equals: 'Function'.
	tags := OrderedCollection new.
	xml childrenDo: [ :element | 
		| tag |
		tag := element name.
		tags add: tag.
		tag = 'IDNr' ifTrue: [ 
			self assert: (element hasOnlyTextElement: '0') ].
		tag = 'FunctionType' ifTrue: [ 
			self assert: (element hasOnlyTextElement: '2') ].
		tag = 'IDName' ifTrue: [ 
			self assert: (element hasOnlyTextElement: 'blah') ].
		tag = 'Description' ifTrue: [ 
			self assert: (element hasOnlyTextElement: 'whatever') ] ].
	self
		assertCollection: tags
		hasSameElements: #( 'IDNr' 'FunctionType' 'IDName' 'Description' )
]

{ #category : #tests }
FRAMFunctionTest >> testColor [

	function0 color: Color yellow.
	self assert: function0 color equals: Color yellow.
	function0 color: 'yellow'.
	self assert: function0 color equals: Color yellow.
	function1 color: 255 asString.
	self assert: function1 color equals: Color blue.
	function1 color: (255 * 256) asString.
	self assert: function1 color equals: Color green.
	function1 color: (255 * 256 * 256) asString.
	self assert: function1 color equals: Color red
]

{ #category : #tests }
FRAMFunctionTest >> testDescription [

	function0 description: 'blah'.
	self assert: function0 description equals: 'blah'
]

{ #category : #tests }
FRAMFunctionTest >> testIDNr [

	self assert: function0 IDNr equals: 0.
	self assert: function1 IDNr equals: 1
]

{ #category : #tests }
FRAMFunctionTest >> testId [

	self assert: function0 id equals: 0.
	self assert: function1 id equals: 1
]
