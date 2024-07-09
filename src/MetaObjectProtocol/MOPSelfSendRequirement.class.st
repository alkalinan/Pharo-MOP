"
I check if the nodes is a message and if the receiver is super 
"
Class {
	#name : 'MOPSelfSendRequirement',
	#superclass : 'MOPRequirement',
	#category : 'MetaObjectProtocol-Requirement',
	#package : 'MetaObjectProtocol',
	#tag : 'Requirement'
}

{ #category : 'verifying' }
MOPSelfSendRequirement >> verify: anASTNode [

	 ^ anASTNode isSelfVariable 
]
