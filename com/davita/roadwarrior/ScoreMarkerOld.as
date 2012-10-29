package com.davita.roadwarrior
{
	import flash.display.*;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	import com.davita.events.ScoreUpdatedEvent;
	import com.davita.roadwarrior.Globe;


	/**
	 * ...
	 * @author Ian Kennedy
	 */
	public class ScoreMarkerOld extends MovieClip
	{

		//---------------------------------------
		// PRIVATE VARIABLES
		//---------------------------------------
		private var _challenges:int;
		private var _miles:int;
		private var _pageMask:Sprite = new Sprite();


		//---------------------------------------
		// CONSTRUCTOR
		//---------------------------------------
		public function ScoreMarkerOld():void
		{
			if (stage)
			{
				init();
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}

		//---------------------------------------
		// PRIVATE METHODS
		//---------------------------------------
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(ScoreUpdatedEvent.SCORE_CHANGED, updateScore);
			dispatchEvent(new ScoreUpdatedEvent(ScoreEvent.SCORE_CHANGED, [1,5,1]));
			updateTextFields();
			maskPage();
			addGlobe(_challenges);
		}

		public function addGlobe(challenges:int):void
		{
			var globe:Globe = new Globe(challenges);
			addChild(globe);
			globe.x = 900;
			globe.y = 600;
		}

		private function maskPage():void
		{
			_pageMask.graphics.beginFill(0x000000);
			_pageMask.graphics.drawRect(0,.5,1000,599.5);
			addChild(_pageMask);
			this.mask = _pageMask;
		}

		public function openSB():void
		{
			var timeline:TimelineLite = new TimelineLite({onComplete:stop});
			timeline.append(TweenLite.to(Object(root).GameBoard_mc, 2, {alpha:1,x:-40}));
		}

		private function updateScore(event:ScoreUpdatedEvent):void
		{
			trace("ScoreMarker::updateScore()" + event.toString());
			var theSuspendDataArray:Array = event.gameInfoArray;
			this._miles = theSuspendDataArray[1];
			this._challenges = theSuspendDataArray[2];
			updateTextFields();
		}


		private function updateTextFields():void
		{
			this.GameBoard_mc.txtMiles.text = this._miles;
			this.GameBoard_mc.txtChallenges.text = this._challenges;
			trace(this._miles + " " + this._challenges )
		}
		
			public function playSBtip():void
		{
			SBinstructions_mc.play();
		}

	}
}