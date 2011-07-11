/*

Copyright (c) 2011 Adams Studio India, All Rights Reserved 

@author   NS Devaraj
@contact  nsdevaraj@gmail.com
@project  EduTube

@internal 

*/
package com.adams.edutube.control
{
	import com.adams.edutube.model.AbstractDAO;
	import com.adams.edutube.model.vo.*;
	import com.adams.edutube.signal.ControlSignal;
	import com.adams.edutube.util.Utils;
	import com.adams.edutube.view.mediators.MainViewMediator;
	import com.adams.swizdao.model.vo.CurrentInstance;
	import com.adams.swizdao.model.vo.SignalVO;
	import com.adams.swizdao.response.SignalSequence;
	import com.adams.swizdao.util.Action;
	import com.adams.swizdao.views.mediators.IViewMediator;
	public class SignalsCommand
	{
		
		[Inject]
		public var controlSignal:ControlSignal;
		
		[Inject]
		public var mainViewMediator:MainViewMediator;
		
		[Inject]
		public var currentInstance:CurrentInstance; 
		
		[Inject("subjectDAO")]
		public var subjectDAO:AbstractDAO;
		
		[Inject("visualDAO")]
		public var visualDAO:AbstractDAO;
		
		[Inject]
		public var signalSequence:SignalSequence;
		
		private var alertView:IViewMediator;
		private var alertResponder:Object;
		// todo: add listener
         /**
          * Whenever an LoadPlaylistSignal is dispatched.
          * MediateSignal initates this loadplaylistAction to perform control Actions
          * The invoke functions to perform control functions
          */
         [ControlSignal(type='loadPlaylistSignal')]
         public function loadplaylistAction(obj:IViewMediator,code:String):void {
			 var signal:SignalVO = new SignalVO(obj,visualDAO,Action.HTTP_REQUEST);
			 signal.emailBody = Utils.GOOG_API+code;
			 signal.receivers = ['entry','feed'];
			 signalSequence.addSignal(signal);
         }

         /**
          * Whenever an LoadVideoCodesSignal is dispatched.
          * MediateSignal initates this loadvideocodesAction to perform control Actions
          * The invoke functions to perform control functions
          */
         [ControlSignal(type='loadVideoCodesSignal')]
         public function loadvideocodesAction(obj:IViewMediator):void {
			 var signal:SignalVO = new SignalVO(obj,subjectDAO,Action.HTTP_REQUEST);
			 signal.emailBody = currentInstance.config.serverLocation;
			 signal.receivers = ['Subject','Subjects'];
			 signalSequence.addSignal(signal);
         }

		
		/**
		 * Whenever an showAlertSignal is dispatched.
		 * MediateSignal initates this showAlertAction to perform control Actions
		 * The invoke functions to perform control functions
		 */
		[ControlSignal(type='showAlertSignal')]
		public function showAlertAction( obj:IViewMediator, text:String, title:String, type:int, responder:Object ):void {
			alertView = obj;
			alertResponder = responder;
			mainViewMediator.showAlert( text, title ,type);
		}
		
		/**
		 * Whenever an ProgressStateSignal is dispatched.
		 * MediateSignal initates this progressStateAction to perform control Actions
		 * The invoke functions to perform control functions
		 */
		[ControlSignal(type='progressStateSignal')]
		public function progressStateAction( state:String ):void {
			mainViewMediator.progressToggler = state;
		}
		
		/**
		 * Whenever an hideAlertSignal is dispatched.
		 * MediateSignal initates this hideAlertAction to perform control Actions
		 * The invoke functions to perform control functions
		 */
		[ControlSignal(type='hideAlertSignal')]
		public function hideAlertAction( state:uint ):void {
			if( state == Utils.ALERT_YES|| state == Utils.ALERT_OK ) {
				alertView.alertReceiveHandler( alertResponder );
			}
			alertView = null;
			alertResponder = null;
		}
		/**
		 * Whenever an ChangeStateSignal is dispatched.
		 * MediateSignal initates this changestateAction to perform control Actions
		 * The invoke functions to perform control functions
		 */
		[ControlSignal(type='changeStateSignal')]
		public function changestateAction(state:String):void {
			mainViewMediator.view.currentState = state;
		}
	}
}