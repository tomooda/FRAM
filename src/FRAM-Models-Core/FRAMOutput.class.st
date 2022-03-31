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
FRAMOutput >> id [

	^ model idOfOutput: self
]

{ #category : #xml }
FRAMOutput >> xmlElement [

	^ 'Output'
]
