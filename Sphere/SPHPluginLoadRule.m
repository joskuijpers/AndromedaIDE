//
//  SPHPluginLoadRule.m
//  JSphereX
//
//  Created by Jos Kuijpers on 8/14/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "SPHPluginLoadRule.h"

@implementation SPHPluginLoadRule

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(self) {
		_kind = dictionary[@"kind"];
		_identifier = dictionary[@"id"];
	}
	return self;
}

@end
