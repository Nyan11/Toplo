Class {
	#name : #ToH5LabelSkin,
	#superclass : #ToThemeLabelSkin,
	#category : #'Toplo-LookAndFeel-Theme-Skins-Label'
}

{ #category : #accessing }
ToH5LabelSkin class >> type [

	^ #h5
]

{ #category : #built }
ToH5LabelSkin >> builtForeground [

	^ self theme colorTextHeading
]

{ #category : #built }
ToH5LabelSkin >> builtTextAttributes [

	| ropedText |
	ropedText := '' asRopedText.
	ropedText lineSpacing: self theme lineHeightHeading5.
	ropedText defaultFontSize: self theme fontSizeHeading5.
	ropedText defaultFontName: self theme fontFamilyCode.
	ropedText weight: self theme fontWeightStrong.

	^ ropedText rope attributes
]
