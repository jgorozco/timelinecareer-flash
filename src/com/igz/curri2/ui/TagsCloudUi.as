package com.igz.curri2.ui 
{
	import com.igz.curri2.Frwk;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import igz.fleaxy.ui.LinkUi;
	import igz.fleaxy.ui.scrollbar.ScrollContainerUi;
	import igz.fleaxy.ui.text.LabelUi;
	import igz.fleaxy.util.ObjectUtil;
	import mx.controls.Label;
	
	/**
	 * ...
	 * @author ...
	 */
	public class TagsCloudUi extends Sprite
	{
		private var _Bg:Sprite;
		private var _TagsContainer:Sprite;
		private var _tags:Array;
		private var _linksUi:Array;
		private var _Settings:Object;
		private var _lastPoint:Point;
		private var _CurrentTag:String;
		private var _OnClickFunction:Function;
		private var _Media:Number;
		private var _OriginalSize:Point;
		public function $GetCurrentTag():String
		{
		return _CurrentTag;	
		}
		
		public function TagsCloudUi( p_settings:Object = null) 
		{
			this.mouseChildren = true;
			this.mouseEnabled = true;
			_CurrentTag = "";
			_tags = new Array();
			_Settings = { "width" : 180
						, "height" : 180
						, "OnClickFunction" : null
				        }
			ObjectUtil.$Merge( p_settings, _Settings );	
			_OriginalSize = new Point(_Settings["width"], _Settings["height"]);
			_Media = (_Settings["width"] + _Settings["width"])/16;
			_OnClickFunction=p_settings["OnClickFunction"];
			_Bg = new Sprite();
			_Bg.graphics.beginFill(Frwk.$Current.$ThemeManager.$GetColorOfTag("line_scuare_1"),0.2);
			_Bg.graphics.drawRoundRect(0, 0, _Settings["width"], _Settings["height"],60);
			_Bg.graphics.endFill();
			addChild(_Bg);
			_TagsContainer= new Sprite();
			_TagsContainer.graphics.beginFill(Frwk.$Current.$ThemeManager.$GetColorOfTag("line_scuare_1"),0.2);
			_TagsContainer.graphics.drawRoundRect(0, 0, _Settings["width"], _Settings["height"],60);
			_TagsContainer.graphics.endFill();
			addChild(_TagsContainer);
			_TagsContainer.addEventListener(MouseEvent.MOUSE_OVER, _OnMouseover);
			_TagsContainer.addEventListener(MouseEvent.MOUSE_OUT, _OnMouseOut);
			_TagsContainer.addEventListener(MouseEvent.MOUSE_MOVE, _OnMouseMove);
			_lastPoint = null;
		}
		
		private function _OnMouseOut(e:MouseEvent):void 
		{
			_lastPoint = null;
		}
		
		private function _OnMouseover(e:MouseEvent):void 
		{
			_lastPoint = new Point(e.localX, e.localY);
		}
			
		private function _OnMouseMove2(e:MouseEvent):void
		{
		if (_lastPoint != null)
			{
				var movemingx:Number = e.localX - _lastPoint.x;
				var movemingy:Number = e.localY - _lastPoint.y;		
				_lastPoint.x = e.localX;
				_lastPoint.y = e.localY;
				var Disp:Sprite;
				var label:DisplayObject;
				for (var i:Number = 0; i< _tags.length; i++)
					{	
						Disp = (_tags[i] as Sprite);
						label = Disp.getChildByName("mylabel");
						label.x += movemingx/2;
						label.y += movemingy/2;
						var scale:Number = 1.5;
						var scalingx:Number = Math.abs(label.x - (_TagsContainer.width / 2))/(_TagsContainer.width*2);
						var scalingy:Number = Math.abs(label.y - (_TagsContainer.height / 2)) /( _TagsContainer.height*2);
						scale = scale-scalingx - scalingy;
						label.scaleX = scale;
						label.scaleY = scale;					
						setIntoLimits(label,_Bg);
					}	
				
			}			
			
		}
		private function _OnMouseMove(e:MouseEvent):void 
		{
			var re:Rectangle=new Rectangle();
			if (_lastPoint != null)
			{
			var Disp:Sprite;
			var label:DisplayObject;
			for (var i:Number = 0; i< _tags.length; i++)	
				{
					Disp = (_tags[i] as Sprite);
					label = Disp.getChildByName("mylabel");
					re.topLeft = new Point(e.localX, e.localY);
					re.bottomRight = new Point(label.x+(label.width/2), label.y+(label.height/2));
					var valor2:Number =Math.sqrt(Math.sqrt((re.width*re.width)+(re.height*re.height)));
					label.scaleX = 1.4 - valor2/_Media;
					label.scaleY = 1.4 - valor2/_Media;
				}
			}
		/*	if (_lastPoint != null)
			{
				trace("e.localX:"+e.localX+"//e.localY:"+e.localY);
				var movemingx:Number = e.localX - _lastPoint.x;
				var movemingy:Number = e.localY - _lastPoint.y;		
				_lastPoint.x = e.localX;
				_lastPoint.y = e.localY;
				var label:LabelUi;
				for (var i:Number = 0; i< _tags.length; i++)
					{	
						label = (_tags[i] as LabelUi);
						label.x += movemingx/2;
						label.y += movemingy/2;
						var scale:Number = 1.5;
						var scalingx:Number = Math.abs(label.x - (_TagsContainer.width / 2))/(_TagsContainer.width*2);
						var scalingy:Number = Math.abs(label.y - (_TagsContainer.height / 2)) /( _TagsContainer.height*2);
						scale = scale-scalingx - scalingy;
						label.scaleX = scale;
						label.scaleY = scale;					
						setIntoLimits(label,_Bg);
					}	
				
			}
			*/
//				trace("e.stageX:"+e.stageX+"//e.stageY:"+e.stageY);		
			/*
			 * mueve segun cuadrantes, arriba, abajo, izkierda y derecha
			
			var moveX:Number = (_TagsContainer.width / 2) - e.localX;
			var moveY:Number = (_TagsContainer.height / 2) - e.localY;	
			var movemingx:Number = (moveX / _TagsContainer.width)*3;
			var movemingy:Number = (moveY / _TagsContainer.height) * 3;
			*/
			

		}
				
		private function setIntoLimits(p_elem:DisplayObject,p_container:Sprite):void
		{
			if (p_elem.x < 0)
			{
				p_elem.x = 0;
			}
			if (p_elem.y < 0)
			{
				p_elem.y = 0;
			}
			if ((p_elem.width+p_elem.x)>_OriginalSize.x)
			{
				p_elem.x = _OriginalSize.x-p_elem.width;
			}
			if (_OriginalSize.y<(p_elem.height+p_elem.y))
			{
				p_elem.y = _OriginalSize.y-p_elem.height;
			}
		}
		
		public function AddTag(p_string:String,p_importance:Number=0):void
		{
			var lab:LabelUi = new LabelUi(p_string, "default" + p_importance);
			var s:Sprite = new Sprite();
			lab.name = "mylabel";
			s.addChild(lab);											
			lab.tabEnabled = false;
			s.buttonMode = true;
			s.useHandCursor = true;
			s.addEventListener(MouseEvent.CLICK, _OnClick );
			s.addEventListener(MouseEvent.MOUSE_OVER, _setHandOn);
			s.addEventListener(MouseEvent.MOUSE_OUT, _setHandOff);			
			lab.x = Math.random() * _TagsContainer.width;
			lab.y = Math.random() * _TagsContainer.height;
			var label:DisplayObject;
			/*revisaar el algoritmo de colocacion, igual mejor haciendo una espiral*/
			for (var i:Number = 0; i < _tags.length; i++)
			{
				var rect:Rectangle = lab.getRect(_TagsContainer);
				var localRect:Rectangle = (_tags[i] as DisplayObject).getRect(_TagsContainer);
				
				while (rect.intersects(localRect))
				{
					lab.x = Math.random() * _TagsContainer.width;
					lab.y = Math.random() * _TagsContainer.height;	
					rect = lab.getRect(_TagsContainer);
					setIntoLimits(lab,_Bg);	
				}
			}
			
			_tags.push(s);
			_TagsContainer.addChild(s);
		}
		
		
		private function _setHandOff(e:MouseEvent):void 
		{
			trace("SETHANDOFF");		
			useHandCursor = false;
			//TODO efecto para cuando sale la mano desaparece
		}
		
		private function _setHandOn(e:MouseEvent):void 
		{
		trace("SETHANDON");
			useHandCursor = true;
			//TODO poner efecto cuado estas encima de una, pones blur a todas lsa demas y las aclaras
		}
		
		private function _OnClick(e:MouseEvent):void 
		{
			var lbl:LabelUi = ((e.target as Sprite).getChildByName("mylabel") as LabelUi);
			_CurrentTag = lbl.text;
			trace("seleccionado :" + _CurrentTag);
			_OnClickFunction();
		}

		public function ClearTags():void
		{
			var num:Number = 0;
			for (num = 0; num < _tags.length; num++)
			{
				(_tags[num] as Sprite).removeEventListener(MouseEvent.CLICK,_OnClick);
				delete _tags[num];
			}
			_tags = new Array();
		}
		
	}

}