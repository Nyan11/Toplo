Class {
	#name : 'ToPressedLookEvent',
	#superclass : 'ToElementLookEvent',
	#category : 'Toplo-Core-LookEvents',
	#package : 'Toplo',
	#tag : 'Core-LookEvents'
}

{ #category : 'sending' }
ToPressedLookEvent >> sendTo: anObject [

	anObject pressedLookEvent: self
]