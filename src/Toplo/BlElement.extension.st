Extension { #name : #BlElement }

{ #category : #'*Toplo' }
BlElement >> asPlaceholderLayer [

	^ ToPlaceholderLayer new
		  in: [ :placeholder | placeholder addChild: self ];
		  yourself
]

{ #category : #'*Toplo' }
BlElement >> checkSkinInitialization [
]

{ #category : #'*Toplo' }
BlElement >> checkSkinInstallation [

	self launchSkinInstallation.
	self childrenDo: [ :child | child checkSkinInstallation ]
]

{ #category : #'*Toplo' }
BlElement >> currentSkinState [

	^ self userData at: #currentSkinState ifAbsentPut: [  ]
]

{ #category : #'*Toplo' }
BlElement >> currentSkinState: aState [

	self userData at: #currentSkinState put: aState
]

{ #category : #'*Toplo' }
BlElement >> disable [

	self isFlaggedAsDisabled ifFalse: [
		self flagAsDisabled.
		self dispatchEnablementChangedEvent  ].
	self childrenDo: [ :child | child disable ]
]

{ #category : #'*Toplo' }
BlElement >> dispatchChildSkinsDirtyEvent [

	self dispatchEvent: ToChildSkinsDirtyEvent new
]

{ #category : #'*Toplo' }
BlElement >> dispatchEnablementChangedEvent [

	self dispatchEvent: ToEnablementChangedEvent new
]

{ #category : #'*Toplo' }
BlElement >> dispatchLookEvent: anEvent [

	self dispatchEvent: anEvent.
	self childrenDo: [ :child | child dispatchLookEvent: anEvent ]
]

{ #category : #'*Toplo' }
BlElement >> enable [

	self isFlaggedAsEnabled ifFalse: [
		self flagAsEnabled.
		self dispatchEnablementChangedEvent ].
	self childrenDo: [ :child | child enable ]
]

{ #category : #'*Toplo' }
BlElement >> flagAsDisabled [

	self userData at: #enabled put: false
]

{ #category : #'*Toplo' }
BlElement >> flagAsEnabled [

	self userData at: #enabled put: true
]

{ #category : #'*Toplo' }
BlElement >> holder [

	^ self constraints infinite holder
]

{ #category : #'*Toplo' }
BlElement >> isDisabled [

	^ self isFlaggedAsDisabled
]

{ #category : #'*Toplo' }
BlElement >> isEnabled [

	^ self isFlaggedAsEnabled 
]

{ #category : #'*Toplo' }
BlElement >> isFlaggedAsDisabled [

	^ self isFlaggedAsEnabled not
]

{ #category : #'*Toplo' }
BlElement >> isFlaggedAsEnabled [

	^ self userData at: #enabled ifAbsentPut: [ true ]
]

{ #category : #'*Toplo' }
BlElement >> launchSkinInstallation [

	"Nothing to do at BlElement level to preserve efficienty"

]

{ #category : #'*Toplo' }
BlElement >> launchSkinUninstallation [

	"Nothing to do at BlElement level to preserve efficienty"

]

{ #category : #'*Toplo' }
BlElement >> privateSkin [

	^ self userData at: #privateSkin ifAbsent: [  ]
]

{ #category : #'*Toplo' }
BlElement >> privateSkin: aSkin [

	self privateSkin = aSkin ifTrue: [ ^ self ].
	self userData at: #privateSkin put: aSkin
]

{ #category : #'*Toplo' }
BlElement >> privateToTheme [

	^ self userData at: #privateToTheme ifAbsent: [  ]
]

{ #category : #'*Toplo' }
BlElement >> privateToTheme: aTheme [

	self userData at: #privateToTheme put: aTheme
]

{ #category : #'*Toplo' }
BlElement >> skinDo: aBlock [

	self privateSkin ifNil: [ ^ self ].
	aBlock value: self privateSkin
]

{ #category : #'*Toplo' }
BlElement >> switchToSkinState: aState [

	self currentSkinState: aState.
	aState applyOn: self
]

{ #category : #'*Toplo-LookAndFeel' }
BlElement >> toTheme [

	^ self privateToTheme ifNil: [
		  self hasParent
			  ifTrue: [ self parent toTheme ]
			  ifFalse: [
				  self isAttachedToSceneGraph
					  ifTrue: [ " install the theme only if the root is visible to 
						avoid default installation in another element that the space root"
						  self privateToTheme: ToAbstractTheme current.
						  self privateToTheme ]
					  ifFalse: [ ToAbstractTheme current ] ] ]
]

{ #category : #'*Toplo-LookAndFeel' }
BlElement >> toTheme: aTheme [

	self privateToTheme = aTheme ifTrue: [ ^ self ].
	self privateToTheme: aTheme.
	self toThemeChanged.

]

{ #category : #'*Toplo-LookAndFeel' }
BlElement >> toThemeChanged [

	self dispatchEvent: ToThemeChangedEvent new.
	self childrenDo: [ :c | c toThemeChanged ].


]

{ #category : #'*Toplo' }
BlElement >> withSkin: aSkin [

	self privateSkin ifNotNil: [ :s |
		self removeEventHandler: s ].
	self privateSkin: aSkin.
	self privateSkin ifNotNil: [ :s |
		self addEventHandler: s.
		self dispatchChildSkinsDirtyEvent ]
]

{ #category : #'*Toplo' }
BlElement >> withoutSkin [

	self privateSkin ifNotNil: [ :s |
		self removeEventHandler: s.
		self privateSkin: nil ]
]
