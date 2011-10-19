package com.igz.curri2.ui 
{
	import com.igz.curri2.Frwk;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.net.SharedObject;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import igz.fleaxy.Fleaxy;
	import igz.fleaxy.locale.LocaleManager;
	import igz.fleaxy.ui.ButtonUi;
	import igz.fleaxy.ui.form.input.Input;
	import igz.fleaxy.ui.form.input.InputType;
	import igz.fleaxy.ui.form.select.SelectUi;
	import igz.fleaxy.ui.LinkUi;
	import igz.fleaxy.ui.text.LabelUi;
	import flash.net.navigateToURL;
	/**
	 * ...
	 * @author ...
	 */
	public class SearchComboUi extends Sprite
	{
		private var _TitleLabel:LabelUi;
		private var _Input:Input;
	//	private var _Recommend:Sprite;
		
		
		public function SearchComboUi()
		{

			var s:Sprite = new Sprite();
			s.graphics.beginFill(0xEEEEEE, 1);
			s.graphics.drawRoundRect(0, 0, 400, 350, 20, 20);
			s.graphics.endFill();
			s.x = (Fleaxy.$Current.$Stage.stageWidth-s.width)/2;
			s.y = (Fleaxy.$Current.$Stage.stageHeight - s.height) / 2;
			
			var title:String = LocaleManager.$GetText("COMBO","INPUT_MAIL");
			if (Frwk.$Current.$firstSearch>0)
			{
				title = LocaleManager.$GetText("COMBO", "BAD_MAIL");
				// _Recommend = new Sprite();
				var label:LabelUi = new LabelUi( LocaleManager.$GetText("COMBO", "RECOM") + Frwk.$Current.$CVToLoad, "default2");
				var link:LinkUi = new LinkUi(label, { "onClick":$recomendMail } );
				link.x = 25;
				link.y = 300;

				s.addChild(link);
				
			}
			_TitleLabel = new LabelUi(title,"default4", { "fixWidth" : 350
														, "maxLines" : 2
														});
														

			_Input = new Input("search_combo", { "width":350,
												"inputType" : InputType.$MAIL} );
			_Input.height = 50;
			var button:ButtonUi = new ButtonUi("Search", f_searchPerson, {  
								  "marginTop"      : 20
								  ,"marginInternal"	: 30
								  ,"round"          : 10
								  ,"labelStyle"     : "default1"
								  ,"background"     : 0xcacaca
								  ,"borderAlpha"	: 0
								  ,"width"          :100
								});
			var link2:ButtonUi =  new ButtonUi(LocaleManager.$GetText("COMBO", "NEW_TIMELINE"), $createCv, {  
				  "marginTop"      : 20
				  ,"marginInternal"	: 30
				  ,"round"          : 10
				  ,"labelStyle"     : "default1"
				  ,"background"     : 0xcacaca
				  ,"borderAlpha"	: 0
				  ,"width"          :200
				});			
			link2.y = 235;
			link2.x = 25;
			s.addChild(link2);					
								
			_TitleLabel.x =25;
			_TitleLabel.y = 15;
			s.addChild(_TitleLabel);
			_Input.x = 25;
			_Input.y = 135;
			s.addChild(_Input);
			button.x = 275;
			button.y = 235;
			s.addChild(button);

			addChild(s);
			/*
			var ShareObj:SharedObject = SharedObject.getLocal("lastCV");
			var arr:Array = ShareObj.data.lastSearch;
			if (arr != null)
			{
			_ListCV = new SelectUi("lastSearchs");
			for (var i = 0; i < arr.length; i++)
			{
			_ListCV.$AddItem(arr[i], arr[i]);	
			}
			addChild(_ListCV);
			}
			*/
		}
		
		public function $recomendMail(e:MouseEvent):void
		{
			var subj:String = "mailto:"+Frwk.$Current.$CVToLoad+"?subject="+LocaleManager.$GetText("COMBO", "RECOM_MAIL");
			trace("MAILTOOOO:"+subj);
			var url:URLRequest = new URLRequest(subj);
			url.method = URLRequestMethod.POST;
			navigateToURL(url,"_blank");		
		}
		
		public function $createCv():void
		{
			var subj:String = "mailto:"+Frwk.$Current.$CVToLoad+"?subject="+LocaleManager.$GetText("COMBO", "RECOM_MAIL");
			var url:URLRequest = new URLRequest("http://www.timelinecareer.com");
			url.method = URLRequestMethod.POST;
			navigateToURL(url,"_blank");		
		}
		
		
		public function f_searchPerson():void
		{
			if(_Input.$Validate())
			{	
				Frwk.$Current.$firstSearch = Frwk.$Current.$firstSearch+1;
				Frwk.$Current.$CVToLoad = _Input.$Value;
				Gui.$Current.MainWindow.$ShowLoading();
				Frwk.$Current.loadCV();
			}else
			{
				
			_Input.$Value = LocaleManager.$GetText("COMBO","PUT_MAIL");
			}
			
		}
		
	}

}