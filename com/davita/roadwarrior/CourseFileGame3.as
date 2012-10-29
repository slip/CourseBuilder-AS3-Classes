﻿/*
Copyright (c) 2012 Normal Software.  All rights reserved.
The copyrights embodied in the content of this file are licensed under the BSD (revised) open source license
 */
package com.davita.roadwarrior
{
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;

	import flash.display.*;
	import flash.events.*;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.text.*;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.utils.Timer;

	import fl.controls.RadioButtonGroup;

	/**
	 *  base class for davita standard game files.
	 *
	 * @langversion ActionScript 3
	 *@playerversion Flash 9.0.0
	 *
	 *@author Dean Hawkey
	 *@since  2012
	 */
	public dynamic class CourseFileGame3 extends MovieClip {;
	private var __courseWrapper:Object;
	private var _challenges:int;
	private var _miles:int;
	public var tf:TextFormat = new TextFormat("Arial",12,0xFFFFFF);
	public var avatarLoader : Loader = new Loader();
	private var _pageMask : Sprite = new Sprite();
	// ---------------------------------------
	// Dean's INSTANCE VARIABLES
	// ---------------------------------------
	public var specificFrameAdvance:String;
	public var delayTime:int;
	public var myAnimator : RWAnimator = new RWAnimator();
	public var myNextButtonWithBackground:NextButtonRW;
	public var endButton : EndBtnRW = new EndBtnRW();
	public var booAS2:Boolean = false;

	// ---------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------
	public function CourseFileGame3():void
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

	// ---------------------------------------
	// PRIVATE METHODS
	// ---------------------------------------
	private function init(e : Event = null):void
	{
		maskPage();
		avatarLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, avatarLoaded);
		// find the wrapper and listen for a score updated event;
		var success:Boolean = findWrapper();
		if (success)
		{
			__courseWrapper.disableNextButton();
			this.miles = __courseWrapper.miles;
			this.challenges = __courseWrapper.challenges;
		}
		else
		{
			this.miles = 15;
			this.challenges = 0;
		}

		if (this.getChildByName("Clipboard_MC") != null)
		{
			this.Clipboard_MC.buttonMode = true;
			this.Clipboard_MC.useHandCursor = true;
		}
	}

	private function findWrapper():Boolean
	{
		var curParent:DisplayObjectContainer = this.parent;
		while (curParent)
		{
			if (curParent.hasOwnProperty("versionNumber") && curParent.hasOwnProperty("currentPage"))
			{
				__courseWrapper = curParent;
				trace("CourseFileGame3:: found the wrapper");
				return true;
			}
			curParent = curParent.parent;
		}
		trace("CourseFileGame3:: not in a wrapper");
		return false;
	}

	private function maskPage():void
	{
		_pageMask.graphics.beginFill(0x000000);
		_pageMask.graphics.drawRect(0, .5, 1000, 599.5);
		addChild(_pageMask);
		this.mask = _pageMask;
	}

	// ---------------------------------------
	// Public METHODS
	// ---------------------------------------
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

	private function sendScore():void
	{
		if (__courseWrapper)
		{
			__courseWrapper.miles = this.miles;
			__courseWrapper.challenges = this.challenges;
		}
	}

	public function addMiles(addedMiles : int, playSound : String = "right"):void
	{
		this.miles = (this.miles + addedMiles);
		sendScore();
		scoreBoard.open();
		if (playSound == "right")
		{
			playCorrectBell();
		}
		else if (playSound == "wrong")
		{
			playWrongBuzzer();
		}
	}

	public function addChallenges(addedChallenge : int):void
	{
		this.challenges = (this.challenges + addedChallenge);
		sendScore();
	}

	// Make sure text changes
	public function changeText():void
	{
		if (this.scoreBoard)
		{
			scoreBoard.txtChallenges.text = this.challenges;
			scoreBoard.txtMiles.text = this.miles;
		}
	}

	// ---------------------------------------
	// Clipboard Methods
	// ---------------------------------------
	// On click open Clipboard
	public function cbStartBtn(event : MouseEvent):void
	{
		Clipboard_MC.gotoAndPlay("CB_Start");
	}

	// Close the Clipboard;
	public function closeClipBoard():void
	{
		if (Clipboard_MC != null)
		{
			this.Clipboard_MC.gotoAndStop(1);
		}
	}

	// ---------------------------------------;
	// Avatar Methods
	// ---------------------------------------
	// Avatar Positions
	// New Avatar Methods
	public function loadAvaInPos(xPos, yPos, avatarLoader):void
	{
		// Align
		addChild(avatarLoader);
		avatarLoader.x = xPos;
		avatarLoader.y = yPos;
		avatarLoader.name = "Avatar";
	}

	public function avatarPreloader():void
	{
		// Start Pre-Loader
		addChild(avatarLoading);
		avatarLoading.x = 500;
		avatarLoading.y = 300;
	}

	public function avatarLoaded(e : Event)
	{
		removeChild(avatarLoading);
		// Check variable to see if this is an AS2 or AS3 avatar. Then play if it is AS2;
		if (booAS2 == true)
		{
			avatarLoader.content.msPlay('Message 1');
		}
	}

	public function removeAvatar():void
	{
		if (getChildByName("Avatar") != null)
		{
			removeChild(getChildByName("Avatar"));
			SoundMixer.stopAll();
		}
	}

	public function sendPositions(avaPositionsX, avaPositionsY)
	{
		loadAvaInPos(avaPositionsX, avaPositionsY, avatarLoader);
	}

	public function setAvatarAndPosition(avatarURL : URLRequest, avaPositionsX : int, avaPositionsY : int, avatarToRemove : Boolean)
	{
		if (removeAvatar == true)
		{
			stage.SoundMixer.stopAll();
			this.removeAvatar();
			trace("CourseFileNocturnalGame::setAvatarAndPosition - Removing avatar");
		}
		else
		{
			trace("CourseFileNocturnalGame::setAvatarAndPosition - Avatar = false");
		}
		sendPositions(avaPositionsX, avaPositionsY);
		avatarPreloader();
		avatarLoader.load(avatarURL);
	}

	// ---------------------------------------;
	// End Button Methods
	// ---------------------------------------
	// Add NextButtonWithBackground to Stage
	private function addEndButtonWithDelay(delayTime : int):void
	{
		trace("addEndButtonWithDelay: " + delayTime);

		var timeline:TimelineLite = new TimelineLite({onComplete:stop});

		this.endButton = new EndBtnRW();
		this.endButton.x = 1050;
		this.endButton.y = 530;
		this.endButton.name = "endButton";
		this.addChild(endButton);

		// now animate the button alpha and position
		timeline.append(TweenLite.from(endButton, 1, {alpha:0, delay:delayTime}));
		timeline.append(TweenLite.to(endButton, 1, {alpha:1, x:500}));
	}

	// ---------------------------------------
	// Next Button Methods
	// ---------------------------------------
	// Add NextButtonWithBackground to Stage
	private function addNextButtonWithBackground(frameLabel : String, delayTime : int, nextHasBackground : Boolean):void
	{
		var timeline:TimelineLite = new TimelineLite({onComplete:stop});

		// this.myNextButtonWithBackground = new NextButtonRW(frameLabel);
		this.myNextButtonWithBackground = new NextButtonRW();
		myNextButtonWithBackground.frameLabel = frameLabel;
		this.myNextButtonWithBackground.x = 1050;
		// Determine whether Next Button needs BG then set the X and Y coordinates
		if (nextHasBackground == true)
		{
			// If it has a BG place it here
			this.myNextButtonWithBackground.y = 530;
		}
		else
		{
			// If it does not then put it here
			this.myNextButtonWithBackground.y = 475;
		}
		this.myNextButtonWithBackground.name = "myNextButtonWithBackground";
		this.addChild(myNextButtonWithBackground);

		// add a listener to myNextButtonWithBackground
		this.myNextButtonWithBackground.addEventListener(MouseEvent.CLICK, animateNextButtonOut);

		// now animate the button alpha and position;
		timeline.append(TweenLite.from(myNextButtonWithBackground, 1, {alpha:0, delay:delayTime}));
		timeline.append(TweenLite.to(myNextButtonWithBackground, 1, {alpha:1, x:925}));
	}

	private function animateNextButtonOut(event : MouseEvent):void
	{
		TweenLite.to(getChildByName("myNextButtonWithBackground"), 1, {alpha:0, x:1050, onComplete:removeNextButtonWithBackground});
	}

	private function removeNextButtonWithBackground():void
	{
		this.removeChild(getChildByName("myNextButtonWithBackground"));
	}

	// ---------------------------------------
	// Audio Methods
	// ---------------------------------------
	private function playWrongBuzzer():void
	{
		var sndWrong : audioWrong = new audioWrong();
		var wrongChannel:SoundChannel = sndWrong.play();
	}

	private function playCorrectBell():void
	{
		var sndCorrect : audioCorrect = new audioCorrect();
		var correctChannel:SoundChannel = sndCorrect.play();
	}

	public function wrapperNext(event):void
	{
		if (__courseWrapper)
		{
			__courseWrapper.nextPage(event);
		}

	}

	public function wrapperReplay(event):void
	{
		if (__courseWrapper)
		{
			__courseWrapper.reloadPage(event);
		}

	}
}
}