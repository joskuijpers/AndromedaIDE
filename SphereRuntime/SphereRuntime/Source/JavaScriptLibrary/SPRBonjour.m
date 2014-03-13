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

#import "SPRBonjour.h"
#import "SPRSocket.h"

@interface SPRBonjour () <NSNetServiceDelegate, NSNetServiceBrowserDelegate>
@end

/*
 Make some kind of singleton
 Make it handle more than one NSNetService
	for publishing
	and for resolving
 Use javascript callbacks and keep lists of visible peers (browse)
 
 */

@implementation SPRBonjour {
	NSNetService *_service;
}

+ (void)installIntoContext:(L8Runtime *)context
{
	context[@"Bonjour"] = [SPRBonjour class];
}

- (instancetype)init
{
	self = [super init];
	if(self) {

	}
	return self;
}

- (BOOL)publishWithName:(NSString *)name
				   type:(NSString *)type
				   port:(uint16_t)port
			   inDomain:(NSString *)domain
{

	_service = [[NSNetService alloc] initWithDomain:@"local"
											   type:@"_game._tcp"
											   name:@""
											   port:port];
	_service.delegate = self;

	[_service publish];

	return NO;
}

- (void)discoverPeersWithType:(NSString *)type
					   domain:(NSString *)domain
					 callback:(void (^)(NSString *name))callback
{
	NSLog(@"Find peers with type %@ in domain %@",type,domain);
	callback(@"Joking!");

//	NSNetServiceBrowser *br = [[NSNetServiceBrowser alloc] init];
//	br.delegate = self;
}

- (SPRSocket *)resolvePeerWithName:(NSString *)name
{
	return nil;
}

- (void)stop
{
	[_service stop];
}

- (void)netServiceDidPublish:(NSNetService *)sender
{
	NSLog(@"Did publish");
}

- (void)netServiceWillPublish:(NSNetService *)sender
{
	NSLog(@"Will publish");
}

- (void)netServiceDidStop:(NSNetService *)sender
{
	NSLog(@"Stopped");
}

@end
