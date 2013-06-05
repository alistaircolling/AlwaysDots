package view {
	import flash.display.Shape;
	import graphics.Drawing;
	import flash.display.Sprite;

	/**
	 * @author acolling
	 */
	public class DotsDisplay extends Sprite {
		private var _bg : Shape;
		public function DotsDisplay() {
			
			init();
		}

		private function init() : void {
			
			drawBG();
			
		}

		private function drawBG() : void {
			
			_bg = Drawing.drawBox(300, 250, 0x8bddff);
			addChild(_bg);
		}
	}
}
