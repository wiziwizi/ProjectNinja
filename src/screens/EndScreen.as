package screens
{
	import flash.display.MovieClip;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.text.*;
	
	/**
	 * ...
	 * @author Rico
	 */
	public class EndScreen extends MovieClip
	{
		public static const RESET:String = "restart game";
		
		public function EndScreen():void
		{
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.addEventListener(KeyboardEvent.KEY_UP, Space);
			//Score.text = EndTime.toString();
		}
		
		private function Space(K:KeyboardEvent):void
		{
			if (K.keyCode == 32)
			{
				trace("jo");
				stage.removeEventListener(KeyboardEvent.KEY_UP, Space);
				dispatchEvent(new Event(RESET));
			}
		}
	}
}