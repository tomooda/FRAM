Class {
	#name : #FRAMOutput,
	#superclass : #FRAMAspect,
	#category : #'FRAM-Models-Core'
}

{ #category : #xml }
FRAMOutput >> IDNr [

	^ model idOfOutput: self
]

{ #category : #private }
FRAMOutput >> addedTo: aFRAMModel [

	aFRAMModel addOutput: self
]

{ #category : #accessing }
FRAMOutput >> aspect [

	^ 'Output'
]

{ #category : #accessing }
FRAMOutput >> getIdFromModel: aFRAMModel [

	^ aFRAMModel idOfOutput: self
]

{ #category : #xml }
FRAMOutput >> xmlElement [

	^ 'Output'
]
