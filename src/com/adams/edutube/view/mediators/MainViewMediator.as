/*

Copyright (c) 2011 Adams Studio India, All Rights Reserved 

@author   NS Devaraj
@contact  nsdevaraj@gmail.com
@project  EduTube

@internal 

*/
package com.adams.edutube.view.mediators
{ 
	import com.adams.edutube.model.vo.*;
	import com.adams.edutube.signal.ControlSignal;
	import com.adams.edutube.util.Utils;
	import com.adams.edutube.view.MainSkinView;
	import com.adams.swizdao.model.vo.*;
	import com.adams.swizdao.views.mediators.AbstractViewMediator;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	import mx.core.IVisualElement;
	
	
	public class MainViewMediator extends AbstractViewMediator
	{ 		 
		
		[Inject]
		public var currentInstance:CurrentInstance; 
		
		[Inject]
		public var controlSignal:ControlSignal;
		
		private var _menuContent:Array
		
		
		public function get menuContent():Array
		{
			return _menuContent;
		}
		
		public function set menuContent(value:Array):void
		{
			view.menu.removeAllElements();
			for each(var obj:IVisualElement in value){
				view.menu.addElement(obj);
			}
			_menuContent = value;
		}
		
		private var _progressToggler:String;
		public function get progressToggler():String {
			return _progressToggler;
		}
		public function set progressToggler( value:String ):void {
			_progressToggler = value;
			if( value == Utils.PROGRESS_ON ) {
				view.progress.visible = true;
			} 
			else if( value == Utils.PROGRESS_OFF ) {
				view.progress.visible = false;
			} 
		}
		
		private var _homeState:String;
		public function get homeState():String
		{
			return _homeState;
		}
		
		public function set homeState(value:String):void
		{
			_homeState = value;
			if(value==Utils.MAIN_INDEX) addEventListener(Event.ADDED_TO_STAGE,addedtoStage);
		}
		
		protected function addedtoStage(ev:Event):void{
			init();
		}
		
		/**
		 * Constructor.
		 */
		public function MainViewMediator( viewType:Class=null )
		{
			super( MainSkinView ); 
		}
		
		/**
		 * Since the AbstractViewMediator sets the view via Autowiring in Swiz,
		 * we need to create a local getter to access the underlying, expected view
		 * class type.
		 */
		public function get view():MainSkinView 	{
			return _view as MainSkinView;
		}
		
		[MediateView( "MainSkinView" )]
		override public function setView( value:Object ):void { 
			super.setView(value);	
		}  
		/**
		 * The <code>init()</code> method is fired off automatically by the 
		 * AbstractViewMediator when the creation complete event fires for the
		 * corresponding ViewMediator's view. This allows us to listen for events
		 * and set data bindings on the view with the confidence that our view
		 * and all of it's child views have been created and live on the stage.
		 */
		override protected function init():void {
			super.init();  
			viewState = Utils.MAIN_INDEX;
			systemManager.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown,false,0,true);
			view.list.addEventListener(MouseEvent.MOUSE_DOWN, closeMenu,false,0,true);
		}
		
		private function closeMenu(event:MouseEvent):void
		{
			view.menu.visible=false;
		}
		
		private function onKeyDown(event:KeyboardEvent):void
		{
			if(event.keyCode == Keyboard.BACK)
			{
				event.preventDefault();
			}
		} 
		
		public function showAlert( text:String, title:String, type:int = 0 ):void {
			view.alert.visible = true;
			view.alert.alertSignal.add(confirmationAlert);
			view.alert.showAlert(title,text,type);
		}
		
		private function confirmationAlert( alertDetail:int ):void {
			view.alert.visible = false;
			controlSignal.hideAlertSignal.dispatch( alertDetail );
		}
		 
		/**
		 * Remove any listeners we've created.
		 */
		override protected function cleanup( event:Event ):void {
			systemManager.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			view.removeEventListener(MouseEvent.MOUSE_DOWN, closeMenu);
			super.cleanup( event ); 		
		} 
	}
}