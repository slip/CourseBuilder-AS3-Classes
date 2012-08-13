package com.davita.nocturnal
{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.Timer;
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	import com.greensock.plugins.TweenPlugin; 
	import com.greensock.plugins.AutoAlphaPlugin; 
	TweenPlugin.activate([AutoAlphaPlugin]);

	/**
	 * ...
	 * @author Ian Kennedy
	 */
	public class Instructions extends MovieClip
	{

		//---------------------------------------
		// PRIVATE VARIABLES
		//---------------------------------------
        private var __gameFile:Object;
        private var _isOpen:Boolean = false;
        private var _instructionsState:String;
        
		//---------------------------------------
		// CONSTRUCTOR
		//---------------------------------------
		public function Instructions():void
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
			trace("Instructions::init()");
			removeEventListener(Event.ADDED_TO_STAGE,init);

			this.stop();

			new TweenLite(instructionsText, 0, {autoAlpha:0});
			new TweenLite(background, 0, {autoAlpha:0});
			new TweenLite(instructionsCloseBtn, 0, {autoAlpha:0});
			
			// find CourseFileNocturnalGame
			var success:Boolean = findGameFile();
			if(success)
			{
				this.instructionsIcon.buttonMode = true;
				this.instructionsIcon.useHandCursor = true;

				instructionsIcon.addEventListener(MouseEvent.CLICK, onInstructionsClick);
				instructionsCloseBtn.addEventListener(MouseEvent.CLICK, onInstructionsClick);
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
					trace("Instructions::findGameFile():gamefile found");
                    return true;
                }
                curParent = curParent.parent;
            }
			trace("Instructions::findGameFile():gamefile not found");
            return false;
        }
        
		private function open(event:MouseEvent):void
		{
			trace("Instructions::openInstructions()");
			this.isOpen = true;
			var timeline:TimelineLite = new TimelineLite();
			timeline.append( new TweenLite(background, 1, {autoAlpha:1}) );
			timeline.append( new TweenLite(instructionsText, 1, {autoAlpha:1}) );
			timeline.append( new TweenLite(instructionsCloseBtn, 1, {autoAlpha:1}) );
		}
		
		private function close(event:MouseEvent):void
		{
			trace("Instructions::closeInstructions()");
			this.isOpen = false;
			var timeline:TimelineLite = new TimelineLite({onComplete:returnToStart});
			timeline.append( new TweenLite(instructionsCloseBtn, .25, {autoAlpha:0}) );
			timeline.append( new TweenLite(instructionsText, 1, {autoAlpha:0}) );
			timeline.append( new TweenLite(background, 1, {autoAlpha:0}) );
		}

		//---------------------------------------
		// GETTER / SETTERS
		//---------------------------------------
		
		public function set isOpen(value:Boolean):void
		{
			trace("Instructions::set isOpen("+value+")");
			_isOpen = value;
		}
		
		public function get isOpen():Boolean
		{
			return _isOpen;
		}
			
		//---------------------------------------
		// EVENT LISTENERS
		//---------------------------------------
		
        private function onInstructionsClick(event:MouseEvent):void
        {
			trace("Instructions::onInstructionsClick()");
			if (_isOpen) { this.close(event); }
			else { this.open(event); }
        }

		//---------------------------------------
		// PUBLIC METHODS
		//---------------------------------------

		//---------------------------------------
		// ACCESSORS
		//---------------------------------------
		public function get instructionsState():String
		{
			return _instructionsState;
		}
		
		public function set instructionsState(value:String):void
		{
			trace("Census::set instructionsState("+value+")");
			_instructionsState = value;
			this.instructionsText.gotoAndStop(_instructionsState);
		}
	}
}