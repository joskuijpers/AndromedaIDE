

function OpenFile(path) {
	return new File(path);
}

function HashFromFile(file) {
	return file.md5hash();
}

function CreateColor(r,g,b,a) {
	return new Color(r,g,b,a);
}

function BlendColors(c1,c2) {
	return c1.blend(c2);
}

function BlendColorsWeighted(c1,c2,w1,w2) {
	return c1.blend(c2,w1,w2);
}

function CreateByteArray(length) {
	return new ByteArray(length);
}

function CreateByteArrayFromString(string) {
	return new ByteArray(string);
}

function CreateStringFromByteArray(byte_array) {
	return byte_array.makeString();
}

function HashByteArray(byte_array) {
	return byte_array.md5hash();
}