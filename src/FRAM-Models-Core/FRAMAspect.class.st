Class {
	#name : #FRAMAspect,
	#superclass : #FRAMComponent,
	#instVars : [
		'function'
	],
	#category : #'FRAM-Models-Core'
}

{ #category : #testing }
FRAMAspect class >> isAbstract [

	^ self = FRAMAspect
]

{ #category : #'instance creation' }
FRAMAspect class >> on: aFRAMModel [

	^ self new
		  setModel: aFRAMModel;
		  yourself
]

{ #category : #xml }
FRAMAspect >> buildXml: aXenq [

	^ aXenq addElement: self xmlElement with: [ :aspect | 
		  self
			  buildXmlIDNr: aspect;
			  buildXmlIDName: aspect.
		  aspect
			  addElement: 'FunctionIDNr'
			  with: [ :functionId | functionId addText: function ] ]
]

{ #category : #accessing }
FRAMAspect >> function [

	^ function
]

{ #category : #accessing }
FRAMAspect >> function: aFRAMFunctionOrStringOrInteger [

	function := aFRAMFunctionOrStringOrInteger isInteger
		            ifTrue: [ aFRAMFunctionOrStringOrInteger ]
		            ifFalse: [ 
			            aFRAMFunctionOrStringOrInteger isString
				            ifTrue: [ 
				            model idOfFunctionNamed:
					            aFRAMFunctionOrStringOrInteger ]
				            ifFalse: [ 
				            model idOfFunction: aFRAMFunctionOrStringOrInteger ] ]
]

{ #category : #testing }
FRAMAspect >> isAspect [

	^ true
]

{ #category : #xml }
FRAMAspect >> xmlElement [

	^ self subclassResponsibility
]
