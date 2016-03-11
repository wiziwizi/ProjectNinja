package screens
{
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Rico
	 */
	public class StartScreen extends MovieClip
	{
		public static const START_GAME:String = "start game";
		
		public function StartScreen():void
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.addEventListener(KeyboardEvent.KEY_UP, Press);
		}
		
		private function Press(K:KeyboardEvent):void
		{
			if(K.keyCode == 32)
			{
				stage.removeEventListener(KeyboardEvent.KEY_UP, Press);
				dispatchEvent(new Event(START_GAME));
			}
		}
	}
}