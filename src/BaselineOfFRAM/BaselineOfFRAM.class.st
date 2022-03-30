Class {
	#name : #BaselineOfFRAM,
	#superclass : #BaselineOf,
	#category : #BaselineOfFRAM
}

{ #category : #baselines }
BaselineOfFRAM >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		spec
			baseline: 'Xenq'
			with: [ spec repository: 'github://tomooda/Xenq:main/src' ];
			baseline: 'XMLParser'
			with: [ 
				spec repository: 'github://pharo-contributions/XML-XMLParser/src' ].

		spec
			package: 'FRAM-Models-Core' with: [ spec requires: #( 'Xenq' ) ];
			package: 'FRAM-Models-Tests'
			with: [ spec requires: #( 'FRAM-Models-Core' ) ].
		spec
			group: 'core' with: #( 'FRAM-Models-Core' );
			group: 'tests' with: #( 'FRAM-Models-Tests' );
			group: 'full' with: #( 'core' 'tests' );
			group: 'default' with: #( 'full' ) ]
]
