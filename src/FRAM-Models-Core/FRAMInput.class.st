Class {
	#name : #FRAMInput,
	#superclass : #FRAMAspect,
	#category : #'FRAM-Models-Core'
}

{ #category : #xml }
FRAMInput >> IDNr [

	^ model idOfInput: self
]

{ #category : #private }
FRAMInput >> addedTo: aFRAMModel [

	aFRAMModel addInput: self
]

{ #category : #accessing }
FRAMInput >> aspect [

	^ 'Input'
]

{ #category : #accessing }
FRAMInput >> getIdFromModel: aFRAMModel [

	^ aFRAMModel idOfInput: self
]

{ #category : #xml }
FRAMInput >> xmlElement [

	^ 'Input'
]
