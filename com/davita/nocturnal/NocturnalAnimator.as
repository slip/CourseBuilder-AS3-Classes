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

		public function animateInVertically(theClip:MovieClip, delayTime:int = 0):void
		{
			var timeline:TimelineLite = new TimelineLite();
			timeline.append(TweenLite.to(theClip, 1, {autoAlpha:1,y:"+150",delay:delayTime}));
		}

		public function animateOutVertically(theClip:MovieClip, delayTime:int = 0):void
		{
			var timeline:TimelineLite = new TimelineLite();
			timeline.append(TweenLite.to(theClip, 1, {autoAlpha:1,y:"-150",delay:delayTime}));
		}		

		public function animateInHorizontally(theClip:MovieClip, delayTime:int = 0):void
		{
			var timeline:TimelineLite = new TimelineLite();
			timeline.append(TweenLite.to(theClip, 1, {autoAlpha:1,x:"+150",delay:delayTime}));
		}

		public function animateOutHorizontally(theClip:MovieClip, delayTime:int = 0):void
		{
			var timeline:TimelineLite = new TimelineLite();
			timeline.append(TweenLite.to(theClip, 1, {autoAlpha:0,x:"-150",delay:delayTime}));
		}
	}
}