﻿package com.davita.nocturnal
{

	public class SFX
	{

		public function SFX()
		{
			trace("SFX class running");
		}
		
		public function sfxWrong()
		{
			var wrongSound:Sound = new SFXwrong(); 
			wrongSound.play();
		}

	}

}