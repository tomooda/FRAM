Class {
	#name : #FRAMComponent,
	#superclass : #Object,
	#instVars : [
		'model',
		'name',
		'id'
	],
	#category : #'FRAM-Models-Core'
}

{ #category : #xml }
FRAMComponent >> IDNr [

	^ self subclassResponsibility
]

{ #category : #private }
FRAMComponent >> addedTo: aFRAMModel [
	^ self subclassResponsibility
]

{ #category : #xml }
FRAMComponent >> buildXml: aXenq [

	^ self subclassResponsibility
]

{ #category : #xml }
FRAMComponent >> buildXmlIDName: aXenq [

	^ aXenq addElement: 'IDName' with: [ :idname | idname addText: name ]
]

{ #category : #xml }
FRAMComponent >> buildXmlIDNr: aXenq [

	^ aXenq
		  addElement: 'IDNr'
		  with: [ :idname | idname addText: self IDNr asString ]
]

{ #category : #accessing }
FRAMComponent >> getIdFromModel: aFRAMModel [
	^ self subclassResponsibility
]

{ #category : #accessing }
FRAMComponent >> id [

	^ id ifNil: [ model idOf: self ]
]

{ #category : #initialization }
FRAMComponent >> initialize [

	super initialize.
	name := '' copy
]

{ #category : #testing }
FRAMComponent >> isAspect [

	^ false
]

{ #category : #testing }
FRAMComponent >> isControl [

	^ false
]

{ #category : #testing }
FRAMComponent >> isFunction [

	^ false
]

{ #category : #testing }
FRAMComponent >> isInput [

	^ false
]

{ #category : #testing }
FRAMComponent >> isOutput [

	^ false
]

{ #category : #testing }
FRAMComponent >> isPrecondition [

	^ false
]

{ #category : #testing }
FRAMComponent >> isResource [

	^ false
]

{ #category : #testing }
FRAMComponent >> isTime [

	^ false
]

{ #category : #accessing }
FRAMComponent >> model [

	^ model
]

{ #category : #accessing }
FRAMComponent >> name [

	^ name
]

{ #category : #accessing }
FRAMComponent >> name: aString [

	name := aString
]

{ #category : #printing }
FRAMComponent >> printOn: aStream [

	aStream
		nextPutAll: self class name;
		nextPut: $(;
		nextPutAll: name asString;
		nextPutAll: ') '
]

{ #category : #private }
FRAMComponent >> rawId [
	^ id
]

{ #category : #private }
FRAMComponent >> setId: anInteger [

	^ id ifNil: [ id := anInteger ]
]

{ #category : #private }
FRAMComponent >> setModel: aFRAMModel [

	model := aFRAMModel.
	self addedTo: aFRAMModel
]
