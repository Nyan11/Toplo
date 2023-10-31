Class {
	#name : 'ToSpaceSkinInstallerPhaseCheckerEventHandler',
	#superclass : 'BlCustomEventHandler',
	#category : 'Toplo-Core-SpaceFrame',
	#package : 'Toplo',
	#tag : 'Core-SpaceFrame'
}

{ #category : 'event handling' }
ToSpaceSkinInstallerPhaseCheckerEventHandler >> elementAddedToSceneGraphEvent: anEvent [
	" add the skin installer and the skin state phases if necessary "

	anEvent currentTarget space isSkinInstallerPhaseInstalled ifFalse: [
		anEvent currentTarget space startSkinInstallerPhase.
		anEvent currentTarget space startSkinStatePhase.

		anEvent currentTarget space root requestSkin ].
	" one shot verification done - i'm removed for the element event dispatcher "
	anEvent currentTarget removeEventHandler: self
]

{ #category : 'api - accessing' }
ToSpaceSkinInstallerPhaseCheckerEventHandler >> eventsToHandle [

	^ { BlElementAddedToSceneGraphEvent }
]