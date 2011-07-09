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
	import com.adams.edutube.model.vo.Visual;
	
	import com.adams.swizdao.model.vo.IValueObject;
	import com.adams.swizdao.model.processor.AbstractProcessor;

	public class VisualProcessor extends AbstractProcessor
	{   
		public function VisualProcessor()
		{
			super();
		}
		//@TODO
		override public function processVO(vo:IValueObject):void
		{
			if(!vo.processed){
				var visualvo:Visual = vo as Visual;
				super.processVO(vo);
			}
		}
	}
}