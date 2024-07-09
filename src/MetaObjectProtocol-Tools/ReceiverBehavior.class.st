Class {
	#name : 'ReceiverBehavior',
	#superclass : 'DebugPointCheckBehavior',
	#instVars : [
		'receiver'
	],
	#category : 'MetaObjectProtocol-Tools-Behaviors',
	#package : 'MetaObjectProtocol-Tools',
	#tag : 'Behaviors'
}

{ #category : 'accessing' }
ReceiverBehavior >> context [

	^ self getArgument: #context
]

{ #category : 'execution' }
ReceiverBehavior >> execute [

	| context top |
	context := self context.
	^ (context findContextSuchThat: [ :ctx |
		   ctx stackPtr > 0 and: [
			   (top := ctx top) isMessageSend and: [
				   top receiver == self receiver ] ] ]) notNil
]

{ #category : 'accessing' }
ReceiverBehavior >> receiver [

	^ receiver
]

{ #category : 'accessing' }
ReceiverBehavior >> receiver: anObject [

	receiver := anObject
]
