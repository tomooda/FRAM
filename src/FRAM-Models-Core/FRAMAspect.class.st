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
FRAMAspect >> buildXmlIDNr: aXenq [

	^ aXenq
		  addElement: 'FunctionIDNr'
		  with: [ :functionIdNr | 
		  functionIdNr addText: function printString ]
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
