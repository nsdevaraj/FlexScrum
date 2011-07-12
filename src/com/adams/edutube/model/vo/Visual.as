/*

Copyright (c) 2011 Adams Studio India, All Rights Reserved 

@author   NS Devaraj
@contact  nsdevaraj@gmail.com
@project  EduTube

@internal 

*/
package com.adams.edutube.model.vo
{
	import com.adams.edutube.util.Utils;
	import com.adams.swizdao.model.vo.AbstractVO;

	[Bindable]
	public class Visual extends AbstractVO
	{
		private var _visualId:int; 
		private var _visualName:String='';
		private var _visualUrl:String;
		private var _visualThumbUrl:String;
		public function Visual()
		{
			super();
		}
		
		public function get visualThumbUrl():String
		{
			return _visualThumbUrl;
		}
		
		public function set visualThumbUrl(value:String):void
		{
			_visualThumbUrl = value;
		} 
		
		public function get visualUrl():String
		{
			return _visualUrl;
		}
		
		public function set visualUrl(value:String):void
		{
			_visualUrl = value;
		}
		
		public function get visualName():String
		{
			return _visualName;
		}
		
		public function set visualName(value:String):void
		{
			_visualName = value;
		}
		
		public function get visualId():int
		{
			return _visualId;
		}
		
		public function set visualId(value:int):void
		{
			_visualId = value;
		}
		override public function fill(item:Object):void{ 
			if(!item.hasOwnProperty('location')){
				if(item.group.hasOwnProperty('description')) visualName = item.group.description;
				if(item.group.hasOwnProperty('player')) visualUrl = (item.group.player.url).split('?v=')[1].split('&feature')[0];
			}else{
				visualUrl = (item.location).split('?v=')[1]; 
				Utils.getHTTPResult(visualUrl,this);
			}
			if(visualUrl) visualThumbUrl = 'http://img.youtube.com/vi/'+visualUrl+'/2.jpg'
		}  
	}
}