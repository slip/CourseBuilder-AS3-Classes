/*
Copyright (c) 2009 Normal Software.  All rights reserved.
The copyrights embodied in the content of this file are licensed under the BSD (revised) open source license
*/
package com.davita.buttons
{
	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;

	public class CourseEnded extends MovieClip
	{
		/*
			TODO change _myParent to findCourseSwf() function
			{ use the same method as findWrapper()}
		*/
		public var __courseWrapper:Object;

		public function CourseEnded()
		{
			this.parent.stop();
			// find the wrapper and add listeners
			var success:Boolean = findWrapper();
			if(success)
			{
				__courseWrapper.LMSSetComplete();
				trace("CourseEnded::initialize(): wrapper found");
			}
		}

		private function findWrapper():Boolean
		{
			var curParent:DisplayObjectContainer = this.parent;
			while (curParent)
			{
				if (curParent.hasOwnProperty("versionNumber") && curParent.hasOwnProperty("currentPage"))
				{
					__courseWrapper = curParent;
					trace("CourseEnded:: found the wrapper");
					return true;
					// Object(curParent).loader.addEventListener("unload", dispose, false, 0, true);
				}
				curParent = curParent.parent;
			}
			trace("CourseEnded:: not in a wrapper");
			return false;
		}
	}
}