Class {
	#name : #ToHoveredState,
	#superclass : #ToElementState,
	#category : #'Toplo-Theme-State'
}

{ #category : #'look event sending' }
ToHoveredState >> applyOn: anElement [

	anElement dispatchLookEvent: ToHoveredLookEvent new
]

{ #category : #testing }
ToHoveredState >> isHoveredState [

	^ true
]