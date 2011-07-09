/*

Copyright (c) 2011 Adams Studio India, All Rights Reserved 

@author   NS Devaraj
@contact  nsdevaraj@gmail.com
@project  EduTube

@internal 

*/
package com.adams.edutube.model.vo
{
	import com.adams.swizdao.model.vo.AbstractVO;
	import mx.collections.ArrayCollection;
	[Bindable]
	[RemoteClass(alias='com.adams.edutube.dao.entities.Visual')]
	public class Visual extends AbstractVO
	{
		private var _visualId:int; 
		private var _visualName:String;
		private var _visualUrl:String;
		private var _subTopic:String='';
		public function Visual()
		{
			super();
		}

		public function get subTopic():String
		{
			return _subTopic;
		}

		public function set subTopic(value:String):void
		{
			_subTopic = value;
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
			visualName = item.label+ ' '+subTopic;
			visualUrl = item.url;
		}
	}
}