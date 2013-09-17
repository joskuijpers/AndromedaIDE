//
//  L8RuntimeTests.m
//  Sphere
//
//  Created by Jos Kuijpers on 9/17/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "L8Runtime+L8Test.h"
#import "L8Value.h"

@interface L8RuntimeTests : XCTestCase

@end

@implementation L8RuntimeTests

- (void)testCurrentRuntime
{
	L8Runtime *localRuntime = [[L8Runtime alloc] init];
	[localRuntime runWithBlock:^(L8Runtime *paramRuntime) {
		XCTAssertEqual(localRuntime, paramRuntime, "Runtime in block parameter is expected runtime");
		XCTAssertEqual(localRuntime, [L8Runtime currentRuntime], "-[currentRuntime] returns current runtime");
	}];
}

@end
