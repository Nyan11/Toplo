Class {
	#name : #ToStyleSheetInterpreter,
	#superclass : #Object,
	#category : #'Toplo-Theme-StyleSheet'
}

{ #category : #accessing }
ToStyleSheetInterpreter >> rawWritersFor: anElement [

	^ Array streamContents: [ :str |
		  (self rulesFor: anElement) do: [ :r |
			  (r canBeAppliedTo: anElement) ifTrue: [
				  str nextPutAll: r writers ] ] ]
]

{ #category : #accessing }
ToStyleSheetInterpreter >> rulesFor: anElement [

	^ Array streamContents: [ :str |
		  anElement styleSheetChain reverseDo: [ :ss |
			  str nextPutAll: ss styleRules ] ]
]

{ #category : #accessing }
ToStyleSheetInterpreter >> skinFor: anElement [

	| writers skin |
	writers := self writersFor: anElement.
	skin := ToSkin new.
	skin writers: writers.
	^ skin
]

{ #category : #accessing }
ToStyleSheetInterpreter >> writersFor: anElement [
	" for an element, several writers can be found. These writers 
	are found with #rawWritersFor:. After, for each property only the last writers is kept"

	| rawWriters supplement uniqueWriters eventClassIndex |
	
	" get all subscriptions for anElement "
	rawWriters := self rawWritersFor: anElement.
	
	" keep only the last writers for each property except those which are declared as supplement"
	eventClassIndex := IdentityDictionary new.
	supplement := OrderedCollection new.
	
	rawWriters do: [ :w |
		w supplement
			ifTrue: [ supplement add: w ]
			ifFalse: [
				| indexByProperty |
				indexByProperty := eventClassIndex
					                   at: w eventClass
					                   ifAbsentPut: [ IdentityDictionary new ].
				indexByProperty at: w property put: w ] ].
		
	uniqueWriters := Array streamContents: [ :str |
		                 eventClassIndex valuesDo: [ :indexByProperty |
			                 str nextPutAll: indexByProperty values ] ].
	
	^ Array streamContents: [:str | 
			str nextPutAll: (uniqueWriters sort: [ :a :b | a property name < b property name ]).
	  		str nextPutAll: supplement ]
]