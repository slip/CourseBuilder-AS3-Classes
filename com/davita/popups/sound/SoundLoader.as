﻿package com.davita.popups.sound
{
	import flash.display.*;
	import flash.media.*;
	import flash.events.*;
	import flash.net.*;
	import flash.text.*;

	public class SoundLoader
	{
		private var songList:Array;
		private var soundReq:URLRequest;
		private var loader:Sound = new Sound();
		private var song:SoundChannel;
		private var songIndex:int = 0;
		private var musicPlayer:Mp3Player;
		private var initialized:Boolean = false;
		public var resumeTime:Number;
		public var isPlaying:Boolean = false;
		private var songLength:Number;

		public function SoundLoader(songs:Array, player:Mp3Player)
		{
			songList = songs;
			musicPlayer = player;
			soundReq = new URLRequest(songList[songIndex]);
			loader.load(soundReq);
			loader.addEventListener(Event.COMPLETE, songLoaded);
			loader.addEventListener(Event.ID3, id3Ready);
		}
		
		private function songLoaded(event:Event):void
		{
			songLength = loader.length;
			resumeTime = 0;
			song = loader.play();
			song.stop();
			song.addEventListener(Event.SOUND_COMPLETE, soundFinished);
			
			if(isPlaying)
			{
				song = loader.play();
			}
			
			if(!initialized)
			{
				initialized = true;
				musicPlayer.playPause = new PlayPauseButton(musicPlayer.playBtn, musicPlayer.pauseBtn, musicPlayer);
				musicPlayer.progSlider = new ProgressSlider(musicPlayer.progBar, musicPlayer.dragSlider, musicPlayer);
			}
		}
		
		private function id3Ready(event:Event):void
		{
			var artist:String = loader.id3.artist;
			var songName:String = loader.id3.songName;
			musicPlayer.artistText.text = artist;
			musicPlayer.songText.text = "\"" + songName + "\"";
		}
		
		public function pauseSong():void
		{
			resumeTime = song.position;
			song.stop();
			isPlaying = false;
		}
		
		public function playSong():void
		{
			song = loader.play(resumeTime);
			isPlaying = true;
			song.addEventListener(Event.SOUND_COMPLETE, soundFinished);
		}
		
		public function changeSong(dir:int):void
		{
			songIndex += dir;
			if(songIndex > songList.length - 1)
			{
				songIndex = 0;
			}
			else if(songIndex < 0)
			{
				songIndex = songList.length - 1;
			}
			song.stop();
			soundReq = new URLRequest(songList[songIndex]);
			loader = new Sound();
			loader.load(soundReq);
			loader.addEventListener(Event.COMPLETE, songLoaded);
			loader.addEventListener(Event.ID3, id3Ready);
		}
		
		private function soundFinished(event:Event):void
		{
			changeSong(1);
		}
		
		public function setVol(vol:Number):void
		{
			songVolume.volume = vol;
			song.soundTransform = songVolume;
		}
		
		public function getVol():Number
		{
			return songVolume.volume;
		}
		
		public function getProg():Number
		{
			return song.position;
		}
		
		public function getSongLength():Number
		{
			return songLength;
		}
		
		public function setResumeTime(time:Number):void
		{
			resumeTime = time;
		}
	}
}
