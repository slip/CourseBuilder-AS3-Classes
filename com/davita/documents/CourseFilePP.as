/*
   Copyright (c) 2011 Normal Software.  All rights reserved.  
   The copyrights embodied in the content of this file are licensed under the BSD (revised) open source license
 */
package com.davita.documents
{
    import flash.display.*;
    import flash.events.*;
    import fl.motion.easing.*;
    import flash.text.*;

    import com.davita.events.Event;
    import com.davita.events.MouseEvent;
    import com.davita.buttons.*;
    import com.davita.utilities.CBAnimator;
    import flash.media.SoundChannel;
    import com.davita.sound.*;

	import flash.utils.*;
    /**
     *  base class for davita ClinEd P&P courses
     *	
     * 	@langversion ActionScript 3
     *	@playerversion Flash 10.0.0
     *
     *	@author Ian Kennedy
     *	@since  15.10.2011
     */
    public dynamic class CourseFilePP extends CourseSwf
    {
        public var sndChannel:SoundChannel = new SoundChannel();
        public var interactions:Array = new Array();

        /**
         *	constructor
         */
        public function CourseFilePP()
        {			
            super();
            addEventListener(Event.ADDED_TO_STAGE, init);
        }

        private function init(event:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, init);
            this.addEventListener(MouseEvent.CLICK, clickHandler);
        }

        /* ================ */
        /* = clickHandler = */
        /* ================ */

        private function clickHandler(event:MouseEvent):void
        {
            /*traceDisplayList(this);*/
            /*trace(getQualifiedClassName(event.target));*/
            if (!getQualifiedClassName(event.target))
            {
                // do nothing
            } 
            else
            {
                switch (getQualifiedClassName(event.target)){

                    case "ContinueBtn" :
                        this.play();
                        interactions.push(this.currentFrame);
                        break;

                    case "ContinueBtn2" :
                        this.play();
                        interactions.push(this.currentFrame);
                        break;

                    case "zBackBtn" :
                        this.gotoAndPlay(interactions.pop());
                        break;

                    case "zBackBtn2" :
                        this.gotoAndPlay(interactions.pop());
                        break;

                    default:
                        trace("event.target: "+ event.target);
                        trace("event.target.name: "+ event.target.name);
                }
            }
        }
        //private function clickHandler(event:MouseEvent):void
        //{
        //if (event.target is ContinueButton)
        //{
        //this.gotoAndPlay(this.currentFrame+1);
        //}
        //else
        //{
        //trace("event.target: "+ event.target);
        //trace("event.target.name: "+ event.target.name);
        //}
        //}
    }
}
