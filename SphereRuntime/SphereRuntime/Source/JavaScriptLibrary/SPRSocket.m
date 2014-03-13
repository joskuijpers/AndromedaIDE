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

#import "SPRSocket.h"
#import "SPRByteArray.h"

@interface SPRSocket () <NSStreamDelegate>
@end

@implementation SPRSocket {
	NSInputStream *_inputStream;
	NSOutputStream *_outputStream;
}

@synthesize connected=_connected;

+ (void)installIntoContext:(L8Runtime *)context
{
	context[@"Socket"] = [SPRSocket class];
}

- (instancetype)init
{
	self = [super init];
	if(self) {
		NSArray *arguments = [L8Runtime currentArguments];

		if(arguments.count >= 2) {
			NSString *host = [arguments[0] toString];
			uint16_t port = [[arguments[1] toNumber] unsignedShortValue];

			[self connectToHost:host onPort:port];
		}
	}
	return self;
}

- (instancetype)initWithAddress:(NSString *)address
						   port:(uint16_t)port
{
	self = [super init];
	if(self) {
		[self connectToHost:address onPort:port];
	}
	return self;
}

- (instancetype)initWithService:(NSNetService *)service
{
	self = [super init];
	if(self) {
		[self connectToService:service];
	}
	return self;
}

- (BOOL)connectToHost:(NSString *)host onPort:(uint16_t)port
{
	CFReadStreamRef readStreamRef;
	CFWriteStreamRef writeStreamRef;

	if([self isConnected])
		return NO;

	CFStreamCreatePairWithSocketToHost(NULL,
									   (__bridge CFStringRef)host,
									   port,
									   &readStreamRef,
									   &writeStreamRef);

	if(readStreamRef == NULL || writeStreamRef == NULL) {
		CFRelease(readStreamRef);
		CFRelease(writeStreamRef);
		return NO;
	}

	_inputStream = (__bridge NSInputStream *)readStreamRef;
	_outputStream = (__bridge NSOutputStream *)writeStreamRef;

	_inputStream.delegate = self;
	_outputStream.delegate = self;

	[_inputStream scheduleInRunLoop:[NSRunLoop mainRunLoop]
						  forMode:NSDefaultRunLoopMode];
	[_outputStream scheduleInRunLoop:[NSRunLoop mainRunLoop]
						  forMode:NSDefaultRunLoopMode];

	[_inputStream open];
	[_outputStream open];

	return YES;
}

- (BOOL)connectToService:(NSNetService *)service
{
	CFReadStreamRef readStreamRef;
	CFWriteStreamRef writeStreamRef;

	if([self isConnected])
		return NO;

	CFStreamCreatePairWithSocketToNetService(NULL,
											 (__bridge CFNetServiceRef)service,
											 &readStreamRef,
											 &writeStreamRef);

	if(readStreamRef == NULL || writeStreamRef == NULL) {
		CFRelease(readStreamRef);
		CFRelease(writeStreamRef);
		return NO;
	}

	_inputStream = (__bridge NSInputStream *)readStreamRef;
	_outputStream = (__bridge NSOutputStream *)writeStreamRef;

	_inputStream.delegate = self;
	_outputStream.delegate = self;

	[_inputStream scheduleInRunLoop:[NSRunLoop mainRunLoop]
							forMode:NSDefaultRunLoopMode];
	[_outputStream scheduleInRunLoop:[NSRunLoop mainRunLoop]
							 forMode:NSDefaultRunLoopMode];

	[_inputStream open];
	[_outputStream open];

	return YES;
}

- (BOOL)isConnected
{
	if(_inputStream.streamStatus == NSStreamStatusOpen
	   && _outputStream.streamStatus == NSStreamStatusOpen)
		return YES;
	return NO;
}

- (SPRByteArray *)readBytes:(size_t)size
{
	// read from buffer

	// if not enough, read as much as possible from stream

	// if not enough, wait

	return nil;
}

- (void)writeByteArray:(SPRByteArray *)byteArray
{
	// test space available

	// write as much as possible

	// put rest in queue
}

- (void)close
{
	[_inputStream close];
	[_outputStream close];

	[_inputStream removeFromRunLoop:[NSRunLoop mainRunLoop]
							forMode:NSDefaultRunLoopMode];
	[_outputStream removeFromRunLoop:[NSRunLoop mainRunLoop]
							 forMode:NSDefaultRunLoopMode];

	_inputStream = nil;
	_outputStream = nil;
}

- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode
{
	NSLog(@"Handle event %lu for stream %@",eventCode,aStream);
	switch(eventCode) {
		case NSStreamEventNone:
			NSLog(@"None");
			break;
		case NSStreamEventOpenCompleted:
			NSLog(@"Open Completed");
			break;
		case NSStreamEventHasBytesAvailable:
			NSLog(@"Bytes Avail");
			// read as much as possible into buffer
			break;
		case NSStreamEventHasSpaceAvailable:
			NSLog(@"Space Avail");
			// _writeable = YES;
			// if in queue, write as much as possible
			break;
		case NSStreamEventErrorOccurred:
			NSLog(@"Error");
			break;
		case NSStreamEventEndEncountered:
			NSLog(@"EOS");
			break;
	}
}

@end

/*
 Use NSStream for outgoing connections in Objective-C.
 If you are connecting to a specific host, create a CFHost object (not NSHost—they are not toll-free bridged), then use CFStreamCreatePairWithSocketToHost or CFStreamCreatePairWithSocketToCFHost to open a socket connected to that host and port and associate a pair of CFStream objects with it. You can then cast these to an NSStream object.

 You can also use the CFStreamCreatePairWithSocketToNetService function with a CFNetServiceRef object to connect to a Bonjour service. Read “Discovering and Advertising Network Services” in Networking Overview for more information.

 */