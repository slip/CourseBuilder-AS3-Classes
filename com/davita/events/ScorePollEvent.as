/*
Copyright (c) 2012 Normal Software.  All rights reserved.  
The copyrights embodied in the content of this file are licensed under the BSD (revised) open source license
*/
package com.davita.events 
{
	import flash.events.*;
	
	/**
	 *	ScorePollEvent class
	 *
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 10.0
	 *
	 *	@author ian kennedy
	 *	@since  06.15.2012
	 */
	public class ScorePollEvent extends Event 
	{
		
		//--------------------------------------
		// CLASS CONSTANTS
		//--------------------------------------
		
		public static const SCORE_POLLED:String = "scorePolled";
		
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
		
		/**
		 *	@constructor
		 */
		public function ScorePollEvent( type:String, bubbles:Boolean=true, cancelable:Boolean=false )
		{
			super(type, bubbles, cancelable);
			trace("ScorePollEvent:: scorePolled");
		}
		
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------
		
		public override function clone():Event 
		{
			return new ScorePollEvent(type, bubbles, cancelable);
		}

		public override function toString():String
		{
            return formatToString("ScorePolled", "type", "bubbles", "cancelable", "eventPhase");
		}
		
	}
	
}
