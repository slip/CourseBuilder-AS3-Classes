/*
Copyright (c) 2009 Normal Software.  All rights reserved.  
The copyrights embodied in the content of this file are licensed under the BSD (revised) open source license
*/
package com.davita.test_interactions
{
	import flash.events.*;
	
	/**
	 *	TestEvent class
	 *	used by CourseWrapper
	 *
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *
	 *	@author ian kennedy
	 *	@since  02.21.2012
	 */
	public class TestEvent extends Event 
	{
		
		//--------------------------------------
		// CLASS CONSTANTS
		//--------------------------------------
		
		public static const TEST_CHANGED:String = "testChanged";
		public var interaction:String;
		
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
		
		/**
		 *	@constructor
		 */
		public function TestEvent( type:String, interaction:String, bubbles:Boolean=true, cancelable:Boolean=false )
		{
			super(type, bubbles, cancelable);
			this.interaction = interaction;
		}
		
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------

		public override function clone():Event 
		{
			return new TestEvent(type, interaction, bubbles, cancelable);
		}
		
		public override function toString():String
		{
            return formatToString("TestEvent", "type", "interaction", "bubbles", "cancelable", "eventPhase");
		};
		
	}
	
}
