
function Module(id, parent) {
	this.filename = null;
	this.id = id;
	this.parent = parent;
	this.exports = {};

	if(parent && parent.children) {
		parent.children.push(this);
	}

	this.loaded = false;
	this.children = []
}

Module._cache = {};
Module._pathCache = {};

function x(id) {

	var module = new Module(id);

	var filename = id;
	module.filename = filename;

	module.load();
}

Module._load = function(request, parent, isMain) {

	var filename = Module._resolveFilename(request);

	var module;

	// Try to load a cached module
	module = Module._cache[filename];
	if(module)
		return module.exports;

	// Create a new module
	module = new Module(filename, parent);

	if(isMain) {
		//process.mainModule = module;
		//module.id = ".";
	}

	// Cache the module
	Module._cache[filename] = module;

	var hadException = true;
	try {
		module.load(filename);
		hadException = false;
	} finally {
		// Do not cache invalid modules
		if(hadException)
			delete Module._cache[filename];
	}
}

Module._resolveFilename = function(request) {
	return "";
}

/**
 * Loads the actual module
 */
Module.prototype.load = function(filename) {
//	assert(!this.loaded);
	var code;

	try {
		code = "console.log('The code runs!'); exports.name = function(name) {console.log('Hello '+name);}"; // read file filename
	} catch(e) {
	}

	if(code) {
		var evalString;

		// requireFileStack push filename

		evalString = "(function(__filename){\n";//exports,require,module,
		evalString = evalString+code+"\n})('"+filename+"')";

		// TODO; use evaluateScript:
		eval(evalString);

		// requireFileStack pop
		this.loaded = true;
	}
}

Module.prototype.require = function(path) {
	//assert(path is string)
	//asser(path)
	return Module._load(path, this);
}