//
//  main.m
//  L8Console
//
//  Created by Jos Kuijpers on 9/17/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "L8.h"

@protocol JSTestConsole <L8Export>

@property (strong) NSString *testProperty;
@property (assign,getter=isHidden,setter=makeHidden:,nonatomic) BOOL hidden;
@property (copy) void (^theBlock)(NSString *text);

L8ExportAs(testArgumentTypes,
		   - (NSString *)testArgumentTypesWithInt:(int)i double:(double)d boolean:(BOOL)b string:(NSString *)s
		   );

- (void)log:(NSString *)text;
- (void)log:(NSString *)text withComponent:(NSString *)component;

+ (void)log:(NSString *)text;

@end

@interface TestConsole : NSObject <JSTestConsole>

- (id)objectForKeyedSubscript:(id)key;
- (id)objectAtIndexedSubscript:(NSUInteger)index;
- (void)setObject:(id)object forKeyedSubscript:(NSObject <NSCopying> *)key;
- (void)setObject:(id)object atIndexedSubscript:(NSUInteger)index;

@end

int main(int argc, const char * argv[])
{
	@autoreleasepool {
		L8Runtime *runtime = [[L8Runtime alloc] init];
		[L8Runtime enableDebugging];

		[runtime executeBlockInRuntime:^(L8Runtime *runtime) {
			runtime[@"Console"] = [TestConsole class];
			[runtime evaluateScript:@"console = new Console('Component'); console.log('It works!');"
						   withName:@"start.js"];
			[runtime[@"console"] invokeMethod:@"log" withArguments:@[@"Me Here"]];
		}];
	}

    return 0;
}

@implementation TestConsole {
	NSMutableDictionary *_dict;
	NSMutableArray *_arr;
}

@synthesize testProperty = _testProperty;
@synthesize hidden = _hidden;
@synthesize theBlock = _theBlock;

- (id)init
{
    self = [super init];
    if (self) {
        _dict = [NSMutableDictionary dictionary];
		_arr = [NSMutableArray array];

		_dict[@"hello"] = @"world";
		_arr[0] = @"Item0";

		NSLog(@"CONSTRUCTED %@",self);
    }
    return self;
}

- (id)initWithComponent:(NSString *)component
{
	self = [self init];
	if(self) {
		NSLog(@"%@",NSStringFromSelector(_cmd));
		_testProperty = component;

		NSLog(@"CONSTRUCTED %@ with component %@",self,component);
	}
	return self;
}

- (id)initWithComponent:(NSString *)component hidden:(BOOL)hidden
{
	self = [self init];
	if(self) {
		NSLog(@"%@",NSStringFromSelector(_cmd));
		_testProperty = component;
		_hidden = hidden;
	}
	return self;
}

- (id)initWithHidden:(BOOL)hidden
{
	self = [self init];
	if(self) {
		NSLog(@"%@",NSStringFromSelector(_cmd));
		_hidden = hidden;
	}
	return self;
}

- (NSString *)testArgumentTypesWithInt:(int)i double:(double)d boolean:(BOOL)b string:(NSString *)s
{
	NSLog(@"int %d, double %d, boolean %d, string %@",i,d,b,s);
	return @"Joo";
}

+ (void)log:(NSString *)text
{
	NSLog(@"STATIC %@",text);
}

- (void)log:(NSString *)text
{
//	assert(text == nil || [text isKindOfClass:[NSString class]]);

	printf("JSConsole: %s\n",[[text description] UTF8String]);
}

- (void)log:(NSString *)text withComponent:(NSString *)component
{
	printf("JSConsole[%s]: %s\n",[component UTF8String],[[text description] UTF8String]);
}

- (id)objectForKeyedSubscript:(id)key
{
	return _dict[key];
}

- (id)objectAtIndexedSubscript:(NSUInteger)index
{
	return _arr[index];
}

- (void)setObject:(L8Value *)object forKeyedSubscript:(NSObject <NSCopying> *)key
{
	_dict[key] = [object toObject];
}

- (void)setObject:(L8Value *)object atIndexedSubscript:(NSUInteger)index
{
	_arr[index] = [object toObject];
}

- (void)dealloc
{
	NSLog(@"Console Dealloc %@",self);
}

@end

/*

THIS FAILS: BLOCKS, WHEN ASSIGNED, CANT BE RUN

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	L8Runtime *runtime = [[L8Runtime alloc] init];

	runtime.debuggerPort = 12345;
	runtime.waitForDebugger = NO;

	[runtime enableDebugging];

	[runtime executeBlockInRuntime:^(L8Runtime *runtime) {

		Console *console = [[Console alloc] init];
		runtime[@"console"] = console;
		NSLog(@"CONSOLE: %@",console);

		runtime[@"gameTick"] = ^() {
			[[L8Runtime currentRuntime] loadScript:@"console.log('TICK!');" withName:@"test.js"];
		};

		runtime[@"sleep"] = ^(int time) {
			sleep(time);
		};

		[runtime loadScript:@"console.log(console); console.log(console.log);" withName:@""];
		[runtime loadScript:@"while(true) { console.log('Hi'); sleep(100); } " withName:@"hello.js"];
	}];

	[[NSRunLoop currentRunLoop] addTimer:[[NSTimer alloc] initWithFireDate:[NSDate date]
																  interval:1
																	target:self
																  selector:@selector(fire:)
																  userInfo:runtime
																   repeats:YES]
								 forMode:NSDefaultRunLoopMode];
}

- (void)fire:(NSTimer *)timer
{
	L8Runtime *runtime = timer.userInfo;
	[runtime executeBlockInRuntime:^(L8Runtime *runtime) {
		[runtime.globalObject invokeMethod:@"gameTick" withArguments:nil];
		//		[runtime[@"console"] invokeMethod:@"log" withArguments:@[@"TICK"]];
	}];
}

*/