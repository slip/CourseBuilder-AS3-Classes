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
		// PRIVATE METHODS
		//---------------------------------------
		private function init(e:Event=null):void
		{
			trace("Census::init()");
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
                    trace("ScoreMarker:: found the gameFile");
                    return true;
                }
                curParent = curParent.parent;
            }
            trace("ScoreMarker:: not in a wrapper");
            return false;
        }

        
        // Census Lead Functions
        private function censusSetup():void
        {
			trace("Census::censusSetup()");
            this.addEventListener(MouseEvent.MOUSE_OVER, censusRollOver);
            this.buttonMode = true;
            this.useHandCursor = true;
            restrictScore2oneClick = false;
            restrict2oneHintDeduction = false;
        }
        
        private function setState(state:String):void
        {
			trace("Census::setState("+state+")");
            this._censusState = state;
        }
        
        private function onCensusClick(event:MouseEvent):void
        {
			trace("Census::onCensusClick("+event+")");
            switch (state)
            {
                case "Pg16" :
                    this.gotoAndStop("Pg16");
                    break;
                case "Pg17" :
                    this.gotoAndStop("Pg17");
                    break;
                default :
                    trace("Census Page numbers not properly setup");
            }
            
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
            this.gotoAndStop(2);
        }

        /*
        GameBoard_mc::GameBoard.as // another class with closeSB(); openSB; delayClose()
        CensusLead_mc::Census.as
        
        */

        private function cencusClickTip(pageNum):void
        {
    
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