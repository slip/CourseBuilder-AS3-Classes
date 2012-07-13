/*
Copyright (c) 2012 Normal Software.  All rights reserved.  
The copyrights embodied in the content of this file are licensed under the BSD (revised) open source license
*/
package com.davita.events 
{
	import flash.events.*;
	
	/**
	 *	ScoreUpdatedEvent class
	 *
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 10.0
	 *
	 *	@author ian kennedy
	 *	@since  06.15.2012
	 */
	public class ScoreUpdatedEvent extends Event 
	{
		
		//--------------------------------------
		// CLASS CONSTANTS
		//--------------------------------------
		
		public static const SCORE_UPDATED:String = "scoreUpdated";
		public var bookmarkMilesChallengesArray:Array;
		
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
		
		/**
		 *	@constructor
		 */
		public function ScoreUpdatedEvent( type:String, bookmarkMilesChallengesArray:Array, bubbles:Boolean=true, cancelable:Boolean=false )
		{
			super(type, bubbles, cancelable);
			this.bookmarkMilesChallengesArray = bookmarkMilesChallengesArray;
			trace("ScoreUpdatedEvent::bookmarkMilesChallengesArray: " + bookmarkMilesChallengesArray);
		}
		
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------

		public override function clone():Event 
		{
			return new ScoreUpdatedEvent(type, bookmarkMilesChallengesArray, bubbles, cancelable);
		}
		
		public override function toString():String
		{
            return formatToString("ScoreUpdatedEvent", "type", "bookmarkMilesChallengesArray", "bubbles", "cancelable", "eventPhase");
		};
		
	}
	
}
