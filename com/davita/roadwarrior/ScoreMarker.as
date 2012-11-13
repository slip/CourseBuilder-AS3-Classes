<<<<<<< HEAD
﻿package com.davita.roadwarrior
{
	import flash.display.*;
	import flash.events.*;
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	import com.davita.roadwarrior.Globe;
	import flash.net.URLRequest;
	import flash.net.URLVariables;


	/**
	 * ...
	 * @author Ian Kennedy
	 */
	public class ScoreMarker extends MovieClip
	{

		//---------------------------------------
		// PRIVATE VARIABLES
		//---------------------------------------
		private var __courseWrapper:Object;
		private var _challenges:int;
		private var _miles:int;
		private var _pageMask:Sprite = new Sprite();
		public var pageNum:String;
		public var zoom:Boolean = true;
		public var booAS2 : Boolean = false;
		public var avatarLoader : Loader = new Loader();

		//---------------------------------------
		// CONSTRUCTOR
		//---------------------------------------
		public function ScoreMarker():void
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

			// mask the edges so they don't run into the wrapper
			maskPage();

			// find the wrapper and add miles and challenges
			var success:Boolean = findWrapper();
			if (success)
			{
				_miles = __courseWrapper.miles;
				_challenges = __courseWrapper.challenges;
			}
			else
			{
				_miles = 0;
				_challenges = 5;
				// Possible Challenges 0,1,2,3,4,15,25,27,35,53,60
			}
			updateScore();
		}

		private function findWrapper():Boolean
		{
			var curParent:DisplayObjectContainer = this.parent;
			while (curParent)
			{
				if (curParent.hasOwnProperty("versionNumber") && curParent.hasOwnProperty("currentPage"))
				{
					__courseWrapper = curParent;
					return true;
				}
				curParent = curParent.parent;
			}
			return false;
		}

		public function set miles(miles:int):void
		{
			_miles = miles;
			changeText();
		}

		public function get miles():int
		{
			return _miles;
		}

		public function set challenges(challenges:int):void
		{
			_challenges = challenges;
			changeText();
		}

		public function get challenges():int
		{
			return _challenges;
		}

		private function updateScore():void
		{
			updateTextFields();
			addGlobe(_challenges);
			//scoreBoard.open();
		}

		public function addGlobe(challenges:int):void
		{
			var globe:Globe = new Globe(challenges);
			this.addChild(globe);
			globe.x = 900;
			globe.y = 600;
			// Zooms globe in to twice size and positions on stage
			if (zoom != true)
			{
				globe.x = 900;
				globe.y = 600;
			}
			else
			{
				globe.x = 300;
				globe.y = 900;
				var timeline:TimelineLite = new TimelineLite();
				timeline.append(TweenLite.from(globe, .5, {alpha:0, scaleX:0 , scaleY:0, delay:.5}) );
				timeline.append(TweenLite.to(globe, 2, {alpha:1,scaleX:2 , scaleY:2}) );
			}
		}

		public function changeBackground(frame:int):void
		{
			// Pulls from Globe.as which background frame to go to.
			theBackground.gotoAndStop(frame);
		}

		private function maskPage():void
		{
			_pageMask.graphics.beginFill(0x000000);
			_pageMask.graphics.drawRect(0,.5,1000,599.5);
			addChild(_pageMask);
			this.mask = _pageMask;
		}

		public function updateTextFields():void
		{
			// do nothing - here because it gets called from the wrapper, which works for gamefiles, but not here.
		}

		public function changeText():void
		{
			// do nothing - here because it gets called from the wrapper, which works for gamefiles, but not here.
		}

		public function revealSB(leaveOpen:Boolean = false):void
		{
			// Adds Scoreboard to stage and animates in. If leaveOpen is false it closes it again after delay
			var scoreBoard:ScoreBoard = new ScoreBoard();
			addChild(scoreBoard);
			scoreBoard.x = -281;
			scoreBoard.y = -56;
			var timeline:TimelineLite = new TimelineLite({onComplete:stop});
			if (leaveOpen == true)
			{
				timeline.append(TweenLite.to(scoreBoard, 1, {alpha:1,x:-40}));
			}
			else
			{
				timeline.append(TweenLite.to(scoreBoard, 1, {alpha:1,x:-40}));
				timeline.append(TweenLite.to(scoreBoard, 1, {alpha:1,x:-281,delay:5}));
			}
		}

		public function addSBInstructions():void
		{
			// Adds Scoreboard instructions to the stage
			var SBinstructions:sbInstructions = new sbInstructions();
			addChild(SBinstructions);
			SBinstructions.x = 215;
			SBinstructions.y = 150;
		}

		public function addEndButton(delayTime:int):void
		{
			// Adds end button and allows a delay
			var EndButton:EndBtnRW = new EndBtnRW();
			addChild(EndButton);
			EndButton.x = 1140;
			EndButton.y = 500;
			var timeline:TimelineLite = new TimelineLite({onComplete:stop});
			timeline.append(TweenLite.to(EndButton, 1, {alpha:1,x:500,delay:delayTime}));
		}
		// Avatar Functions

		public function loadAvaInPos(xPos, yPos, avatarLoader) : void {
			// Align
			addChild(avatarLoader);
			avatarLoader.x = xPos;
			avatarLoader.y = yPos;
			avatarLoader.name = "Avatar";
		}

		public function avatarPreloader() : void {
			// Start Pre-Loader
			addChild(avatarLoading);
			avatarLoading.x = 500;
			avatarLoading.y = 300;
		}

		public function avatarLoaded(e : Event) {
			removeChild(avatarLoading);
			// Check variable to see if this is an AS2 or AS3 avatar. Then play if it is AS2;
			if (booAS2 == true) {
				avatarLoader.content.msPlay('Message 1');
			}
		}

		public function removeAvatar() : void {
			if (getChildByName("Avatar") != null) {
				removeChild(getChildByName("Avatar"));
				SoundMixer.stopAll();
			}
		}

		public function sendPositions(avaPositionsX, avaPositionsY) {
			loadAvaInPos(avaPositionsX, avaPositionsY, avatarLoader);
		}

		public function setAvatarAndPosition(avatarURL : URLRequest, avaPositionsX : int, avaPositionsY : int, avatarToRemove : Boolean) {
			if (removeAvatar == true) {
				stage.SoundMixer.stopAll();
				this.removeAvatar();
				trace("CourseFileNocturnalGame::setAvatarAndPosition - Removing avatar");
			} else {
				trace("CourseFileNocturnalGame::setAvatarAndPosition - Avatar = false");
			}
			sendPositions(avaPositionsX, avaPositionsY);
			avatarPreloader();
			avatarLoader.load(avatarURL);
			avatarLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, avatarLoaded);
		}
	}
}
=======
﻿package com.davita.roadwarrior{	import flash.display.*;	import flash.events.*;	import com.greensock.TimelineLite;	import com.greensock.TweenLite;	import com.davita.roadwarrior.Globe;	import flash.net.URLRequest;	import flash.net.URLVariables;	import flash.media.SoundMixer;	import flash.utils.getDefinitionByName; 	/**	 * ...	 * @author Ian Kennedy	 */	public class ScoreMarker extends MovieClip	{		//---------------------------------------		// PRIVATE VARIABLES		//---------------------------------------		private var __courseWrapper:Object;		private var _challenges:int;		private var _miles:int;		private var _pageMask:Sprite = new Sprite();		public var pageNum:String;		public var zoom:Boolean = true;		public var booAS2:Boolean = false;		public var avatarLoader : Loader = new Loader();		//---------------------------------------		// CONSTRUCTOR		//---------------------------------------		public function ScoreMarker():void		{			if (stage)			{				init();			}			else			{				addEventListener(Event.ADDED_TO_STAGE, init);			}		}		//---------------------------------------		// PRIVATE METHODS		//---------------------------------------		private function init(e:Event = null):void		{			removeEventListener(Event.ADDED_TO_STAGE, init);			// mask the edges so they don't run into the wrapper			maskPage();			// find the wrapper and add miles and challenges			var success:Boolean = findWrapper();			if (success)			{				_miles = __courseWrapper.miles;				_challenges = __courseWrapper.challenges;			}			else			{				_miles = 0;				_challenges = 61;				// Possible Challenges 0,1,3,4,16,27,28,36,54,61			}			updateScore();		}		private function findWrapper():Boolean		{			var curParent:DisplayObjectContainer = this.parent;			while (curParent)			{				if (curParent.hasOwnProperty("versionNumber") && curParent.hasOwnProperty("currentPage"))				{					__courseWrapper = curParent;					return true;				}				curParent = curParent.parent;			}			return false;		}		public function set miles(miles:int):void		{			_miles = miles;			changeText();		}		public function get miles():int		{			return _miles;		}		public function set challenges(challenges:int):void		{			_challenges = challenges;			changeText();		}		public function get challenges():int		{			return _challenges;		}		private function updateScore():void		{			updateTextFields();			addGlobe(_challenges);			//scoreBoard.open();		}		public function addGlobe(challenges:int):void		{			var globe:Globe = new Globe(challenges);			this.addChild(globe);			globe.x = 900;			globe.y = 600;			// Zooms globe in to twice size and positions on stage			if (zoom != true)			{				globe.x = 900;				globe.y = 600;			}			else			{				globe.x = 300;				globe.y = 900;				var timeline:TimelineLite = new TimelineLite();				timeline.append(TweenLite.from(globe, .5, {alpha:0, scaleX:0 , scaleY:0, delay:.5}) );				timeline.append(TweenLite.to(globe, 2, {alpha:1,scaleX:2 , scaleY:2}) );			}		}		public function changeBackground(frame:int):void		{			// Pulls from Globe.as which background frame to go to.			theBackground.gotoAndStop(frame);		}		private function maskPage():void		{			_pageMask.graphics.beginFill(0x000000);			_pageMask.graphics.drawRect(0,.5,1000,599.5);			addChild(_pageMask);			this.mask = _pageMask;		}		public function updateTextFields():void		{			// do nothing - here because it gets called from the wrapper, which works for gamefiles, but not here.		}		public function changeText():void		{			// do nothing - here because it gets called from the wrapper, which works for gamefiles, but not here.		}		public function revealSB(leaveOpen:Boolean = false):void		{			// Adds Scoreboard to stage and animates in. If leaveOpen is false it closes it again after delay			var scoreBoard:ScoreBoard = new ScoreBoard();			addChild(scoreBoard);			scoreBoard.x = -281;			scoreBoard.y = -56;			var timeline:TimelineLite = new TimelineLite({onComplete:stop});			if (leaveOpen == true)			{				timeline.append(TweenLite.to(scoreBoard, 1, {alpha:1,x:-40}));			}			else			{				timeline.append(TweenLite.to(scoreBoard, 1, {alpha:1,x:-40}));				timeline.append(TweenLite.to(scoreBoard, 1, {alpha:1,x:-281,delay:5}));			}		}		public function addSBInstructions():void		{			// Adds Scoreboard instructions to the stage			var SBinstructions:sbInstructions = new sbInstructions();			addChild(SBinstructions);			SBinstructions.x = 215;			SBinstructions.y = 150;		}		public function addEndButton(delayTime:int):void		{			// Adds end button and allows a delay			var EndButton:EndBtnRW = new EndBtnRW();			addChild(EndButton);			EndButton.x = 1140;			EndButton.y = 560;			var timeline:TimelineLite = new TimelineLite({onComplete:stop});			timeline.append(TweenLite.to(EndButton, 1, {alpha:1,x:500,delay:delayTime}));		}		public function playCurrentAudio(audioLink):void		{			SoundMixer.stopAll();			trace("audioLink: " + audioLink);			var SoundClass:Class = getDefinitionByName(audioLink) as Class;			var audioVO:Sound = new SoundClass();			var voChannel:SoundChannel = audioVO.play();		}		public function wrapperNext(event):void		{			if (__courseWrapper)			{				__courseWrapper.nextPage(event);			}		}		public function wrapperReplay(event):void		{			if (__courseWrapper)			{				__courseWrapper.reloadPage(event);			}		}	}}
>>>>>>> Avatar Gone Audio Methods added
