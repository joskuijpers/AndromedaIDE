/*
 * Copyright (c) 2014 Jos Kuijpers. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY APPLE INC. ``AS IS'' AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL APPLE INC. OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
 * OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

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
