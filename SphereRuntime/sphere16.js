

function OpenFile(path) {
	return new __File(path);
}

function HashFromFile(file) {
	return file.md5hash();
}

function CreateColor(r,g,b,a) {
	return new __Color(r,g,b,a);
}

function BlendColors(c1,c2) {
	return c1.blend(c2);
}

function BlendColorsWeighted(c1,c2,w1,w2) {
	return c1.blend(c2,w1,w2);
}

function CreateByteArray(length) {
	return new __ByteArray(length);
}

function CreateByteArrayFromString(string) {
	return new __ByteArray(string);
}

function CreateStringFromByteArray(byte_array) {
	return byte_array.makeString();
}

function HashByteArray(byte_array) {
	return byte_array.md5hash();
}

function LoadImage(filename) {
	return new __Image(filename);
}

function GetLocalAddress() {
	return Network.localAddress;
}

function GetLocalName() {
	return Network.localName;
}

function ListenOnPort(port) {
	return Network.listen(port);
}

function OpenAddress(address, port) {
	return new __Socket(address, port);
}

Socket.prototype.isConnected = function() {
	return this.connected;
}
