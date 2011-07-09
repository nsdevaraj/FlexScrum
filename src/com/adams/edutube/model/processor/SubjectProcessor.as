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
	import com.adams.edutube.model.vo.Subject;
	
	import com.adams.swizdao.model.vo.IValueObject;
	import com.adams.swizdao.model.processor.AbstractProcessor;

	public class SubjectProcessor extends AbstractProcessor
	{   
		public function SubjectProcessor()
		{
			super();
		}
		//@TODO
		override public function processVO(vo:IValueObject):void
		{
			if(!vo.processed){
				var subjectvo:Subject = vo as Subject;
				super.processVO(vo);
			}
		}
	}
}