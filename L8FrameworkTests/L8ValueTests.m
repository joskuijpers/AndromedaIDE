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

#import <XCTest/XCTest.h>
#import "L8Runtime+L8Test.h"
#import "L8Value.h"
#import "L8Export.h"

@interface L8ValueTests : XCTestCase @end
@interface CustomSimpleObject : NSObject @end

@interface CustomMethodClass : NSObject
- (void)simpleMethod;
- (int)methodReturningInteger;
- (id)methodReturningId;
- (void)methodWithStringArgument:(NSString *)argument;
@end

@interface CustomPropertiesClass : NSObject
@property NSString *stringVal;
@property double doubleVal;
@end

@interface CustomPropertiesClassWithAttributes : NSObject
@property (strong,readonly) NSString *stringVal;
@property (assign,getter=isHidden) BOOL hidden;
@property (strong,setter=setMaker:,getter=seeMaker) NSString *maker;
@property (strong,setter=oddSetter:) NSString *oddities;
@end

@interface CustomClass : NSObject
@end


@implementation L8ValueTests

- (void)testStringValue
{
	[[[L8Runtime alloc] init] runWithBlock:^(L8Runtime *runtime) {
		L8Value *value = [L8Value valueWithObject:@"Hello World"];

		XCTAssertNotNil(value, "-[valueWithObject:]");
		XCTAssertEqualObjects([value toObject], @"Hello World", "-[toObject]");
		XCTAssertEqualObjects([value toString], @"Hello World", "-[toString]");
		XCTAssertTrue([value isString], "-[isString]");


		runtime[@"string"] = @"Hello World";
		XCTAssertEqualObjects([runtime[@"string"] toString], @"Hello World", "Value from object");

		L8Value *retVal = [runtime evaluateScript:@"string" withName:@"test.js"];
		XCTAssertEqualObjects([retVal toString], @"Hello World", "Global string assignment script result");
	}];
}

- (void)testBooleanValue
{
	[[[L8Runtime alloc] init] runWithBlock:^(L8Runtime *runtime) {
		L8Value *value = [L8Value valueWithBool:YES];

		XCTAssertNotNil(value, "-[valueWithBool:]");
		XCTAssertEqual([value toBool], YES, "-[toBool]");
		XCTAssertEqualObjects([value toObject], @YES, "-[toObject]");
		XCTAssertTrue([value isBoolean], "-[isBool]");

		XCTAssertEqual([value toBool], [[L8Value valueWithObject:@YES] toBool], "-[valueWithObject:]");
	}];
}

- (void)testNullValue
{
	[[[L8Runtime alloc] init] runWithBlock:^(L8Runtime *runtime) {
		L8Value *value = [L8Value valueWithNull];

		XCTAssertNotNil(value, "-[valueWithNull]");
		XCTAssertEqualObjects([value toObject], [NSNull null], "-[toObject]");
		XCTAssertTrue([value isNull], "-[isNull]");

		XCTAssertEqualObjects([value toObject], [[L8Value valueWithObject:[NSNull null]] toObject], "-[valueWithObject:]");
	}];
}

- (void)testUndefinedValue
{
	[[[L8Runtime alloc] init] runWithBlock:^(L8Runtime *runtime) {
		L8Value *value = [L8Value valueWithUndefined];

		XCTAssertNotNil(value, "-[valueWithUndefined]");
		XCTAssertNil([value toObject], "-[toObject]");
		XCTAssertTrue([value isUndefined], "-[isUndefined]");

		XCTAssertEqualObjects([value toObject], [[L8Value valueWithObject:nil] toObject], "-[valueWithObject:]");
	}];
}

- (void)testDateValue
{
	[[[L8Runtime alloc] init] runWithBlock:^(L8Runtime *runtime) {
		NSDate *date = [NSDate date];
		L8Value *value = [L8Value valueWithObject:date];

		XCTAssertNotNil(value, "-[valuewithObject:]");
		XCTAssertEqual((long long)[value toDouble],(long long)[date timeIntervalSince1970],"-[toDouble]");
		XCTAssertNotNil([value toObject], "-[toObject]");
		XCTAssertTrue([value isObject], "-[isObject]");
	}];
}

- (void)testDoubleValue
{
	[[[L8Runtime alloc] init] runWithBlock:^(L8Runtime *runtime) {
		L8Value *value = [L8Value valueWithDouble:5.0];

		XCTAssertNotNil(value, "-[valueWithDouble:]");
		XCTAssertEqualObjects([value toNumber], @5.0, "-[toNumber]");
		XCTAssertEqualObjects([value toObject], @5.0, "-[toObject]");
		XCTAssertTrue([value isNumber], "-[isNumber]");

		XCTAssertEqualObjects([value toNumber], [[L8Value valueWithObject:@5.0] toNumber], "-[valueWithObject:]");
	}];
}

