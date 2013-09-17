//
//  L8FrameworkTests.m
//  L8FrameworkTests
//
//  Created by Jos Kuijpers on 9/17/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "L8Runtime+L8Test.h"
#import "L8Value.h"

@interface L8ValueTests : XCTestCase

@end

@implementation L8ValueTests

- (void)testStringValue
{
	[[[L8Runtime alloc] init] runWithBlock:^(L8Runtime *runtime) {
		XCTAssertEqualObjects([[L8Value valueWithObject:@"Hello World"] toString], @"Hello World", "String value storage");

		runtime[@"string1"] = @"Hello World";
		XCTAssertEqualObjects([runtime[@"string1"] toString], @"Hello World", "Value from object");

		L8Value *retVal = [runtime evaluateScript:@"string1" withName:@"test.js"];
		XCTAssertEqualObjects([retVal toString], @"Hello World", "Global string assignment script result");
	}];
}

- (void)testBooleanValue
{
	[[[L8Runtime alloc] init] runWithBlock:^(L8Runtime *runtime) {
		XCTAssertEqual([[L8Value valueWithBool:YES] toBool], YES, "Boolean value storage");
	}];
}

- (void)testDoubleValue
{
	[[[L8Runtime alloc] init] runWithBlock:^(L8Runtime *runtime) {
		XCTAssertEqualObjects([[L8Value valueWithDouble:1.0] toNumber], @1.0, "Double value storage");
	}];
}



@end
