package view {
	import flash.display.Shape;
	import graphics.Drawing;
	import flash.display.Sprite;

	/**
	 * @author acolling
	 */
	public class DotsDisplay extends Sprite {
		private var _bg : Shape;
		private var _sketchParams : SketchParams;
		private var _circles : Array;
		private var _holder : Sprite;
		public function DotsDisplay() {
			
			init();
		}

		private function init() : void {
			_holder = new Sprite();
			drawBG();
			addChild(_holder);
			
		}

		private function drawBG() : void {
			
			_bg = Drawing.drawBox(300, 250, 0x8bddff);
			addChild(_bg);
		}

		public function valuesSet(sketchParams : SketchParams) : void {
			_sketchParams = sketchParams;
			generateCircles();
		}

		public function generateCircles() : void {
			trace("DotsDisplay.generateCircles()  ");
			
				while(_holder.numChildren>0){
					_holder.removeChildAt(0);
			}
			
			_circles = new Array();
						
			for (var i : int = 0; i < _sketchParams.totalCirles; i++) {			
				var circle:Circle = createNewCircle(i);
				circle.x = 150;
				circle.y = 125;	
				_holder.addChild(circle);
				_circles.push(circle);																	
			}
			
		}

		private function createNewCircle(i : int) : Circle {
			//total dots, radius, dot radius
			var retCircle:Circle = new Circle(_sketchParams.dotsPerCircle, 
			_sketchParams.initialCircleRadius+(i*_sketchParams.spaceBetweenCircles), _sketchParams.smallestDotRadius+(i*_sketchParams.dotRadiusIncrement))
			return retCircle;
		}
	}
}