- (void)testArrayValue
{
	[[[L8Runtime alloc] init] runWithBlock:^(L8Runtime *runtime) {
		L8Value *value = [L8Value valueWithObject:@[@"a",@"b"]];

		XCTAssertNotNil(value, "-[valueWithObject:(NSArray)]");
		XCTAssertEqualObjects([value toArray], (@[@"a",@"b"]), "-[toArray]");
		XCTAssertEqualObjects([value toObject], (@[@"a",@"b"]), "-[toObject]");
		XCTAssertTrue([value isObject], "-[isObject]");

		value = [L8Value valueWithNewArray];
		XCTAssertNotNil(value, "-[valueWithNewArray]");
		XCTAssertEqualObjects([value toArray], @[], "-[toArray] (newArray)");
		XCTAssertEqualObjects([value toObject], @[], "-[toObject] (newArray)");
		XCTAssertTrue([value isObject], "-[isObject] (newArray)");
	}];
}

- (void)testDictionaryValue
{
	[[[L8Runtime alloc] init] runWithBlock:^(L8Runtime *runtime) {
		L8Value *value = [L8Value valueWithObject:@{@"a":@"1",@"b":@2}];

		XCTAssertNotNil(value, "-[valueWithObject:(NSDictionary)]");
		XCTAssertEqualObjects([value toDictionary], (@{@"a":@"1",@"b":@2}), "-[toArray]");
		XCTAssertEqualObjects([value toObject], (@{@"a":@"1",@"b":@2}), "-[toObject]");
		XCTAssertTrue([value isObject], "-[isObject]");
	}];
}

- (void)testObjectValue
{
	[[[L8Runtime alloc] init] runWithBlock:^(L8Runtime *runtime) {
		L8Value *value = [L8Value valueWithNewObject];

		XCTAssertNotNil(value, "-[valueWithNewObject]");
		XCTAssertNotNil([value toObject], "-[toObject]");
		NSLog(@"OBJECT %@",value);
		XCTAssertTrue([value isObject], "-[isObject]");
	}];
}

- (void)testCustomClassValue
{
	[[[L8Runtime alloc] init] runWithBlock:^(L8Runtime *runtime) {
		id object = [[CustomSimpleObject alloc] init];
		L8Value *value = [L8Value valueWithObject:object];

		XCTAssertNotNil(value, "-[valueWithObject:(Custom)]");
		XCTAssertEqual([value toObject], object, "-[toObject]");
		XCTAssertTrue([value isObject], "-[isObject]");
	}];
}

- (void)testProperties
{
	[[[L8Runtime alloc] init] runWithBlock:^(L8Runtime *runtime) {
		L8Value *value = [L8Value valueWithNewObject];

		XCTAssertNotNil(value, "-[valueWithNewObject]");

		[value setValue:@"Hello World" forProperty:@"key"];
		XCTAssertNotNil([value valueForProperty:@"key"],"-[setValue:forProperty:]");
		XCTAssertEqualObjects([[value valueForProperty:@"key"] toString], @"Hello World", "-[valueForProperty:]");
		XCTAssertTrue([value hasProperty:@"key"], "-[hasProperty]");

		runtime[@"object"] = value;
		L8Value *returnValue = [runtime evaluateScript:@"object.key" withName:@""];
		XCTAssertEqualObjects([returnValue toString], @"Hello World", "getting value in JavaScript");

		XCTAssertEqualObjects([value toDictionary], (@{@"key":@"Hello World"}), "-[toDictionary] (Object conversion)");

		[value deleteProperty:@"key"];
		XCTAssertFalse([value hasProperty:@"key"], "-[deleteProperty:]");
	}];
}

- (void)testKeyedProperties
{
	[[[L8Runtime alloc] init] runWithBlock:^(L8Runtime *runtime) {
		L8Value *value = [L8Value valueWithNewObject];

		XCTAssertNotNil(value, "-[valueWithNewObject]");

		value[@"key"] = @"Hello World";
		XCTAssertNotNil(value[@"key"],"-[setObject:forKeyedSubscript:]");
		XCTAssertEqualObjects([value[@"key"] toString], @"Hello World", "-[objectForKeyedSubscript:]");
		XCTAssertTrue([value hasProperty:@"key"], "-[hasProperty]");
	}];
}

