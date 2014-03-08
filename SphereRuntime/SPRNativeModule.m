//
//  SPRModule.m
//  Sphere
//
//  Created by Jos Kuijpers on 08/03/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

#import "SPRNativeModule.h"

@implementation SPRNativeModule

@synthesize identifier=_identifier, filename=_filename;
@synthesize exports=_exports, loaded=_loaded;

+ (void)installIntoContext:(JSContext *)context
{
	context[@"NativeModule"] = [SPRNativeModule class];

	NSDictionary *desc;

	// Add the cache property to globally bind the cache to the context
	desc = @{JSPropertyDescriptorValueKey:[JSValue valueWithNewObjectInContext:context],
			 JSPropertyDescriptorWritableKey:@YES,
			 JSPropertyDescriptorEnumerableKey:@NO,
			 JSPropertyDescriptorConfigurableKey:@YES};
	[context[@"NativeModule"] defineProperty:@"_cache"
								  descriptor:desc];

	// Same for the sources
	// TODO correct value
	desc = @{JSPropertyDescriptorValueKey:[JSValue valueWithNewObjectInContext:context],
			 JSPropertyDescriptorWritableKey:@YES,
			 JSPropertyDescriptorEnumerableKey:@NO,
			 JSPropertyDescriptorConfigurableKey:@YES};
	[context[@"NativeModule"] defineProperty:@"_source"
								  descriptor:desc];


}

- (instancetype)init
{
	self = [super init];
	if(self) {
		NSArray *arguments = [JSContext currentArguments];

		if(arguments.count < 1) {
			[[JSContext currentContext] throw:@"Error: missing argument for NativeModule()"];
			return nil;
		}

		_identifier = [[(JSValue *)arguments[0] toString] copy];
		_filename = [NSString stringWithFormat:@"%@.js",_identifier];
		_exports = [[NSMutableDictionary alloc] init];
		_loaded = FALSE;
	}
	return self;
}

+ (id)requireWithIdentifier:(NSString *)identifier
{
	JSContext *context;
	SPRNativeModule *module;

	context = [JSContext currentContext];

	if([identifier isEqualToString:@"native_module"])
		return context[@"NativeModule"];

	module = [self getCachedWithIdentifier:identifier];
	if(module)
		return module.exports;

	if(![self moduleWithIdentifierExists:identifier])
		[context throw:[NSString stringWithFormat:@"Error: no such native module %@",identifier]];

	// add to moduleLoadList NativeModule+id

	module = [[SPRNativeModule alloc] init];
	[module cache];
	[module compile];

	return module.exports;
}

+ (instancetype)getCachedWithIdentifier:(NSString *)identifier
{
	NSDictionary *cache;

	cache = [JSContext currentContext][@"NativeModule"][@"_cache"];

	NSLog(@"Cache: %@",cache);

	return cache[identifier];
}

+ (BOOL)moduleWithIdentifierExists:(NSString *)identifier
{
	return YES;
}

- (void)cache
{
	[JSContext currentContext][@"NativeModule"][@"_cache"][_identifier] = self;
}

- (void)compile
{
	NSString *sourceCode;

	sourceCode = @"someCode();";
	sourceCode = [NSString stringWithFormat:@"(function (exports, require, module, "
				  @"__filename, __dirname) { %@\n});",sourceCode];

	// make function

	// call as: _exports, [@"NativeModule"][@"require"], self, _filename, [_filename deleting last comp])
}

@end


#if 0

/**
 * JavaScript code used to create a closure for the module code
 * The call of the function contains all module-local 'global' variables
 */
NativeModule._wrapper = [
						 "(function (exports, require, module, __filename, __dirname) { ",
						 "\n});" // A newline is needed here, for semicolon insertion
						 ];

NativeModule.prototype.compile = function() {
	var source, func;

	source = NativeModule.getSource(this.id);
	source = NativeModule.wrapper[0] + source + NativeModule.wrapper[1];

	func = runInThisContext(source, {"filename": this.filename});
	func(this.exports, NativeModule.require, this, this.filename, this.filename /*TODO: make dirname*/);
}

contextifyscript = process.binding(contextify).contextifyscript
runInThisContext(code,options):
script = contextifyscript(code,options)
return script.runInThisContext


#endif