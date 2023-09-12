"
A ToPropertyDefinitionTest is a test class for testing the behavior of ToPropertyDefinition
"
Class {
	#name : #ToPropertyTypeTest,
	#superclass : #TestCase,
	#instVars : [
		'reader'
	],
	#category : #'Toplo-Theme-Tests-LookUpdater'
}

{ #category : #tests }
ToPropertyTypeTest >> testExplicitPropertyDefinition [

	| w prop  writer |
	w := ToElement new.
	prop := ToPseudoProperty new.
	writer := [ :e :v | e background: v ].
	reader := [ :e | e background ].
	prop writer: writer.
	prop reader: reader.
	prop name: #background.
	self assert: prop writer equals: writer.
	self assert: prop reader equals: reader.
	self assert: prop name equals: #background.
	prop write: Color blue to: w.
	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color blue.
	self assert: (prop read: w) equals: w background
]

{ #category : #tests }
ToPropertyTypeTest >> testInstVarPropertyDefinition [

	| w prop |
	w := ToElement new.
	prop := ToInstVarProperty new.
	prop name: #background.
	self assert: prop name equals: #background.
	prop write: Color blue to: w.
	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color blue.
	self assert: (prop read: w) equals: w background
]

{ #category : #tests }
ToPropertyTypeTest >> testInstVarPropertyDefinition2 [

	| w prop |
	w := ToElement new.
	prop := #background asInstVarPropertyDef.
	self assert: prop name equals: #background.
	prop write: Color blue to: w.
	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color blue.
	self assert: (prop read: w) equals: w background
]

{ #category : #tests }
ToPropertyTypeTest >> testSlotPropertyDefinition [

	| w prop first |
	w := ToCheckLookTestElement new.
	prop := ToSlotProperty new.
	prop name: #first.
	self assert: prop name equals: #first.
	first := BlElement new.
	prop write: first to: w.
	self assert: w first equals: first.
	self assert: (prop read: w) equals: first
]

{ #category : #tests }
ToPropertyTypeTest >> testSlotPropertyDefinition2 [

	| w prop first |
	w := ToCheckLookTestElement new.
	prop := #first asSlotPropertyDef.
	self assert: prop name equals: #first.
	first := BlElement new.
	prop write: first to: w.
	self assert: w first equals: first.
	self assert: (prop read: w) equals: first
]