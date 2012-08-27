package com.davita.nocturnal
{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.Timer;
	import com.greensock.TweenLite;

	/**
	 * ScoreBoard for CourseFileNocturnalGame
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
				this.buttonMode = true;
				this.useHandCursor = true;
                addEventListener(MouseEvent.ROLL_OVER, onScoreBoardRollOver);
                addEventListener(MouseEvent.CLICK, onScoreBoardClick);
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
					trace("ScoreBoard::findGameFile():gamefile found");
                    return true;
                }
                curParent = curParent.parent;
            }
			trace("ScoreBoard::findGameFile():gamefile not found");
            return false;
        }
        
		//---------------------------------------
		// PUBLIC METHODS
		//---------------------------------------

		public function open():void
		{
			trace("ScoreBoard::openScoreBoard()");
			this.isOpen = true;
			TweenLite.to(this, 1, {x:-130});
		}
		
		public function close():void
		{
			trace("ScoreBoard::closeScoreBoard()");
			this.isOpen = false;
			TweenLite.to(this, 1, {x:-225});
		}

		public function delayClose(seconds:int)
		{
			var myTimer:Timer = new Timer(seconds * 1000,1);
			myTimer.addEventListener(TimerEvent.TIMER, close);
			myTimer.start();
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
		// EVENT LISTENERS
		//---------------------------------------
		
        private function onScoreBoardClick(event:MouseEvent):void
        {
			trace("ScoreBoard::onScoreBoardClick()");
			if (this.isOpen)
			{
				this.close();
			}
			else
			{
				this.open();
			}
			
        }

        private function onScoreBoardRollOver(event:MouseEvent):void
        {
			// trace("ScoreBoard::onScoreBoardRollOver()");
        }

	}
}