Class {
	#name : #ToMenuWindowDresser,
	#superclass : #ToPopupWindowDresser,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'api - install/uninstall  hook' }
ToMenuWindowDresser >> mouseUpOutside: anEvent in: aMenuWindow [
	" redefined to not close the menu if the mousedown occurs inside a submenu window"

	| win origEventTarget |
	
	origEventTarget := anEvent originalEvent target.
	" if I'm the original event target then do nothing"
	origEventTarget ifNil: [
		^ super mouseUpOutside: anEvent in: aMenuWindow ].
	" if one of my children is the original event target then do nothing"
	(origEventTarget hasInParentChain: aMenuWindow) ifTrue: [
		^ self ].

	win := aMenuWindow openedSubmenuWindow.
	[ win notNil ] whileTrue: [
		" If the original event target is one of the submenu child then do nothing"
		(origEventTarget hasInParentChain: win) ifTrue: [
			^ self ].
		win := win openedSubmenuWindow ].

	" ok, the event is outside of the submenu chain"
	super mouseUpOutside: anEvent in: aMenuWindow
]
