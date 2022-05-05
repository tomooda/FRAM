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

{ #category : #accessing }
FRAMTime >> aspect [

	^ 'Time'
]

{ #category : #accessing }
FRAMTime >> getIdFromModel: aFRAMModel [

	^ aFRAMModel idOfTime: self
]

{ #category : #xml }
FRAMTime >> xmlElement [

	^ 'Time'
]
