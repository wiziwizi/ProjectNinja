package screens
{
	import adobe.utils.CustomActions;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.media.Sound;
	import flash.media.SoundMixer;
	import flash.net.URLRequest;

	
	/**
	 * ...
	 * @author Rico
	 */
	public class GameScreen extends MovieClip
	{
		public static const END_GAME:String = "end game";
		public static const WIN_GAME:String = "win game";
		
		private var ToSoonToLate:Boolean = false;
		
		private var RandomTime:Number = Math.random()*10000;
		private var RandomTimer:Timer = new Timer(RandomTime, 1);
		private var TimeLeft:uint = 1000;
		private var TimeToStrike:Timer = new Timer(TimeLeft, 1);
		private var DelayW:Timer = new Timer(1000, 1);
		private var DelayW2:Timer = new Timer(1000, 1);
		private var DelayL:Timer = new Timer(1000, 1);
		private var DelayL2:Timer = new Timer(1000, 1);
		
		private var PlayerI:MovieClip = new PlayerImg();
		private var GameI:MovieClip = new GameImg();
		private var EnemyI:MovieClip = new EnemyImg();
		private var Slash:MovieClip = new SlashImg();
		private var SlashQue:MovieClip = new SlashQueImg();
		
		private var PlayerD:MovieClip = new PlayerDmg();
		private var EnemyD:MovieClip = new EnemyDmg();
		
		private var CurrentTime:Date;
		private var ReactionTime:Date;
		public var EndTime:Number = 0;
		
		private var SlashSoud:Sound = new Sound(new URLRequest("http://www.freesound.org/data/previews/35/35213_307822-lq.mp3"));
		
		public function GameScreen():void
		{
			this.addEventListener(Event.ADDED_TO_STAGE, init);
			
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.addEventListener(KeyboardEvent.KEY_UP, Space);
			TimeToStrike.addEventListener(TimerEvent.TIMER, ToLate);
			RandomTimer.addEventListener(TimerEvent.TIMER, OnRandomTime);
			DelayW.addEventListener(TimerEvent.TIMER, WinScreen);
			DelayW2.addEventListener(TimerEvent.TIMER, Win2Screen);
			DelayL.addEventListener(TimerEvent.TIMER, LoseScreen);
			DelayL2.addEventListener(TimerEvent.TIMER, Lose2Screen);
			
			addChild(GameI);
			GameI.x = stage. stageWidth / 2;
			GameI.y = stage.stageHeight / 2;
			
			addChild(PlayerI);
			PlayerI.x = 50;
			PlayerI.y = stage.stageHeight / 2 + 100;
			PlayerI.scaleX = 0.3;
			PlayerI.scaleY = 0.3;
			
			addChild(EnemyI);
			EnemyI.x = 700;
			EnemyI.y = 100;
			EnemyI.scaleX = 0.7;
			EnemyI.scaleY = 0.7;
			
			ToSoonToLate = true;
			
			RandomTimer.start();
			
		}
		
		private function Space(K:KeyboardEvent):void
		{
			trace(K.keyCode);
			if(K.keyCode == 32)
			{
				if (ToSoonToLate == true)
				{
					Fail(null);
				}
				
				else
				{
					Win(null);
				}
			}
		}
		
		private function OnRandomTime(T:TimerEvent):void
		{
			SoundMixer.stopAll();
			addChild(SlashQue);
			TimeToStrike.start();
			ToSoonToLate = false;
			CurrentTime = new Date();
			
		}
		private function ToLate(T:TimerEvent):void
		{
			trace("fail2");
			removeChild(SlashQue);
			Fail(null);
		}
		
		private function Fail(T:TimerEvent):void
		{
			SlashSoud.play();
			stage.removeEventListener(KeyboardEvent.KEY_UP, Space);
			TimeToStrike.stop();
			RandomTimer.stop();
			TimeToStrike.reset();
			RandomTimer.reset();
			addChild(Slash);
			Slash.x = stage.stageWidth / 2;
			Slash.y = stage.stageHeight / 2 - 10;
			DelayL.start();
		}
		
		private function LoseScreen(T:TimerEvent):void
		{
			DelayL.stop();
			DelayL.reset();
			removeChild(Slash);
			addChild(PlayerD);
			PlayerD.scaleX = 0.3;
			PlayerD.scaleY = 0.3;
			PlayerD.x = 50;
			PlayerD.y = stage.stageHeight / 2 + 100;
			DelayL2.start();
		}
		
		private function Lose2Screen(T:TimerEvent):void
		{
			DelayL2.stop();
			DelayL2.reset();
			removeChild(PlayerD);
			remove();
			dispatchEvent(new Event(END_GAME));
		}
		
		private function Win(T:TimerEvent):void
		{
			SlashSoud.play();
			stage.removeEventListener(KeyboardEvent.KEY_UP, Space);
			ReactionTime = new Date();
			TimeToStrike.stop();
			EndTime = ReactionTime.milliseconds - CurrentTime.milliseconds;
			
			if (EndTime < 0)
			{
				EndTime = EndTime + 1000;
			}
			
			trace(EndTime);
			RandomTimer.stop();
			TimeToStrike.reset();
			RandomTimer.reset();
			addChild(Slash);
			removeChild(SlashQue);
			Slash.x = stage.stageWidth / 2;
			Slash.y = stage.stageHeight / 2 - 10;
			DelayW.start();
		}
		
		private function WinScreen(T:TimerEvent):void
		{
			DelayW.stop();
			DelayW.reset();
			removeChild(Slash);
			addChild(EnemyD);
			EnemyD.x = 700;
			EnemyD.y = 100;
			EnemyD.scaleX = 0.7;
			EnemyD.scaleY = 0.7;
			DelayW2.start();
		}
		
		private function Win2Screen(T:TimerEvent):void
		{
			DelayW2.stop();
			DelayW2.reset();
			removeChild(EnemyD);
			remove();
			dispatchEvent(new Event(END_GAME));
		}
		
		private function remove():void
		{
			stage.removeEventListener(KeyboardEvent.KEY_UP, Space);
			TimeToStrike.removeEventListener(TimerEvent.TIMER, ToLate);
			RandomTimer.removeEventListener(TimerEvent.TIMER, OnRandomTime);
			DelayW.removeEventListener(TimerEvent.TIMER, Win);
			DelayW2.removeEventListener(TimerEvent.TIMER, WinScreen);
			DelayL.removeEventListener(TimerEvent.TIMER, Fail);
			DelayL2.removeEventListener(TimerEvent.TIMER, LoseScreen);
		}
	}
}