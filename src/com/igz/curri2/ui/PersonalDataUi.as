package com.igz.curri2.ui 
{
	import com.greensock.data.DropShadowFilterVars;
	import com.greensock.TweenLite;
	import com.igz.curri2.Frwk;
	import com.igz.curri2.frwk.PersonalDataDto;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import igz.fleaxy.events.CommEvent;
	import igz.fleaxy.locale.LocaleManager;
	import igz.fleaxy.net.Comm;
	import igz.fleaxy.net.CommResponseType;
	import igz.fleaxy.ui.LinkUi;
	import igz.fleaxy.ui.text.LabelUi;
	import flash.net.navigateToURL;
	/**
	 * ...
	 * @author ...
	 */
	public class PersonalDataUi extends Sprite
	{
		public var $Showed:Boolean;
		private var _LabelShowPersonal:LinkUi;
		private var _PersonalDataDto:PersonalDataDto;
		private var _OthersData:LabelUi;		
		private var _NameLabel:LabelUi;
		private var _PhoneLabel:LabelUi;
		private var _AddressLabel:LabelUi;
		private var _UniversityLabel:LabelUi;
		private var _DriveLicenseLabel:LabelUi;
		private var _PoblationLabel:LabelUi;
		private var _NationalityLabel:LabelUi;
		private var _MailLabel:LabelUi;

		private var _NameData:LabelUi;
		private var _PhoneData:LabelUi;
		private var _AddressData:LabelUi;
		private var _UniversityData:LabelUi;
		private var _DriveLicenseData:LabelUi;
		private var _PoblationData:LabelUi;
		private var _NationalityData:LabelUi;
		private var _MailData:LinkUi;
		private var _PhotoData:Sprite;

		public function PersonalDataUi() 
		{
			var s:Sprite = new Sprite();
			s.graphics.beginFill(Frwk.$Current.$ThemeManager.$GetColorOfTag("bg_personal_data") );
		//	s.graphics.drawRect(0, 0, 700, 370);
			s.graphics.lineStyle(1,Frwk.$Current.$ThemeManager.$GetColorOfTag("bg_personal_line") , 1, true);
			s.graphics.moveTo(0, 0);
			s.graphics.lineTo(700,0);
			s.graphics.lineTo(700, 280);
			s.graphics.curveTo(700, 300,680, 300);
			s.graphics.lineTo(520, 300);
			s.graphics.curveTo(500, 300,500, 320);
			s.graphics.curveTo(500, 340,480, 340);			
			s.graphics.lineTo(220, 340);
			s.graphics.curveTo(200, 340, 200, 320);
			s.graphics.curveTo(200, 300,180, 300);
			s.graphics.lineTo(20, 300);			
			s.graphics.curveTo(0,300,0, 280);
			s.graphics.lineTo(0,280);
			s.graphics.endFill();
			var myGlow:GlowFilter = new GlowFilter(); 
			myGlow.inner=true; 
			myGlow.color = 0x888888; 
		//	myGlow.knockout = true;
		//	myGlow.strength = 200;
			myGlow.blurX = 13; 
			myGlow.blurY = 13; 
			s.filters = [myGlow];
			
			
			addChild(s);
			$Showed = false;
			var personalData:LabelUi = new LabelUi(LocaleManager.$GetText("PERSONAL_DATA","SHOW_DATA"), "CenterH1");
			_LabelShowPersonal = new LinkUi(personalData, { "onClick":_OnClickShow,"onMouseOver":_OnMouseOver, "onMouseOut":_OnMouseOut } );
			addChild(_LabelShowPersonal);
			_LabelShowPersonal.x = (this.width-_LabelShowPersonal.width) / 2;
			_LabelShowPersonal.y = 305;
			_CreateElementsLabel();
		}
		
		public function $LoadPersonalData(p_object:PersonalDataDto):void
		{
			_PersonalDataDto = p_object;
			//if (p_object.$Photo.length==0)
			//{
				var pictLdr:Loader = new Loader();
				var pictURLReq:URLRequest = new URLRequest(p_object.Photo);
				pictLdr.load(pictURLReq);
				pictLdr.contentLoaderInfo.addEventListener( Event.INIT , loaded);
			//}
			_NameData.text =p_object.Name;
			_PhoneData.text = p_object.Phone
			_AddressData.text = p_object.Address;
			_UniversityData.text = p_object.University;
			_DriveLicenseData.text = p_object.DriveLicense;
			_PoblationData.text = p_object.Poblation;
			_NationalityData.text = p_object.Nationality;
			(_MailData.getChildAt(0)as LabelUi).text = p_object.Mail;
		}
		
		private function loaded(event:Event):void
		{
			var targetLoader:Loader = Loader(event.target.loader);
			//targetLoader.x = 400 - (targetLoader.width / 2);
			//targetLoader.y = 260 - (targetLoader.height / 2);
			targetLoader.height = 120;
			targetLoader.scaleX = targetLoader.scaleY;
			_PhotoData.removeChildAt(_PhotoData.numChildren-1);
			_PhotoData.addChild(targetLoader);
		}
		private function _CreateElementsLabel():void
		{
			_NameLabel = new LabelUi(LocaleManager.$GetText("PERSONAL_DATA","NAME_SURN"), "default3");
			_MailLabel = new LabelUi(LocaleManager.$GetText("PERSONAL_DATA","MAIL"), "default3");	
			
			_NameData = new LabelUi("noname qwertyuiop qwertgfdsa", "default5");
			_MailData = new LinkUi(new LabelUi("dddddd@fdsfds.wa", "default5"), { "onClick":$GoToUrl } );
			
			_NameLabel.x = 40;
			_NameLabel.y = 20;
			addChild(_NameLabel);
			addChild(_NameData);			
			_NameData.x = _NameLabel.x+5 ;
			_NameData.y = _NameLabel.y+ _NameLabel.height + 5;		
			/**/
			_MailLabel.x = 40;
			_MailLabel.y = 80;
			addChild(_MailLabel);
			addChild(_MailData);
			_MailData.x = _MailLabel.x+5;
			_MailData.y = _MailLabel.y+ _MailLabel.height +5;	
			
			/**/
			_PhotoData = new Sprite();
			_PhotoData.addChild(curri2dot0.$Personal);
			//_PhotoData.graphics.beginFill(0xff0000);
			//_PhotoData.graphics.drawRect(0, 0, 90, 110);
			//_PhotoData.graphics.endFill();
			addChild(_PhotoData);
			_PhotoData.x = 40;
			_PhotoData.y = 150;					
			
			/*************************************/
			_OthersData = new LabelUi(LocaleManager.$GetText("PERSONAL_DATA","OTHER_DATA") , "default5");
			_OthersData.x = 360;
			_OthersData.y = 20;
			addChild(_OthersData);
			
			/*creacion labels*/
			_PhoneLabel = new LabelUi(LocaleManager.$GetText("PERSONAL_DATA","PHONE") , "default2");
			_AddressLabel = new LabelUi(LocaleManager.$GetText("PERSONAL_DATA","ADDRS"),"default2");			
			_DriveLicenseLabel = new LabelUi(LocaleManager.$GetText("PERSONAL_DATA","DRIV_LICENSE"),"default2");
			_UniversityLabel = new LabelUi(LocaleManager.$GetText("PERSONAL_DATA","STUDIES"), "default2");
			_PoblationLabel=new LabelUi(LocaleManager.$GetText("PERSONAL_DATA","POBLATION"), "default2");
			_NationalityLabel = new LabelUi(LocaleManager.$GetText("PERSONAL_DATA","COUNTRY"), "default2");
			/*creacion contents*/
			_PhoneData = new LabelUi("666666", "default2");
			_AddressData = new LabelUi("c/qwerty", "default2");		
			_DriveLicenseData = new LabelUi("type b", "default2");
			_UniversityData =new LabelUi("qwerty asdfg zxcvb", "default2");
			_PoblationData=new LabelUi("Qeuerty, querty", "default2");
			_NationalityData=new LabelUi("Cuertyy", "default2");
			var others:Sprite=new Sprite();
			others.graphics.beginFill(0x000000, 0.1);
			others.graphics.drawRoundRect(0, 0, 340, 240, 15, 15);
			others.graphics.endFill();
			addChild(others);
			others.x = 340;
			others.y = 50;
			//--
			others.addChild(_PhoneLabel);
			_PhoneLabel.x = 10;
			_PhoneLabel.y = 10;			
			others.addChild(_PhoneData);
			_PhoneData.x = _PhoneLabel.x+_PhoneLabel.width+10;
			_PhoneData.y = _PhoneLabel.y;		
			//++
			//--
			others.addChild(_AddressLabel);
			_AddressLabel.x = 10;
			_AddressLabel.y = 35;
			others.addChild(_AddressData);
			_AddressData.x = _AddressLabel.x+_AddressLabel.width+10;
			_AddressData.y = _AddressLabel.y;				
			//++
			//--			
			others.addChild(_DriveLicenseLabel);
			_DriveLicenseLabel.x = 10;
			_DriveLicenseLabel.y = 60;	
			others.addChild(_DriveLicenseData);
			_DriveLicenseData.x = _DriveLicenseLabel.x+_DriveLicenseLabel.width+10;
			_DriveLicenseData.y = _DriveLicenseLabel.y;					
			//++
			//--			
			others.addChild(_UniversityLabel);
			_UniversityLabel.x = 10;
			_UniversityLabel.y = 85;	
			others.addChild(_UniversityData);
			_UniversityData.x = _UniversityLabel.x+_UniversityLabel.width+10;
			_UniversityData.y = _UniversityLabel.y;					
			//++
			//--			
			others.addChild(_PoblationLabel);
			_PoblationLabel.x = 10;
			_PoblationLabel.y = 110;	
			others.addChild(_PoblationData);
			_PoblationData.x = _PoblationLabel.x+_PoblationLabel.width+10;
			_PoblationData.y = _PoblationLabel.y;					
			//++
			//--			
			others.addChild(_NationalityLabel);
			_NationalityLabel.x = 10;
			_NationalityLabel.y = 135;
			others.addChild(_NationalityData);
			_NationalityData.x = _NationalityLabel.x+_NationalityLabel.width+10;
			_NationalityData.y = _NationalityLabel.y;				
/*			
			_PhoneLabel.x = 400;
			_PhoneLabel.y = 20;
			addChild(_PhoneLabel);
			_AddressLabel.x = 400;
			_AddressLabel.y = 60;
			addChild(_AddressLabel);
			_DriveLicenseLabel.x = 400;
			_DriveLicenseLabel.y = 100;			
			addChild(_DriveLicenseLabel);
			_UniversityLabel.x = 400;
			_UniversityLabel.y = 140;
			addChild(_UniversityLabel);
			_PoblationLabel.x = 400;
			_PoblationLabel.y = 180;			
			addChild(_PoblationLabel);
			_NationalityLabel.x = 400;
			_NationalityLabel.y = 220;			
			addChild(_NationalityLabel);	
*/					
		}
		
		
		public function $GoToUrl(m:MouseEvent):void
		{
			var url:URLRequest = new URLRequest("mailto:"+_PersonalDataDto.Mail);
			
			url.method = URLRequestMethod.POST;
			navigateToURL(url,"_blank");
			
		}
		
		
		
		private function _OnMouseOver(e:MouseEvent):void
		{
			var f:DropShadowFilter = new DropShadowFilter();
			f.distance = 2;
			f.color = 0xffffff;
			f.blurX = 13;
			f.blurY = 13;
			f.quality = 3;
			
			
			e.currentTarget.filters = [f];
		}

		
		private function _OnMouseOut(e:MouseEvent):void
		{
			e.currentTarget.filters = [];
		}		
		
		private function _OnClickShow(e:MouseEvent):void 
		{
			if ($Showed)//ocultamos
			{
				TweenLite.to(this, 0.7, { y: -300,onComplete:_ChangeText } );
			}
			else
			{
				TweenLite.to(this, 0.7, { y: 0, onComplete:_ChangeText } );		
				//$LoadPersonalData(null);
			}
			$Showed = !$Showed;
		}
		
		private function _ChangeText():void
		{
			var label:LabelUi=(_LabelShowPersonal.$DisplayObject as LabelUi);
			if (!$Showed)
			{
				label.text = LocaleManager.$GetText("PERSONAL_DATA","SHOW_DATA");
			}else
			{
				label.text = LocaleManager.$GetText("PERSONAL_DATA","HIDE_DATA");				
			}
		}
		
	}

}