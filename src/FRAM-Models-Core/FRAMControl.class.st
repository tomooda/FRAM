Class {
	#name : #FRAMControl,
	#superclass : #FRAMAspect,
	#category : #'FRAM-Models-Core'
}

{ #category : #xml }
FRAMControl >> IDNr [

	^ model idOfControl: self
]

{ #category : #private }
FRAMControl >> addedTo: aFRAMModel [

	aFRAMModel addControl: self
]

{ #category : #accessing }
FRAMControl >> id [

	^ model idOfControl: self
]

{ #category : #xml }
FRAMControl >> xmlElement [

	^ 'Control'
]