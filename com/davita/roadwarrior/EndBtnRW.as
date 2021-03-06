﻿package com.davita.roadwarrior {
	import flash.display.*;
	import flash.events.*;

	/**
	 * ...
	 * @author Ian Kennedy
	 */
	public class EndBtnRW extends MovieClip {
		// ---------------------------------------
		// CONSTRUCTOR
		// ---------------------------------------
		// Init
		public function EndBtnRW() : void {
			if (stage) {
				init();
			} else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}

		// ---------------------------------------
		// PRIVATE METHODS
		// ---------------------------------------
		private function init(e : Event = null) : void {
			trace("endBtnRW::init()");

			removeEventListener(Event.ADDED_TO_STAGE, init);
			this.addEventListener(MouseEvent.CLICK, endBtnClickHandler);
		}

		private function endBtnClickHandler(event : MouseEvent) : void {
			// Place code her to talk to wrapper that gates can be opened
		}
	}
}
