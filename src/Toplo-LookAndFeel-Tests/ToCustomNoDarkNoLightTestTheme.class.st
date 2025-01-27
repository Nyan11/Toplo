"
I'm a test theme
"
Class {
	#name : #ToCustomNoDarkNoLightTestTheme,
	#superclass : #ToAbstractTheme,
	#category : #'Toplo-LookAndFeel-Tests-Utils'
}

{ #category : #skins }
ToCustomNoDarkNoLightTestTheme class >> skinClassesFor: aToElementClass [
	"return skins which are designed for this theme"

	| oc |
	oc := OrderedCollection new.
	
	aToElementClass = ToButton ifTrue:[
		^ oc add: ToEmptyTestSkin; yourself.
	].

	^ oc
]

{ #category : #colors }
ToCustomNoDarkNoLightTestTheme >> darkTheme [

	^ nil
]

{ #category : #colors }
ToCustomNoDarkNoLightTestTheme >> initialize [ 

	super initialize.
	self name:'Custom Theme for tests (not support dark/light mode)'.
]

{ #category : #colors }
ToCustomNoDarkNoLightTestTheme >> isDark [

	^ false
]

{ #category : #colors }
ToCustomNoDarkNoLightTestTheme >> isLight [

	^ false
]

{ #category : #colors }
ToCustomNoDarkNoLightTestTheme >> lightTheme [

	^ nil
]
