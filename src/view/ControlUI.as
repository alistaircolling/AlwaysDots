package view {
	import hires.debug.Stats;
	

	import uk.co.soulwire.gui.SimpleGUI;

	import utils.TextFieldUtils;

	import flash.display.Sprite;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

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
			
			_gui.addSlider("sketchParams.dotsPerCircle", 1, 40, {label:"Dots per Circle", width:370, tick:1});
			_gui.addSlider("sketchParams.initialCircleRadius", 1, 300, {label:"Initial Circle Radius", width:370, tick:1});
			_gui.addSlider("sketchParams.spaceBetweenCircles", 1, 150, {label:"Space Between Circles", width:370, tick:1});

			_gui.addGroup("     ");
			_gui.addGroup("DOT PARAMETERS");
			_gui.addSlider("sketchParams.smallestDotRadius", 1, 50, {label:"Smallest Dot Size", width:370, tick:1});
			_gui.addSlider("sketchParams.dotRadiusIncrement", 1, 20, {label:"Dot Size Increment", width:370, tick:1});
			
			_gui.addGroup("     ");
			_gui.addGroup("MOVEMENT");
			_gui.addSlider("sketchParams.rotateSpeed", 1, 600, {label:"Rotate Speed", width:370, tick:1});
			
			_gui.addButton("MAKE THE DOTS", {callback:startSimulation, width:160});
			_gui.addButton("RESTART", {callback:reset, width:160});
	
			
			
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
			
		}
		
		
		public function valueUpdated() : void {
			trace("ControlUI.valueUpdated()  ");
		}
		
		public function startSimulation():void{
			trace("ControlUI.startSimulation()  ");			 
		}
		
		public function reset():void{
			trace("ControlUI.reset()  ");
		}
	}
}
