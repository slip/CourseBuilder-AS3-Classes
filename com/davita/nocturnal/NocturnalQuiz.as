﻿package com.davita.nocturnal
{
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import fl.controls.RadioButton;
	import fl.controls.RadioButtonGroup;
	import fl.controls.Label;

	/**
	 * ...
	 * @author Ian Kennedy
	 */
	public class NocturnalQuiz extends MovieClip
	{

		//---------------------------------------
		// PRIVATE VARIABLES
		//---------------------------------------
		private var __gameFile:Object;

		private var _question:String;
		private var _answers:Array;
		private var _destinations:Array;
		private var _correctAnswer:String;

		private var tf:TextFormat = new TextFormat("Arial",12,0xFFFFFF);
		public var questionTextField:TextField;

		private var _radioButtons:Array = [];
		private var _radioButtonGroup:RadioButtonGroup = new RadioButtonGroup("_radioButtonGroup");

		//---------------------------------------
		// CONSTRUCTOR
		//---------------------------------------
		public function NocturnalQuiz():void
		{
			if (stage)
			{
				init();
			}
			{
				addEventListener(Event.ADDED_TO_STAGE,init);
			}
		}

		//---------------------------------------
		// PUBLIC METHODS
		//---------------------------------------
		public function addAnswer(answer:String, destination:String):void
		{
			var newAnswer:Array = [answer, destination];
			_answers.push(newAnswer);
		}

		//---------------------------------------
		// PRIVATE METHODS
		//---------------------------------------
		private function init(e:Event=null):void
		{
			trace("NocturnalQuiz::init()");
			removeEventListener(Event.ADDED_TO_STAGE,init);

			// find CourseFileNocturnalGame
			var success:Boolean = findGameFile();
			{
				Submit_btn.addEventListener(MouseEvent.CLICK, checkAnswer);
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
					trace("NocturnalQuiz::findGameFile():gamefile found");
					return true;
				}
				curParent = curParent.parent;
			}
			trace("NocturnalQuiz::findGameFile():gamefile not found");
			return false;
		}

		private function placeRadioButtons():void
		{
			var initX = 17;
			var initY = 25;

			for (var i = 0; i <  _radioButtons.length ; i++)
			{
				_radioButtons[i].x = initX;
				initY = initY + 29;
				_radioButtons[i].y = initY;
				addChild(_radioButtons[i]);
			}
		}

		//---------------------------------------
		// GETTER / SETTERS
		//---------------------------------------

		public function set question(value:String):void
		{
			trace("NocturnalQuiz::set question("+value+")");
			_question = value;
			questionTextField.text = _question;
		}

		public function get question():String
		{
			return _question;
		}

		public function set answers(value:Array):void
		{
			trace("NocturnalQuiz::set answers("+value+")");
			_answers = value;
			for (var i = 0; i < _answers.length; i++)
			{
				_radioButtons[i] = new RadioButton();
				_radioButtons[i].label = _answers[i][0];
				_radioButtons[i].value = _answers[i][1];
				_radioButtons[i].setStyle("textFormat", tf);
				_radioButtons[i].width = 800;
				_radioButtons[i].group = _radioButtonGroup;
			}
			placeRadioButtons();
		}

		public function get answers():Array
		{
			return _answers;
		}

		//---------------------------------------
		// EVENT LISTENERS
		//---------------------------------------
		private function checkAnswer(event:MouseEvent):void
		{
			trace("checkAnswer::destinationFrameLabel: " + _radioButtonGroup.selectedData);
			__gameFile.gotoAndPlay(_radioButtonGroup.selectedData);
		}
	}
}