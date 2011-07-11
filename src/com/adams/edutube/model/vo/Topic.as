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
	public class Topic extends AbstractVO
	{
		private var _topicId:int;
		private var _topicName:String;
		private var _playCode:String;
		private var _visualThumbUrl:String;
		private var _visuals:ArrayCollection;
		public function Topic()
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

		public function get playCode():String
		{
			return _playCode;
		}

		public function set playCode(value:String):void
		{
			_playCode = value;
		}

		public function get visuals():ArrayCollection
		{
			return _visuals;
		}

		public function set visuals(value:ArrayCollection):void
		{
			_visuals = value;
		}

		public function get topicName():String
		{
			return _topicName;
		}

		public function set topicName(value:String):void
		{
			_topicName = value;
		}

		public function get topicId():int
		{
			return _topicId;
		}

		public function set topicId(value:int):void
		{
			_topicId = value;
		}
		override public function fill(item:Object):void{ 
			topicName = item.name;
			playCode = item.code;
		}
	}
}