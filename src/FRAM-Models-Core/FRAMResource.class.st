Class {
	#name : #FRAMResource,
	#superclass : #FRAMAspect,
	#category : #'FRAM-Models-Core'
}

{ #category : #xml }
FRAMResource >> IDNr [

	^ model idOfResource: self
]

{ #category : #private }
FRAMResource >> addedTo: aFRAMModel [

	aFRAMModel addResource: self
]

{ #category : #accessing }
FRAMResource >> aspect [

	^ 'Resource'
]

{ #category : #accessing }
FRAMResource >> getIdFromModel: aFRAMModel [

	^ aFRAMModel idOfResource: self
]

{ #category : #xml }
FRAMResource >> xmlElement [

	^ 'Resource'
]
