Class {
	#name : #FRAMPrecondition,
	#superclass : #FRAMAspect,
	#category : #'FRAM-Models-Core'
}

{ #category : #xml }
FRAMPrecondition >> IDNr [

	^ model idOfPrecondition: self
]

{ #category : #private }
FRAMPrecondition >> addedTo: aFRAMModel [

	aFRAMModel addPrecondition: self
]

{ #category : #accessing }
FRAMPrecondition >> id [

	^ model idOfPrecondition: self
]

{ #category : #xml }
FRAMPrecondition >> xmlElement [

	^ 'Precondition'
]
