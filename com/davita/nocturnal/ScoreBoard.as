package com.davita.nocturnal
{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	/**
	 * ...
	 * @author Ian Kennedy
	 */
	public class ScoreBoard extends MovieClip
	{

		//---------------------------------------
		// PRIVATE VARIABLES
		//---------------------------------------
        
        private var _ScoreBoardState:String;
        private var __gameFile:Object;
        
		//---------------------------------------
		// CONSTRUCTOR
		//---------------------------------------
		public function ScoreBoard():void
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
		// GETTER / SETTERS
		//---------------------------------------
		
		public function get ScoreBoardState():String
		{
			return _ScoreBoardState;
		}
		
		public function set ScoreBoardState(value:String):void
		{
			trace("ScoreBoard::set ScoreBoardState()");
			_ScoreBoardState = value;
		}
		
		//---------------------------------------
		// PRIVATE METHODS
		//---------------------------------------
		private function init(e:Event=null):void
		{
			trace("ScoreBoard::init()");
			this.stop();
			removeEventListener(Event.ADDED_TO_STAGE,init);
			var success:Boolean = findGameFile();
			if(success)
			{
                addEventListener(MouseEvent.ROLL_OVER, onScoreBoardRollOver);
                addEventListener(MouseEvent.CLICK, onScoreBoardClick);
			}
		}
        
        private function findGameFile():Boolean
        {
            var curParent:DisplayObjectContainer = this.parent;
            while (curParent) 
            { 
                if (curParent.hasOwnProperty("varPoints")) 
                { 
                    __gameFile = curParent;
					trace("ScoreBoard::findGameFile():gamefile found");
                    return true;
                }
                curParent = curParent.parent;
            }
			trace("ScoreBoard::findGameFile():gamefille not found");
            return false;
        }

        
        // ScoreBoard Lead Functions
        public function ScoreBoardSetup():void
        {
			trace("ScoreBoard::ScoreBoardSetup()");
            this.addEventListener(MouseEvent.ROLL_OVER, onScoreBoardRollOver);
            this.buttonMode = true;
            this.useHandCursor = true;
            restrictScore2oneClick = false;
            restrict2oneHintDeduction = false;
        }
        
        private function onScoreBoardClick(event:MouseEvent):void
        {
			trace("ScoreBoard::onScoreBoardClick()");
        }

        private function onScoreBoardRollOver(event:MouseEvent):void
        {
			trace("ScoreBoard::onScoreBoardRollOver()");
        }

	}
}