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
		// GETTER / SETTERS
		//---------------------------------------
		
		public function get censusState():String
		{
			return _censusState;
		}
		
		public function set censusState(value:String):void
		{
			trace("Census::set censusState()");
			_censusState = value;
		}
		
		//---------------------------------------
		// PRIVATE METHODS
		//---------------------------------------
		private function init(e:Event=null):void
		{
			trace("Census::init()");
			this.stop();
			removeEventListener(Event.ADDED_TO_STAGE,init);
			var success:Boolean = findGameFile();
			if(success)
			{
                addEventListener(MouseEvent.ROLL_OVER, onCensusRollOver);
                addEventListener(MouseEvent.CLICK, onCensusClick);
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

        
        // Census Lead Functions
        public function censusSetup():void
        {
			trace("Census::censusSetup()");
            this.addEventListener(MouseEvent.ROLL_OVER, onCensusRollOver);
            this.buttonMode = true;
            this.useHandCursor = true;
            restrictScore2oneClick = false;
            restrict2oneHintDeduction = false;
        }
        
        private function onCensusClick(event:MouseEvent):void
        {
			trace("Census::onCensusClick(CLICK):_censusState = " + _censusState);
			
			this.gotoAndStop(_censusState);
            
            if (__gameFile.restrict2oneHintDeduction == false)
            {
                trace("restrictScore2oneClick: False, deducting 5");
                __gameFile.addPoints(-5);
                __gameFile.restrict2oneHintDeduction = true;
            }
            else
            {
    
                trace("restrictScore2oneClick: True, No Deduction");
                __gameFile.restrict2oneHintDeduction = true;
            }
        }

        private function onCensusRollOver(event:MouseEvent):void
        {
			trace("Census::onCensusRollOver(ROLL_OVER)");
            this.gotoAndStop(2);
        }

        private function cencusClickTip(pageNum):void
        {
    		trace("Census::cencusClickTip()");
            this.GameBoard_mc.txtPoints.textColor = 0xFF0000;
            var closeSBTimer:Timer = new Timer(3000,1);
            closeSBTimer.addEventListener(TimerEvent.TIMER, delayClose);
            closeSBTimer.start();
            var wrongSound:Sound = new SFXidea();
            wrongSound.play();
            function delayClose(e:TimerEvent)
            {
    
                CloseSB();
            }
        }
	}
}