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
	[RemoteClass(alias='com.adams.edutube.dao.entities.Topic')]
	public class Topic extends AbstractVO
	{
		private var _topicId:int;
		private var _topicName:String;
		private var _visuals:ArrayCollection = new ArrayCollection();
		public function Topic()
		{
			super();
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
			for each(var vobj:Object in item.video as ArrayCollection){
				var videoVisual:Visual = new Visual();
				videoVisual.fill(vobj);
				visuals.addItem(videoVisual);
			}
			for each(var stobj:Object in item.SubTopic as ArrayCollection){
				var subTopic:String = stobj.name;
				for each(var obj:Object in stobj.video as ArrayCollection){
					var videoSubVisual:Visual = new Visual();
					videoSubVisual.subTopic = subTopic;
					videoSubVisual.fill(obj);
					visuals.addItem(videoSubVisual);
				}
			}
		}
	}
}