"
Primary button: indicate the main action, one primary button at most in one section.
"
Class {
	#name : #ToPrimaryButtonSkin,
	#superclass : #ToThemeButtonSkin,
	#category : #'Toplo-LookAndFeel-Theme-Skins-Button'
}

{ #category : #accessing }
ToPrimaryButtonSkin class >> type [

	^ #primary
]

{ #category : #built }
ToPrimaryButtonSkin >> builtBackground [

	^ self theme colorPrimary 
]

{ #category : #built }
ToPrimaryButtonSkin >> builtBackgroundHover [ 

	^ self theme colorPrimaryHover
]

{ #category : #built }
ToPrimaryButtonSkin >> builtBackgroundPressed [ 

	^ self theme colorPrimaryPressed
]

{ #category : #built }
ToPrimaryButtonSkin >> builtBorder [

	^ nil
]

{ #category : #built }
ToPrimaryButtonSkin >> builtBorderHover [

	^ nil
]

{ #category : #built }
ToPrimaryButtonSkin >> builtBorderPressed [

	^ nil
]

{ #category : #built }
ToPrimaryButtonSkin >> builtDefaultSize [

	^ 0 @ (self theme controlHeight)
]

{ #category : #built }
ToPrimaryButtonSkin >> builtGeometry [

	^ BlRoundedRectangleGeometry cornerRadius: self theme borderRadius
]

{ #category : #built }
ToPrimaryButtonSkin >> builtPadding [ 

	^ BlInsets top: (self theme paddingXS / 2) left: (self theme paddingContentHorizontal) bottom: (self theme paddingXS / 2) right: (self theme paddingContentHorizontal)
]

{ #category : #built }
ToPrimaryButtonSkin >> builtShadow [

	^ BlGaussianShadowEffect
		  color: (self theme colorPrimary alphaMixed: 0.233 with: self theme backgroundColor)
		  width: 2
		  offset: 0 @ 2
]

{ #category : #built }
ToPrimaryButtonSkin >> imageSkinType [

	^ ToPrimaryImageSkin type
]

{ #category : #built }
ToPrimaryButtonSkin >> labelSkinType [

	^ ToPrimaryLabelSkin type
]
