package com.igz.curri2.ui 
{
	import com.igz.curri2.Frwk;
	import com.igz.curri2.frwk.ProyectDto;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.text.TextFieldAutoSize;
	import igz.fleaxy.locale.LocaleManager;
	import igz.fleaxy.ui.LinkUi;
	import igz.fleaxy.ui.scrollbar.ScrollBarContainerUi;
	import igz.fleaxy.ui.scrollbar.ScrollContainerUi;
	import igz.fleaxy.ui.text.LabelUi;
	import igz.fleaxy.ui.text.TextUi;
	import flash.net.navigateToURL;
	/**
	 * ...
	 * @author 
	 */
	public class ProyectSheetUi extends Sprite
	{
		private var _Title:LabelUi;
		private var _Company:LabelUi;
		private var _Category:LabelUi;
		private var _SubCategory:LabelUi;
		private var _DetailsLabel:LabelUi;
		private var _DetailsText:LabelUi;
		private var _ScrollDetails:ScrollBarContainerUi;
		private var _WebLink:LinkUi;
		private var _Bg:Sprite;
		public static var $SheetWidth:Number=300;
		public static var _SheetHeight:Number;	
		private var mydto:ProyectDto;
		
		public function ProyectSheetUi(p_proyectDTO:ProyectDto) 
		{
			mydto = p_proyectDTO;
			_Bg = new Sprite();
			if (p_proyectDTO.Profesional == false)
			{
				_Bg.graphics.lineStyle(3, Frwk.$Current.$ThemeManager.$GetColorOfTag("line_bg_proyect_sheet"));
				_Bg.graphics.beginFill(Frwk.$Current.$ThemeManager.$GetColorOfTag("bg_proyect_sheet"));	
			}else
			{
				_Bg.graphics.lineStyle(3, Frwk.$Current.$ThemeManager.$GetColorOfTag("line_bg_proyect_sheet_personal"));
				_Bg.graphics.beginFill(Frwk.$Current.$ThemeManager.$GetColorOfTag("bg_proyect_sheet_personal"));	
				
			}
			var myGlow:GlowFilter = new GlowFilter(); 
			myGlow.inner=true; 
			myGlow.color = 0x888888; 
			myGlow.blurX = 13; 
			myGlow.blurY = 13; 
			_Bg.filters = [myGlow];
			
			_SheetHeight = 300;
			_Bg.graphics.drawRoundRect(0, 0, $SheetWidth, _SheetHeight,50);
			addChild(_Bg);
			_Title = new LabelUi(p_proyectDTO.Name, "CenterH1");
			
			_Company = new LabelUi("at " + p_proyectDTO.Company, "CenterH2");
			if (p_proyectDTO.Company == "")
			{
				_Company.visible = false;
			}
			_Category = new LabelUi(p_proyectDTO.SubCategory+" in "+p_proyectDTO.Category+" category ", "CenterH3");
			//_SubCategory = new LabelUi(p_proyectDTO.SubCategory, "CenterH3");
			_DetailsLabel = new LabelUi(LocaleManager.$GetText("GLOBAL","DETAILS"), "CenterH3_u");
			_ScrollDetails = new ScrollBarContainerUi( { "width":  $SheetWidth - 50, "height": 100, "borderAlpha" : 0, "backgroundAlpha": 1,"background":Frwk.$Current.$ThemeManager.$GetColorOfTag("bg_proyectsheet_details") } );
			_ScrollDetails.$ScrollBarV.$MarkColor = Frwk.$Current.$ThemeManager.$GetColorOfTag("scrollbar_proyectsheet_details");
			_ScrollDetails.$ScrollBarH.visible = false;
			myGlow.blurX = 5; 
			myGlow.blurY = 5; 
			_ScrollDetails.filters = [myGlow];
			_DetailsText = new LabelUi(p_proyectDTO.Description, "Content", { maxLines: 20, fixWidth: 200 } );
			_ScrollDetails.addChild(_DetailsText);
		trace("--->["+p_proyectDTO.Url+"]")
			_WebLink = new LinkUi(new LabelUi(p_proyectDTO.Url, "CenterH3",{"fixWidth" : $SheetWidth-30}), { "onClick":$GoToUrl } );
			addChild(_Title);
			addChild(_Company);
			addChild(_Category);
		//	addChild(_SubCategory);
			addChild(_DetailsLabel);
			addChild(_ScrollDetails);
			addChild(_WebLink);
			$Recolocate();
		}
		
		public function $GoToUrl(m:MouseEvent):void
		{
			var url:URLRequest = new URLRequest(mydto.Url);
			
			navigateToURL(url,"_blank");
			
		}
		
		public function $Recolocate():void
		{
		_Title.x = 15;	
		_Title.y = 15;
		_Company.x = _Title.x;
		_Company.y = _Title.y+_Title.height+3;
		_Category.x = _Title.x;
		_Category.y =_Company.y+_Company.height+5;
	//	_SubCategory.x = 155;
	//	_SubCategory.y = 75;		
		_DetailsLabel.x = _Title.x;
		_DetailsLabel.y = _Category.y+_Category.height+5;
		_ScrollDetails.x = _Title.x;
		_ScrollDetails.y =  _DetailsLabel.y+_DetailsLabel.height+3;
//		trace("poniendo las cosas en su sitio ["+_DetailsText.height+"]");
		_WebLink.x = _ScrollDetails.x;
		_WebLink.y = _ScrollDetails.y + _ScrollDetails.height+5;
		
		}
		
	}

}