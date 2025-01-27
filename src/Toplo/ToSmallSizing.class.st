Class {
	#name : #ToSmallSizing,
	#superclass : #ToControlSizing,
	#category : #'Toplo-Core-Theme-skins'
}

{ #category : #'private geometry' }
ToSmallSizing >> applyOn: anElement [

	anElement skinDo: [ :s | s applySmallSizing: self on: anElement ]
]

{ #category : #'private geometry' }
ToSmallSizing >> heightOn: anElement [

	^ anElement smallHeight
]

{ #category : #'private geometry' }
ToSmallSizing >> shapingRadiusIn: anElement [

		^ anElement toTheme borderRadiusSM
]
