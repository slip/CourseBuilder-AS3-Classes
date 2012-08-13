﻿package com.davita.roadwarrior{	import flash.display.*;	import flash.events.*;	import com.greensock.TimelineLite;	import com.greensock.TweenLite;	import com.davita.events.*;	import com.davita.roadwarrior.Globe;	import flash.net.URLRequest;	import flash.net.URLVariables;		/**	 * ...	 * @author Ian Kennedy	 */	public class ScoreMarker extends MovieClip	{		//---------------------------------------		// PRIVATE VARIABLES		//---------------------------------------		private var __courseWrapper:Object;		private var _bookmark:int;		private var _challenges:int;		private var _miles:int;		private var _pageMask:Sprite = new Sprite();		public static const INITIALIZED:String = "childInitialized";		//---------------------------------------		// CONSTRUCTOR		//---------------------------------------		public function ScoreMarker():void		{			if (stage)			{				init();			}			else			{				addEventListener(Event.ADDED_TO_STAGE, init);			}		}		//---------------------------------------		// PRIVATE METHODS		//---------------------------------------		private function init(e:Event = null):void		{			removeEventListener(Event.ADDED_TO_STAGE, init);			// mask the edges so they don't run into the wrapper			maskPage();			// find the wrapper and listen for a score updated event			var success:Boolean = findWrapper();			if(success)			{				__courseWrapper.addEventListener(ScoreUpdatedEvent.SCORE_UPDATED, updateScore, false, 0, true);				dispatchEvent(new ScorePollEvent(ScorePollEvent.SCORE_POLLED));			}		}		private function findWrapper():Boolean		{			var curParent:DisplayObjectContainer = this.parent;			while (curParent) 			{ 				if (curParent.hasOwnProperty("versionNumber") && curParent.hasOwnProperty("currentPage")) 				{ 					__courseWrapper = curParent;					trace("ScoreMarker:: found the wrapper");					return true;					// Object(curParent).loader.addEventListener("unload", dispose, false, 0, true); 				}				curParent = curParent.parent;			}			trace("ScoreMarker:: not in a wrapper");			return false;		}		private function updateScore(event:ScoreUpdatedEvent):void		{			trace("ScoreMarker::updateScore(" + event.toString() + ")");			var theSuspendDataArray:Array = event.bookmarkMilesChallengesArray;			this._bookmark = theSuspendDataArray[0];			this._miles = theSuspendDataArray[1];			this._challenges = theSuspendDataArray[2];			addGlobe(_challenges);			updateTextFields();			openSB();		}		public function addGlobe(challenges:int):void		{			trace("ScoreMarker::addGlobe("+challenges+")");			var globe:Globe = new Globe(challenges);			this.addChild(globe);			globe.x = 900;			globe.y = 600;			switch (challenges)			{				case 1 :					this.theBackground.gotoAndStop(2);					break;				case 2 :					this.theBackground.gotoAndStop(3);					break;				case 3 :					this.theBackground.gotoAndStop(4);					break;			}		}		public function changeBackground(frame:int):void		{			this.theBackground(gotoAndStop(frame)); 		}		public function endInOutB4game(delayTime:int):void		{			var endLesson:endBtn = new endBtn();			addChild(endLesson);			endLesson.x = 1200;			endLesson.y = 500;			var timeline:TimelineLite = new TimelineLite();			timeline.append(TweenLite.from(endLesson, 1, {alpha:0,x:1300,delay:delayTime}));			timeline.append(TweenLite.to(endLesson, 0, {alpha:0}));			timeline.append(TweenLite.to(endLesson, 1, {alpha:1,x:500}));		}		private function maskPage():void		{			_pageMask.graphics.beginFill(0x000000);			_pageMask.graphics.drawRect(0,.5,1000,599.5);			addChild(_pageMask);			this.mask = _pageMask;		}		private function openSB():void		{			var timeline:TimelineLite = new TimelineLite({onComplete:stop});			timeline.append(TweenLite.to(Object(root).GameBoard_mc, 2, {alpha:1,x:-40}));		}		private function updateTextFields():void		{			this.GameBoard_mc.txtMiles.text = this._miles;			this.GameBoard_mc.txtChallenges.text = this._challenges;			trace(this._miles + " " + this._challenges );		}	}}