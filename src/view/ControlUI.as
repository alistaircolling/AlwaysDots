package view {
	import flash.events.TimerEvent;
	import hires.debug.Stats;

	import uk.co.soulwire.gui.SimpleGUI;

	import utils.CustomEvent;
	import utils.TextFieldUtils;

	import flash.display.Sprite;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.Timer;

	/**
	 * @author acolling
	 */
	public class ControlUI extends Sprite {
		private var _holder : Sprite;
		private var _gui : SimpleGUI;
		private var _total : *;
		private var _format : TextFormat;
		
		public var sketchParams:SketchParams;
		
		
		
		//all circles
		public var totalCirles:uint;
		public var dotsPerCircle:uint;
		public var initialCircleRadius:uint;
		public var spaceBetweenCircles:uint;
		//dots
		public var smallestDotRadius:uint;
		public var dotRadiusIncrement:uint;
		//movement
		public var rotateSpeed : uint;
		private var _stats : Stats;
		private var _timer : Timer;
		
		
		public function ControlUI() {
			init();
		}

		private function init() : void {
			
			sketchParams = new SketchParams();
			_holder = new Sprite();
			addChild(_holder);
			createControls();
			
		}

		private function createControls() : void {
			_gui = new SimpleGUI(this, "DOTS SIMULATION", "C");

			_gui.addGroup("Set these parameters before starting simulation");
			_gui.addGroup("All CIRCLES");
			_gui.addSlider("sketchParams.totalCirles", 1, 10, {label:"Total Circles", width:370, tick:1, value:5, callback:valueUpdated});
			
			_gui.addSlider("sketchParams.dotsPerCircle", 1, 40, {label:"Dots per Circle", width:370, tick:1, callback:valueUpdated});
			_gui.addSlider("sketchParams.initialCircleRadius", 1, 300, {label:"Initial Circle Radius", width:370, tick:1, value:200, callback:valueUpdated});
			_gui.addSlider("sketchParams.spaceBetweenCircles", 1, 150, {label:"Space Between Circles", width:370, tick:1, callback:valueUpdated});

			_gui.addGroup("     ");
			_gui.addGroup("DOT PARAMETERS");
			_gui.addSlider("sketchParams.smallestDotRadius", 1, 200, {label:"Smallest Dot Size", width:370, tick:1, callback:valueUpdated});
			_gui.addSlider("sketchParams.dotRadiusIncrement", 1, 50, {label:"Dot Size Increment", width:370, tick:1, callback:valueUpdated});
			_gui.addSlider("sketchParams.dotAlpha", 0, 1, {label:"Dot Alpha", width:370, tick:.1, callback:valueUpdated});
			_gui.addColour("sketchParams.dotColor",{label:"Dot Color", callback:valueUpdated});
			_gui.addToggle("sketchParams.showCircles", {label:"Show Circles",  callback:valueUpdated});
			
			
			_gui.addGroup("     ");
			_gui.addGroup("MOVEMENT");
			_gui.addSlider("sketchParams.rotateSpeed", -5, 5 , {label:"Rotate Speed", width:370, tick:1, callback:valueUpdated});
			
		
			_gui.show();
			sketchParams.dotRadiusIncrement = 36;
			sketchParams.dotsPerCircle = 10;
			sketchParams.initialCircleRadius =  40;
			sketchParams.rotateSpeed = 1;
			sketchParams.smallestDotRadius = 30;
			sketchParams.spaceBetweenCircles = 70;
			sketchParams.totalCirles = 4;
			sketchParams.dotColor = 0xff00ff;
			sketchParams.dotAlpha = .3;
			sketchParams.rotateSpeed = 1;
			_gui.hide();
			_gui.show();
			
			


			_total = TextFieldUtils.createTextField();
			_total.x = 750;
			_total.y = 20;
			addChild(_total);

			_format = TextFieldUtils.createTextFormat("HelveticaNeue", 0xffffff, 30);
			_total.defaultTextFormat = _format;
			_total.border = true;
			_total.autoSize = TextFieldAutoSize.LEFT;
			_total.text = "completed: 0";
			_total.borderColor = 0xffffff;
			
			_timer = new Timer(500, 1);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			_timer.start();
		}

		private function onTimerComplete(event : TimerEvent) : void {
			_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);			
			_timer = null;
			sketchParams.initialCircleRadius = 40;
			
		}
		
		
		public function valueUpdated() : void {
		
			var e:CustomEvent = new CustomEvent("valueUpdated");
			dispatchEvent(e);
		}
		
		public function startSimulation():void{
			trace("ControlUI.startSimulation()  ");			 
		}
		
		public function reset():void{
			trace("ControlUI.reset()  ");
		}
	}
}
