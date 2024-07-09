"
I redirect superclass nodes to another method whose selector is provided to me.
"
Class {
	#name : 'MOPSelfSendOperation',
	#superclass : 'MOPOperation',
	#instVars : [
		'proxy'
	],
	#category : 'MetaObjectProtocol-Operation',
	#package : 'MetaObjectProtocol',
	#tag : 'Operation'
}

{ #category : 'accessing' }
MOPSelfSendOperation class >> proxy: aProxy [

	^ self new
		  proxy: aProxy;
		  yourself
]

{ #category : 'accessing' }
MOPSelfSendOperation >> apply: aRFOperation with: anOrderedCollection [

		^ 1halt. 
		"aRFOperation receiver
			  perform: self selector
			  withArguments: aRFOperation arguments "
]

{ #category : 'accessing' }
MOPSelfSendOperation >> proxy [

	^ proxy
]

{ #category : 'accessing' }
MOPSelfSendOperation >> proxy: anObject [

	proxy := anObject
]
