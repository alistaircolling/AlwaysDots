package 
{
	import hires.debug.Stats;

	import view.ControlUI;
	import view.DotsDisplay;

	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;

	[SWF(width="1000", height="800", frameRate="30", backgroundColor="#000000")]
	public class Main extends Sprite {
		
		private var _controls : ControlUI;
		private var _holder : Sprite;
		private var _display : DotsDisplay;
		private var _bannerWidth:int  = 300;
		private var _bannerHeight:int = 250;
		
		
		
		public function Main()
		{
			(stage) ? initApp() : addEventListener(Event.ADDED_TO_STAGE, initApp);
		}

		private function initApp(e:Event = null) : void {
			if (e) removeEventListener(Event.ADDED_TO_STAGE, initApp);
			stage.scaleMode = StageScaleMode.NO_SCALE;			
			_holder = new Sprite();
			_display = new DotsDisplay();	
			_display.x = 500-(.5*_bannerWidth);
			_display.y = 400-(.5*_bannerHeight);
			
			
			_controls = new ControlUI();
			_controls.x = 700;
			_controls.y = -50;
			var stats:Stats = new Stats();
			stats.x = _display.x+_bannerWidth;
			stats.y = _display.y+ _bannerHeight- 100;
		//	_controls.addChild(stats);
			
			_holder.addChild(_display);
			_holder.addChild(_controls);
			
			addChild(_holder);
			
			addListeners();
			valueUpdatedListener(new Event("init"));
			
			 
      
		}
		
	
		

		private function addListeners() : void {
			_controls.addEventListener("valueUpdated", valueUpdatedListener)
			_controls.addEventListener("explode", explodeListener)
			
		}

		private function valueUpdatedListener(e:Event) : void {
			
			_display.valuesSet(_controls.sketchParams);
		}
		
		private function explodeListener(e:Event) : void {
		
			
			_display.explode();
		}
		
	}
}
