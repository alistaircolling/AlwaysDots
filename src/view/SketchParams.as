package view {
	/**
	 * @author acolling
	 */
	public class SketchParams  extends Object {
		public var totalCirles : int;
		public var dotsPerCircle : int;
		public var initialCircleRadius : int;
		public var spaceBetweenCircles : int;
		public var smallestDotRadius : int;
		public var dotRadiusIncrement : int;
		public var rotateSpeed : Number;
		public var dotColor : int;
		public var showCircles : Boolean;
		public var dotAlpha : Number;
		public var filterType : Object;
		public var filterSize : int;
		public var filterColor : int;
		public var filterStrength : int;
		public var filterAlpha : Number;
		public var explosionPower : Number;
		public var expansionRate : Number;
		public var depth : int;
		public var epsilon : Number;
		public var presetIndex : uint;
		public var friction : Number;

		public function savePreset() : String {
			var preset : String = "totalCirles," + totalCirles + ",dotsPerCircle," + dotsPerCircle + ",initialCircleRadius," + initialCircleRadius + ",spaceBetweenCircles," + spaceBetweenCircles + ",smallestDotRadius," + smallestDotRadius + ",dotRadiusIncrement," + dotRadiusIncrement + ",rotateSpeed," + rotateSpeed + ",dotColor," + dotColor + ",showCircles," + showCircles + ",dotAlpha," + dotAlpha + ",filterType," + filterType + ",filterSize," + filterSize + ",filterColor," + filterColor + ",filterStrength," + filterStrength + ",filterAlpha," + filterAlpha + ",explosionPower," + explosionPower + ",expansionRate," + expansionRate + ",depth," + depth + ",epsilon," + epsilon+"-";
			return preset;
		}
	}
}
