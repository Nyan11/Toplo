Class {
	#name : #ToWindowLook,
	#superclass : #ToDefaultElementLook,
	#instVars : [
		'installAction',
		'openAction',
		'closeAction',
		'disabledAction',
		'initialAction'
	],
	#category : #'Toplo-Core-Theme-Looks'
}

{ #category : #accessing }
ToWindowLook >> closeAction [

	^ closeAction
]

{ #category : #accessing }
ToWindowLook >> closeAction: aValuable [

	closeAction := aValuable
]

{ #category : #'event handling' }
ToWindowLook >> closeLookEvent: anEvent [

	super closeLookEvent: anEvent.		
	anEvent elementDo: [ :e |
		self closeAction ifNotNil: [ :a | a value: e ] ]
]

{ #category : #accessing }
ToWindowLook >> disabledAction [

	^ disabledAction
]

{ #category : #accessing }
ToWindowLook >> disabledAction: aValuable [

	disabledAction := aValuable
]

{ #category : #'event handling' }
ToWindowLook >> disabledLookEvent: anEvent [

	super disabledLookEvent: anEvent.		
	anEvent elementDo: [ :e |
		self disabledAction ifNotNil: [ :a | a value: e ] ]
]

{ #category : #accessing }
ToWindowLook >> initialAction [

	^ initialAction
]

{ #category : #accessing }
ToWindowLook >> initialAction: aValuable [

	initialAction := aValuable
]

{ #category : #'event handling' }
ToWindowLook >> initialLookEvent: anEvent [

	super initialLookEvent: anEvent.		
	anEvent elementDo: [ :e |
		self initialAction ifNotNil: [ :a | a value: e ] ]
]

{ #category : #accessing }
ToWindowLook >> installAction [

	^ installAction
]

{ #category : #accessing }
ToWindowLook >> installAction: aValuable [

	installAction := aValuable
]

{ #category : #'event handling' }
ToWindowLook >> installLookEvent: anEvent [

	super installLookEvent: anEvent.		
	anEvent elementDo: [ :e |
		self installAction ifNotNil: [ :a | a value: e ] ]
]

{ #category : #accessing }
ToWindowLook >> openAction [

	^ openAction
]

{ #category : #accessing }
ToWindowLook >> openAction: aValuable [

	openAction := aValuable
]

{ #category : #'event handling' }
ToWindowLook >> openLookEvent: anEvent [

	super openLookEvent: anEvent.		
	anEvent elementDo: [ :e |
		self openAction ifNotNil: [ :a | a value: e ] ]
]
