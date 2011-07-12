/*

Copyright (c) 2011 Adams Studio India, All Rights Reserved 

@author   NS Devaraj
@contact  nsdevaraj@gmail.com
@project  EduTube

@internal 

*/
package com.adams.edutube
{
	
	import com.adams.edutube.model.vo.MapConfigVO;
	import com.adams.edutube.util.Utils;
	import com.adams.swizdao.controller.ServiceController;
	import com.adams.swizdao.model.vo.CurrentInstance;
	
	import flash.desktop.NativeApplication;
	import flash.events.StatusEvent;
	
	import mx.collections.ArrayCollection;
	import mx.core.FlexGlobals;
	import mx.utils.URLUtil;
	
	
	public class BootStrapCommand
	{
		[Inject]
		public var currentInstance:CurrentInstance; 
		 
		[Inject]
		public var service:ServiceController; 
		/** <p>
		 * Boot straps the application from context, 
		 * with postconstruct metadata the function is called after Injection is performed.
		 * </p>
 		 */
		[PostConstruct]
		public function execute():void
		{
			var appName:String = NativeApplication.nativeApplication.applicationID;
			if(appName.indexOf('EduTube')!=-1){
				currentInstance.config.serverLocation =Utils.XMLPATH+"playlist.xml";
			}else{
				currentInstance.config.serverLocation =Utils.XMLPATH+"cartoon.xml";	
			}
			currentInstance.mapConfig =new MapConfigVO();
		} 
	}
}