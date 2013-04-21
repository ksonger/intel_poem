package com.poem.helpers.notifications
{
	import com.poem.helpers.notifications.MessageWindow;
	import com.poem.models.PoemModel;
	
	import flash.desktop.NativeApplication;
	import flash.display.NativeWindow;
	import flash.display.Screen;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.*;
	
	public class PopupAlertManager extends EventDispatcher
	{
		private var lifeTicks:uint = 0;
		private var lifeTimer:Timer = new Timer(1000);
		private var currentScreen:Screen;
		private const timeToLive:uint = 10;
		private const gutter:int = 10;
		private var messageWindow:MessageWindow;
		private var currentMessage:String = '';
		
		public static const LIFE_TICK:String = "lifeTick";
		
		//Create the timer
		public function PopupAlertManager():void {
			lifeTimer.addEventListener(TimerEvent.TIMER, addTick,false,0,true);
			lifeTimer.start();
		}
		
		//Create a new message window and animate its entrance
		public function displayMessage(message:String, icon_url:String):void{

			if (message != currentMessage) 
			{
				messageWindow = null;
				messageWindow = new MessageWindow(message, icon_url, this);
				var position:Point = findSpotForMessage(messageWindow.bounds);
				messageWindow.timeToLive = timeToLive;
				messageWindow.x = position.x;
				messageWindow.y = currentScreen.bounds.height;
				messageWindow.visible = true;
				messageWindow.animateY(position.y);
				currentMessage = message;
			}
		}
		
		
		//Stop the timer when the user is away
		public function pauseExpiration():void{
			lifeTimer.stop();
		}
		
		//Start the timer when the user returns, reset the expiration of 
		//existing messages so the user has a chance to read them.
		public function resumeExpiration():void{
			lifeTimer.start();
		}
		
		//Increment the expiration timer
		private function addTick(event:Event):void{
			lifeTicks++;
			var tickEvent:Event = new Event(LIFE_TICK,false,false);
			dispatchEvent(tickEvent);
		}
		
		//Finds a spot onscreen for a message window
		private function findSpotForMessage(size:Rectangle):Point{
			var spot:Point = new Point();
			var done:Boolean = false;
			for each(var screen:Screen in Screen.screens){
				currentScreen = screen;
				for(var x:int = screen.visibleBounds.x + screen.visibleBounds.width - size.width - gutter; 
						x >= screen.visibleBounds.x; 
						x -= (size.width + gutter)){
					for(var y:int = screen.visibleBounds.y + screen.visibleBounds.height - size.height - gutter;
							y >= screen.visibleBounds.y;  
							y -= 10){
						var testRect:Rectangle = new Rectangle(x, y, size.width + gutter, size.height + gutter);
						if(!isOccupied(testRect)){
							spot.x = x;
							spot.y = y;
							done = true;
							break;
						}
					}
					if(done){break;}
				}
				if(done){break;}
			}
			return spot;
		}
		
		//Checks to see if any opened message windows are in a particular spot on screen
		private function isOccupied(testRect:Rectangle):Boolean{
			var occupied:Boolean = false;
			for each (var window:NativeWindow in NativeApplication.nativeApplication.openedWindows){
				occupied = occupied || window.bounds.intersects(testRect);
			}
			return occupied;
		}
	}
}