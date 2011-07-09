/*

Copyright (c) 2011 Adams Studio India, All Rights Reserved 

@author   NS Devaraj
@contact  nsdevaraj@gmail.com
@project  EduTube

@internal 

*/
package com.adams.edutube.signal
{
	import com.adams.swizdao.views.mediators.IViewMediator;
	import com.adams.swizdao.model.vo.SignalVO;
	
	import mx.collections.ArrayCollection;
	import org.osflash.signals.Signal;
	import com.adams.edutube.model.vo.*;
	public class ControlSignal
	{
		// add Signal 
         public var loadVideoCodesSignal:Signal= new Signal(IViewMediator);
		public var changeStateSignal:Signal= new Signal(String);
		public var hideAlertSignal:Signal = new Signal( uint );
		public var progressStateSignal:Signal = new Signal( String );
		public var showAlertSignal:Signal = new Signal( IViewMediator, String, String, int,Object );
	}
}