- (void)testIndexedProperties
{
	[[[L8Runtime alloc] init] runWithBlock:^(L8Runtime *runtime) {
		L8Value *value = [L8Value valueWithNewArray];

		XCTAssertNotNil(value, "-[valueWithNewArray]");

		value[0] = @"Hello World";
		XCTAssertNotNil(value[0],"-[setObject:forIndexedSubscript:]");
		XCTAssertEqualObjects([value[0] toString], @"Hello World", "-[objectForIndexedSubscript:]");
		XCTAssertTrue([value hasProperty:@"0"], "-[hasProperty]");

		runtime[@"object"] = value;
		L8Value *returnValue = [runtime evaluateScript:@"object" withName:@""];
		XCTAssertEqualObjects([returnValue toArray], @[@"Hello World"], "getting value in JavaScript and conversion to NSArray");

		[value deleteProperty:@"0"];
		XCTAssertFalse([value hasProperty:@"0"], "-[deleteProperty:]");
	}];
}

- (void)testCustomObjectWithMethods
{
	[[[L8Runtime alloc] init] runWithBlock:^(L8Runtime *runtime) {
		L8Value *retVal;
		CustomMethodClass *object = [[CustomMethodClass alloc] init];
		L8Value *value = [L8Value valueWithObject:object];

		XCTAssertNotNil(value, "-[valueWithObject:(CustomMethodClass)]");

		retVal = [value invokeMethod:@"simpleMethod" withArguments:@[]];
		XCTAssertTrue([retVal isUndefined], "-[invokeMethod:(void returning) withArguments:@[]], returns Undefined");

		retVal = [value invokeMethod:@"methodReturningInteger" withArguments:@[]];
		XCTAssertEqualObjects([retVal toNumber], @42, "-[invokeMethod:(int returning) withArguments:@[]]");
		XCTAssertTrue([retVal isNumber], "-[retVal isNumber]");

		// TODO: more methods
	}];
}

- (void)testCustomObjectWithProperties
{
	[[[L8Runtime alloc] init] runWithBlock:^(L8Runtime *runtime) {
		L8Value *retVal;
		CustomPropertiesClass *object = [[CustomPropertiesClass alloc] init];
		object.stringVal = @"Hello World";

		L8Value *value = [L8Value valueWithObject:object];

		XCTAssertNotNil(value, "-[valueWithObject:(CustomPropertiesClass)]");

		runtime[@"object"] = object;
		retVal = [runtime evaluateScript:@"object.stringVal" withName:@""];
		XCTAssertEqualObjects([retVal toString], @"Hello World", "Property getting in JavaScript");

		[runtime evaluateScript:@"object.stringVal = 'John';" withName:@""];
		XCTAssertEqualObjects(object.stringVal, @"John", "Property setting in JavaScript");

		retVal = [runtime evaluateScript:@"object.notThere" withName:@""];
		XCTAssertTrue([retVal isUndefined], "Invalid property getting in JavaScript");

		// TODO: more properties
	}];
}

- (void)testCustomObjectWithAttributedProperties
{
	/*[[[L8Runtime alloc] init] runWithBlock:^(L8Runtime *runtime) {
		L8Value *retVal;
		CustomMethodClass *object = [[CustomMethodClass alloc] init];
		L8Value *value = [L8Value valueWithObject:object];

		XCTAssertNotNil(value, "-[valueWithObject:(CustomMethodClass)]");

		retVal = [value invokeMethod:@"simpleMethod" withArguments:@[]];
		XCTAssertTrue([retVal isUndefined], "-[invokeMethod:(void returning) withArguments:@[]], returns Undefined");

		retVal = [value invokeMethod:@"methodReturningInteger" withArguments:@[]];
		XCTAssertEqualObjects([retVal toNumber], @42, "-[invokeMethod:(int returning) withArguments:@[]]");
		XCTAssertTrue([retVal isNumber], "-[retVal isNumber]");

		// TODO: more methods
	}];*/
}

- (void)testCustomJSFunction
{
	[[[L8Runtime alloc] init] runWithBlock:^(L8Runtime *runtime) {
		Class cls = [CustomClass class];
		L8Value *value = [L8Value valueWithObject:cls];

		XCTAssertNotNil(value, "-[valueWithObject:(Class)]");
	}];
}

@end

@implementation CustomSimpleObject @end

@implementation CustomMethodClass

- (void)simpleMethod
{

}

- (int)methodReturningInteger
{
	return 42;
}

- (id)methodReturningId
{
	return nil;
}

- (void)methodWithStringArgument:(NSString *)argument
{

}

@end

@implementation CustomPropertiesClass

@end

@implementation CustomClass

@end