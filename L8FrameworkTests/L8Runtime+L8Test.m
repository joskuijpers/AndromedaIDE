//
//  L8Runtime+L8Test.m
//  Sphere
//
//  Created by Jos Kuijpers on 9/17/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "L8Runtime+L8Test.h"
#import "L8RuntimeDelegate.h"
#import "L8Value.h"

@interface L8TestRuntimeDelegate : NSObject <L8RuntimeDelegate>

@property (strong) void (^block)(L8Runtime *runtime);

@end

@implementation L8Runtime (L8Test)

- (void)runWithBlock:(void (^)(L8Runtime *runtime))block
{
	L8Runtime *runtime;
	L8TestRuntimeDelegate *delegate;

	delegate = [[L8TestRuntimeDelegate alloc] init];
	delegate.block = [block copy];

	self.delegate = delegate;

	[self start];
}

@end

@implementation L8TestRuntimeDelegate

- (void)runtimeDidFinishCreatingContext:(L8Runtime *)runtime
{
	_block(runtime);
}

@end