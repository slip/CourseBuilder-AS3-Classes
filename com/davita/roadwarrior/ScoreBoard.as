package com.davita.roadwarrior
{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.Timer;
	import com.greensock.TimelineLite;
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
				this.addEventListener(Event.ADDED_TO_STAGE,init);
			}
		}

		//---------------------------------------
		// PRIVATE METHODS
		//---------------------------------------
		private function init(e:Event=null):void
		{
			this.stop();
			removeEventListener(Event.ADDED_TO_STAGE,init);

			// find GameFile
			var success:Boolean = findGameFile();
			if(success)
			{
				this.buttonMode = true;
				this.useHandCursor = true;
				updateTextFields();
				addEventListener(MouseEvent.CLICK, onScoreBoardClick);
			}
		}

		private function findGameFile():Boolean
		{
			var curParent:DisplayObjectContainer = this.parent;
			while (curParent)
			{
				if (curParent.hasOwnProperty("miles"))
				{
					__gameFile = curParent;
					return true;
				}
				curParent = curParent.parent;
			}
			return false;
		}

		//---------------------------------------
		// PUBLIC METHODS
		//---------------------------------------

		public function open():void
		{
			if (isOpen == false) {
				var timeline : TimelineLite = new TimelineLite({onComplete:stop});
				timeline.append(TweenLite.to(this, 1, {alpha:1, x:-40}));
				timeline.append(TweenLite.to(this, 1, {alpha:1, x:-282, delay:1}));
			}
		}

		public function close():void
		{
			var timeline : TimelineLite = new TimelineLite({onComplete:stop});
			timeline.append(TweenLite.to(this, 2, {alpha:1, x:-282}));
			isOpen = false;
		}

		public function delayClose(seconds:int)
		{
			var myTimer:Timer = new Timer(seconds * 1000,1);
			myTimer.addEventListener(TimerEvent.TIMER, close);
			myTimer.start();
		}

		public function updateTextFields():void
		{
			this.txtMiles.text = __gameFile.miles;
			this.txtChallenges.text = __gameFile.challenges;
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
	}
}