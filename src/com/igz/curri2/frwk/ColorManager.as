package com.igz.curri2.frwk 
{
	import igz.fleaxy.util.ObjectUtil;
	/**
	 * ...
	 * @author 
	 */
	public class ColorManager
	{
		private var _Style:Object;
		private var _ArrayObj:Array;
		public function ColorManager(p_object:Object) 
		{
			_Style = p_object;
			_ArrayObj = null;
			try {
				_ArrayObj = (_Style as Array);
				if (_ArrayObj.length>2)
				{
					_ArrayObj= (_Style as Array);
				}
			}catch (e:Error)
			{
				trace("NO ES ARRAY");
			}
		}
		
		public function $GetColorOfTag(p_element:String):Number
		{
			var color:Number = 0x00ff00;
			var s:String = "00ff00";
			if (_ArrayObj != null)
			{
				trace ("recorrooo1::"+_ArrayObj.length);
				
				for (var i:int = 0; i < _ArrayObj.length;i++ )
				{
					var elem:Object = _ArrayObj[i];
					ObjectUtil.$DebugObject(elem);
//					trace("name["+elem.Name+"] and ["+elem.Color+"]");
					if (elem["Name"] ==p_element)
					{
						s = elem["Color"];
						break;
					}
				}
				
			}else {
				
				s = (_Style[p_element] as String);
			}
		//	trace("----getting color [" + p_element + "]=[" + s + "] of ["+_Style+"]");
			if (s != null)
			{
				color = Number("0x"+s);
			}
			return color;
			}
		
	}

}