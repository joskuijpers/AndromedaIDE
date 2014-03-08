
console.log(NativeModule._cache);

var testModule = require("./test_module.js");

testModule.doSomethingFancy("With My Argument");
//console.log(__filename);

//var s = new __Socket("www.google.com",80);
//console.log(String(s));
//console.log(s.connected);

//s.close();

//Network.listen(100);
//console.log(Network.localName);
//console.log(Network.localAddress);

//console.log(Network.bonjour.test());


//var bonj = new __Bonjour("My Game","_game._tcp","local");
//bonj.publish("My Game","_tcp",12345,"local.");
// bonj.discover(


// File System and File
//http://nodejs.org/api/fs.html
// fs.readFile(filename, [Options{flag,encoding}], cb(err, data))

// Modules
/*
var link = require("./link.js");
link.create("foo");

// in link.js:
exports.create = function(foo) { return "bar"; }

// or:
var JSON = require("./json.js");
var js = new JSON("{x:1}");

module.exports = function(string) { // the constructor
}
*/

// Folders as modules

// Create a folder, add a package.json with:
//{ "name":"Link","main":"./lib/link.js","version":"1.6"}
// Now require('./link') (if ./link is the lib folder) will load ./link/lib/link.js
// If no package.json found, load main.js

// require(x) always returns same object: no multi-eval! Allows transitive dependencies to be loaded
// because partially done can be returned

/*
Module {
	var id;
	var filename;
	var Promise<Boolean> loaded;
	var exports;
	// parent, children
	function require(id);
}

require(x)
require.resolve(x)
require.main set to the module when executing single module


// Net

createServer([options], [listener])
connect(options, [listener])
connect(port, [host], [listener])

net.Server {
	listen(port, cb)
	close(cb)
	unref()
	ref()
	maxConnections
	connections
	getConnections(cb)

	Events: listening, connection, close, error
}

net.Socket {
	new Socket([options])
	connect(port, [host], [listener])
	bufferSize
	write(data, [encoding], [cb])

	destroy()
	end([data],[encoding])
	pause()
	resume()

	setTimeout()
	setNoDelay()
	setKeepAlive()

	address()

	unref()
	ref()

	remoteAddress
	remotePort
	localAddress
	localPort
	bytesRead
	bytesWritten

	Events: connect, data, end, timeout, drain, error, close
}

net.Bonjour {
	new Bonjour(type, domain)
	var type
	var domain

	var state; // 'publishing', 'published', 'discovering'
	function isPublished()

	function publish([name]="",port,[cb]=null)
	function discover(cb) // Peer objects
	function resolve(cb) // to host+port
}

net.Bonjour.Peer {
	resolve()
	function getSocket()
}

// net.Stream {}

net.Datagram {
	connect()
	bind()
	close()
}

os.hostname()
os.networkInterfaces()
*/

//GLOBAL
// In modules, the global scope is module-scope. Use some trick?
// console object // global
// function require() // global
// function require.resolve() // global
// var require.cache (KVS) // global
// __filename // filename of current module, local to each module
// __dirname // dirname of current module, local to each module
// module // , local to each module
// t = setTimeout(cb,ms)
// clearTimeout(t)
// t = setInterval(cb, ms)
// clearInterval(t)

// module.exports.Console = Console;
// module.exports.createServer = function() {}
// module.exports.<classname> = <classname>