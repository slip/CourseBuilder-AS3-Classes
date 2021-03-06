﻿package com.davita.popups.sound
{
	import flash.display.*;
	import flash.media.*;
	import flash.events.*;
	import flash.net.*;
	import flash.text.*;

	public class Mp3Player
	{
		private var songList:Array;
		public var soundLoader:SoundLoader;
		public var playPause:PlayPauseButton;
		public var progSlider:ProgressSlider;
		
		public var playBtn:SimpleButton;
		public var pauseBtn:SimpleButton;
		public var volBar:MovieClip;
		public var artistText:TextField;
		public var songText:TextField;
		public var progBar:MovieClip;
		public var dragSlider:MovieClip;

		public function Mp3Player(songs:Array, vol:MovieClip, pl:SimpleButton, pa:SimpleButton, aText:TextField, sText:TextField, slider:MovieClip, drag:MovieClip)
		{
			songList = songs;
			volBar = vol;
			playBtn = pl;
			pauseBtn = pa;
			artistText = aText;
			songText = sText;
			progBar = slider;
			dragSlider = drag;
			
			soundLoader = new SoundLoader(songs, this);
		}
	}
}
