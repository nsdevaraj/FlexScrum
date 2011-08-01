package com.adams.edutube.service
{
	import com.adams.edutube.model.vo.Subject;
	import com.adams.swizdao.util.GetVOUtil;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.http.HTTPService;
	
	public class SubjectHTTPDelegate implements IResponder
	{
		public function doSend(service:HTTPService,subject:Subject):void{
			var token:AsyncToken = service.send();
			token.subject = subject;
			token.addResponder(this);
		}
		
		public function result(ev:Object):void{  
			var obj:Object = GetVOUtil.xmlToObject( ev.result as XML);
			var result:Object = GetVOUtil.parseHTTPResult(obj, ['entry','feed']);
			ev.token.subject.topicObjs = result;
		}
		public function fault(obj:Object):void{}
	}
}
