//
//  SPHTarget.m
//  Sphere
//
//  Created by Jos Kuijpers on 8/28/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "SPXTarget.h"

@implementation SPXTarget

- (id)initWithCoder:(NSCoder *)coder
{
	self = [super init];
	if(self) {
		_name = [coder decodeObjectForKey:@"name"];
		_buildPhases = [coder decodeObjectForKey:@"buildPhases"];
		_configurationList = [coder decodeObjectForKey:@"configurationList"];
		_productReference = [coder decodeObjectForKey:@"productReference"];
		_productName = [coder decodeObjectForKey:@"productName"];
		_productInstallPath = [coder decodeObjectForKey:@"productInstallPath"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
	[coder encodeObject:_name forKey:@"name"];
	[coder encodeObject:_buildPhases forKey:@"buildPhases"];
	[coder encodeObject:_configurationList forKey:@"configurationList"];
	[coder encodeObject:_productReference forKey:@"productReference"];
	[coder encodeObject:_productName forKey:@"productName"];
	[coder encodeObject:_productInstallPath forKey:@"productInstallPath"];

}

@end
