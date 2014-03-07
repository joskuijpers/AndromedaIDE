

function OpenFile(path) {
	return new File(path);
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