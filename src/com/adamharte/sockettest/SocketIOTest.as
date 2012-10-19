package com.adamharte.sockettest 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import io.socket.flash.ISocketIOTransport;
	import io.socket.flash.ISocketIOTransportFactory;
	import io.socket.flash.SocketIOErrorEvent;
	import io.socket.flash.SocketIOEvent;
	import io.socket.flash.SocketIOTransportFactory;
	import io.socket.flash.WebsocketTransport;
	import io.socket.flash.XhrPollingTransport;
	
	/**
	 * ...
	 * @author Adam Harte (adam@adamharte.com)
	 */
	public class SocketIOTest extends Sprite 
	{
		private var socketIOTransportFactory:ISocketIOTransportFactory = new SocketIOTransportFactory();
		private var ioSocket:ISocketIOTransport;
		
		
		public function SocketIOTest() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			connectToServer();
		}
		
		
		
		private function connectToServer():void 
		{
			trace('CONNECTING TO SERVER')
			//ioSocket = socketIOTransportFactory.createSocketIOTransport(XhrPollingTransport.TRANSPORT_TYPE, "localhost:7878/socket.io", this);
			ioSocket = socketIOTransportFactory.createSocketIOTransport(WebsocketTransport.TRANSPORT_TYPE, "localhost:7878/socket.io", this);
			ioSocket.addEventListener(SocketIOEvent.CONNECT, ioSocket_connectHandler);
			ioSocket.addEventListener(SocketIOEvent.DISCONNECT, ioSocket_disconnectHandler);
			ioSocket.addEventListener(SocketIOEvent.MESSAGE, ioSocket_messageHandler);
			ioSocket.addEventListener(SocketIOErrorEvent.CONNECTION_FAULT, ioSocket_connectionFaultHandler);
			ioSocket.addEventListener(SocketIOErrorEvent.SECURITY_FAULT, ioSocket_securityFaultHandler);
			ioSocket.connect();
		}
		
		
		
		private function ioSocket_connectHandler(e:SocketIOEvent):void 
		{
			ioSocket.removeEventListener(SocketIOEvent.CONNECT, ioSocket_connectHandler);
			
			trace('CONNECTED:', e.target, ', ', e.message);
			//ioSocket.send({type: "message", data: "Heeeeelllloooooo!!!"});
			//ioSocket.send({type: "msg", data: "Wooowwww"});
			ioSocket.send({type: 'register', data: "Wooowwww"});
		}
		
		private function ioSocket_disconnectHandler(e:SocketIOEvent):void 
		{
			trace("DISCONNECTED:", e.target);
		}
		
		private function ioSocket_messageHandler(e:SocketIOEvent):void 
		{
			trace('==========');
			trace('MESSAGE: ', e.message.type);
		}
		
		private function ioSocket_connectionFaultHandler(e:SocketIOErrorEvent):void 
		{
			trace('FAULT:', e.type, ":", e.text);
		}
		
		private function ioSocket_securityFaultHandler(e:SocketIOErrorEvent):void 
		{
			trace('SECURITY FAULT:', e.type, ":", e.text);
		}
		
	}

}