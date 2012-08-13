package com.davita.nocturnal

{
	import flash.display.MovieClip;
	import flash.display.*;
	import flash.events.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	import com.greensock.*;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.plugins.FrameLabelPlugin;
	import com.greensock.loading.*;
	import com.greensock.events.LoaderEvent;
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
			TweenPlugin.activate([VolumePlugin]);
			TweenPlugin.activate([BlurFilterPlugin]);
			TweenPlugin.activate([FilterPlugin]);
		}

		//---------------------------------------
		// PRIVATE METHODS
		//---------------------------------------

		//  [**************** Content Tweening *********************];
		// Text Box Standard Fade in
		public function txtFadeIn(mc:MovieClip):void
		{
			var mcY:int = mc.y;
			stop();
			mc.alpha = 0;
			var timeline:TimelineLite = new TimelineLite({onComplete:stop});
			timeline.append(TweenLite.from(mc, 0, {alpha:0,y:-500}));
			timeline.append(TweenLite.to(mc, 2, {alpha:1, y:mcY}));
		}

		// Add tip to stage where you want it to pause. Pass MC instance name and amount of time you want it to pause.
		public function tipInOut(mc:MovieClip,delayIn,delayOut):void
		{

			var timeline:TimelineLite = new TimelineLite();
			timeline.append(TweenLite.from(mc, 1, {alpha:0,delay:delayIn}));
			timeline.append(TweenLite.to(mc, .5, {alpha:1}));
			timeline.append(TweenLite.to(mc, 1, {alpha:0,x:1300,delay:delayOut}));
		}

		// Slides avatar off stage. Adds end Lesson and Slides that in.
		public function avatarOutWithEndButton(delayTime:int,avatar:Object):void
		{
		trace("avatarOutWithEndButton")
			var timeline:TimelineLite = new TimelineLite({onComplete:CourseFileGame3.removeAvatar});
			timeline.append(TweenLite.from(avatar, 0, {alpha:1,delay:delayTime}));
			timeline.append(TweenLite.to(avatar, 2, {alpha:0,x:-1000}));
		}


		public function nxtBtnIn(delayTime:int,myNextBtnWbg:Object)
		{
			trace("Animating Next Button In Seconds: " + delayTime);
			
			var timeline:TimelineLite = new TimelineLite({onComplete:stop});
			timeline.append(TweenLite.from(myNextBtnWbg, 1, {alpha:0,delay:delayTime}));
			timeline.append(TweenLite.to(myNextBtnWbg, 1, {alpha:1,x:925}));
		}
		
		/*public function nxtBtnOut(myNextBtnWbg:Object)
		{
			if (myNextBtnWbg != null) {
			trace("Animating Next Button Out");
			var timeline:TimelineLite = new TimelineLite();
			timeline.append(TweenLite.from(myNextBtnWbg, 1, {alpha:1}));
			timeline.append(TweenLite.to(myNextBtnWbg, 1, {alpha:0,x:1025}));
			} else {
				trace("No next button found so not removing it");
			}
			
		}*/


		// Move Question off stage when answered correctly
		public function textOut(mc:MovieClip):void
		{
			var timeline:TimelineLite = new TimelineLite();
			timeline.append(TweenLite.from(mc, 1.5, {alpha:1}));
			timeline.append(TweenLite.to(mc, 7, {alpha:0,y:-640}));
		}
		// Move Question off stage when answered correctly
		public function flyInWaitThenOut(delayTime:int,movieClips:Array,waitTime:int):void
		{
			stop();
			var timeline:TimelineLite = new TimelineLite();
			timeline.append(TweenLite.delayedCall(delayTime,timeline.play));
			for (var i:int=0; i < movieClips.length; i++)
			{
				timeline.append(TweenLite.from(movieClips[i], 0, {alpha:0}));
				timeline.append(TweenLite.to(movieClips[i],1, {alpha:1,x:500}));
				timeline.append(TweenLite.from(movieClips[i], 1, {alpha:1,delay:waitTime}));
				timeline.append(TweenLite.to(movieClips[i],1, {alpha:.7,x:-700,delay:1}));
				
			}
		}
			// Move Question off stage when answered correctly
			public function HintInWaitThenOut(movieClip,waitTime:int):void
			{
				stop();
				var timeline:TimelineLite = new TimelineLite();
				movieClip.x = -280;
				timeline.append(TweenLite.to(movieClip,1, {alpha:1,x:500}));
				timeline.append(TweenLite.to(movieClip, 0, {delay:waitTime}));
				timeline.append(TweenLite.to(movieClip,1, {alpha:.7,x:1400}));

			}
		// Move Question off stage when answered correctly
		public function flyIn2PosWaitThenOut(delayTime:int,movieClips:Array,waitTime:int,posX:int,posY:int):void
		{
			stop();
			var timeline:TimelineLite = new TimelineLite();
			timeline.append(TweenLite.delayedCall(delayTime,timeline.play));
			for (var i:int=0; i < movieClips.length; i++)
			{
				timeline.append(TweenLite.from(movieClips[i], 0, {alpha:0}));
				timeline.append(TweenLite.to(movieClips[i],1, {alpha:1,x:posX,y:posY}));
				timeline.append(TweenLite.from(movieClips[i], 1, {alpha:1,delay:waitTime}));
				timeline.append(TweenLite.to(movieClips[i],1, {alpha:.7,x:-700}));
			}
		}
		
			public function delayFlyInList(delayTime:int,movieClips:Array):void
			{
				stop();
				var timeline:TimelineLite = new TimelineLite();
				timeline.append(TweenLite.delayedCall(delayTime,timeline.play));
				for (var i:int=0; i < movieClips.length; i++)
				{
					timeline.append(TweenLite.from(movieClips[i], 0, {alpha:0}));
					timeline.append(TweenLite.to(movieClips[i],1, {alpha:1,x:500}));

				}
			}
		
		public function imageFlyInOutDelays(delayTime:int,mc:MovieClip):void
		{
			var mcX = mc.x;
			var mcY = mc.y;
			var timeline:TimelineLite = new TimelineLite({onComplete:stop});
			timeline.append(TweenLite.from(mc, 1, {alpha:0,delay:delayTime}));
			timeline.append(TweenLite.to(mc, 1, {alpha:1,x:600,y:300,delay:3}));
			timeline.append(TweenLite.to(mc, 1, {alpha:1,x:mcX,y:mcY}));
		}
		

	}
}