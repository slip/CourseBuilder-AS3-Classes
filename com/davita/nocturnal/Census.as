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
	public class Census extends MovieClip
	{

		//---------------------------------------
		// PRIVATE VARIABLES
		//---------------------------------------
        
        private var _censusState:String;
        private var __gameFile:Object;

		//---------------------------------------
		// CONSTRUCTOR
		//---------------------------------------
		public function Census():void
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
		// ACCESSORS
		//---------------------------------------
		public function get censusState():String
		{
			return _censusState;
		}
		
		public function set censusState(value:String):void
		{
			trace("Census::set censusState("+value+")");
			_censusState = value;
		}
		
		//---------------------------------------
		// PRIVATE METHODS
		//---------------------------------------
		private function init(e:Event=null):void
		{
			trace("Census::init()");
			removeEventListener(Event.ADDED_TO_STAGE,init);

			this.stop();
            this.buttonMode = true;
            this.useHandCursor = true;
			
			// find parent file
			var success:Boolean = findGameFile();
			if(success)
			{
                addEventListener(MouseEvent.ROLL_OVER, onCensusRollOver);
                addEventListener(MouseEvent.CLICK, onCensusClick);
	            __gameFile.restrictScore2oneClick = false;
	            __gameFile.restrict2oneHintDeduction = false;
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
					trace("Census::findGameFile():gamefile found");
                    return true;
                }
                curParent = curParent.parent;
            }
			trace("Census::findGameFile():gamefille not found");
            return false;
        }
        
		//---------------------------------------
		// EVENT HANDLERS
		//---------------------------------------
        private function onCensusClick(event:MouseEvent):void
        {
			trace("Census::onCensusClick(CLICK):_censusState = " + _censusState);
			this.gotoAndStop(_censusState);
            __gameFile.scoreBoard_mc.txtPoints.textColor = 0xFF0000;
            var wrongSound:Sound = new SFXidea();
            wrongSound.play();
            
			
            if (__gameFile.restrict2oneHintDeduction == false)
            {
                __gameFile.addPoints(-5);
                __gameFile.restrict2oneHintDeduction = true;
            }
            else
            {    
                __gameFile.restrict2oneHintDeduction = true;
            }
        }

        private function onCensusRollOver(event:MouseEvent):void
        {
			trace("Census::onCensusRollOver(ROLL_OVER)");
            this.gotoAndStop(2);
        }

        public function timedReturn( delayTime:int )
        {
        	var resetCensusTimer:Timer = new Timer(delayTime,1);
			resetCensusTimer.addEventListener(TimerEvent.TIMER, reset);
			resetCensusTimer.start();
        }

        public function reset( e:TimerEvent )
        {
        	gotoAndStop(1);
        }
	}
}