package {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import igz.fleaxy.Fleaxy;
	import igz.fleaxy.ui.preloader.LinearPreloaderUi;
	
	/**
	 * ...
	 * @author josevk
	 */
	[SWF(width="1000", height="700", frameRate="24", backgroundColor="#FFFFFF")]
	public class curri2dot0_preloader extends Sprite {

		//{ EMBED IMAGEs
/*
		[Embed( source = "../image/close.png", mimeType="image/png") ]
		static private var _Close:Class;
		static public function get $Close() : Bitmap {
			return new _Close() as Bitmap;
		}
*/
		//}

		//{ EMBED FONTs
		[Embed(source = '../font/cooper.ttf'
				, fontName = "DefaultPreloader", fontStyle = "regular", fontWeight = "normal"
				, mimeType = "application/x-font-truetype"
				, unicodeRange="U+0000-U+00FF,U+20AC"
				)
		]
		public static const DefaultPreloader_N:Class;
		//}

		private var _PreloaderUi:LinearPreloaderUi;

		public function curri2dot0_preloader() {
			stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align 	= StageAlign.TOP_LEFT;
			stage.quality   = StageQuality.HIGH;
			stage.showDefaultContextMenu = false;

			var iso639:String = loaderInfo.parameters["iso639"] == null ? "ES" : loaderInfo.parameters["iso639"];

			_PreloaderUi = new LinearPreloaderUi();
			addChild(_PreloaderUi);
			Fleaxy.$Preload("curri2dot0.swf?iso639=" + iso639, _OnPreloadComplete, _OnLoadProgress);
		}

		protected function _OnInitComplete() : void {

		}
		private function _OnPreloadComplete(p_commEvent:Event) : void {
			p_commEvent["$ResponseSwf"].visible = false;
			addChild(p_commEvent["$ResponseSwf"]);
		}

		private function _OnLoadProgress(p_progressEvent:ProgressEvent) : void {
			_SetPercent( (p_progressEvent.bytesLoaded * 100) / p_progressEvent.bytesTotal );
		}
		
		private function _SetPercent(p_percent:Number) : void {
			if ( p_percent < 0 ) {
				p_percent = 0;
			}
			else if ( p_percent > 100 ) {
				p_percent = 100;
			}
			_PreloaderUi.$SetValue(p_percent);
			
		}

		public function $HidePreloader() : void {
		
		}
		
	}
	
}