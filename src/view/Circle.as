package view {
	import graphics.Drawing;

	import flash.display.Shape;
	import flash.display.Sprite;

	/**
	 * @author acolling
	 */
	public class Circle extends Sprite {
		private var _totalDots : uint;
		private var _radius : uint;
		private var _dotRadius : uint;
		private var _dots : Array;
		private var _dotHolder : Sprite;
		
		//total dots, radius, dot radius
		public function Circle(dots:uint, radius:uint, dotRadius:uint) {
			
			_totalDots = dots;
			_radius = radius;
			_dotRadius = dotRadius;
			_dots = [];
			_dotHolder = new Sprite();
			addChild(_dotHolder);
			
			init();
			
		}

		private function init() : void {
			var bg:Shape = Drawing.drawCircle(_radius, 0xffffff*Math.random());
			bg.alpha = .2;
			addChild(bg);
			while(_dotHolder.numChildren>0){
				_dotHolder.removeChildAt(0);
				
			}
			
			
			var increment:Number = (Math.PI*2)/_totalDots;
			for (var i : int = 0; i < _totalDots; i++) {
				var dot:Dot = new Dot(_dotRadius);
				dot.x = (Math.cos(increment*i) * _radius);;// + _centerX;
				dot.y = (Math.sin(increment*i) * _radius);;// + _centerX;
				_dotHolder.addChild(dot);
			}
			
		}
	}
}
