Class {
	#name : 'MOPMetaObject',
	#superclass : 'Object',
	#instVars : [
		'instrumentations',
		'object',
		'protocol',
		'proxy',
		'objectClass',
		'objectAnoClass'
	],
	#category : 'MetaObjectProtocol-base',
	#package : 'MetaObjectProtocol',
	#tag : 'base'
}

{ #category : 'adding' }
MOPMetaObject >> addInstrumentation: anInstrumentation [
	instrumentations add: anInstrumentation
]

{ #category : 'handling DNU' }
MOPMetaObject >> handle: aMessage [

	<debuggerCompleteToSender>
	aMessage traceCr.
	objectClass ifNotNil: [ :class |
		(class lookupSelector: aMessage selector) ifNotNil: [ :selector |
			self instrument: selector ] ].

	^ MirrorPrimitives
		  withReceiver: object
		  perform: aMessage selector
		  withArguments: aMessage arguments asArray
]

{ #category : 'initialization' }
MOPMetaObject >> initialize [

	object := Object new.

	protocol := MOPProtocol new.
	protocol metaObject: self.

	instrumentations := OrderedCollection new.

]

{ #category : 'install' }
MOPMetaObject >> installOnAnnonymousClass: aRBMethod [

	(objectAnoClass includesSelector: aRBMethod selector) ifTrue: [
		^ self ].
	objectAnoClass compile: aRBMethod sourceCode
]

{ #category : 'install' }
MOPMetaObject >> installOnAnnonymousClass: aRBMethod installeur: instrumentationInstalleur [

	(objectAnoClass includesSelector: aRBMethod selector) ifTrue: [
		^ self ].
	instrumentationInstalleur selfEscapeResolve: aRBMethod  proxy: proxy .
	instrumentationInstalleur superProblemeResolve: aRBMethod.
	objectAnoClass compile: aRBMethod sourceCode
]

{ #category : 'instrument' }
MOPMetaObject >> instrument: aMethod [

	| instrumentationInstalleur methodNeedToInstall |
	instrumentationInstalleur := MOPInstrumentationInstaller new.
	instrumentationInstalleur object: object.

	self installOnAnnonymousClass: aMethod installeur: instrumentationInstalleur .
	

	methodNeedToInstall := objectAnoClass >> aMethod selector.



	self instrumentations do: [ :instrumentation |
		| nodes |
		nodes := methodNeedToInstall ast allChildren select: [ :n |
			         instrumentation requirement verify: n ].
		nodes := nodes select: [ :n |
			         n hasMetaLinks
				         ifTrue: [ n links first metaObject ~= instrumentation ]
				         ifFalse: [ true ] ].

		nodes do: [ :n |
			instrumentationInstalleur install: instrumentation onNode: n ] ]
]

{ #category : 'accessing' }
MOPMetaObject >> instrumentations [

	^ instrumentations 
]

{ #category : 'accessing' }
MOPMetaObject >> object: anObject [

	
	object := anObject.
	objectClass := anObject class.
	objectAnoClass := objectClass newAnonymousSubclass.
	objectAnoClass adoptInstance: anObject.
]

{ #category : 'accessing' }
MOPMetaObject >> protocol [

	^ protocol
]

{ #category : 'accessing' }
MOPMetaObject >> proxy: aMOPProxy [

	proxy := aMOPProxy
]
