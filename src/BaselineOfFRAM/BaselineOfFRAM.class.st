Class {
	#name : #BaselineOfFRAM,
	#superclass : #BaselineOf,
	#category : #BaselineOfFRAM
}

{ #category : #baselines }
BaselineOfFRAM >> baseline: spec [

	<baseline>
	spec for: #common do: [ spec package: 'FRAM-Models-Core' ]
]
