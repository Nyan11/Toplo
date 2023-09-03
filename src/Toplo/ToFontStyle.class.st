"
# Font property (`ToFontStyle`)

Font properties control how a component (morph) with font will draw the text.
I keep this properties: 

- name: The font name (it needs to be available in the list of fonts, e.g. ""Source Code Pro"") 
- size: The font point size.
- bold: Font is bold? (boolean, default """"false"""")
- italic: Font is italic? (boolean, default """"false"""")

## Usage
The identifier of font in the stylesheet is `Font`.

```language=Javascript
Font { 
 	#name: ""Source Sans Pro"",  
	#size: 12,
	#bold: false,
	#italic: false
}
```

## Predefined fonts
User can also point to the fonts pre-defined (comming from Settings).
To do that, is enough to access the property `predefinedFont`, and value can be one of the list: 

- `#default`
- `#code`
- `#ballon`
- `#button`
- `#halo`
- `#list`
- `#menu`

**NOTE:** Using `predefinedFont` will meke any other Font property defined to be ignored.

```language=Javascript
Font { 
 	#predefinedFont: #code
}
```

"
Class {
	#name : #ToFontStyle,
	#superclass : #ToPropertyStyle,
	#instVars : [
		'predefinedFont',
		'name',
		'size',
		'italic',
		'bold',
		'color'
	],
	#classVars : [
		'ApplyDisplayScaleFactor',
		'FontCache'
	],
	#category : #'Toplo-StyleSheet'
}

