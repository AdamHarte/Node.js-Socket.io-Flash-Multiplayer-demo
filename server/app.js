var app = require('http').createServer(handler)
  , io = require('socket.io').listen(app)
  , fs = require('fs')

app.listen(7878);

function handler (req, res) {
	console.log('DOING STUFF');
	fs.readFile(__dirname + '/index.html',
		function (err, data) {
			if (err) {
				res.writeHead(500);
				return res.end('Error loading index.html');
			}
			
			res.writeHead(200);
			res.end(data);
		}
	);
}

io.sockets.on('connection', function (socket) {
	console.log('~~ CONNECTED ~~');
	//socket.emit('news', { hello: 'world' });
	socket.on('message', function (msg) {
		console.log('Message: ' + msg.type + ',  Data: ' + msg.data);
		
		switch(msg.type) {
			case 'register':
				console.log('registering now');
				//socket.emit('news', { hello: 'world' });
				//socket.json.send({foo:'bar'});
				socket.json.send({type:'stuff',things:{foo:'bar',mine:'craft'}});
				break;
			default:
				
		}
		
	});
});