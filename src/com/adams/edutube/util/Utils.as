/*

Copyright (c) 2011 Adams Studio India, All Rights Reserved 

@author   NS Devaraj
@contact  nsdevaraj@gmail.com
@project  EduTube

@internal 

*/
package com.adams.edutube.util
{  
	import com.adams.edutube.model.AbstractDAO;
	import com.adams.edutube.model.vo.Visual;
	import com.adams.edutube.service.HTTPDelegate;
	import com.adams.swizdao.util.GetVOUtil;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IViewCursor;
	import mx.collections.Sort;
	import mx.collections.SortField;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class Utils
	{  	  
		// todo: add view index
		public static const MAIN_INDEX:String='Main';
		// todo: add key
		public static const VISUALKEY  :String='visualUrl';
		public static const TOPICKEY  :String='playCode';
		public static const SUBJECTKEY  :String='subjectName';
		
		// todo: add dao
		public static const WEB_INDEX:String='Web';
		public static const GOOG_M:String='http://m.google.com'
		public static const GOOG_API:String='https://gdata.youtube.com/feeds/api/playlists/'
		public static const YTV_API:String='http://www.chooseandwatch.com/YTTV/ytkey.php?id='
		public static const YOU_TUBE_M:String='http://m.youtube.com/watch?v='
		public static var fileSplitter:String =  '//';
		public static const XMLPATH:String="assets"+fileSplitter+"xml"+fileSplitter+"cartoon.xml";
		public static const VISUALDAO  :String='visualDAO'; 
		public static const TOPICDAO  :String='topicDAO'; 
		public static const SUBJECTDAO  :String='subjectDAO'; 
		public static const LIST_INDEX:String='List';
		
		public static const ALERT_YES:int = 0;
		public static const ALERT_NO:int = 1;
		public static const ALERT_OK:int = 2;
		
		public static const PORTRAIT:String='portrait';
		public static const LANDSCAPE:String='landscape';
		public static const PROGRESS_INDEX:String='Progress';
		public static const PROGRESS_ON:String = "progressOn"; 
		public static const PROGRESS_OFF:String = "progressOff"; 
		public static const MENU_ON:String = "menuOn"; 
		public static const MENU_OFF:String = "menuOff"; 	
		public static var http:HTTPService= new HTTPService()
		public static var httpDelegate:HTTPDelegate= new HTTPDelegate()
		public static function addArrcStrictItem( item:Object, arrc:ArrayCollection, sortString:String, modified:Boolean =false ):void{
			var returnValue:int = -1;
			var sort:Sort = new Sort(); 
			sort.fields = [ new SortField( sortString ) ];
			if(arrc.sort==null) arrc.sort = sort;
			arrc.refresh(); 
			var cursor:IViewCursor = arrc.createCursor();
			var found:Boolean = cursor.findAny( item );	
			if( found ) {
				returnValue = arrc.getItemIndex( cursor.current );
			} 	
			if( returnValue == -1 ) {
				arrc.addItem(item);
			}else{
				if(modified){
					arrc.removeItemAt(returnValue);
					arrc.addItemAt(item, returnValue);
				}
			}
		}
		
		public static function getHTTPResult(visualUrl:String,visual:Visual):void{
			http.resultFormat ='e4x';
			http.url =  "http://gdata.youtube.com/feeds/api/videos/"+ visualUrl;
			httpDelegate.doSend(http,visual);
		} 
		
		public static function removeArrcItem(item:Object,arrc:ArrayCollection, sortString:String):void{
			var returnValue:int = -1;
			var sort:Sort = new Sort(); 
			sort.fields = [ new SortField( sortString ) ];
			if(arrc.sort==null) arrc.sort = sort;
			arrc.refresh(); 
			var cursor:IViewCursor = arrc.createCursor();
			var found:Boolean = cursor.findAny( item );	
			if( found ) {
				returnValue = arrc.getItemIndex( cursor.current );
			} 	
			if( returnValue != -1 ) {
				arrc.removeItemAt(returnValue);
			}
		} 
	}
}