/*

Copyright (c) 2011 Adams Studio India, All Rights Reserved 

@author   NS Devaraj
@contact  nsdevaraj@gmail.com
@project  EduTube

@internal 

*/
package com.adams.edutube.view.mediators
{ 
	import com.adams.edutube.model.AbstractDAO;
	import com.adams.edutube.model.vo.*;
	import com.adams.edutube.signal.ControlSignal;
	import com.adams.edutube.util.Utils;
	import com.adams.edutube.view.ListSkinView;
	import com.adams.edutube.view.renderers.ThumbnailRenderer;
	import com.adams.swizdao.model.vo.*;
	import com.adams.swizdao.util.Action;
	import com.adams.swizdao.util.StringUtils;
	import com.adams.swizdao.views.mediators.AbstractViewMediator;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.media.StageWebView;
	
	import mx.collections.ArrayCollection;
	import mx.core.ClassFactory;
	import mx.core.FlexGlobals;
	import mx.events.ResizeEvent;
	
	import spark.components.HGroup;
	import spark.events.IndexChangeEvent;
	
	public class ListViewMediator extends AbstractViewMediator
	{ 		 
		
		[Inject]
		public var controlSignal:ControlSignal;
		
		[Inject("subjectDAO")]
		public var subjectDAO:AbstractDAO; 
		private var currentSub:Subject;
		private var currentTop:Topic;
		private var webViewFirstLoad:Boolean = true;
		private var webView:StageWebView = new StageWebView();
		private var _homeState:String;
		public function get homeState():String
		{
			return _homeState;
		}
		
		public function set homeState(value:String):void
		{
			_homeState = value;
			if(value==Utils.LIST_INDEX) addEventListener(Event.ADDED_TO_STAGE,addedtoStage);
		}
		
		protected function addedtoStage(ev:Event):void{
			init();
		}
		
		/**
		 * Constructor.
		 */
		public function ListViewMediator( viewType:Class=null )
		{
			super( ListSkinView ); 
		}
		
		/**
		 * Since the AbstractViewMediator sets the view via Autowiring in Swiz,
		 * we need to create a local getter to access the underlying, expected view
		 * class type.
		 */
		public function get view():ListSkinView 	{
			return _view as ListSkinView;
		}
		
		[MediateView( "ListSkinView" )]
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
			viewState = Utils.LIST_INDEX;
			applicationResizeHandler(); 
			view.list.addEventListener(IndexChangeEvent.CHANGE, setLevel,false,0,true);
			view.topicBtn.clicked.add(setBtnLevel);
			view.subjectBtn.clicked.add(setBtnLevel);
			view.videoBtn.clicked.add(setBtnLevel);
			controlSignal.loadVideoCodesSignal.dispatch(this);
		} 
		
		protected function setBtnLevel(ev:MouseEvent):void {
			if(ev.currentTarget == view.subjectBtn){
				setHeaderData(1);
			}else if(ev.currentTarget == view.topicBtn){
				setHeaderData(2);
			}else if(ev.currentTarget == view.videoBtn){
				setHeaderData(3);
			}
			setLevel(ev);
		}
		
		protected function setHeaderData(level:int):void {
			switch(level)
			{
				case 1:
				{
					view.header.removeAllElements();
					view.header.addElement(view.logo);
					view.list.itemRenderer = new ClassFactory(ThumbnailRenderer);
					view.list.labelField = 'subjectName';
					break;
				}
				case 2:
				{
					view.header.removeAllElements();
					view.header.addElement(view.subjectBtn);
					view.list.itemRenderer = new ClassFactory(ThumbnailRenderer);
					view.list.labelField = 'topicName';
					break;
				}
				case 3:
				{
					if(view.videoBtn.parent is HGroup)view.header.removeElement(view.videoBtn);
					view.header.addElement(view.topicBtn);
					view.list.itemRenderer = new ClassFactory(ThumbnailRenderer);
					view.list.labelField = 'visualName';
					break;
				}
				case 4:
				{
					view.header.addElement(view.videoBtn);
					break;
				}	 
			}
		}
		
		protected function setLevel(ev:Event):void {
			view.list.visible =true;
			var obj:Object;
			webView.stage = null;
			webView.loadURL(Utils.GOOG_M);
			if(ev is IndexChangeEvent){
				obj = ev.currentTarget.selectedItem;
			}else if(ev is MouseEvent){
				if(ev.currentTarget == view.subjectBtn){
					view.list.dataProvider = subjectDAO.collection.items;
				}else if(ev.currentTarget == view.topicBtn){
					obj = currentSub;
				}
			}
			if(obj is Subject){
				currentSub = obj as Subject;
				view.list.dataProvider =currentSub.topics;
				view.subjectBtn.label = currentSub.subjectName;
				setHeaderData(2);
			}else if(obj is Topic){
				currentTop = obj as Topic;
				view.topicBtn.label = currentTop.topicName;
				if(!currentTop.visuals){
					if(!currentTop.ytv){
						controlSignal.loadPlaylistSignal.dispatch(this,currentTop.playCode);
					}else{
						controlSignal.loadTVUserSignal.dispatch(this,currentTop.playCode);
					}
					controlSignal.progressStateSignal.dispatch(Utils.PROGRESS_ON);
				}else{
					view.list.dataProvider = currentTop.visuals;
					setHeaderData(3);
				}
			}else if(obj is Visual){
				webViewFirstLoad =true;
				webView.stage = this.stage;
				setStageWeb();
				view.videoBtn.label = Visual(obj).visualName;
				webView.loadURL(Utils.YOU_TUBE_M+ Visual(obj).visualUrl);
				setHeaderData(4);
			}
		} 
		
		override protected function serviceResultHandler( obj:Object,signal:SignalVO ):void {  
			if(signal.action == Action.HTTP_REQUEST && signal.daoName == Utils.SUBJECTDAO) {
				view.list.dataProvider = subjectDAO.collection.items;
				setHeaderData(1);
			}
			if(signal.action == Action.HTTP_REQUEST && signal.daoName == Utils.VISUALDAO) {
				for each(var visual:Visual in signal.currentHTTPCollection){
					if(currentTop.ted){
						visual.visualName = visual.visualName.substr(18,visual.visualName.length);
					}else if(currentTop.ytv){ 
						visual.visualName = currentTop.playCode;
					}
					visual.visualName = StringUtils.removeExtraWhitespace( visual.visualName);
				}
				currentTop.visuals = signal.currentHTTPCollection as ArrayCollection
				if(currentTop.visuals.length>0 )currentTop.visualThumbUrl = currentTop.visuals.getItemAt(0).visualThumbUrl
				view.list.dataProvider = currentTop.visuals;
				setHeaderData(3);
				controlSignal.progressStateSignal.dispatch(Utils.PROGRESS_OFF);
			}
		}
		/**
		 * Create listeners for all of the view's children that dispatch events
		 * that we want to handle in this mediator.
		 */
		override protected function setViewListeners():void {
			FlexGlobals.topLevelApplication.addEventListener(ResizeEvent.RESIZE,applicationResizeHandler, false, 0, true);
			super.setViewListeners(); 
		}
		
		protected function applicationResizeHandler(event:ResizeEvent=null):void{
			view.currentState =FlexGlobals.topLevelApplication.aspectRatio;
			if(webView.stage != null){
				setStageWeb()
			}
		} 
		
		protected function setStageWeb(): void { 
			view.list.visible =false;
			if(webViewFirstLoad){
				webView.viewPort = new Rectangle( 0, 50, stage.stageWidth,stage.stageHeight-50);
				webViewFirstLoad = false;
			}else{
				webView.viewPort = new Rectangle( 0, 50, stage.stageHeight, stage.stageWidth-50);
			}
		} 
		/**
		 * Remove any listeners we've created.
		 */
		override protected function cleanup( event:Event ):void {
			view.list.addEventListener(IndexChangeEvent.CHANGE, setLevel);
			FlexGlobals.topLevelApplication.removeEventListener(ResizeEvent.RESIZE,applicationResizeHandler);
			super.cleanup( event ); 		
		} 
	}
}