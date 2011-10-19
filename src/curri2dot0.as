package {
	import com.igz.curri2.Frwk;
	import com.igz.curri2.ui.Gui;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.system.Capabilities;
	import igz.fleaxy.Fleaxy;
	import igz.fleaxy.locale.LocaleManager;

	/**
	 * ...
	 * @author josevk
	 */
	[SWF(width="1000", height="700", frameRate="24", backgroundColor="0xDDDDDD")]
	public class curri2dot0 extends Sprite {

		//{ EMBED IMAGEs
/*
		[Embed( source = "../image/close.png", mimeType="image/png") ]
		static private var _Close:Class;
		static public function get $Close() : Bitmap {
			return new _Close() as Bitmap;
		}
*/
		//}

		
		[Embed(source='../image/personal1.png', mimeType="image/png")]
		static private var _Personal:Class;
		static public function get $Personal() : Bitmap {
			return new _Personal() as Bitmap;
		}
		
		//{ EMBED FONTs
		[Embed(source='../font/verdana.ttf'
				, fontName = "Default", fontStyle = "regular", fontWeight = "normal"
				, mimeType = "application/x-font-truetype"
				, unicodeRange="U+0000-U+00FF,U+20AC"
				)
		]
		public static const Default_N:Class;
		//}


		public function curri2dot0() {
			if ( stage ) {
				_OnAddedToStage();
			}
			else {
				addEventListener(Event.ADDED_TO_STAGE, _OnAddedToStage);
			}
		}
		
		private function _OnAddedToStage(p_event:Event = null) : void {
			stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align 	= StageAlign.TOP_LEFT;
			stage.quality   = StageQuality.HIGH;
			stage.showDefaultContextMenu = false;

			var iso639:String = loaderInfo.parameters["iso639"] == null ? "ES" : loaderInfo.parameters["iso639"];

			Fleaxy.$Current.$Init( stage, { "embedFonts" : [
												   Default_N
												  ]
								 , "iso639" 	: iso639
								 , "onComplete" : _FleaxyInit_OnComplete
								 , "uriConfigXml" : "./swf/config.xml"
								 }
						);

		}

		protected function _FleaxyInit_OnComplete() : void {
			trace(LocaleManager.$Iso639 + "//" + LocaleManager.$GetText("GLOBAL", "LOADING"));
    		  Gui.$Current.$Init();
			 Frwk.$Current.$Init(Gui.$Current.MainWindow.initData);
			}
		
	}
	
}