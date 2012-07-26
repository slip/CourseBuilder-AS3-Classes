﻿/*Copyright (c) 2012 Normal Software.  All rights reserved.  The copyrights embodied in the content of this file are licensed under the BSD (revised) open source license*/package com.davita.nocturnal{	import flash.display.*;	import flash.events.*;	import fl.motion.easing.*;	import flash.text.*;	import flash.media.SoundChannel;	import flash.media.Sound;	import flash.media.SoundLoaderContext;	import flash.media.SoundTransform;	import flash.media.SoundMixer;	import flash.net.URLRequest;	import flash.net.URLVariables;	import com.greensock.*;	import flash.events.Event;	import flash.text.TextField;	import fl.controls.RadioButtonGroup;	import com.davita.events.*;	import flash.display.Sprite;	import flash.events.Event;	import flash.utils.Timer;	import flash.utils.getTimer;	import flash.events.TimerEvent;	/**	 *  base class for davita standard game files.	 *	 * @langversion ActionScript 3	 *@playerversion Flash 9.0.0	 *	 *@author Dean Hawkey	 *@since  2012	 */	public dynamic class CourseFileNocturnalGame extends MovieClip 	{	//Ian Integrate	//public var varChallenges:int = 0; // No longer needed	//public var varMiles:int = 5;    private var __courseWrapper:Object;	public var varPoints:int = 25;	public var sbOpenClose:String = "closed";	public var tf:TextFormat = new TextFormat("Arial",12,0xFFFFFF);	public var avatarLoader:Loader = new Loader();	public var instructionsReturn = false;	public var restrictCorrect2one:Boolean = false;	public var restrictScore2oneClick:Boolean = false;	public var restrict2oneHintDeduction:Boolean = false;	private var closeSBTimer:Timer = new Timer(3000,1);	private var nextFrameTimer:Timer = new Timer(3500,1);	private var _pageMask:Sprite = new Sprite();	public var pieGreen:Boolean = false;	public var pieBlue:Boolean = false;	public var pieRed:Boolean = false;	public var pieYellow:Boolean = false;	//---------------------------------------	// CONSTRUCTOR	//---------------------------------------	public function CourseFileNocturnalGame():void	{		if (stage)		{			init();		}		else		{			addEventListener(Event.ADDED_TO_STAGE, init);		}	}	//---------------------------------------	// PRIVATE METHODS	//---------------------------------------	private function init(e:Event = null):void	{		trace("CourseFileNocturnalGame::init()");;		//addEventListener(ScoreUpdatedEvent.SCORE_UPDATED, updateScore);		maskPage();		        // find the wrapper and listen for a score updated event        var success:Boolean = findWrapper();        if(success)        {            __courseWrapper.addEventListener(ScoreUpdatedEvent.SCORE_UPDATED, updateScore, false, 0, true);            dispatchEvent(new ScorePollEvent(ScorePollEvent.SCORE_POLLED));        }				setUpHelpBtn();		trace("restrictScore2oneClick = " + restrictScore2oneClick);		//Ian Integrate;		//dispatchEvent(new ScorePollEvent.SCORE_POLL);	}        private function findWrapper():Boolean    {        var curParent:DisplayObjectContainer = this.parent;        while (curParent)         {             if (curParent.hasOwnProperty("versionNumber") && curParent.hasOwnProperty("currentPage"))             {                 __courseWrapper = curParent;                trace("ScoreMarker:: found the wrapper");                return true;                // Object(curParent).loader.addEventListener("unload", dispose, false, 0, true);             }            curParent = curParent.parent;        }        trace("ScoreMarker:: not in a wrapper");        return false;    }    private function updateScore(event:ScoreUpdatedEvent):void    {        trace("ScoreMarker::updateScore(" + event.toString() + ")");        var theSuspendDataArray:Array = event.bookmarkMilesChallengesArray;        this._bookmark = theSuspendDataArray[0];        this._miles = theSuspendDataArray[1];        this._challenges = theSuspendDataArray[2];        addGlobe(_challenges);        updateTextFields();        openSB();    }        private function setUpHelpBtn():void    {        // Help Icon		this.Help_mc.visible = false;		this.Help_mc.buttonMode = true;		this.Help_mc.useHandCursor = true;		this.Help_mc.addEventListener(MouseEvent.CLICK, helpClose);    }    	private function maskPage():void	{		_pageMask.graphics.beginFill(0x000000);		_pageMask.graphics.drawRect(0,.5,1000,599.5);		addChild(_pageMask);		this.mask = _pageMask;	}	public function addPoints(addedPoints:int):void	{		OpenSB();		stage.addEventListener(Event.ENTER_FRAME, changeText);		trace("Calculating Points: " + addedPoints);		varPoints = (varPoints + addedPoints);		trace("Total Points: " + varPoints);		this.GameBoard_mc.txtPoints.text = varPoints;	}	public function delayClose(e:TimerEvent)	{		CloseSB();	}	public function moveNext(e:TimerEvent)	{		nextFrame();	}	// SCORING   ------------------++++++++++++++++++	private function correctClick(event:MouseEvent):void	{		if (restrictCorrect2one == false)		{			trace("Correct Click");			var rightSound:Sound = new SFXcorrect();			rightSound.play();			this.GameBoard_mc.txtPoints.textColor = 0x00FF66;			restrictCorrect2one = true;			addPoints(5);			this.CensusLead_mc.gotoAndStop("Correct");			var closeSBTimer:Timer = new Timer(3000,1);			closeSBTimer.addEventListener(TimerEvent.TIMER, delayClose);			closeSBTimer.start();			nextFrameTimer.addEventListener(TimerEvent.TIMER, moveNext);			nextFrameTimer.start();			restrict2oneHintDeduction = true;		}		else		{			restrictScore2oneClick = true;			var rightSound2:Sound = new SFXcorrect();			rightSound2.play();			nextFrameTimer.addEventListener(TimerEvent.TIMER, moveNext);			nextFrameTimer.start();			this.CensusLead_mc.gotoAndStop("Correct");			trace("Already added to score, not doing it again.");		}	}	private function correctInit():void	{		CorrectBTN_mc.addEventListener(MouseEvent.CLICK, correctClick);		CorrectBTN_mc.buttonMode = true;		CorrectBTN_mc.useHandCursor = true;		restrictScore2oneClick = false;		restrictCorrect2one = false;	}	private function IncorrectInit():void	{		IncorrectClick_mc.addEventListener(MouseEvent.CLICK, incorrectClick);		IncorrectClick_mc.buttonMode = true;		IncorrectClick_mc.useHandCursor = true;	}	private function incorrectClick(event:MouseEvent):void	{		if (restrictScore2oneClick == false)		{			trace("Incorrect Click");			this.GameBoard_mc.txtPoints.textColor = 0xFF0000;			restrictScore2oneClick = true;			addPoints(-5);			this.CensusLead_mc.gotoAndStop("Incorrect");			var closeSBTimer:Timer = new Timer(3000,1);			closeSBTimer.addEventListener(TimerEvent.TIMER, delayClose);			closeSBTimer.start();			var wrongSound:Sound = new SFXwrong();			wrongSound.play();			function delayClose(e:TimerEvent)			{				CloseSB();			}		}		else		{			var wrongSound2:Sound = new SFXwrong();			wrongSound2.play();			this.CensusLead_mc.gotoAndStop("Incorrect2");			trace("Already deducted score, not doing it again.");		}	}	//Ian Integrate --- No longer needed	/*public function addChallenges(addedChallenge:int):void	{	stage.addEventListener(Event.ENTER_FRAME, changeText);	trace("Adding Challenge Points: " + addedChallenge);	varChallenges = (varChallenges + addedChallenge);	trace("Total Challenge Points: " + varChallenges);	this.GameBoard_mc.txtChallenges.text = varChallenges;	setScore();	}*/	// Make sure text changes	public function changeText(evt:Event)	{		this.GameBoard_mc.txtPoints.text = varPoints;		stage.removeEventListener(Event.ENTER_FRAME, changeText);	}	// [*********** Navigation Functions **************]	// Use this function for Next Button before the game starts. --- No Clipboard --- No Scoreboard calls	public function nextBtnBGSetup()	{		this.Next_BTNwBG_mc.visible = true;		this.Next_BTNwBG_mc.Next_BTN_mc.addEventListener(MouseEvent.CLICK, nextFrameBtnB4game);		this.Next_BTNwBG_mc.Next_BTN_mc.buttonMode = true;		this.Next_BTNwBG_mc.Next_BTN_mc.useHandCursor = true;	}	public function nextBtnSetup()	{		this.Next_BTN_mc.addEventListener(MouseEvent.CLICK, nextFrameBtn);		this.Next_BTN_mc.buttonMode = true;		this.Next_BTN_mc.useHandCursor = true;		this.Next_BTN_mc.visible = false;	}	private function helpClose(event:MouseEvent):void	{		this.Help_mc.visible = false;	}	public function helpOpen(event:MouseEvent):void	{		this.Help_mc.visible = true;		var timeline:TimelineLite = new TimelineLite();		timeline.append(TweenLite.from(this.Help_mc, 1, {alpha:0}));		timeline.append(TweenLite.to(this.Help_mc, 1, {alpha:1}));	}	//Animates Next Button Entry;	public function nxtBtnIn(mc:MovieClip):void	{		stop();		mc.visible = true;		this.Next_BTNwBG_mc.Next_BTN_mc.visible = true;		var timeline:TimelineLite = new TimelineLite();		timeline.append(TweenLite.to(mc,1.5, {alpha:1,x:925}));	}	// Delays the entry of next button until time specified. For timing with end of avatar animation.;	public function delayNxtBtn(delayTime):void	{		this.Next_BTN_mc.visible = true;		var timeline:TimelineLite = new TimelineLite({onComplete:stop});		timeline.append(TweenLite.from(this.Next_BTN_mc, 1, {alpha:0,delay:delayTime}));		timeline.append(TweenLite.to(this.Next_BTN_mc, 1, {alpha:1}));	}	// Delays the entry of next button until time specified. For timing with end of avatar animation.;	public function delayBGNxtBtn(delayTime):void	{		this.Next_BTNwBG_mc.visible = true;		var timeline:TimelineLite = new TimelineLite({onComplete:stop});		timeline.append(TweenLite.from(this.Next_BTNwBG_mc, 1, {alpha:0,delay:delayTime}));		timeline.append(TweenLite.to(this.Next_BTNwBG_mc, 1, {alpha:1}));	}	//Animates Next Button Entry;	public function nxtBtnOut(mc:MovieClip):void	{		stop();		mc.visible = true;		this.Next_BTNwBG_mc.Next_BTN_mc.visible = true;		var timeline:TimelineLite = new TimelineLite();		timeline.append(TweenLite.to(mc,.5, {alpha:1,x:1025}));	}	// Next Button Click Event;	public function nextFrameBtn(event:MouseEvent):void	{		nextFrame();		var timeline:TimelineLite = new TimelineLite({onComplete:stop});		if (GameBoard_mc != null)		{			if (sbOpenClose == "open")			{				timeline.append(TweenLite.to(this.GameBoard_mc,1, {alpha:1,x:-282}));				sbOpenClose = "closed";			}		}		else		{			trace("Storyboard should be closed");			trace(sbOpenClose);		}	}	public function nextFrameBtnB4game(event:MouseEvent):void	{		nextFrame();	}	//  [**************** Content Tweening *********************];	// Text Box Standard Fade in	public function txtFadeIn(mc:MovieClip):void	{		stop();		mc.alpha = 0;		var timeline:TimelineLite = new TimelineLite({onComplete:stop});		timeline.append(TweenLite.from(mc, 1, {alpha:0,x:72, y:-200}));		timeline.append(TweenLite.to(mc, 2, {alpha:1,x:72, y:-20}));		timeline.append(TweenLite.to(mc, .2, {alpha:1, colorTransform:{exposure:1.9}}));		timeline.append(TweenLite.to(mc, .25, {alpha:.9, colorTransform:{exposure:1}}));	}	// Add tip to stage where you want it to pause. Pass MC instance name and amount of time you want it to pause.	public function tipInOut(mc:MovieClip,delayIn,delayOut):void	{		var timeline:TimelineLite = new TimelineLite();		timeline.append(TweenLite.from(mc, 1, {alpha:0,delay:delayIn}));		timeline.append(TweenLite.to(mc, .5, {alpha:1}));		timeline.append(TweenLite.to(mc, 1, {alpha:0,x:1300,delay:delayOut}));	}	public function endInOut(delayTime):void	{		var endLesson:endBtn = new endBtn();		addChild(endLesson);		endLesson.x = 1200;		endLesson.y = 500;		var timeline:TimelineLite = new TimelineLite({onComplete:removeAvatar});		timeline.append(TweenLite.from(endLesson, 1, {alpha:0,x:1300,delay:delayTime}));		timeline.append(TweenLite.to(endLesson, 0, {alpha:0}));		timeline.append(TweenLite.to(avatarLoader, 1, {alpha:0,x:-1000}));		timeline.append(TweenLite.to(endLesson, 1, {alpha:1,x:500}));	}	// Move Question off stage when answered correctly	public function textOut(mc:MovieClip):void	{		var timeline:TimelineLite = new TimelineLite();		timeline.append(TweenLite.from(mc, 1.5, {alpha:1}));		timeline.append(TweenLite.to(mc, 7, {alpha:0,y:-640}));	}	// [*************** Scoreboard Functions **********************]	// Scoreboard Tab Button	public function OpenSBbtn(event:MouseEvent):void	{		var timeline:TimelineLite = new TimelineLite({onComplete:stop});		if (sbOpenClose == "closed")		{			timeline.append(TweenLite.to(this.GameBoard_mc,1.5, {alpha:1,x:-150}));			sbOpenClose = "open";		}		else		{			timeline.append(TweenLite.to(this.GameBoard_mc,1, {alpha:1,x:-224}));			sbOpenClose = "closed";		}	}	// Open Scoreboard for use in timeline calls	public function OpenSB():void	{		var timeline:TimelineLite = new TimelineLite({onComplete:stop});		timeline.append(TweenLite.to(this.GameBoard_mc, 2, {alpha:1,x:-150}));		sbOpenClose = "open";	}	// Close Scoreboard for use in timeline calls and Next Button Function	public function CloseSB():void	{		this.GameBoard_mc.txtPoints.textColor = 0xFFFFFF;		var timeline:TimelineLite = new TimelineLite({onComplete:stop});		timeline.append(TweenLite.to(this.GameBoard_mc, 2, {alpha:1,x:-224}));		sbOpenClose = "closed";	}	// Setup the Scoreboard Tab Button	/*public function gameBoardBtnSetup()	{		if (this.GameBoard_mc.x <= -200)		{			sbOpenClose = "closed";		}		else		{			sbOpenClose = "open";		}		this.GameBoard_mc.OpenSBtab.addEventListener(MouseEvent.CLICK, OpenSBbtn);		this.GameBoard_mc.OpenSBtab.buttonMode = true;		this.GameBoard_mc.OpenSBtab.useHandCursor = true;	}*/	// [*********************** Avatar/Census Functions **********************]	// AvatarPositions			public function LoadAvaInPos(xPos,yPos,avatarLoader):void		{			// Align			addChild(avatarLoader);			avatarLoader.x = xPos;			avatarLoader.y = yPos;			avatarLoader.name = "Avatar";			//avatarLoader.content.msPlay('Message 1');		}		public function avatarPreloader()		{			// Start Pre-Loader			addChild(avatarLoading);			avatarLoading.x = 500;			avatarLoading.y = 300;		}		public function removeAvatar():void		{			removeChild(getChildByName("Avatar"));			SoundMixer.stopAll();		}		//Census Functions		public function timedCensusReturn(delayTime:int):void	{		var resetCensusTimer:Timer = new Timer(delayTime,1);		resetCensusTimer.addEventListener(TimerEvent.TIMER, resetCensus);		resetCensusTimer.start();	}		public function resetCensus(e:TimerEvent)	{		if (CensusLead_mc != null)		{			this.CensusLead_mc.gotoAndStop(1);		}			}}}