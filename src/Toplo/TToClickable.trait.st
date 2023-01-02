Trait {
	#name : #TToClickable,
	#category : #'Toplo-Core'
}

{ #category : #'t - click behavior' }
TToClickable >> whenClickedDo: aBlock [
	"Inform that the widget has been aclicked, and its action has been performed.
	 `aBlock` receive zero arguments."

	self when: BlClickEvent do: aBlock
]