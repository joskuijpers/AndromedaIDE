//
//  JSContext+SPRFixes.m
//  Sphere
//
//  Created by Jos Kuijpers on 07/03/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

#import "JSContext+SPRFixes.h"
#import <objc/runtime.h>

@implementation JSContext (SPRFixes)

// This code is needed to make constructors work.
// After calling this on the context with given class and name, one can actually do
// new <name>() on the context.
void spr_make_class_available(JSContext *context, Class class, NSString *name)
{
    NSString *formattedName;

	formattedName = [NSString stringWithFormat:@"__%s", class_getName(class)];

	// The constructor function
    context[formattedName] = ^(void) {
		return [[class alloc] init];
	};

    [context evaluateScript:[NSString stringWithFormat:@"var %@ = function (){ return %@();};", name, formattedName]];
}

// Replace the default implementation (publicly availble) with an implementation
// that checks for class objects and acts appropriately
- (void)setValue:(id)value forKey:(NSString *)key
{
	if(class_isMetaClass(object_getClass(value)))
		spr_make_class_available(self, value, key);
	else
		[self.globalObject setValue:value forKey:key];
}

// Replace the default implementation (publicly availble) with an implementation
// that checks for class objects and acts appropriately
- (void)setObject:(id)object forKeyedSubscript:(NSObject <NSCopying> *)key
{
	if(class_isMetaClass(object_getClass(object))) {
		NSString *skey = [key isKindOfClass:[NSString class]]?(NSString *)key:[key description];
		spr_make_class_available(self, object, skey);
	} else
		[self.globalObject setObject:object
				   forKeyedSubscript:key];
}

@end
