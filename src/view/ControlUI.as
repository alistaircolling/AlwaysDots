package view {
	import hires.debug.Stats;

	import uk.co.soulwire.gui.SimpleGUI;

	import utils.CustomEvent;
	import utils.TextFieldUtils;

	import com.bit101.components.Component;

	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.net.SharedObject;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.ByteArray;
	import flash.utils.Timer;

	/**
	 * @author acolling
	 */
	public class ControlUI extends Sprite {
		private var _holder : Sprite;
		private var _gui : SimpleGUI;
		private var _total : *;
		private var _format : TextFormat;
		public var sketchParams : SketchParams;
		// all circles
		public var totalCirles : uint;
		public var dotsPerCircle : uint;
		public var initialCircleRadius : uint;
		public var spaceBetweenCircles : uint;
		// dots
		public var smallestDotRadius : uint;
		public var dotRadiusIncrement : uint;
		// movement
		public var rotateSpeed : uint;
		private var _stats : Stats;
		private var _timer : Timer;
		public var presets : Array;
		private var _presets : *;
		private var _presetCombo : Component;
		private var _presetIndex : int = 0;

		public function ControlUI() {
			init();
		}

		private function init() : void {
			presets = [];
			sketchParams = new SketchParams();
			_holder = new Sprite();
			addChild(_holder);
			createControls();
			addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);

			var mySo : SharedObject;
			mySo = SharedObject.getLocal("application-name");
			mySo.clear();
		}

		private function mouseDownHandler(event : MouseEvent) : void {
			var sprite : Sprite = Sprite(event.target);
			trace("mouseDownHandler:" + sprite.name);
			sprite.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			if (sprite.name == "instance24" || sprite.name == "instance11") {
				this.startDrag();
			}
		}

		private function mouseUpHandler(event : MouseEvent) : void {
			trace("mouseUpHandler");
			var sprite : Sprite = Sprite(event.target);
			sprite.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			this.stopDrag();
		}

		private function mouseMoveHandler(event : MouseEvent) : void {
			trace("mouseMoveHandler");
			event.updateAfterEvent();
		}

		private function createControls() : void {
			_gui = new SimpleGUI(this, "PRESS 'C' TO SHOW/HIDE CONTROLS- DRAG TO MOVE CONTROLS", "C");

			_gui.addGroup("All CIRCLES");
			_gui.addSlider("sketchParams.totalCirles", 1, 10, {label:"Total Circles", width:370, tick:1, value:5, callback:valueUpdated});

			_gui.addSlider("sketchParams.dotsPerCircle", 1, 40, {label:"Dots per Circle", width:370, tick:1, callback:valueUpdated});
			_gui.addSlider("sketchParams.initialCircleRadius", 1, 300, {label:"Initial Circle Radius", width:370, tick:1, value:200, callback:valueUpdated});
			_gui.addSlider("sketchParams.spaceBetweenCircles", 1, 150, {label:"Space Between Circles", width:370, tick:1, callback:valueUpdated});

			_gui.addGroup("DOT PARAMETERS");
			_gui.addSlider("sketchParams.smallestDotRadius", .5, 200, {label:"Smallest Dot Size", width:370, tick:.5, callback:valueUpdated});
			_gui.addSlider("sketchParams.dotRadiusIncrement", .5, 100, {label:"Dot Size Increment", width:370, tick:.5, callback:valueUpdated});
			_gui.addSlider("sketchParams.dotAlpha", 0, 1, {label:"Dot Alpha", width:370, tick:.1, callback:valueUpdated, value:1});
			_gui.addColour("sketchParams.dotColor", {label:"Dot Color", callback:valueUpdated});
			_gui.addToggle("sketchParams.showCircles", {label:"Show Circles", callback:valueUpdated});

			_gui.addGroup("MOVEMENT");
			_gui.addSlider("sketchParams.rotateSpeed", -2, 2, {label:"Rotate Speed", width:370, tick:.1, callback:valueUpdated});

			_gui.addGroup("FILTER PARAMS");
			// _gui.addComboBox("sketchParams.filterType", [{data:"blur", label:"blur"}, {label:"glow", data:"glow"}], {label:'Filter Type', callback:valueUpdated});
			/*	_gui.addComboBox("sketchParams.filterType", [

			{label:"blur",	data:"blur"},
			{label:"glow",	data:"glow"}
	
	
	
			], {label:"Filter Type", callback:valueUpdated});*/
			_gui.addSlider("sketchParams.filterSize", 0, 20, {label:"Filter Size", width:370, tick:.5, callback:valueUpdated});
			_gui.addSlider("sketchParams.filterStrength", 0, 255, {label:"Filter Strength", width:370, tick:1, callback:valueUpdated});
			_gui.addSlider("sketchParams.filterAlpha", 0, 1, {label:"Filter Alpha", width:370, tick:.05, callback:valueUpdated});
			_gui.addColour("sketchParams.filterColor", {label:"Filter Color", callback:valueUpdated});

			_gui.addGroup("EXPLOSION");
			_gui.addSlider("sketchParams.explosionPower", 0, 200, {label:"Explosion Power", width:370, tick:.5, callback:valueUpdated});
			_gui.addSlider("sketchParams.expansionRate", 0, 1000, {label:"Expansion Rate", width:370, tick:10, callback:valueUpdated});
			_gui.addSlider("sketchParams.depth", 0, 300, {label:"Depth", width:370, tick:10, callback:valueUpdated});
			_gui.addSlider("sketchParams.epsilon", 0, 50, {label:"Epsilon", width:370, tick:1, callback:valueUpdated});
			_gui.addSlider("sketchParams.friction", 0, 1000, {label:"Friction", width:370, tick:5, callback:valueUpdated});

			_gui.addButton("Explode!", {callback:makeExplosion});
			_gui.addButton("Make Dots", {callback:startSimulation});
			_gui.addButton("Save Preset", {callback:savePreset});

			_gui.show();
			sketchParams.dotRadiusIncrement = 1;
			sketchParams.dotsPerCircle = 22;
			sketchParams.initialCircleRadius = 56;
			sketchParams.rotateSpeed = 1;
			sketchParams.smallestDotRadius = 1;
			sketchParams.spaceBetweenCircles = 21;
			sketchParams.totalCirles = 7;
			sketchParams.dotColor = 0xffffff;
			sketchParams.dotAlpha = .5;
			sketchParams.rotateSpeed = 0.6;
			sketchParams.filterType = {label:"glow", data:"glow"};
			sketchParams.filterSize = 3;
			sketchParams.filterColor = 0xffffff;
			sketchParams.filterStrength = 100;
			sketchParams.filterAlpha = .2;
			sketchParams.explosionPower = .5;
			sketchParams.expansionRate = 10;
			sketchParams.epsilon = 20;
			sketchParams.depth = 10;
			sketchParams.friction = 500;

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

		private function savePreset() : void {
			var preset : String = sketchParams.savePreset();
			trace("preset saved:" + preset);
			writeToTextFile(preset);
			// presets.push(sketchParams);
		}

		private function writeToTextFile(preset : String) : void {
			var mySo : SharedObject;
			mySo = SharedObject.getLocal("application-name");
			var cloned : * = clone(sketchParams);
			if (mySo.data.presets) {
				mySo.data.presets.push(cloned);
			} else {
				mySo.data.presets = new Array();
				mySo.data.presets.push(cloned);
			}
			mySo.flush();
			presets = mySo.data.presets;
			addPresetsCombo(mySo.data.presets);
		}

		private function addPresetsCombo(presets : Array) : void {
			var addArr : Array = [];
			for (var i : int = 0; i < presets.length; i++) {
				addArr.push({label:"preset " + i.toString(), data:i});
				;
			}

			if (!_presetCombo) {
				_presetCombo = _gui.addComboBox("presetIndex", [{label:"preset 0", data:0}]);
			} else {
				var items : Array = _presetCombo["items"];
				_presetCombo["items"] = addArr;
			}
			// trace("---"+addArr[0].label+":"+addArr[0].data);
		}

		public function makeExplosion() : void {
			trace("ControlUI.makeExplosion()  ");

			var e : CustomEvent = new CustomEvent("explode");
			dispatchEvent(e);
		}

		public function valueUpdated() : void {
			var e : CustomEvent = new CustomEvent("valueUpdated");
			dispatchEvent(e);
		}

		public function startSimulation() : void {
			trace("ControlUI.startSimulation()  ");
			valueUpdated()	 ;
		}

		public function reset() : void {
			trace("ControlUI.reset()  ");
		}

		public function get presetIndex() : int {
			return _presetIndex;
		}

		public function clone(source : SketchParams) : SketchParams {
			var clone : SketchParams = new SketchParams();
			clone.totalCirles = source.totalCirles             ;
			clone.dotsPerCircle = source.dotsPerCircle           ;
			clone.initialCircleRadius = source.initialCircleRadius     ;
			clone.spaceBetweenCircles = source.spaceBetweenCircles     ;
			clone.smallestDotRadius = source.smallestDotRadius       ;
			clone.dotRadiusIncrement = source.dotRadiusIncrement      ;
			clone.rotateSpeed = source.rotateSpeed             ;
			clone.dotColor = source.dotColor                ;
			clone.showCircles = source.showCircles             ;
			clone.dotAlpha = source.dotAlpha                ;
			clone.filterType = source.filterType              ;
			clone.filterSize = source.filterSize              ;
			clone.filterColor = source.filterColor             ;
			clone.filterStrength = source.filterStrength          ;
			clone.filterAlpha = source.filterAlpha             ;
			clone.explosionPower = source.explosionPower;
			clone.expansionRate = source.expansionRate;
			clone.depth = source.depth;
			clone.epsilon = source.epsilon;

			return clone
		}

		public function set presetIndex(presetIndex : int) : void {
			_presetIndex = presetIndex;

			sketchParams = presets[presetIndex];
		}
	}
}
