/**
	[src] C:\igz\proyectos\ig_intelygenz\IG11_09_AS3\FlashDevelop\Templates\ProjectTemplates\191 ActionScript 3 - Fleaxy Project\bin\js\fleaxy.js

	[0.022] 01.03.2010	- Por defecto se carga ./swf/get_flash_player.gif en vez desde una ruta absoluta
											- Por defecto el wmode es window para que funcione el mousewheel

**/

var Fleaxy = new function () {
	var _VERSION = 0.022;

	/**
	 * Fleaxy.$MouseRightClick.$Init(p_flashId, p_flashContainerId, f_as3RightClickFunction);
	*/
	this.$MouseRightClick = new function () {
		var _RIGHT_BUTTON = 2;
	
		var _FlashObjectID    = "";
		var _FlashContainerID = "";
		var _Cache 			  = _FlashObjectID;
		var _As3RightClickFunction = "";
	
		function _KillAllEvents (eventObject) {
			if(eventObject) {
				if ( eventObject.cancelBubble ) {
					eventObject.cancelBubble = true;
				}
		    	if (eventObject.stopPropagation) {
					eventObject.stopPropagation();
				}
		        if (eventObject.preventDefault) {
		        	eventObject.preventDefault();
		        }
		        if (eventObject.preventCapture) {
		        	eventObject.preventCapture();
		        }
		        if (eventObject.preventBubble) {
		        	eventObject.preventBubble();
		        }
		    }
		}
	
	    function _Call () {
	    	var swfObj = swfobject.getObjectById(_FlashObjectID);
	    	try {
	    		eval("swfObj."+_As3RightClickFunction);
	    	}
	    	catch (ex) {
	    		alert("[ERROR] _Call -> swfObj."+_As3RightClickFunction);
	    	}
	    }

	    function _Gecko_OnMouseDown(ev) {
			if (ev.button == _RIGHT_BUTTON) {
		    	_KillAllEvents(ev);
			    if ( ev.target.id == _FlashObjectID ) {
			    	_Call();
			    }
			}
		}
	
	    function _IE_OnMouseDown () {
	        if (event.button == _RIGHT_BUTTON) {
	            if ( window.event.srcElement.id == _FlashObjectID ) {
	               _Call();
	            }
				document.getElementById(_FlashContainerID).setCapture();
				if ( window.event.srcElement.id ) {
					_Cache = window.event.srcElement.id;
				}
	        }
	    }
	
	    this.$Init = function (p_flashId, p_flashContainerId, f_as3RightClickFunction) {
	    	_FlashObjectID 	  = p_flashId;
	    	_FlashContainerID = p_flashContainerId;
	    	_As3RightClickFunction = f_as3RightClickFunction;
	        if(window.addEventListener){
	             window.addEventListener("mousedown", _Gecko_OnMouseDown, true);
	        }
	        else {
						document.getElementById(_FlashContainerID).onmouseup = function() { document.getElementById(_FlashContainerID).releaseCapture(); }
						document.oncontextmenu = function(){ if(window.event.srcElement.id == _FlashObjectID) { return false; } else { _Cache = "nan"; }}
						document.getElementById(_FlashContainerID).onmousedown = _IE_OnMouseDown;
	        }
	    }
	}

	/**
	 * Fleaxy.$SwfObj.$Call(p_swdId, p_swfFunction);
	*/
	this.$SwfObj = new function() {

		var _Swfs = { $Id : [], $Container : [] };

		this.$Get = function (p_swdId) {
	    	return swfobject.getObjectById(p_swdId);
	    }

		this.$Call = function (p_swdId, p_swfFunction) {
	    	var swfObj = swfobject.getObjectById(p_swdId);
	    	if ( swfObj!=null ) {
	    		try {
	    			eval("swfObj."+p_swfFunction);
	    		}
	    		catch (ex) {
	    			alert("[ERROR] Fleaxy.$SwfObj.$Call -> Al intentar ejecutar "+p_swdId+"."+p_swfFunction);
	    		}
	    	}
	    	else {
	    		alert("No existe ningún element swf ["+p_swdId+"] en la página ["+document.location.href+"]");
	    	}
	    }
	
		function _Init (p_idSwf, p_parameters, p_attributes, p_flashvars) {
			var p;
			var params = { menu  : "false"
				 		 , scale : "noScale"
				 		 , wmode : "window"
				 		 , bgcolor : "#FFFFFF"
				 		 , allowScriptAccess : "sameDomain"
				 		 }
			for ( p in p_parameters ) {
				try {
					eval("params."+p+"=p_parameters."+p);
				}
				catch(p_ex){}
			}
			var attributes = { width  : "100%"
							 , height : "100%"
							 , id	  : p_idSwf
				 		 	}
			for ( p in p_attributes ) {
				try {
					eval("attributes."+p+"=p_attributes."+p);
				}
				catch(p_ex){}
			}
			var flashvars = { }
			for ( p in p_flashvars ) {
				try {
					eval("flashvars."+p+"=p_flashvars."+p);
				}
				catch(p_ex){}
			}
			swfobject.embedSWF( "./"+p_idSwf+".swf", _GetContainer(p_idSwf), attributes.width, attributes.height, "10.0.0", "swf/expressInstall.swf"
							  , flashvars
							  , params
							  , attributes
							  );
		}

		function _AddSwf(p_swfId, p_swfAltContainer) {
			_Swfs.$Id.push(p_swfId);
			_Swfs.$Container.push(p_swfAltContainer);
		}

		function _GetContainer(p_swfId) {
			return _Swfs.$Container[jQuery.inArray(p_swfId,_Swfs.$Id)];
		}

		this.$Draw =  function (p_swfId, p_swfAltContainer, p_parameters, p_attributes,p_flashvars) {
			_AddSwf(p_swfId, p_swfAltContainer);
			_Init(p_swfId, p_parameters, p_attributes,p_flashvars);
			var sHtml = "<div id='"+ _GetContainer(p_swfId) +"'>"
				 	  +	"<p></p>"
				 	  + 	"<p>"
				 	  +		"<a href='http://www.adobe.com/go/getflashplayer'>"
				 	  + 			"<img src='./swf/get_flash_player.gif' alt='Get Adobe Flash player' />"
				 	  +		"</a>"
				 	  +	"</p>"
				 	  +"</div>"
				 	  ;
			return sHtml;
		}
		
		this.$Print = function (p_swfId, p_swfAltContainer, p_parameters, p_attributes,p_flashvars) {
			document.write(this.$Draw(p_swfId, p_swfAltContainer, p_parameters, p_attributes,p_flashvars));
		}

	}
}
