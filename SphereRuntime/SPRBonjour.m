//
//  SPRBonjour.m
//  Sphere
//
//  Created by Jos Kuijpers on 08/03/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

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

+ (void)installIntoContext:(JSContext *)context
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
