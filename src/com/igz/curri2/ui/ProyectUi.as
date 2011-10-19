package com.igz.curri2.ui 
{
	import com.greensock.TweenLite;
	import com.igz.curri2.Frwk;
	import com.igz.curri2.frwk.ProyectDto;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import igz.fleaxy.Fleaxy;
	import igz.fleaxy.ui.LinkUi;
	import igz.fleaxy.util.SpriteUtil;
	/**
	 * ...
	 * @author 
	 */
	public class ProyectUi extends Sprite
	{
		public  var $HeaderHeight:Number;
		public  var $CompleterHeight:Number;
		public var $Showed:Boolean;
		private var _ShowBtn:LinkUi;
		private var  _Content:Sprite ;
		private var _btn_show:Sprite;
		public function ProyectUi() 
		{
			$Showed = false;
			$HeaderHeight = 40;
			$CompleterHeight = 300;
			var s:Sprite = new Sprite();
			s.graphics.beginFill(Frwk.$Current.$ThemeManager.$GetColorOfTag("bg_proyectlist"));
			s.graphics.lineStyle(1, 0X666666, 1, true);
			s.graphics.moveTo(0, 0);
			s.graphics.curveTo(Fleaxy.$Current.$Stage.stageWidth / 2, -60 , Fleaxy.$Current.$Stage.stageWidth, 0);
			s.graphics.lineTo(Fleaxy.$Current.$Stage.stageWidth, 300);
			s.graphics.lineTo(0, 300);
			s.graphics.lineTo(0,0);
			//s.graphics.drawRect(0, 0, Fleaxy.$Current.$Stage.stageWidth, 300);
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

			_Content = null;

			_btn_show = new Sprite();
			_btn_show.graphics.beginFill(0X666666);
			_btn_show.graphics.drawEllipse(0, 0, 150, 80);
			//btn_show.graphics.drawRect(0, 0, 80, 40);
			_btn_show.graphics.endFill();

			var tamanio:Number = 5;
			var altura:Number = 10;
			var up:Sprite = new Sprite();
			up.name = "uptag";			
			up.graphics.beginFill(0x000000);			
			up.graphics.lineStyle(2, 0xffffff);
			up.graphics.moveTo(_btn_show.width / 2, altura);
			up.graphics.lineTo((_btn_show.width / 2) - tamanio, altura + tamanio);
			up.graphics.moveTo(_btn_show.width / 2,altura);
			up.graphics.lineTo((_btn_show.width / 2) + tamanio,altura + tamanio);
			_btn_show.addChild(up);

			var down:Sprite = new Sprite();
			down.name = "downtag";	
			down.graphics.beginFill(0x000000);
			down.graphics.lineStyle(2, 0xffffff);
			down.graphics.moveTo(_btn_show.width / 2, altura+tamanio);
			down.graphics.lineTo((_btn_show.width / 2) - tamanio, altura );
			down.graphics.moveTo(_btn_show.width / 2,altura+tamanio);
			down.graphics.lineTo((_btn_show.width / 2) + tamanio, altura);
			_btn_show.addChild(down);			
			
			down.visible = false;
			
			_ShowBtn = new LinkUi(_btn_show, { "onClick":_OnClickShow,"onMouseOver":_OnMouseOver, "onMouseOut":_OnMouseOut  } );
			addChild(_ShowBtn);
			swapChildren(s,_ShowBtn);
			$Recolocate();
		}
		
		
		
		private function _OnMouseOver(e:MouseEvent):void
		{

			var myGlow:GlowFilter = new GlowFilter(); 
			myGlow.inner=true; 
			myGlow.color = 0xaaaaaa; 
		//	myGlow.knockout = true;
		//	myGlow.strength = 200;
			myGlow.blurX = 13; 
			myGlow.blurY = 13; 
			e.currentTarget.filters = [myGlow];
		}

		
		private function _OnMouseOut(e:MouseEvent):void
		{
			e.currentTarget.filters = [];
		}
		
		
		private function _OnClickShow(e:MouseEvent):void 
		{
			var p:Number;
		
			if ($Showed)//ocultamos
			{
				_btn_show.getChildByName("uptag").visible = true;
				_btn_show.getChildByName("downtag").visible = false;					
				p = this.y + 220;
				TweenLite.to(this, 0.7, { y: p /*,onComplete:_ChangeText */} );
			}
			else
			{
				_btn_show.getChildByName("uptag").visible = false;
				_btn_show.getChildByName("downtag").visible = true;	
				 p = this.y - 220;
				TweenLite.to(this, 0.7, { y: p /*, onComplete:_ChangeText */} );		
				//$LoadPersonalData(null);
			}
			$Showed = !$Showed;
		}
		
		public function $Recolocate():void
		{
			
			_ShowBtn.y = -50;
			_ShowBtn.x = ( this.width - _ShowBtn.width)/2;
		}
		
		public function $SetArrayProyects(p_arr:Array):void
		{
			//trace("Setting Array elements ["+p_arr.length+"]");
			var proyect:ProyectDto;
			var pSheet:ProyectSheetUi;
			if (_Content != null)
			{
				removeChild(_Content);
				_Content = null;
				}
			_Content = new Sprite();
			_Content.name = "content";
			_Content.graphics.beginFill(0x000000, 0.0);
			_Content.graphics.drawRect(0, 0, ProyectSheetUi.$SheetWidth * p_arr.length, this.height);
			_Content.graphics.endFill();
			for (var i:Number = 0; i < p_arr.length; i++)
			{
					pSheet = new ProyectSheetUi((p_arr[i] as ProyectDto));
					_Content.addChild(pSheet);
					pSheet.x = pSheet.width * i;
			}
			addChild(_Content);
			_Content.x = (this.width-_Content.width) / 2;
			
		}
		
		
	}

}