Class {
	#name : #ToLabelMonoLineInnerElement,
	#superclass : #BlAttributedTextElement,
	#traits : 'TToLabelInnerElement + TToResizable',
	#classTraits : 'TToLabelInnerElement classTrait + TToResizable classTrait',
	#category : #'Toplo-Widget-Album-Label'
}

{ #category : #'api - editor' }
ToLabelMonoLineInnerElement >> editorShortcutsIn: aLabel [

	^ { (BlShortcutWithAction new
			 combination: ((BlKeyCombination primaryReturn or: BlKeyCombination return) or: BlKeyCombination primaryS );
			 action: [  aLabel text: aLabel editor text. aLabel removeEditor ];
			 description: 'Accept the edited text';
			 name: 'Accept';
			 yourself).
	 (BlShortcutWithAction new
			 combination: (BlKeyCombination escape or: BlKeyCombination primaryL);
			 action: [ :e | aLabel removeEditor ];
			 description: 'Escape from text editing';
			 name: 'Escape';
			 yourself).
		 }
]

{ #category : #initialization }
ToLabelMonoLineInnerElement >> initialize [ 

	super initialize.
	" Need Label measurement to ensure right vertical alignement with labels/menus "
	self labelMeasurement.
	self preventMouseEvents 
]

{ #category : #'api - editor' }
ToLabelMonoLineInnerElement >> newEditorIn: aLabel [

	| ed |
	ed := ToTextField new dresser: (ToLabelEditorDresser label: aLabel).
	(self editorShortcutsIn: aLabel) do: [ :s | ed editor addEditorShortcut: s ].
	^ ed
]

{ #category : #'t - layout resizeable' }
ToLabelMonoLineInnerElement >> resizableConstraintsDo: aBlock [
	"Perform aBlock with my constraints as argument.
	Note: After evaluation I request a layout update!
	aBlock must not be nil.
	aBlock must accept exactly one argument
	
	Can be basically defined with #constraintsDo: aBlock.
	
	Introduced a an explicit requirement to let user
	implement additional actions when resizing is changed
	
	"
	self constraintsDo: aBlock
]

{ #category : #'api - text accessing' }
ToLabelMonoLineInnerElement >> text [

	^ super text
]

{ #category : #'api - text accessing' }
ToLabelMonoLineInnerElement >> text: aText [

	super text: aText.
	self forceLocalLayout 
]

{ #category : #'event handling' }
ToLabelMonoLineInnerElement >> textChanged [

	super textChanged.
	self dispatchEvent: (ToTextReplacedEvent new text: self text)
	
]
