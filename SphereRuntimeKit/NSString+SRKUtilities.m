//
//  NSString+SRKUtilities.m
//  Sphere
//
//  Created by Jos Kuijpers on 24/02/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

#import "NSString+SRKUtilities.h"

@implementation NSString (SRKUtilities)

- (NSString *)srk_stringByTrimmingWhitespace
{
	return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

@end
