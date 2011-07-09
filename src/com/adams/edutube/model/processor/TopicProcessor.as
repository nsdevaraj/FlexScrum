/*

Copyright (c) 2011 Adams Studio India, All Rights Reserved 

@author   NS Devaraj
@contact  nsdevaraj@gmail.com
@project  EduTube

@internal 

*/
package com.adams.edutube.model.processor
{
	import com.adams.edutube.model.AbstractDAO;
	import com.adams.edutube.model.vo.Topic;
	
	import com.adams.swizdao.model.vo.IValueObject;
	import com.adams.swizdao.model.processor.AbstractProcessor;

	public class TopicProcessor extends AbstractProcessor
	{   
		public function TopicProcessor()
		{
			super();
		}
		//@TODO
		override public function processVO(vo:IValueObject):void
		{
			if(!vo.processed){
				var topicvo:Topic = vo as Topic;
				super.processVO(vo);
			}
		}
	}
}