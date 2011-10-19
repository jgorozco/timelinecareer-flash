package com.igz.curri2.ui 
{
	import com.greensock.TweenLite;
	import com.igz.curri2.Frwk;
	import com.igz.curri2.frwk.CategoryDto;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author 
	 */
	public class ComboCategoriesUI extends Sprite
	{
		public var Categorie:CategoriesUi;
		public var SubCategorie:CategoriesUi;	
		public var CurrentCategorie:CategoriesUi;
		public var Timeline:TimeLineUi;
		
		public function ComboCategoriesUI() 
		{
			var setting:Object = new Object();
			setting["parent"] = this;
			setting["principal"] = true;
			setting["color"] = Frwk.$Current.$ThemeManager.$GetColorOfTag("line_scuare_2");		
			Categorie = new CategoriesUi(setting);
			var setting2:Object = new Object();
			setting2["parent"] = this;
			setting2["principal"] = false;
			setting2["color"] = Frwk.$Current.$ThemeManager.$GetColorOfTag("line_scuare_1");		
			SubCategorie = new CategoriesUi(setting2);	
			Timeline = new TimeLineUi(Categorie);
			addChild(Timeline);		
			addChild(SubCategorie);
			addChild(Categorie);
			CurrentCategorie = Categorie;
			SubCategorie.x = SubCategorie.width;
			$SetAndFixCategory();
			
		}
		
		public function $SetAndFixCategory():void
		{
			Timeline.$SetCategorie(CurrentCategorie);
			var offsetx:Number = 0;
			var offsety:Number = 0;		
			if (CurrentCategorie.$IsPrincipal())
			{//quitamos el tamaño del boton
				offsetx =CurrentCategorie.$BtnMedidas.x;
				offsety = CurrentCategorie.$BtnMedidas.y;
			}
			var posinx:Number = CurrentCategorie.x + CurrentCategorie.width-offsetx;		
			var posiny:Number =CurrentCategorie.y + ((CurrentCategorie.height - Timeline.height-offsety) / 2);
			TweenLite.to(Timeline, 0.4, { x:posinx,y:posiny} );
			}
		
		public function $AddCategorie(p_categories:Array):void
		{
			Categorie.$ClearAllCategories();
			for each (var itm:CategoryDto in p_categories)
			{
				Categorie.$AddCategorie(itm);
			}
		}
		
		public function $AddSubCategorie(p_categories:Array):void
		{
			SubCategorie.$ClearAllCategories();
			for each (var itm:CategoryDto in p_categories)
			{
				SubCategorie.$AddCategorie(itm);
			}			
		}
		
		public function $ShowCategorie():void
		{		
			CurrentCategorie = Categorie;
			TweenLite.to(Categorie, 0.5, { x:-15 ,"onComplete":$SetAndFixCategory} )	;
			TweenLite.to(SubCategorie, 0.5, { x: -SubCategorie.width } )	;
			
		}

		public function $HideCategorie():void
		{
			TweenLite.to(Categorie, 0.5, { x:40-Categorie.width} );
			CurrentCategorie = SubCategorie;
			TweenLite.to(SubCategorie, 0.5, { x:40,"onComplete":$SetAndFixCategory} )	;
		}		
		
		
	}

}