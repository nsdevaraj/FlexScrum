/*

Copyright (c) 2011 Adams Studio India, All Rights Reserved 

@author   NS Devaraj
@contact  nsdevaraj@gmail.com
@project  EduTube

@internal 

*/
package com.adams.edutube.signal
{
	import com.adams.edutube.model.vo.*;
	import com.adams.swizdao.model.vo.SignalVO;
	import com.adams.swizdao.views.mediators.IViewMediator;
	
	import mx.collections.ArrayCollection;
	
	import org.osflash.signals.Signal;
	public class ControlSignal
	{
		// add Signal 
        public var openMenuSignal:Signal= new Signal(IViewMediator,Array,Boolean);
        public var loadTVUserSignal:Signal= new Signal(IViewMediator,String);
		public var loadPlaylistSignal:Signal= new Signal(IViewMediator,String);
		public var loadVideoCodesSignal:Signal= new Signal(IViewMediator);
		public var changeStateSignal:Signal= new Signal(String);
		public var hideAlertSignal:Signal = new Signal( uint );
		public var progressStateSignal:Signal = new Signal( String );
		public var showAlertSignal:Signal = new Signal( IViewMediator, String, String, int,Object );
	}
}