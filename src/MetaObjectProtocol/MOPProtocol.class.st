Class {
	#name : 'MOPProtocol',
	#superclass : 'Object',
	#instVars : [
		'metaObject'
	],
	#classInstVars : [
		'mopRegistry'
	],
	#category : 'MetaObjectProtocol-base',
	#package : 'MetaObjectProtocol',
	#tag : 'base'
}

{ #category : 'adding' }
MOPProtocol >> addInstrumentation: anInstrumentation [ 

	metaObject addInstrumentation: anInstrumentation 
]

{ #category : 'accessing' }
MOPProtocol >> instrumentations [

	^ metaObject instrumentations
]

{ #category : 'accessing' }
MOPProtocol >> listOfInstrumentation [

	metaObject instrumentations size asString traceCr.
	^ metaObject instrumentations
]

{ #category : 'accessing' }
MOPProtocol >> message [

	^ MOPMessageBuilder protocol: self
]

{ #category : 'accessing' }
MOPProtocol >> metaObject [
	^ metaObject
]

{ #category : 'accessing' }
MOPProtocol >> metaObject: aMOPMetaObject [

	metaObject := aMOPMetaObject 
]

{ #category : 'accessing' }
MOPProtocol >> method [

	^ MOPMethodBuilder protocol: self
]

{ #category : 'accessing' }
MOPProtocol >> node [

	^ MOPNodeBuilder protocol: self
]

{ #category : 'instrumentation' }
MOPProtocol >> uninstall: aMOPInstrumentation [

	metaObject uninstall: aMOPInstrumentation
]

{ #category : 'accessing' }
MOPProtocol >> variable [

	^ MOPVariableBuilder protocol: self
]
