Trait {
	#name : #TToMenuItemHolder,
	#instVars : [
		'items',
		'client',
		'columnWidth'
	],
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'t - menu item holder - adding/removing' }
TToMenuItemHolder >> addAllItems: aCollection [

	aCollection do: [ :item | self addItem: item ]
]

{ #category : #'t - menu item holder - adding/removing' }
TToMenuItemHolder >> addItem: aMenuItem [

	self items add: aMenuItem.
	self menuWindow root addChild: aMenuItem.
	aMenuItem addedInMenu: self
]

{ #category : #'t - menu item holder - adding/removing' }
TToMenuItemHolder >> addSeparator [

	self addItem: ToSeparatorMenuItem new
]

{ #category : #'t - menu item holder - accessing' }
TToMenuItemHolder >> client [

	^ client 
]

{ #category : #'t - menu item holder - accessing' }
TToMenuItemHolder >> client: anObject [

	client := anObject
]

{ #category : #'t - menu item holder - accessing' }
TToMenuItemHolder >> columnWidth [

	^ columnWidth ifNil: [ columnWidth := 35 ] 
]

{ #category : #'t - menu item holder - accessing' }
TToMenuItemHolder >> columnWidth: anInteger [

	columnWidth = anInteger ifTrue: [ ^ self ].
	columnWidth := anInteger
]

{ #category : #'t - menu item holder - testing' }
TToMenuItemHolder >> hasItems [ 

	^ self items notEmpty
]

{ #category : #'t - menu item holder -  initialization' }
TToMenuItemHolder >> initializeMenuItemHolder [

	items := OrderedCollection new
]

{ #category : #'t - menu item holder - accessing' }
TToMenuItemHolder >> items [

	^ items
]

{ #category : #'t - menu item holder - adding/removing' }
TToMenuItemHolder >> removeItem: aMenuItem [

	aMenuItem removedFromMenu: self.
	self items remove: aMenuItem.
	self menuWindow root removeChild: aMenuItem
]

{ #category : #'t - menu item holder - adding/removing' }
TToMenuItemHolder >> removeItemAt: anIndex [

	| item |
	item := self items at: anIndex.
	self removeItem: item
]

{ #category : #'t - menu item holder - adding/removing' }
TToMenuItemHolder >> replaceItemAt: anIndex with: anItem [

	| previous |
	previous := self items at: anIndex.
	previous removedFromMenu: self.
	self items at: anIndex put: anItem.
	self menuWindow root replaceChild: previous with: anItem

]

{ #category : #'t - menu item holder - accessing' }
TToMenuItemHolder >> withoutLeftColumn [

	self columnWidth: 0
]
