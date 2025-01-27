Class {
	#name : #ToAlbum,
	#superclass : #ToPane,
	#traits : 'TToWidget + TToElement + TToEnableable + TAlbInfiniteDecorator + TToWidgetWithViewModel + TToWidgetWithTooltip + TToWidgetWithContextMenu + TToWidgetWithLayers + TToWidgetWithPlaceholder',
	#classTraits : 'TToWidget classTrait + TToElement classTrait + TToEnableable classTrait + TAlbInfiniteDecorator classTrait + TToWidgetWithViewModel classTrait + TToWidgetWithTooltip classTrait + TToWidgetWithContextMenu classTrait + TToWidgetWithLayers classTrait + TToWidgetWithPlaceholder classTrait',
	#instVars : [
		'#editsFeedbackLayer',
		'#innerElement',
		'#edited => ObservableSlot'
	],
	#category : #'Toplo-Widget-Album-TextPane'
}

{ #category : #'t - initialization dresser' }
ToAlbum >> defaultDresser [

	^ ToAlbumBasicDresser new
]

{ #category : #initialization }
ToAlbum >> defaultEditorElement [

	^ AlbEditorElement new
]

{ #category : #accessing }
ToAlbum >> edited [

	^ edited ifNil: [ edited := false ]
]

{ #category : #accessing }
ToAlbum >> edited: aBoolean [

	edited = aBoolean ifTrue: [ ^ self ].
	edited := aBoolean
]

{ #category : #'client - protocol' }
ToAlbum >> flash [

	self dispatchEvent: (ToAlbumFlashRequestedEvent new client: self)
]

{ #category : #initialization }
ToAlbum >> initialize [

	super initialize.
	self matchParent.
	
	self editorDo: [:ed | ed when: AlbTextEditedEvent do: [ self edited: true ] ].
	"self whenTextEditedDo: [ self edited: true ]."
]

{ #category : #accessing }
ToAlbum >> innerElement [

	^ self next
]

{ #category : #'t - widget with layers - accessing' }
ToAlbum >> layerReferentElement [

		^ self 
]

{ #category : #layers }
ToAlbum >> placeholderText: aText [

	self placeholder: (ToAlbumPlaceholder new text: aText).
	self text size isZero ifTrue: [ self showPlaceholder ]
]

{ #category : #'t - initialization dresser' }
ToAlbum >> preInitializeDresser [ 

	super preInitializeDresser.

	self next: self defaultEditorElement.
	self addChild: self next.

]

{ #category : #'transaction hook' }
ToAlbum >> requestCancel [

	self dispatchEvent: (ToAlbumCancelRequestedEvent new client: self)
]

{ #category : #'transaction hook' }
ToAlbum >> requestSave [

	self dispatchEvent: (ToAlbumSaveRequestedEvent new
			 client: self;
			 unacceptedEdits: self edited ;
			 yourself)
]

{ #category : #'transaction hook' }
ToAlbum >> saveResult: aBoolean [

	| event |
	self edited: aBoolean not.
	event := aBoolean
		                ifTrue: [ ToAlbumSaveAcceptedEvent new client: self ]
		                ifFalse: [ ToAlbumSaveDeniedEvent new client: self ].
	self dispatchEvent: event
]

{ #category : #accessing }
ToAlbum >> text: aBlText [

	aBlText == self text ifTrue: [ ^ self ].
	self next text: aBlText.
	self edited: false
]

{ #category : #'transaction hook' }
ToAlbum >> whenCancelRequestedDo: aBlock [

	self when: ToAlbumCancelRequestedEvent do: aBlock
]

{ #category : #'property change hook' }
ToAlbum >> whenEditedChangedDo: aBlock [

	"set a block to perform after that the text has been chanbed, and its action performed"

	self property: #edited whenChangedDo: aBlock
]

{ #category : #'transaction hook' }
ToAlbum >> whenSaveAcceptedDo: aBlock [

	self when: ToAlbumSaveAcceptedEvent do: aBlock
]

{ #category : #'transaction hook' }
ToAlbum >> whenSaveDeniedDo: aBlock [

	self when: ToAlbumSaveDeniedEvent do: aBlock
]

{ #category : #'transaction hook' }
ToAlbum >> whenSaveRequestedDo: aBlock [

	self when: ToAlbumSaveRequestedEvent do: aBlock
]

{ #category : #layers }
ToAlbum >> withEditsFeedback [

	editsFeedbackLayer ifNotNil: [ ^ self ].
	editsFeedbackLayer := ToAlbumEditsFeedbackLayer new.
	self addLayer: editsFeedbackLayer 
]

{ #category : #initialization }
ToAlbum >> withSaveCapability [

	self withEditsFeedback.

	self addEditorShortcut: (BlShortcutWithAction new
			 combination: BlKeyCombination primaryS;
			 action: [ :aShortcutEvent :aShortcut | self requestSave ];
			 name: 'Save';
			 description: 'Apply changes and save the source code (compile).').
	self addEditorShortcut: (BlShortcutWithAction new
			 combination: BlKeyCombination primaryL;
			 action: [ :aShortcutEvent :aShortcut | self requestCancel ];
			 name: 'Cancel';
			 description: 'Cancel changes and rollback the previous accepted source code.')
]

{ #category : #layers }
ToAlbum >> withoutEditsFeedback [

	editsFeedbackLayer ifNil: [ ^ self ].
	self removeLayer: editsFeedbackLayer.
	editsFeedbackLayer := nil
]

{ #category : #layers }
ToAlbum >> withoutPlaceholder [ 

	self hidePlaceholder 
]
