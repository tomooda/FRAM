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
FRAMResource >> id [

	^ model idOfResource: self
]

{ #category : #xml }
FRAMResource >> xmlElement [

	^ 'Resource'
]
