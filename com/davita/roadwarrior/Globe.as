﻿package com.davita.roadwarrior{	import flash.display.*;	import flash.events.*;	import com.greensock.TimelineLite;	import com.greensock.TweenLite;	import com.davita.events.ScoreEvent;	/**	 * ...	 * @author Ian Kennedy	 */	public class Globe extends MovieClip	{		//---------------------------------------		// PRIVATE VARIABLES		//---------------------------------------		private var _challenges:int;		//---------------------------------------		// CONSTRUCTOR		//---------------------------------------		public function Globe(challenges:int):void		{			_challenges = challenges;			if (stage)			{				init();			}			else			{				addEventListener(Event.ADDED_TO_STAGE,init);			}		}		//---------------------------------------		// PRIVATE METHODS		//---------------------------------------		private function init(e:Event=null):void		{			removeEventListener(Event.ADDED_TO_STAGE,init);			updateGlobeScore();		}		private function updateGlobeScore():void		{			trace((("Globe::updateGlobeScore(" + this._challenges) + ")"));			switch (_challenges)			{				case 1 :					this.gotoAndPlay("area01");					break;				case 2 :					this.gotoAndPlay("area02");					break;				case 3 :					this.gotoAndPlay("area03");					break;			}		}	}}