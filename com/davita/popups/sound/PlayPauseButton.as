﻿package com.davita.popups.sound
{
	import flash.display.*;
	import flash.media.*;
	import flash.events.*;

	public class PlayPauseButton
	{
		private var playBtn:SimpleButton;
		private var pauseBtn:SimpleButton;
		private var musicPlayer:Mp3Player;
		
		public function PlayPauseButton(plButton:SimpleButton, paButton:SimpleButton, player:Mp3Player)
		{
			playBtn = plButton;
			pauseBtn = paButton;
			musicPlayer = player;
			playBtn.addEventListener(MouseEvent.CLICK, playSong);
			pauseBtn.addEventListener(MouseEvent.CLICK, pauseSong);
			pauseBtn.visible = false;
		}
		
		private function playSong(event:MouseEvent):void
		{
			playBtn.visible = false;
			pauseBtn.visible = true;
			musicPlayer.soundLoader.playSong();
		}
		
		private function pauseSong(event:MouseEvent):void
		{
			playBtn.visible = true;
			pauseBtn.visible = false;
			musicPlayer.soundLoader.pauseSong();
		}
	}
}
