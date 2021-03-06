﻿/*
Copyright (c) 2009 Normal Software.  All rights reserved.
The copyrights embodied in the content of this file are licensed under the BSD (revised) open source license
*/
package com.davita.documents {
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Matrix;
	import fl.motion.easing.*;
	import flash.text.*;
	import flash.utils.Timer;
	import flash.ui.*;
	import flash.media.SoundMixer;

	import com.davita.events.*;
	import com.davita.buttons.*;
	import com.davita.utilities.CBAnimator;
    import com.davita.utilities.Console;

	import com.greensock.*;
    import com.greensock.easing.*;

	import com.yahoo.astra.fl.managers.AlertManager;
	/**
	 *	All loaded swfs should have these properties and methods.
	 *	So all document classes except CourseWrapper should
	 *	inherit from CourseSwf.
	 *
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *
	 *	@author Ian Kennedy
	 *	@since  22.02.2008
	 */
	public class CourseSwf extends MovieClip {

		//--------------------------------------
		// CLASS CONSTANTS
		//--------------------------------------
		private var _pageMask:Sprite = new Sprite();
		private var _background:Sprite = new Sprite();
		private var _backgroundRemoved:Boolean = false;

		public var __courseWrapper:Object;
		public var animator:CBAnimator;
        public var console:Console = new Console();

		/**
		 *	the audio transcription to be used in the closed captions.
		 */
		private var _ccText:String;
		public var hasAudio:Boolean = new Boolean();

		/**
         * Private property to internally keep track of whether or
         * not the current movie clip is being played
         */
		private var _isPlaying:Boolean = true;

		/**
         * Getter function creating a public, read-only isPlaying
         * property allowing users to get but not set the _isPlaying
         *  property to determine if the movie clip is playing
         */
        public function get isPlaying():Boolean {
            return _isPlaying;
        }

		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------

		/**
		 *	@Constructor
		 */
		public function CourseSwf(){
			super();
			addEventListener(Event.ADDED_TO_STAGE, initialize);
			addEventListener(Event.REMOVED_FROM_STAGE, dealloc);
			animator = new CBAnimator();
		}

		private function initialize(event:Event):void
		{
			stage.align = StageAlign.TOP_LEFT;
			removeEventListener(Event.ADDED_TO_STAGE, initialize);

			drawBackground();
			maskPage();

			// find the wrapper and add listeners
			var success:Boolean = findWrapper();
			if(success)
			{
				//__courseWrapper.addEventListener(ScoreUpdatedEvent.SCORE_UPDATED, updateScore, false, 0, true);
				this.hasAudio = false;
				trace("CourseSwf::initialize(): wrapper found");
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
					trace("CourseSwf:: found the wrapper");
					return true;
					// Object(curParent).loader.addEventListener("unload", dispose, false, 0, true);
				}
				curParent = curParent.parent;
			}
			__courseWrapper = null;
			trace("CourseSwf:: not in a wrapper");
			return false;
		}

		private function dealloc(event:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, dealloc);
			SoundMixer.stopAll();
		}

		/* =========================== */
		/* = course gating functions = */
		/* =========================== */

		public function gateCourse():void
		{
			if (__courseWrapper)
			{
				__courseWrapper.setCourseAsGated();
			}
		}


		public function openGate():void
		{
			if (__courseWrapper)
			{
				__courseWrapper.openGate();
			}
		}

		/* =================== */
		/* = draw background = */
		/* =================== */

		private function drawBackground():void
		{
			_background.graphics.beginFill(0x86ACC6);
			_background.graphics.drawRect(0,0,1000,600);
			_background.graphics.endFill();
			addChildAt(_background, 0);
		}

        /**
         * changes background color
         **/
		public function changeBgColor(color:uint):void
		{
			removeChildAt(0);
			_background.graphics.beginFill(color);
			_background.graphics.drawRect(0,0,1000,600);
			_background.graphics.endFill();
			addChildAt(_background, 0);
		}

        /**
         * removes the background
         * useful for falcon courses
         **/
        public function removeBackground():void
        {
			if (! this._backgroundRemoved)
			{
				removeChildAt(0);
			}
			this._backgroundRemoved = true;
			var filltype:String = GradientType.LINEAR;
            var colors:Array = [0x000000, 0x20201f];
            var alphas:Array = [1,1];
            var ratios:Array = [127, 255];
            var matrix:Matrix = new Matrix();
            matrix.createGradientBox(200, 700, Math.PI/2, 0, 1);

            _background.graphics.beginGradientFill(filltype, colors, alphas, ratios, matrix);
			_background.graphics.drawRect(0,0,1000,600);
			addChildAt(_background, 0);
        }

		/**
		 *	used in the constructor to add a mask to the coursefile in case the designer forgets
		 */
		private function maskPage():void
		{
			_pageMask.graphics.beginFill(0x000000);
			_pageMask.graphics.drawRect(0,.5,1000,599.5);
			addChild(_pageMask);
			this.mask = _pageMask;
		}

	 	/* ============================ */
	 	/* = closed caption functions = */
	 	/* ============================ */

		/**
		 *	getter for closed caption text
		 *	@return String
		 */
		public function getCcText():String
		{
			return _ccText;
		}

		/**
		 *	setter for closed caption text
		 *	@param	value	 the audio transcription
		 */
		public function setCcText( value:String ):void
		{
			if( value != _ccText )
			{
				_ccText = value;
				dispatchEvent(new CaptionEvent(CaptionEvent.CAPTION_CHANGED, _ccText));
			}
		}
	}
}
