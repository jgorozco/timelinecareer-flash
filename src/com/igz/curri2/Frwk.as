package com.igz.curri2 {
	import com.igz.curri2.frwk.CategoryDto;
	import com.igz.curri2.frwk.PersonalDataDto;
	import com.igz.curri2.frwk.ProyectDto;
	import com.igz.curri2.frwk.ColorManager;
	import com.igz.curri2.ui.CategoriesUi;
	import flash.external.ExternalInterface;
	import flash.system.Capabilities;
	import flash.system.System;
	import igz.fleaxy.configuration.ConfigurationManager;
	import igz.fleaxy.Fleaxy;
	import igz.fleaxy.net.Comm;
	import igz.fleaxy.events.CommEvent;
	import com.igz.curri2.ui.Gui;
	import igz.fleaxy.net.CommResponseType;
	import igz.fleaxy.util.ObjectUtil;
	/**
	 * ...
	 * @author josevk
	 */
	public class Frwk {

		public var $PersonalData:PersonalDataDto=null;
		public var $ArrayProyects:Array=null;
		public var $ShowedProyects:Array=null;
		public var $Categories:Array=null;
		public var $ThemeManager:ColorManager=null;
		public var $TagColorManager:ColorManager=null;
		private var _onCompleteLoad:Function;
		public var $CVToLoad:String;
		public var $firstSearch:int;
		public var $LastSearchs:Array;
		static protected var _Current:Frwk;
		static public function get $Current() : Frwk {
			if ( _Current == null ) {
				_Current = new Frwk();
			}
			return _Current;
		}

		public function Frwk() : void {
		}

		public function $Init(p_complete:Function ) : void {
			$firstSearch = 0;
			$LastSearchs = new Array();
			_onCompleteLoad = p_complete;
			var c:String = "";
			if (ExternalInterface.available){
				c = ExternalInterface.call("window.location.href.toString");
				$firstSearch = 1;
			//	var arr:Array = c.split("?");
			//	c = arr[1];
				var arr:Array = c.split("=");
				c = arr[1];
				if (c == null)
				{
					c = "josevalekas@gmail.com";
				}
			}else {
					c = "josevalekas@gmail.com";
				}
		//		var content:String = "UserData.json";
		$CVToLoad = c;
		loadCV();
		}
		
		public function loadCV():void
		{
			var content:String = Fleaxy.$Current.$ConfigurationManager.$GetValue("com.igz.curri2/BASE_URI") + $CVToLoad;
			trace("content[" + content + "]");
			Comm.$Get(content, { onComplete:_OnCompleteLoadData } );	
			
		}
		
		public function $AddSon(p_category:CategoryDto):int
		{
			var add:Boolean = false;
			var returned:int = 0;
			for  (var i:int; i < $Categories.length; i++ )
			{
				if (($Categories[i] as CategoryDto).$Name == p_category.$Name)
					{
						returned = i;
						($Categories[i] as CategoryDto).$Increment();
						add = true;
					}
			}
			if (!add)
				{
					$Categories.push(p_category);
					p_category.$Count = 1;
					returned = $Categories.length-1;
				}
			return returned;	
		}		
		
		
		public function $GetProyectFromCategorie(p_categorie:CategoryDto):Array
		{
			var arrOut:Array = new Array();
			var i:int = 0;
			var auxp:ProyectDto;
			for (i = 0; i < $ArrayProyects.length; i++)
			{
				auxp = ($ArrayProyects[i] as ProyectDto);
				if ((auxp.Category == p_categorie.$Name) || (auxp.SubCategory == p_categorie.$Name))
				{
					arrOut.push(auxp);
				}
				
			}
			return arrOut;
		}
		
		
		
		private function _OnCompleteLoadData(p_event:CommEvent):void
		{
			if ("{\"status\":\"ERROR[bad argument]\"}" == p_event.$ResponseText)
			{
				_onCompleteLoad();
			}else
			if (p_event.$CommResponseType==CommResponseType.$JSON)
			{
				$ThemeManager = new ColorManager(p_event.$ResponseJSON.Data.Theme);
				$PersonalData = new PersonalDataDto();
				$PersonalData.$LoadFromJson(p_event.$ResponseJSON.Data.UserData);
				$ArrayProyects = new Array();
				$Categories = new Array ();
				$TagColorManager = new ColorManager(p_event.$ResponseJSON.Data.Tags);
				var arr:Array = (p_event.$ResponseJSON.Data.Proyects as Array);
				var aux:ProyectDto;
				var category:CategoryDto;
				var subCat:CategoryDto;
				for each (var itm:Object in arr) 
					{
						aux = new ProyectDto();
						//sacamos la fecha minima para la grafica
						aux.$LoadFromJson(itm);
						$ArrayProyects.push(aux);
						category = new CategoryDto();
						category.$Name = aux.Category;
						var d:int = $AddSon(category);
						subCat = new CategoryDto();
						subCat.$Name = aux.SubCategory;
						($Categories[d] as CategoryDto).$AddSon(subCat);
						
					}
				_onCompleteLoad();
			}else 
			{
				_onCompleteLoad();
			}
			
		}
	}
}