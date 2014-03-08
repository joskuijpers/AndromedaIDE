//
//  SPRJSClass.h
//  Sphere
//
//  Created by Jos Kuijpers on 08/03/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

@protocol SPRJSClass <NSObject>

@required

/**
 * Called at creation of a context. In this method you
 * must add all classes, function, etc to the context
 * needed for your class.
 *
 * @param context the JSContext to install into
 */
+ (void)installIntoContext:(JSContext *)context;

@end

/**
 * Install all JS Lib classes into given context.
 * A JS Lib class conforms to SPRJSClass.
 *
 * @param context the JSContext to install into
 */
extern void spr_install_js_lib(JSContext *context);
