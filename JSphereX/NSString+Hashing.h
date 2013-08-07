//
//  NSString+Hashing.h
//  JSphereX
//
//  Created by Jos Kuijpers on 8/7/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
	JSXStringMD5Hash,
	JSXStringSHA1Hash
} JSXStringHashMethod;

@interface NSString (Hashing)

- (NSString *)stringByHashingWithMethod:(JSXStringHashMethod)method;

@end
