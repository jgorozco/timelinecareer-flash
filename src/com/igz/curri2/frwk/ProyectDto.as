package com.igz.curri2.frwk 
{
	import igz.fleaxy.pattern.Dto;
	import igz.fleaxy.util.DateTimeFormat;
	import igz.fleaxy.util.DateTimeUtil;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ProyectDto extends Dto
	{

		public var Name:String = "";
		public var Company:String="";
		public var Category:String="";
		public var SubCategory:String="";
		public var InitDate:Date=new Date();
		public var EndDate:Date = new Date();
		public var Description:String="";
		public var Url:String = "";
		public var Profesional:Boolean=false;
		
		
		public function ProyectDto() 
		{
			
		}

		public function $LoadFromJson(p_object:Object):void
		{
			this.Name = p_object.Name;
			this.Category = p_object.Category;
			this.Company = p_object.Company;
			this.Url = p_object.Url;
			this.Description = p_object.Description;
			if (p_object.Profesional == "true")
			{
				Profesional = true;	
			}else
			{
				Profesional = false;
			}
			if (DateTimeUtil.$Validate(p_object.EndDate)){
				this.EndDate = DateTimeUtil.$ToDate(p_object.EndDate, DateTimeFormat.DEFAULT_DATE);
			}else
			{
				this.EndDate = new Date();
				}
			if (DateTimeUtil.$Validate(p_object.InitDate)) {		
				
				this.InitDate = DateTimeUtil.$ToDate((p_object.InitDate as String), DateTimeFormat.DEFAULT_DATE);
			}
			this.SubCategory = p_object.SubCategory;
		}		
		
		
	}

}