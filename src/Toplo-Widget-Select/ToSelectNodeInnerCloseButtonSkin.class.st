Class {
	#name : #ToSelectNodeInnerCloseButtonSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Select'
}

{ #category : #'event handling' }
ToSelectNodeInnerCloseButtonSkin >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	anEvent elementDo: [ :e | 
		e mouseCursor: BlCursor hand.
		e border: (Color red alpha: 0.5) ]
]

{ #category : #'event handling' }
ToSelectNodeInnerCloseButtonSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e vFitContent.
		e geometry: BlCircleGeometry new.
		e border: BlBorder empty.
		e padding: BlInsets empty ]
]

{ #category : #'event handling' }
ToSelectNodeInnerCloseButtonSkin >> leavedLookEvent: anEvent [

	super leavedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e mouseCursor: BlCursor default.
		e border: BlBorder empty ]
]