
var c1 = new Color();
var c2 = new Color(0,0,0);
var c3 = new Color(255,255,255,255);

console.log("c1: "+strColor(c1));
console.log("c2: "+strColor(c2));
console.log("c3: "+strColor(c3));

var c4 = c2.blend(c3);
var c5 = c2.blendWeighted(c3,0.5,0.1);

console.log("c4: "+strColor(c4));
console.log("c5: "+strColor(c5));

function strColor(c) {
	return "{"+c.red+","+c.green+","+c.blue+","+c.alpha+"}";
}

