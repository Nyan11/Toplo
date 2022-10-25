"
I'm a workspace example made with Album/Toplo
"
Class {
	#name : #ToWorkspaceExample,
	#superclass : #Object,
	#instVars : [
		'textModel',
		'bindings'
	],
	#classVars : [
		'MyTranscript'
	],
	#category : #'Toplo-Examples'
}

{ #category : #'instance creation' }
ToWorkspaceExample class >> closeTranscript [

	MyTranscript ifNotNil: [ MyTranscript close ]
]

{ #category : #'instance creation' }
ToWorkspaceExample class >> openInHost: aBlOSWindowHost [

	<script>
	| space |
	self transcriptAlreadyOpened ifFalse: [ self openTranscript ].

	space := BlSpace new
		         host: aBlOSWindowHost;
		         yourself.
	self new openInSpace: space
]

{ #category : #'instance creation' }
ToWorkspaceExample class >> openInMorphic [

	<script>
	self openInHost: BAMorphicWindowHost new
]

{ #category : #'instance creation' }
ToWorkspaceExample class >> openInSDL [

	<script>
	self openInHost: BAOSWindowSDL2Host new
]

{ #category : #'instance creation' }
ToWorkspaceExample class >> openTranscript [

	MyTranscript := Transcript openLabel: self class instanceSide name , ' Transcript'.
	MyTranscript
		onAnnouncement: MorphDeleted
		send: #transcriptClosed
		to: self
]

{ #category : #initialization }
ToWorkspaceExample class >> resetTranscript [

	" self resetTranscript "
	MyTranscript := nil
]

{ #category : #'instance creation' }
ToWorkspaceExample class >> transcriptAlreadyOpened [

	^ MyTranscript notNil
]

{ #category : #'instance creation' }
ToWorkspaceExample class >> transcriptClosed [

	MyTranscript announcer unsubscribe: self.
	self resetTranscript 
]

{ #category : #bindings }
ToWorkspaceExample >> bindingOf: aString [

	"I want to have workspace that force the user to declare  
	variables. Still subclasses may want to do something else"
	
	| key |
	key := aString asSymbol.
	(bindings includesKey: key) ifFalse: [ 
		bindings at: key put: (WorkspaceVariable key: key value: nil) ].
	^ bindings at: key
]

{ #category : #bindings }
ToWorkspaceExample >> bindings [

	^ bindings 
]

{ #category : #'user interface' }
ToWorkspaceExample >> codeEditor [

	| st |
	st := textModel
		      withLineNumbers;
		      withGhostText:
			      (('Workspace example' , String cr , '- doit: Cmd-d')
				       asRopedText
				       fontSize: 24;
				       foreground: Color gray lighter;
				       yourself);
		      styler: (BlRBTextStyler new
				       isForWorkspace: true;
				       workspace: self;
				       fontName: AeFontManager defaultCodeFontFamilyName;
				       yourself);
		      yourself.
	st widgetDo: [ :album | 
		album editorElement addEditorShortcut: (BlShortcutWithAction new
				 combination: BlKeyCombination primaryD;
				 action: [ :aShortcutEvent :aShortcut | self doIt ];
				 name: 'Do it';
				 description: 'Run selected expression.') ].
	^ st onAlbum
]

{ #category : #accessing }
ToWorkspaceExample >> correctFrom: start to: stop with: aString [

	('correctFrom: ', start asString, ' to: ', stop asString, ' with: ', aString asString) traceCr
]

{ #category : #accessing }
ToWorkspaceExample >> doIt [

	textModel widgetDo: [ :widget | 
		| toDo |
		toDo := widget editorElement selectedText asString.
		toDo ifEmpty: [ toDo := widget editorElement text asString ].
		^ OpalCompiler new
			  source: toDo readStream;
			  requestor: self;
			  failBlock: [ ^ Object new ];
			  evaluate ]
]

{ #category : #bindings }
ToWorkspaceExample >> hasBindingOf: aString [
	^ bindings includesKey: aString asSymbol
]

{ #category : #initialization }
ToWorkspaceExample >> initialize [
	super initialize.
	bindings := Dictionary new.
	textModel := ToAlbumViewModel new.

]

{ #category : #bindings }
ToWorkspaceExample >> notify: aString at: anInteger in: aString3 [ 
	('parse error: ', aString, ' at: ', anInteger asString) traceCr.
]

{ #category : #'user interface' }
ToWorkspaceExample >> open [

	self openInSpace: OBlSpace new
]

{ #category : #'user interface' }
ToWorkspaceExample >> openInSpace: aSpace [

	aSpace
		title: self class instanceSide name;
		extent: 300 asPoint.
	aSpace root addChild: self codeEditor.
	aSpace show.
	aSpace addEventHandler: (BlEventHandler
			 on: BlSpaceClosedEvent
			 do: [ :evt | self class closeTranscript ])
]

{ #category : #accessing }
ToWorkspaceExample >> text [

	^ textModel text
]