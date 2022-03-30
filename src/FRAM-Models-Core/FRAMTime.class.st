Class {
	#name : #FRAMTime,
	#superclass : #FRAMAspect,
	#category : #'FRAM-Models-Core'
}

{ #category : #xml }
FRAMTime >> IDNr [

	^ model idOfTime: self
]

{ #category : #private }
FRAMTime >> addedTo: aFRAMModel [

	aFRAMModel addTime: self
]
