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
	
	import mx.collections.ArrayCollection;
	import mx.collections.IViewCursor;
	import mx.collections.Sort;
	import mx.collections.SortField;
	public class Utils
	{  	  
		// todo: add view index
		public static const MAIN_INDEX:String='Main';
		// todo: add key
       public static const VISUALKEY  :String='visualId';
       public static const TOPICKEY  :String='topicId';
       public static const SUBJECTKEY  :String='subjectId';
		 
		// todo: add dao
       public static const WEB_INDEX:String='Web';
	   public static const GOOG_M:String='http://m.google.com'
	   public static const YOU_TUBE_M:String='http://m.youtube.com/watch?v='
	   public static var fileSplitter:String =  '//';
	   public static const XMLPATH:String="assets"+fileSplitter+"xml"+fileSplitter+"video.xml";
       public static const VISUALDAO  :String='visualDAO'; 
       public static const TOPICDAO  :String='topicDAO'; 
       public static const SUBJECTDAO  :String='subjectDAO'; 
       public static const LIST_INDEX:String='List';
		
		public static const ALERT_YES:int = 0;
		public static const ALERT_NO:int = 1;
		public static const ALERT_OK:int = 2;
		public static const PROGRESS_INDEX:String='Progress';
		public static const PROGRESS_ON:String = "progressOn"; 
		public static const PROGRESS_OFF:String = "progressOff"; 	 
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