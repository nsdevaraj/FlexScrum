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
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class Subject extends AbstractVO
	{
		private var _subjectId:int; 
		private var _subjectName:String;
		private var _topicObjs:Object
		public var user:String;
		private var _topics:ArrayCollection = new ArrayCollection();
		public function Subject()
		{
			super();
		}
		
		public function get topicObjs():Object
		{
			return _topicObjs;
		}

		public function set topicObjs(value:Object):void
		{
			_topicObjs = value;
			fillTopics(value);
		}

		public function get topics():ArrayCollection
		{
			return _topics;
		}
		
		public function set topics(value:ArrayCollection):void
		{
			_topics = value;
		}
		
		public function get subjectName():String
		{
			return _subjectName;
		}
		
		public function set subjectName(value:String):void
		{
			_subjectName = value;
		}
		
		public function get subjectId():int
		{
			return _subjectId;
		}
		
		public function set subjectId(value:int):void
		{
			_subjectId = value;
		}
		
		override public function fill(item:Object):void{ 
			subjectName = item.name;
			if(!item.hasOwnProperty('user')){
				fillTopics(item.Topic);
			}else{
				user= item.user;
				Utils.getTopicHTTPResult(user,this);
			}
		}
		
		private function fillTopics(topObj:Object):void{
			for each(var obj:Object in topObj as ArrayCollection){
				var topic:Topic = new Topic();
				topic.fill(obj);
				topics.addItem(topic);
			}
		}
	}
}