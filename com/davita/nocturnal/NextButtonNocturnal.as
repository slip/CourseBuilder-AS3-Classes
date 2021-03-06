﻿package com.davita.nocturnal
{
	import flash.display.*;
	import flash.events.*;

	/**
	 * ...
	 * @author Ian Kennedy
	 */
	public class NextButtonNocturnal extends MovieClip
	{

		//---------------------------------------
		// PRIVATE VARIABLES
		//---------------------------------------
		private var __gameFile:Object;
		private var __gotoLabel:String;
		private var __delayTime:int;

		//---------------------------------------
		// CONSTRUCTOR
		//---------------------------------------
		
		// on instantiation, the NextButtonNocturnal can be passed a frameLabel
		public function NextButtonNocturnal():void
		{
			if (stage)
			{
				init();
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE,init);
			}
		}
				
		//---------------------------------------
		// PRIVATE METHODS
		//---------------------------------------
		private function init(e:Event=null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,init);

			// find CourseFileNocturnalGame
			var success:Boolean = findGameFile();
			if(success)
			{
				// set up NextButtonNocturnal properties
				this.buttonMode = true;
				this.useHandCursor = true;
				this.addEventListener(MouseEvent.CLICK, nextButtonClickHandler);
			}
		}

        private function findGameFile():Boolean
        {
            var curParent:DisplayObjectContainer = this.parent;
            while (curParent) 
            { 
                if (curParent.hasOwnProperty("points")) 
                { 
                    __gameFile = curParent;
					trace("NextButtonNocturnal::findGameFile():gamefile found");
                    return true;
                }
                curParent = curParent.parent;
            }
			trace("NextButtonNocturnal::findGameFile():gamefile not found");
            return false;
        }
		
		private function nextButtonClickHandler(event:MouseEvent):void
		{
			trace("NextButtonNocturnal::nextButtonClickHandler()");
			this.removeEventListener(MouseEvent.CLICK, nextButtonClickHandler);
			continueGame();
		}
		
		private function continueGame():void
		{
			if(__gotoLabel != "" && __gotoLabel != null)
			{
				__gameFile.gotoAndPlay(__gotoLabel);
			}
			else
			{
				__gameFile.play();
			}
		}

		//---------------------------------------
		// PUBLIC METHODS
		//---------------------------------------

		//---------------------------------------
		// GETTER / SETTERS
		//---------------------------------------
		
		public function set gotoLabel(value:String):void
		{
			trace("NextButtonNocturnal::set gotoLabel("+value+")");
			__gotoLabel = value;
		}
		
		public function get gotoLabel():String
		{
			return __gotoLabel;
		}		

		public function set delayTime(value:int):void
		{
			trace("NextButtonNocturnal::set delayTime("+value+")");
			__delayTime = value;
		}
		
		public function get delayTime():int
		{
			return __delayTime;
		}		
	}
}