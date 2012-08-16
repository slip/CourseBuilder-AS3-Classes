package com.davita.nocturnal
{
	import flash.display.*;
	import flash.events.Event;
	import com.greensock.*;
	import com.greensock.plugins.*;

	public class NocturnalAnimator extends MovieClip
	{

		//---------------------------------------
		// CONSTRUCTOR
		//---------------------------------------
		public function NocturnalAnimator()
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

		private function init(e:Event = null):void
		{
			trace("NocturnalAnimator::init()");
			TweenPlugin.activate([AutoAlphaPlugin]);
		}

		//---------------------------------------;
		// PUBLIC METHODS
		//---------------------------------------

		public function animateInFromTop(theClip:MovieClip, delayTime:int = 0):void
		{
			var timeline:TimelineLite = new TimelineLite();
			timeline.append(TweenLite.from(theClip, 2, {y:"-150", alpha:0, delay:delayTime}));
		}

		public function animateOutFromTop(theClip:MovieClip, delayTime:int = 0):void
		{
			var timeline:TimelineLite = new TimelineLite();
			timeline.append(TweenLite.to(theClip, 1, {alpha:0, y:"-150", delay:delayTime}));
		}		
		public function animateInFromBottom(theClip:MovieClip, delayTime:int = 0):void
		{
			var timeline:TimelineLite = new TimelineLite();
			timeline.append(TweenLite.from(theClip, 2, {y:"+150", alpha:0, delay:delayTime}));
		}

		public function animateOutFromBottom(theClip:MovieClip, delayTime:int = 0):void
		{
			var timeline:TimelineLite = new TimelineLite();
			timeline.append(TweenLite.to(theClip, 1, {alpha:0, y:"+150", delay:delayTime}));
		}		

		public function animateInFromLeft(theClip:MovieClip, delayTime:int = 0):void
		{
			var timeline:TimelineLite = new TimelineLite();
			timeline.append(TweenLite.from(theClip, 2, {x:"-150", alpha:0, delay:delayTime}));
		}

		public function animateOutFromLeft(theClip:MovieClip, delayTime:int = 0):void
		{
			var timeline:TimelineLite = new TimelineLite();
			timeline.append(TweenLite.to(theClip, 1, {alpha:0, x:"-150", delay:delayTime}));
		}		
		public function animateInFromRight(theClip:MovieClip, delayTime:int = 0):void
		{
			var timeline:TimelineLite = new TimelineLite();
			timeline.append(TweenLite.from(theClip, 2, {x:"+150", alpha:0, delay:delayTime}));
		}

		public function animateOutFromRight(theClip:MovieClip, delayTime:int = 0):void
		{
			var timeline:TimelineLite = new TimelineLite();
			timeline.append(TweenLite.to(theClip, 1, {alpha:0, x:"+150", delay:delayTime}));
		}		
	}
}