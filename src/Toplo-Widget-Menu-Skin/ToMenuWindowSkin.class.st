Class {
	#name : #ToMenuWindowSkin,
	#superclass : #ToWidgetSkin,
	#category : #'Toplo-Widget-Menu-Skin'
}

{ #category : #'api - install/uninstall  hook' }
ToMenuWindowSkin >> checkItemsIn: aMenuWindow [

	" check items alignement (based on the icon) 
		if any items has an icon then add an icon to all items with missing icon "
	(aMenuWindow items anySatisfy: [ :it | it hasIcon ]) ifTrue: [
		aMenuWindow items do: [ :it | 
			it hasIcon ifFalse: [ it icon: self newBlankIcon ] ] ]
]

{ #category : #accessing }
ToMenuWindowSkin >> newBlankIcon [

	^ ToImage new size: 16 asPoint
]

{ #category : #'api - install/uninstall  hook' }
ToMenuWindowSkin >> onSkinInstalledIn: anElement [

	super onSkinInstalledIn: anElement.
	anElement geometry: (BlRoundedRectangleGeometry cornerRadius: 4).
	anElement padding: (BlInsets top: 5 left: 5 bottom: 5 right: 5 ).
	self addLook: (ToBackgroundLook new
			 initialBg: [ :e | e toTheme backgroundColor ];
			 yourself).
	self addLook: (ToWindowLook new 
			openAction: [ :e | self checkItemsIn: e ])
		
]
