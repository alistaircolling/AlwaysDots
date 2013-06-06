package view {
	import org.flintparticles.twoD.actions.Explosion;
	import graphics.Drawing;

	import org.flintparticles.common.particles.Particle;
	import org.flintparticles.twoD.actions.Move;
	import org.flintparticles.twoD.emitters.Emitter2D;
	import org.flintparticles.twoD.particles.Particle2DUtils;
	import org.flintparticles.twoD.renderers.DisplayObjectRenderer;

	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	import flash.filters.GlowFilter;

	/**
	 * @author acolling
	 */
	public class DotsDisplay extends Sprite {
		private var _bg : Shape;
		private var _sketchParams : SketchParams;
		private var _circles : Array;
		private var _holder : Sprite;
		private var _bigHolder : Sprite;
		private var _bitmapFilter : BitmapFilter;
		private var _emitter : Emitter2D;
		private var _renderer : DisplayObjectRenderer;
		private var _explosion : Explosion;

		public function DotsDisplay() {
			init();
		}

		private function init() : void {
			drawBG();
			_bigHolder = new Sprite();
			_bigHolder.x = 150;
			_bigHolder.y = 125;
			addChild(_bigHolder);
			_holder = new Sprite();
			_holder.x = -150;
			_holder.y = -125;
			_bigHolder.addChild(_holder);
			createParticlesRenderer();
			addEventListener(Event.ENTER_FRAME, oef);
		}

		private function createParticlesRenderer() : void {
			
			_emitter = new Emitter2D();
			_emitter.x = 150;
			_emitter.y = 125;
			_emitter.addAction( new Move() );
			
			_renderer = new DisplayObjectRenderer();
			_renderer.x = 150;
			_renderer.y = 125;
			_renderer.addEmitter(_emitter);
			addChild(_renderer);
			_emitter.start();
			
		}
		
		public function explode():void{
			trace("DotsDisplay.explode()  ");
			var arr:Array = getDots();
			var particles:Vector.<Particle> = Particle2DUtils.createParticles2DFromDisplayObjects(arr);
			_emitter.addParticles( particles, false );
			_bigHolder.visible = false;			
			
			
				_explosion = new Explosion( 100, 0, 0,600);
				_emitter.addAction( _explosion );
			
		}

		private function getDots() : Array {			
			var dotsAll:Array = [];
			for (var i : int = 0; i < _sketchParams.totalCirles; i++) {
				var circle : Circle = _circles[i] as Circle;
				var dots:Array = circle.getDots();
								
				dotsAll = dotsAll.concat(dots);
			}
			return dotsAll;
		}

		private function oef(event : Event) : void {
			if (!_sketchParams) return;
			_bigHolder.rotation += _sketchParams.rotateSpeed;
		}

		private function drawBG() : void {
			_bg = Drawing.drawBox(300, 250, 0x8bddff);
			addChild(_bg);
		}

		public function valuesSet(sketchParams : SketchParams) : void {
			_sketchParams = sketchParams;
			setFilter();
			generateCircles();
		}

		private function setFilter() : void {
			if (filters.length > 0) {
				filters = [];
			}
			switch(_sketchParams.filterType.label) {
				case "blur":
					trace("adding blur filter");
					var bitmapFilter : BlurFilter = new BlurFilter(_sketchParams.filterSize, _sketchParams.filterSize, 2);
					filters.push(bitmapFilter);
					break;
				case "glow":
					trace("adding glow filter");
					var glowFilter : GlowFilter = getBitmapFilter();
					_holder.filters = [glowFilter];
					break;
				default:
			}
		}

		public function getBitmapFilter() : GlowFilter {
			var color : Number = _sketchParams.filterColor
			var alpha : Number = _sketchParams.filterAlpha;
			var blurX : Number = _sketchParams.filterSize;
			var blurY : Number = _sketchParams.filterSize;
			var strength : Number = _sketchParams.filterStrength;
			var inner : Boolean = false;
			var knockout : Boolean = false;
			var quality : Number = BitmapFilterQuality.HIGH;

			return new GlowFilter(color, alpha, blurX, blurY, strength, quality, inner, knockout);
		}

		public function generateCircles() : void {
			trace("DotsDisplay.generateCircles()  ");

			while (_holder.numChildren > 0) {
				_holder.removeChildAt(0);
			}

			_circles = new Array();

			for (var i : int = 0; i < _sketchParams.totalCirles; i++) {
				var circle : Circle = createNewCircle(i);
				circle.x = 150;
				circle.y = 125;
				_holder.addChild(circle);
				_circles.push(circle);
			}
		}

		

		private function createNewCircle(i : int) : Circle {
			// total dots, radius, dot radius
			var retCircle : Circle = new Circle(_sketchParams.dotsPerCircle, _sketchParams.initialCircleRadius + (i * _sketchParams.spaceBetweenCircles), _sketchParams.smallestDotRadius + (i * _sketchParams.dotRadiusIncrement), _sketchParams.dotColor, _sketchParams.showCircles, _sketchParams.dotAlpha);
			return retCircle;
		}
	}
}
