﻿package com.davita.popups.sound
{
	import flash.display.*;
	import flash.media.*;
	import flash.events.*;
	import flash.net.*;
	import flash.geom.*;

	public class ProgressSlider
	{
		private var progBar:MovieClip;
		private var musicPlayer:Mp3Player;
		private var dragSlider:MovieClip;
		private var progPercent:Number;
		private var isPlaying:Boolean;
		

		public function ProgressSlider(pBar:MovieClip, drag:MovieClip, player:Mp3Player)
		{
			progBar = pBar;
			dragSlider = drag;
			musicPlayer = player;
			progBar.addEventListener(Event.ENTER_FRAME, showProgress);
			dragSlider.addEventListener(MouseEvent.MOUSE_DOWN, updateProgress);
			dragSlider.buttonMode = true;
		}
		
		private function showProgress(event:Event):void
		{
			if(musicPlayer.soundLoader.isPlaying)
			{
			progPercent = musicPlayer.soundLoader.getProg() / musicPlayer.soundLoader.getSongLength();
			dragSlider.x = progPercent * (progBar.width - dragSlider.width);
			}
		}
		
		private function updateProgress(event:MouseEvent):void
		{
			if(musicPlayer.soundLoader.isPlaying)
			{
				isPlaying = true;
				musicPlayer.soundLoader.pauseSong();
			}
			else
			{
				isPlaying = false;
			}
			
			dragSlider.startDrag(false, new Rectangle(0,dragSlider.y,progBar.width - dragSlider.width, 0));
			progBar.stage.addEventListener(MouseEvent.MOUSE_UP, stopDragging);
			progBar.removeEventListener(Event.ENTER_FRAME, showProgress);
		}
		
		private function stopDragging(event:MouseEvent):void
		{
			var dragPercent:Number = dragSlider.x / (progBar.width - dragSlider.width);
			musicPlayer.soundLoader.setResumeTime(dragPercent * musicPlayer.soundLoader.getSongLength());
			if(isPlaying)
			{
				musicPlayer.soundLoader.playSong();
			}
			
			dragSlider.stopDrag();
			progBar.stage.removeEventListener(MouseEvent.MOUSE_UP, stopDragging);
			progBar.addEventListener(Event.ENTER_FRAME, showProgress);
		}
	}
}
