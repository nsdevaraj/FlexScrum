package com.adams.edutube.service
{
	import com.adams.edutube.model.vo.Visual;
	import com.adams.swizdao.util.GetVOUtil;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.http.HTTPService;
	
	public class VisualHTTPDelegate implements IResponder
	{
		public function doSend(service:HTTPService,visual:Visual):void{
			var token:AsyncToken = service.send();
			token.visual = visual;
			token.addResponder(this);
		}
		
		public function result(ev:Object):void{  
			var obj:Object = GetVOUtil.xmlToObject( ev.result as XML);
			ev.token.visual.visualName = obj.entry.title.value
		}
		public function fault(obj:Object):void{}
	}
}
