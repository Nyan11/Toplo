Class {
	#name : #ToCheckboxItemSkin,
	#superclass : #ToCheckableMenuItemSkin,
	#traits : 'TToCheckboxSkin',
	#classTraits : 'TToCheckboxSkin classTrait',
	#category : #'Toplo-Widget-Menu-Skins'
}

{ #category : #accessing }
ToCheckboxItemSkin >> iconSkinIn: aButton [ 

	^ self type checkboxIconSkinIn: aButton

]