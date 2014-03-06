//
//  JSContext+SPRExceptions.m
//  Sphere
//
//  Created by Jos Kuijpers on 06/03/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

#import "JSContext+SPRExceptions.h"

@implementation JSContext (SPRExceptions)

- (instancetype)initWithExceptionHandler
{
	self = [self init];
	if(self) {
		self.exceptionHandler = ^(JSContext *context, JSValue *value) {
			// TODO: dissect the JSValue and work with TypeError, SyntaxError, etc exceptions
			@throw value;
		};
	}
	return self;
}

- (void)throwValue:(JSValue *)value
{
	self.exception = value;
}

- (void)throw:(NSObject *)object
{
	self.exception = [JSValue valueWithObject:object inContext:self];
}

@end