{ #category : #private }
ToFontStyle class >> addFontToCache: aFont [

	self fontCache add: aFont
]

{ #category : #accessing }
ToFontStyle class >> applyDisplayScaleFactor [

	^ ApplyDisplayScaleFactor ifNil: [ true ]
]

{ #category : #accessing }
ToFontStyle class >> applyDisplayScaleFactor: aBoolean [

	ApplyDisplayScaleFactor := aBoolean
]

{ #category : #private }
ToFontStyle class >> fontCache [

	^ FontCache ifNil: [ FontCache := WeakSet new ]
]

{ #category : #'ston-core' }
ToFontStyle class >> stonName [
	
	^ 'Font'
]

{ #category : #private }
ToFontStyle >> addFontToCache: aFont [

	self class addFontToCache: aFont
]

{ #category : #private }
ToFontStyle >> anyFontDecorator [
	
	^ color notNil 
		or: [ size notNil 
		or: [ bold notNil 
		or: [ italic notNil ] ] ]
]

{ #category : #private }
ToFontStyle >> applyDisplayScaleFactor [

	^ self class applyDisplayScaleFactor
]

{ #category : #operations }
ToFontStyle >> applyTo: aWidget [

	"not all morphs understand font, I need to verify it (which is not cool verifying a 
	 selector but other way would be to define #font: in Widget and I do not want that)"
	(aWidget respondsTo: #font:) ifFalse: [ ^ self ].
	
	self isReset 
		ifFalse: [ aWidget font: self definedFont ].
	
	self color ifNil: [ ^ self ].
	"Again, not all morphs understand #textColor: and I need to verify it is there."
	(aWidget respondsTo: #textColor:) ifFalse: [ ^ self ].
	aWidget textColor: self colorVariable valueAsColor
]

{ #category : #accessing }
ToFontStyle >> bold [

	^ self boldVariable value
]

{ #category : #accessing }
ToFontStyle >> bold: aBoolean [

	bold := aBoolean asStyleVariable
]

{ #category : #'accessing - variables' }
ToFontStyle >> boldVariable [

	^ self toVariable: bold
]

{ #category : #private }
ToFontStyle >> calculateDefinedFont [
	| font |
	
	font := LogicalFont
		familyName: self calculateFontName
		pointSize: self calculateFontSize.

	self isItalic ifTrue: [ font forceItalicOrOblique ].
	self isBold ifTrue: [ font forceBold ].

	^ font
]

{ #category : #private }
ToFontStyle >> calculateFontName [
	| var |
	
	var := self nameVariable.
	^ var isEnvironmentVariable 
		ifTrue: [ var familyName ] 
		ifFalse: [ var value ]
]

{ #category : #private }
ToFontStyle >> calculateFontSize [
	
	self sizeVariable ifNotNil: [ :aVariable |
		aVariable value ifNotNil: [ 
			^ self scaledSize ] ].
	self nameVariable isEnvironmentVariable ifTrue: [ 
		^ self nameVariable pointSize * self displayScaleFactor ].
	self hasPredefinedFont ifTrue: [ 
		^ self obtainPredefinedFont pointSize * self displayScaleFactor ].

	^ nil
]

{ #category : #accessing }
ToFontStyle >> color [
  "This is meant to set the text color.
	This property can be expressed as 
	- a STON map: ==Color { #red : 1., #green : 0, #blue : 0, #alpha : 1 }==
	- a named selector: ==#red==
	- an hex string: =='FF0000'=="

	^ self colorVariable value
]

{ #category : #accessing }
ToFontStyle >> color: aColorOrSymbol [

	color := aColorOrSymbol asStyleVariable
]

{ #category : #'accessing - variables' }
ToFontStyle >> colorVariable [
  "This is meant to set the text color.
	This property can be expressed as 
	- a STON map: ==Color { #red : 1., #green : 0, #blue : 0, #alpha : 1 }==
	- a named selector: ==#red==
	- an hex string: =='FF0000'=="

	^ self toVariable: color
]

{ #category : #private }
ToFontStyle >> definedFont [
	| definedFont |

	(self predefinedFont notNil and: [ self anyFontDecorator not ]) ifTrue: [ 
		^ self obtainPredefinedFont  ].

	self withCachedFontDo: [ :aFont | ^ aFont ].
	
	definedFont := self calculateDefinedFont.
	self addFontToCache: definedFont.
	^ definedFont
]

{ #category : #private }
ToFontStyle >> displayScaleFactor [

	^ self applyDisplayScaleFactor
		ifTrue: [ self currentWorld displayScaleFactor ]
		ifFalse: [ 1 ]
]

{ #category : #private }
ToFontStyle >> hasPredefinedFont [

	^ self predefinedFont notNil
]

{ #category : #testing }
ToFontStyle >> isBold [
	"property may be nil, we verify with strict comparisson"
	
	^ self boldVariable value == true
]

{ #category : #testing }
ToFontStyle >> isItalic [
	"property may be nil, we verify with strict comparisson"
	
	^ self italicVariable value == true 
]

{ #category : #testing }
ToFontStyle >> isReset [

	^ name notNil and: [ name isResetVariable ]
]

{ #category : #accessing }
ToFontStyle >> italic [

	^ self italicVariable value
]

{ #category : #accessing }
ToFontStyle >> italic: aBoolean [

	italic := aBoolean asStyleVariable
]

{ #category : #'accessing - variables' }
ToFontStyle >> italicVariable [

	^ italic
]

{ #category : #operations }
ToFontStyle >> mergeWith: otherProperty [
	| merged |

	merged := super mergeWith: otherProperty.

	"Ensure predefined font will be overriden even if nil."
	otherProperty name 
		ifNotNil: [
			merged 
				writeSlotNamed: 'predefinedFont' value: nil;
				writeSlotNamed: 'name' value: (otherProperty readSlotNamed: 'name') ].
		
	^ merged
]

{ #category : #accessing }
ToFontStyle >> name [

	^ self nameVariable value
]

{ #category : #accessing }
ToFontStyle >> name: aString [

	name := aString asStyleVariable
]

{ #category : #'accessing - variables' }
ToFontStyle >> nameVariable [

	^ self toVariable: name
]

{ #category : #private }
ToFontStyle >> obtainPredefinedFont [

	^ StandardFonts perform: (self predefinedFont value, 'Font') asSymbol
]

{ #category : #accessing }
ToFontStyle >> predefinedFont [

	^ predefinedFont
]

{ #category : #accessing }
ToFontStyle >> predefinedFont: aSymbol [

	predefinedFont := aSymbol
]

{ #category : #accessing }
ToFontStyle >> scaledSize [

	^ self applyDisplayScaleFactor
		ifTrue: [ self sizeVariable scaledValue ]
		ifFalse: [ self sizeVariable nonscaledValue ]
]

{ #category : #accessing }
ToFontStyle >> size [

	^ self sizeVariable value
]

{ #category : #accessing }
ToFontStyle >> size: aNumber [

	size := aNumber asStyleVariable
]

{ #category : #'accessing - variables' }
ToFontStyle >> sizeVariable [

	^ size
]

{ #category : #private }
ToFontStyle >> withCachedFontDo: aBlock [

	self class fontCache 
		detect: [ :each | 
			each familyName = self name 
				and: [ each pointSize = self scaledSize 
				and: [ each isBold = self isBold
				and: [ each isItalic = self isItalic ] ] ] ]
		ifFound: aBlock
]