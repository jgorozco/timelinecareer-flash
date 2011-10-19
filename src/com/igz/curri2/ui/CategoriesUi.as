package com.igz.curri2.ui 
{
	import com.greensock.plugins.VolumePlugin;
	import com.greensock.TweenLite;
	import com.igz.curri2.Frwk;
	import com.igz.curri2.frwk.CategoryDto;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import igz.fleaxy.ui.LinkUi;
	import igz.fleaxy.ui.text.LabelUi;
	import igz.fleaxy.util.ObjectUtil;
	import igz.fleaxy.util.SpriteUtil;
	/**
	 * ...
	 * @author ...
	 */
	public class CategoriesUi extends Sprite
	{
		private var _Categories:Array;
		private var _CategoriesData:Array;
		private var _principal:Boolean;
		private var _Parent:ComboCategoriesUI;
		private var _BackButton:LinkUi;
		private var _SubCategories:CategoriesUi;
		public var $CatContainer:Sprite;
		public var $IsHidden:Boolean;
		public var $BG:Sprite;
		private var _Settings:Object={ "width" : 80
									, "height" : 300
									, "btnWith":20
									, "btnHeight":20
									};
		public var $BtnMedidas:Point;							
							
		
		
		public function CategoriesUi(p_settings:Object) 
		{
			_CategoriesData = new Array();
			_Categories = new Array();
			
			ObjectUtil.$Merge( p_settings, _Settings );
			_Parent = (p_settings["parent"] as ComboCategoriesUI);
			_principal = (p_settings["principal"]as Boolean);
			$CatContainer = new Sprite();
			$CatContainer.name = "$CatContainer";
			var color:Number = (_Settings["color"] as Number);
			trace("IS PRINCIPAL?" + _principal);
			if (_principal == true)
			{
				$BtnMedidas = new Point(Number(_Settings["btnWith"]), Number(_Settings["btnHeight"]));
			}else
			{
				$BtnMedidas = new Point(0,0);
			}
			$IsHidden = _principal;
			$BG = new Sprite();
			$BG.graphics.beginFill(color);
			$BG.graphics.drawRoundRect(0, 0, _Settings["width"], _Settings["height"],40);
			$BG.graphics.endFill();
			var myGlow:GlowFilter = new GlowFilter(); 
			myGlow.inner=true; 
			myGlow.color = 0x888888; 
		//	myGlow.knockout = true;
		//	myGlow.strength = 200;
			myGlow.blurX = 13; 
			myGlow.blurY = 13; 
			$BG.filters = [myGlow];
			addChild($BG);
			$BG.addChild($CatContainer);
			if (_principal)
			{
				var linked:Sprite = new Sprite();
				linked.graphics.beginFill(Frwk.$Current.$ThemeManager.$GetColorOfTag("close_button"));
				linked.graphics.drawRoundRect(0, 0, _Settings["btnWith"], _Settings["btnHeight"],_Settings["btnWith"]);
				linked.graphics.endFill();
				var cross:Sprite = new Sprite();
				//cross.graphics.beginFill(0xffffff);
				cross.graphics.lineStyle(2, 0xffffff, 1, true);
				var tamanio:Number = 5;
				cross.graphics.moveTo(linked.width / 4, linked.height / 2);
				cross.graphics.lineTo((3 * linked.width / 4),  linked.height / 2);
				cross.graphics.lineTo(( linked.width / 2),  linked.height / 4);
				cross.graphics.moveTo((3 * linked.width / 4),  linked.height / 2);
				cross.graphics.lineTo(( linked.width / 2),  3*linked.height / 4);
			/*	cross.graphics.moveTo(linked.width / 2, linked.height / 2);
				cross.graphics.lineTo((linked.width / 2) - tamanio, (linked.height / 2) - tamanio);
				cross.graphics.moveTo(linked.width / 2, linked.height / 2);
				cross.graphics.lineTo((linked.width / 2) -tamanio, (linked.height / 2) + tamanio);
				cross.graphics.moveTo(linked.width / 2, linked.height / 2);
				cross.graphics.lineTo((linked.width / 2) + tamanio, (linked.height / 2) + tamanio);
				cross.graphics.moveTo(linked.width / 2, linked.height / 2);
				cross.graphics.lineTo((linked.width / 2) + tamanio, (linked.height / 2) -tamanio);*/
				linked.addChild(cross);
				_BackButton = new LinkUi(linked, { "onClick":_OnClickReturn 
													,"onMouseOver":_OnMouseOver_btn
													,"onMouseOut":_OnMouseOut_btn  } );
				addChild(_BackButton);
				_BackButton.x =this.width-_Settings["btnWith"]/2;
				_BackButton.y = -_BackButton.height/2;
				_BackButton.visible = false;
			}
		}
		
		public function $GetCategories():Array
		{
			return _CategoriesData;	
		}
		
		public function $IsPrincipal(): Boolean
		{
			return _principal;	
		}		
		
		
		public function $ClearAllCategories():void
		{
			if (!_principal)
			{
				SpriteUtil.$RemoveChildsOf($CatContainer);
			}
			_Categories = new Array();
			_CategoriesData = new Array();			
		}
		
		public function $AddCategorie(p_categore:CategoryDto):void
		{
			_CategoriesData.push(p_categore);
			var linkUi:LinkUi = new LinkUi(new LabelUi(p_categore.$Name, "default5"), { "onClick":_OnClickSelectCategorie
																						,"onMouseOver":_OnMouseOver
																						,"onMouseOut":_OnMouseOut  } );
			linkUi.name = p_categore.$Name;
			_Categories.push(linkUi);
			$CatContainer.addChild(linkUi);
			_ColocarEtiquetas();
		}
		
		private function _OnMouseOver_btn(e:MouseEvent):void
		{

			var myGlow:GlowFilter = new GlowFilter(); 
			myGlow.inner=true; 
			myGlow.color = 0xffffff; 
			myGlow.blurX = 10; 
			myGlow.blurY = 10; 
			myGlow.alpha = 0.6;
			e.currentTarget.filters = [myGlow];
		}

		
		private function _OnMouseOut_btn(e:MouseEvent):void
		{
			e.currentTarget.filters = [];
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
		
		
		private function _ColocarEtiquetas():void
		{
			var etiqs:Number = _Categories.length;
			var positioned:Number = 0;
			var maxHeight:Number = (_Categories[0] as LinkUi).height * etiqs;
			(_Categories[0] as LinkUi).x = this.width - (_Categories[0] as LinkUi).width;
			var maxW:int ;
			if (etiqs == 1)
			{
				positioned = _Settings["height"];
				(_Categories[0] as LinkUi).y = (_Settings["height"] - (_Categories[0] as LinkUi).height) / 2;
				(_Categories[0] as LinkUi).x = $CatContainer.width - (_Categories[0] as LinkUi).width+5;
				maxW=(_Categories[0] as LinkUi).width;
			}else
			{
				(_Categories[0] as LinkUi).y = 0;
				if (maxHeight > _Settings["height"])
				{
					_Settings["height"] = maxHeight;
				}
				positioned = _Settings["height"] / etiqs;
				maxW =  (_Categories[0] as LinkUi).width + 60;
				for (var i:Number = 0; i < etiqs; i++)
				{
					(_Categories[i] as LinkUi).y = ( positioned * (i+0.4)) - ((_Categories[i] as LinkUi).height) / 2;
					(_Categories[i] as LinkUi).x = $CatContainer.width - (_Categories[i] as LinkUi).width-9;
					if ((_Categories[i] as LinkUi).width > maxW)
					{
						maxW = ( _Categories[i] as LinkUi).width;
					}
				}
			}
			maxW = maxW ;
		
			//			graphics.beginFill((_Settings["color"] as Number));
//			graphics.drawRect(0, 0, width, _Settings["height"]);
			if (_principal)
			{
				_BackButton.x =maxW-_BackButton.width+5;
			}
			$BG.graphics.clear();
			$BG.graphics.beginFill(_Settings["color"] as Number);
			trace("_________tellme the widht! [" + $CatContainer.width + "] and max? [" + maxW + "]");
			//graphics.lineStyle(4, Frwk.$Current.$ThemeManager.$GetColorOfTag("line_content_1"), 1);
			$BG.graphics.drawRoundRect(0, 0,maxW, _Settings["height"], 40);
		//	$CatContainer.x = 50;
			$BG.graphics.endFill();
		}
		
		private function _GetCategorie(p_str:String):CategoryDto
		{
		var cat:CategoryDto = null;
			for (var i:int = 0; i < _CategoriesData.length; i++)
			{
				if (p_str == (_CategoriesData[i] as CategoryDto).$Name)
				{
					cat	= (_CategoriesData[i] as CategoryDto);
				}
			}
		return cat;	
		}
		
		private function _OnClickReturn(p_event:MouseEvent):void
		{
			_Parent.$ShowCategorie();
			_BackButton.visible = false;
			$IsHidden = !$IsHidden;
		}
		
		private function _OnClickSelectCategorie(p_event:MouseEvent):void
		{
			if (_principal)
			{
				$IsHidden = !$IsHidden;
				if (!$IsHidden)
				{
					var link:LinkUi = ( p_event.currentTarget as LinkUi);
					var currentCat:CategoryDto = _GetCategorie(link.name);
					_Parent.$AddSubCategorie(currentCat.$Sons);
					_Parent.$HideCategorie();
					_BackButton.visible = true;
				}else
				{
					_Parent.$ShowCategorie();
					_BackButton.visible = false;
				}
			}
			else
			{
				//parent muestra linea de la movida selecionada
			}			
		}
		
	}

}