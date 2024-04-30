Class {
	#name : 'BaselineOfFRAM',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfFRAM',
	#package : 'BaselineOfFRAM'
}

{ #category : 'baselines' }
BaselineOfFRAM >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec
			baseline: 'Xenq'
			with: [ spec repository: 'github://tomooda/Xenq:main/src' ].

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
