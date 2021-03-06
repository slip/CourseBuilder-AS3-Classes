﻿package com.davita.roadwarrior
{
	import flash.display.*;
	import flash.events.*;
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	import com.davita.events.ScoreEvent;

	/**
	 * ...
	 * @author Ian Kennedy
	 */
	public class Globe extends MovieClip
	{

		//---------------------------------------
		// PRIVATE VARIABLES
		//---------------------------------------
		private var _challenges:int;

		//---------------------------------------
		// CONSTRUCTOR
		//---------------------------------------
		public function Globe(challenges:int):void
		{
			_challenges = challenges;
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
			removeEventListener(Event.ADDED_TO_STAGE,init);
			updateGlobeScore();
		}

		private function updateGlobeScore():void
		{
			trace((("Globe::updateGlobeScore(" + this._challenges) + ")"));
			switch (_challenges)
			{
				case 0 :
					this.gotoAndPlay("area01");
					this.parent.changeBackground(1);
					this.parent.zoom = false;
					break;

				case 1 :
					this.gotoAndPlay("area02");
					this.parent.changeBackground(2);
					break;

				case 2 :
					this.gotoAndPlay("wrong");
					this.parent.changeBackground(12);
					this.parent.zoom = false;
					break;

				case 3 :
					this.gotoAndPlay("area03");
					this.parent.changeBackground(3);
					break;

				case 4 :
					this.gotoAndPlay("area04");
					this.parent.changeBackground(4);
					break;

				case 5 :
					this.gotoAndPlay("area05");
					this.parent.changeBackground(5);
					break;

				case 15 :
					this.gotoAndPlay("wrong");
					this.parent.changeBackground(6);
					this.parent.zoom = false;
					break;
					
				case 16 :
					this.gotoAndPlay("area06");
					this.parent.changeBackground(6);
					break;
					
				case 27 :
					this.gotoAndPlay("area07");
					this.parent.changeBackground(7);
					break;

				case 28 :
					this.gotoAndPlay("area08");
					this.parent.changeBackground(8);
					break;

				case 36 :
					this.gotoAndPlay("area09");
					this.parent.changeBackground(9);
					break;

				case 54 :
					this.gotoAndPlay("area10");
					this.parent.changeBackground(10);
					break;

				case 61 :
					this.gotoAndPlay("area11");
					this.parent.changeBackground(11);
					break;
			}
		}
	}
}