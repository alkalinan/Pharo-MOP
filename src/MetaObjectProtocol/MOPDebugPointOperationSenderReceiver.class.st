Class {
	#name : 'MOPDebugPointOperationSenderReceiver',
	#superclass : 'MOPOperation',
	#instVars : [
		'debugPoint'
	],
	#category : 'MetaObjectProtocol-Operation',
	#package : 'MetaObjectProtocol',
	#tag : 'Operation'
}

{ #category : 'accessing' }
MOPDebugPointOperationSenderReceiver class >> object: a receiver: b [

	^ self new
		  object: a
		  receiver: b;
		  yourself
]

{ #category : 'accessing' }
MOPDebugPointOperationSenderReceiver >> apply: aRFOperation with: anOrderedCollection [

	debugPoint hitWithContext: thisContext
]

{ #category : 'testing' }
MOPDebugPointOperationSenderReceiver >> isDebugPointOperation [

	^ true
]

{ #category : 'accessing' }
MOPDebugPointOperationSenderReceiver >> object: anObject [

	debugPoint := DebugPointManager
		              installNew: MOPBreakDebugPoint
		              forMOPProxy: anObject.
	debugPoint
		addBehavior: (ConditionBehavior new condition:
					 '(thisContext sender findContextSuchThat: [ :ctx |
	 (#(#isInspector. #isInspection. #class. #isKindOf: . #printString . #asString . #stDisplayString ) includes:
		  ctx selector) or: [
		 (ctx receiver isInspector) or: [
			 ctx receiver isInspection ] ] ]) isNil')
]

{ #category : 'accessing' }
MOPDebugPointOperationSenderReceiver >> object: a receiver: b [

	debugPoint := DebugPointManager
		              installNew: MOPBreakDebugPoint
		              forMOPProxy: a.
	debugPoint addBehavior: (ReceiverBehavior new receiver: b)
]
