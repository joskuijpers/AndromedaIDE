//
//  JSContext+SPRExceptions.h
//  Sphere
//
//  Created by Jos Kuijpers on 06/03/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

#import <JavaScriptCore/JavaScriptCore.h>

@interface JSContext (SPRExceptions)

- (instancetype)initWithExceptionHandler;

/**
 * Throws given JSValue to JavaScript
 *
 * @param value JSValue to throw
 */
- (void)throwValue:(JSValue *)value;

/**
 * Throws given object to JavaScript
 *
 * @param object Object to throw
 */
- (void)throw:(NSObject *)object;

@end
