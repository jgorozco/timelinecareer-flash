package com.igz.curri2.ui 
{
	import com.greensock.TimelineLite;
	import com.igz.curri2.Frwk;
	import com.igz.curri2.frwk.CategoryDto;
	import com.igz.curri2.frwk.PersonalDataDto;
	import flash.display.Sprite;
	import flash.external.ExternalInterface;
	import flash.net.SharedObject;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import igz.fleaxy.Fleaxy;
	import igz.fleaxy.locale.LocaleManager;
	import igz.fleaxy.net.LoaderUi;
	import igz.fleaxy.ui.ShieldUi;
	import igz.fleaxy.ui.text.LabelUi;
	import igz.fleaxy.util.SpriteUtil;
	import mx.controls.Label;
	
	/**
	 * ...
	 * @author ...
	 */
	public class MainWindowUi extends Sprite
	{
		
		private var _tagCloud:TagsCloudUi;
		private var _PersonalData:PersonalDataUi;
		private var _ComboCategoriesUI:ComboCategoriesUI;
		private var _SecondaryCategories:CategoriesUi;
		private var _ProyectUi:ProyectUi;
		private var _SearchComboUi:SearchComboUi;
		private var _loadingBanner:Sprite;
		public function MainWindowUi() 
		{
			
			_loadingBanner = new Sprite();
			$ShowLoading();
			
		}
		
		public function $ShowLoading():void
		{
			SpriteUtil.$RemoveChildsOf(this);
			_loadingBanner.addChild(new LabelUi(LocaleManager.$GetText("GLOBAL","LOADING"), "default5"));
			_loadingBanner.x = (Fleaxy.$Current.$Stage.stageWidth-_loadingBanner.width)/2;
			_loadingBanner.y = (Fleaxy.$Current.$Stage.stageHeight-_loadingBanner.height)/2;
			addChild(_loadingBanner);
		}
		
		public function initData():void
		{
			SpriteUtil.$RemoveChildsOf(this);
			if (Frwk.$Current.$PersonalData == null)
			{
			_showComboSearch();
			
			}else {
			var ShareObj:SharedObject = SharedObject.getLocal("lastCV");
			var arr:Array = ShareObj.data.lastSearch;
			if (arr == null)
			{
			arr = new Array();	
			}
			if (arr.length >= 5)
			{
			arr.pop();	
			}
			arr.push(Frwk.$Current.$CVToLoad);
			ShareObj.data.lastSearch = arr;
			ShareObj.flush();
			
			
			_addTimeline();
			_addExtraPlugins();
			_addProyectView();
			_addPersonalData();
			}
		}
		
		
		private function _showComboSearch():void
		{
			SpriteUtil.$RemoveChildsOf(this);
			_SearchComboUi = new SearchComboUi();
			addChild(_SearchComboUi);
			
	/*	var err:ShieldUi = new ShieldUi();
		var c:String = "NO PARAMETER IN URL, try with ?mail={cv email}";
		if (ExternalInterface.available){
			c = ExternalInterface.call("window.location.href.toString");
		//	var arr:Array = c.split("?");
		//	c = arr[1];
			var arr:Array = c.split("=");
			c = arr[1];
		}
		
		//var d:String = Fleaxy.$Current.$Stage.loaderInfo.parameters;
		var lbl:LabelUi = new LabelUi("problem with mail ["+c+"] check it and try again ", "default6");
		err.addChild(lbl);
		addChild(err);*/
		}
		
		private function _addTimeline():void
		{
			_ComboCategoriesUI = new ComboCategoriesUI();
			_ComboCategoriesUI.$AddCategorie( Frwk.$Current.$Categories);
			_ComboCategoriesUI.y = (Fleaxy.$Current.$Stage.stageHeight-_ComboCategoriesUI.height+120) / 2;
			addChild(_ComboCategoriesUI);
			_ComboCategoriesUI.$ShowCategorie();
		}

		private function _addPersonalData():void
		{
			_PersonalData = new PersonalDataUi();
			_PersonalData.x = (Fleaxy.$Current.$Stage.stageWidth-_PersonalData.width)/2;
			_PersonalData.y =-300;
			addChild(_PersonalData);
			_PersonalData.$LoadPersonalData(Frwk.$Current.$PersonalData);
		}
		
		
		private function _addExtraPlugins():void
		{
		/*	var MySettings:Object = { "width" : 200
						, "height" : 200
						, "OnClickFunction" : _clickedFunction
				        }
		
					
						
		_tagCloud = new TagsCloudUi(MySettings);
		for each (var itm:CategoryDto in Frwk.$Current.$Categories) 
		{
		_tagCloud.AddTag(itm.$Name, itm.$Count+3);
		if (itm.$Sons.length > 0)
		  for each (var itm2:CategoryDto in itm.$Sons)
			{
			  _tagCloud.AddTag(itm2.$Name, itm.$Count);
		   
			}
			
		}
		
		addChild(_tagCloud);
		_tagCloud.x = 690;
		_tagCloud.y = 20;*/
		}		
		private function _addProyectView():void
		{
			_ProyectUi = new ProyectUi();
			addChild(_ProyectUi);
			_ProyectUi.y = (Fleaxy.$Current.$Stage.stageHeight - _ProyectUi.$HeaderHeight)-30;
		}
		
		
		public function $ReloadProyectList(p_arr:Array):void
		{
			
		_ProyectUi.$SetArrayProyects(p_arr);	
		}
		
		private function _clickedFunction():void
		{
			trace("clicked function");
			var selected:String = _tagCloud.$GetCurrentTag();
		//	_Categories.$AddCategorie(selected);
			//var lab:LabelUi = new LabelUi(selected);
			//lab.x = Math.random() * 700;
			//lab.y = Math.random() * 700;
			//addChild(lab);
		}
		
	}

}