﻿/*
Copyright (c) 2009 Normal Software.  All rights reserved.  
The copyrights embodied in the content of this file are licensed under the BSD (revised) open source license
*/
package com.davita.quiz
{
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.net.*;
	import fl.controls.*;
	import com.davita.documents.CourseSwf;
	import com.davita.quiz.BlankStandard;
	import com.davita.quiz.QuizItem_DD;
	import com.davita.quiz.QuizItem_FB;
	import com.davita.quiz.QuizItem_MC;
	import flash.utils.getQualifiedClassName;
	import com.greensock.TweenLite;
	
	/**
	 *	base class for post quiz
	 *
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *
	 *	@author Ian Kennedy
	 *	@since  15.11.2007
	 */
	public class Quiz extends CourseSwf {
		
		//--------------------------------------
		// CLASS CONSTANTS
		//--------------------------------------
		public static const ANSWERED_CORRECTLY = 1;
		public static const ANSWERED_INCORRECTLY = 2;
		
		private var _quizQuestions:Array = new Array();
		
		private var _currentQuizQuestion;
		private var _currentQuestionNumber:Number;
		
		public var quizReview = new QuizResults();
						
		//--------------------------------------
		//  CONSTRUCTOR
		//--------------------------------------
		
		/**
		 *	@Constructor
		 */
		public function Quiz()
		{	
			this.stop();
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event):void
		{
			_currentQuestionNumber = 0;
		}
				
		public function scoreAndContinue(answeredCorrectly:Number):void 
		{
			// adds answer to correct or incorrect array
			if (answeredCorrectly == ANSWERED_CORRECTLY)
			{
				quizReview.correctQuestions.push(_currentQuizQuestion);
				
			} else if (answeredCorrectly == ANSWERED_INCORRECTLY) 
			{
				quizReview.incorrectQuestions.push(_currentQuizQuestion);
			}
			this.removeChild(_currentQuizQuestion);
			_currentQuizQuestion = null;
			_currentQuestionNumber++;
			nextQuestion();
		}
		
		private function beginQuiz():void 
		{
			_currentQuizQuestion = new _quizQuestions[0]();
			addQuestionToStage(_currentQuizQuestion);
		}
		
		private function nextQuestion():void
		{
			if (_currentQuestionNumber == quizQuestions.length)
			{	
				addEndBtnToStage();
				addResultsToStage();
			}
			else
			{
				_currentQuizQuestion = new _quizQuestions[_currentQuestionNumber]();
				addQuestionToStage(_currentQuizQuestion);
			}
		}
		
		private function addResultsToStage():void
		{
			quizReview.x = 70;
			quizReview.y = 100;
			quizReview.alpha = 0;
			this.addChild(quizReview);
			TweenLite.to(quizReview, 2, {alpha:1});
		}
		
		/**
		 *	adds question at correct position
		 */
		private function addQuestionToStage(question):void 
		{
			// TODO: question.x and .y should be dynamic
			question.x = 70;
			question.y = 100;
			question.alpha = 0;
			this.addChild(question);
			TweenLite.to(question, 2, {alpha:1});
		}
		
		/**
		 *	adds lessonEndedBtn at correct position
		 */
		private function addEndBtnToStage():void 
		{
			var endBtn = new LessonEndedBtn();
			endBtn.x = 45;
			endBtn.y = 550;
			this.addChild(endBtn);
		}
		
		public function get quizQuestions():Array 
		{ 
			return _quizQuestions; 
		}
		
		public function set quizQuestions( questions:Array ):void 
		{
			if( questions != _quizQuestions ){
				_quizQuestions = questions;
			}
		}
	}	
}
