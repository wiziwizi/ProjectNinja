package
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import screens.StartScreen;
	import screens.GameScreen;
	import screens.EndScreen;
	
	/**
	 * ...
	 * @author Rico
	 */
	
	public class Main extends Sprite 
	{
		private var _StartScreen:StartScreen = new StartScreen();
		private var _GameScreen:GameScreen = new GameScreen();
		private var _EndScreen:EndScreen = new EndScreen();
		
		private var endScreen:MovieClip = new EndScreenImg();
		private var Intro:MovieClip = new IntroImg();
		
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			stage.addChild(_StartScreen);
			_StartScreen.addEventListener(StartScreen.START_GAME, StartGame);
			stage.addChild(Intro);
			Intro.x = stage.stageWidth / 2;
			Intro.y = stage.stageHeight / 2;
		}
		
		private function StartGame(e:Event = null):void
		{
			stage.removeChild(_StartScreen);
			stage.addChild(_GameScreen);
			_GameScreen.addEventListener(GameScreen.END_GAME, EndGame);
			stage.removeChild(Intro);
		}
		
		private function EndGame(e:Event = null):void
		{
			stage.removeChild(_GameScreen);
			stage.addChild(_EndScreen = new EndScreen);
			addChild(endScreen);
			endScreen.Score.text = _GameScreen.EndTime;
			endScreen.x = stage.stageWidth / 2;
			endScreen.y = stage.stageHeight / 2;
			_EndScreen.addEventListener(EndScreen.RESET, restart);
		}
		private function restart(e:Event = null):void
		{
			_EndScreen.removeEventListener(EndScreen.RESET, restart);
			stage.removeChild(_EndScreen);
			removeChild(endScreen);
			stage.addChild(_GameScreen = new GameScreen);
			_GameScreen.addEventListener(GameScreen.END_GAME, EndGame);
		}
	}
}