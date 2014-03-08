//
//  SPRNetwork.m
//  Sphere
//
//  Created by Jos Kuijpers on 08/03/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

#import "SPRNetwork.h"
#import "SPRBonjour.h"

@implementation SPRNetwork

+ (void)installIntoContext:(JSContext *)context
{
	context[@"Network"] = [SPRNetwork class];
	context[@"Network"][@"bonjour"] = [SPRBonjour class];

	NSDictionary *property;

	// localName property on Network
	property = @{JSPropertyDescriptorGetKey: ^{
					 return [SPRNetwork localName];
				 }};
	[context[@"Network"] defineProperty:@"localName"
							 descriptor:property];

	// localAddress property on Network
	property = @{JSPropertyDescriptorGetKey: ^{
					 return [SPRNetwork localAddress];
				 }};
	[context[@"Network"] defineProperty:@"localAddress"
							 descriptor:property];
}

+ (NSString *)localName
{
	// TODO: there are multiple names. Which one to use?
	return [[NSHost currentHost] name];
}

+ (NSString *)localAddress
{
	// TODO: There are multiple addresses, including:
	// local, loopback, ipv4 and ipv6. Which one to use?
	return [[NSHost currentHost] address];
}

+ (BOOL)listenOnPort:(uint16_t)port
{
	NSLog(@"Go listen on port %hu",port);

	return NO;
}

@end
