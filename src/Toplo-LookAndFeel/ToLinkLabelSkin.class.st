Class {
	#name : #ToLinkLabelSkin,
	#superclass : #ToThemeLabelSkin,
	#category : #'Toplo-LookAndFeel-Theme-Skins-Label'
}

{ #category : #accessing }
ToLinkLabelSkin class >> type [

	^ #link
]

{ #category : #built }
ToLinkLabelSkin >> builtForeground [

	^ self theme colorLink
]

{ #category : #built }
ToLinkLabelSkin >> builtForegroundHover [

	^ self theme colorLinkHover
]

{ #category : #built }
ToLinkLabelSkin >> builtTextAttributes [

	| ropedText |
	ropedText := '' asRopedText.
	ropedText lineSpacing: self theme lineHeight.
	ropedText defaultFontSize: self theme fontSize.
	ropedText defaultFontName: self theme fontFamilyCode.
	ropedText weight: self theme fontWeightStrong.

	^ ropedText rope attributes
]
