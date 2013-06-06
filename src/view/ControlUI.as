package view {
	import hires.debug.Stats;

	import uk.co.soulwire.gui.SimpleGUI;

	import utils.CustomEvent;
	import utils.TextFieldUtils;

	import flash.display.BlendMode;
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
			_gui = new SimpleGUI(this, "PRESS 'C' TO SHOW/HIDE CONTROLS", "C");

			
			_gui.addGroup("All CIRCLES");
			_gui.addSlider("sketchParams.totalCirles", 1, 10, {label:"Total Circles", width:370, tick:1, value:5, callback:valueUpdated});
			
			_gui.addSlider("sketchParams.dotsPerCircle", 1, 40, {label:"Dots per Circle", width:370, tick:1, callback:valueUpdated});
			_gui.addSlider("sketchParams.initialCircleRadius", 1, 300, {label:"Initial Circle Radius", width:370, tick:1, value:200, callback:valueUpdated});
			_gui.addSlider("sketchParams.spaceBetweenCircles", 1, 150, {label:"Space Between Circles", width:370, tick:1, callback:valueUpdated});

			_gui.addGroup("     ");
			_gui.addGroup("DOT PARAMETERS");
			_gui.addSlider("sketchParams.smallestDotRadius", 1, 200, {label:"Smallest Dot Size", width:370, tick:1, callback:valueUpdated});
			_gui.addSlider("sketchParams.dotRadiusIncrement", 1, 100, {label:"Dot Size Increment", width:370, tick:1, callback:valueUpdated});
			_gui.addSlider("sketchParams.dotAlpha", 0, 1, {label:"Dot Alpha", width:370, tick:.1, callback:valueUpdated, value:1});
			_gui.addColour("sketchParams.dotColor",{label:"Dot Color", callback:valueUpdated});
			_gui.addToggle("sketchParams.showCircles", {label:"Show Circles",  callback:valueUpdated});
			
			
			_gui.addGroup("     ");
			_gui.addGroup("MOVEMENT");
			_gui.addSlider("sketchParams.rotateSpeed", -2, 2 , {label:"Rotate Speed", width:370, tick:.25, callback:valueUpdated});
			
			_gui.addGroup("FILTER PARAMS");
			//_gui.addComboBox("sketchParams.filterType", [{data:"blur", label:"blur"}, {label:"glow", data:"glow"}], {label:'Filter Type', callback:valueUpdated});
		/*	_gui.addComboBox("sketchParams.filterType", [

	{label:"blur",	data:"blur"},
	{label:"glow",	data:"glow"}
	
	
	
], {label:"Filter Type", callback:valueUpdated});*/
			_gui.addSlider("sketchParams.filterSize", 0, 20 , {label:"Filter Size", width:370, tick:.5, callback:valueUpdated});
			_gui.addSlider("sketchParams.filterStrength", 0, 255 , {label:"Filter Strength", width:370, tick:1, callback:valueUpdated});
			_gui.addSlider("sketchParams.filterAlpha", 0, 1, {label:"Filter Alpha", width:370, tick:.05, callback:valueUpdated});
			_gui.addColour("sketchParams.filterColor",{label:"Filter Color", callback:valueUpdated});
			
			_gui.addGroup("EXPLOSION");
			_gui.addButton("Explode!", {callback:makeExplosion});
			
			
			
			
			
		
			_gui.show();
			sketchParams.dotRadiusIncrement = 9;
			sketchParams.dotsPerCircle = 6;
			sketchParams.initialCircleRadius =  75;
			sketchParams.rotateSpeed = 1;
			sketchParams.smallestDotRadius = 5;
			sketchParams.spaceBetweenCircles = 40;
			sketchParams.totalCirles = 4;
			sketchParams.dotColor = 0xff00ff;
			sketchParams.dotAlpha = 1;
			sketchParams.rotateSpeed = 1;
			sketchParams.filterType = {label:"glow",	data:"glow"};
			sketchParams.filterSize = 5;
			sketchParams.filterColor = 0x00ff00;
			sketchParams.filterStrength = 100;
			sketchParams.filterAlpha = .5;

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
		
		public function makeExplosion():void{
			
			trace("ControlUI.makeExplosion()  ");
			
			var e:CustomEvent = new CustomEvent("explode");
			dispatchEvent(e);
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
