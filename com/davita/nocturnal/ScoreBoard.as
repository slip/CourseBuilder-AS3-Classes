package com.davita.nocturnal
{
	import flash.display.*;
	import flash.events.*;
	import com.greensock.TweenLite;
	/**
	 * ...
	 * @author Ian Kennedy
	 */
	public class ScoreBoard extends MovieClip
	{

		//---------------------------------------
		// PRIVATE VARIABLES
		//---------------------------------------
        private var _isOpen:Boolean = false;
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
		
		public function set isOpen(value:Boolean):void
		{
			trace("ScoreBoard::set isOpen("+value+")");
			_isOpen = value;
		}
		
		public function get isOpen():Boolean
		{
			return _isOpen;
		}
		
		//---------------------------------------
		// PRIVATE METHODS
		//---------------------------------------
		private function init(e:Event=null):void
		{
			trace("ScoreBoard::init()");
			this.stop();
			removeEventListener(Event.ADDED_TO_STAGE,init);
			
			// find CourseFileNocturnalGame
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
			trace("ScoreBoard::findGameFile():gamefile not found");
            return false;
        }
        
		private function openScoreBoard():void
		{
			trace("ScoreBoard::openScoreBoard()");
			this.isOpen = true;
			TweenLite.to(this, 1, {x:"+100"});
		}
		
		private function closeScoreBoard():void
		{
			trace("ScoreBoard::closeScoreBoard()");
			this.isOpen = false;
			TweenLite.to(this, 1, {x:"-100"});
		}
		
		//---------------------------------------
		// EVENT LISTENERS
		//---------------------------------------
		
        private function onScoreBoardClick(event:MouseEvent):void
        {
			trace("ScoreBoard::onScoreBoardClick()");
			if (this.isOpen)
			{
				closeScoreBoard();
			}
			else
			{
				openScoreBoard();
			}
			
        }

        private function onScoreBoardRollOver(event:MouseEvent):void
        {
			trace("ScoreBoard::onScoreBoardRollOver()");
        }

		//---------------------------------------
		// PUBLIC METHODS
		//---------------------------------------
        public function setup():void
        {
			trace("ScoreBoard::setup()");
            this.addEventListener(MouseEvent.ROLL_OVER, onScoreBoardRollOver);

			this.OpenSBtab.addEventListener(MouseEvent.CLICK, OpenSBbtn);
			this.OpenSBtab.buttonMode = true;
			this.OpenSBtab.useHandCursor = true;
        }
		
	}
}