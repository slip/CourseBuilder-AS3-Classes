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
		var _myParent:Object;
		var completeMethod:String = "LMSSetComplete";		
		
		public function CourseEnded()
		{
			_myParent = (this.parent as MovieClip);
			_myParent.stop();
			
			if(completeMethod in _myParent)
			{
			    _myParent.LMSSetComplete();
			}
			else if (completeMethod in _myParent.parent)
			{
				_myParent.parent.LMSSetComplete();
			}			
		}
		
		public function getWrapper():Object {
			var wrapper:Object;
			var completeMethod:String = "LMSSetComplete";
			
			if (completeMethod in this.parent)
			{
				wrapper = this.parent;
				return wrapper;
			}
			else if (completeMethod in this.parent.parent)
			{
				wrapper = this.parent.parent;
				return wrapper;
			}
			else if (completeMethod in this.parent.parent.parent)
			{
				wrapper = this.parent.parent.parent;
				return wrapper;
			}
			else
			{
				return null;
			}	
		}		
	}
}