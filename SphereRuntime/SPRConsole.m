//
//  SPRConsole.m
//  Sphere
//
//  Created by Jos Kuijpers on 23/02/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

#import "SPRConsole.h"

@implementation SPRConsole

- (void)log:(NSString *)string
{
	printf("[LOG ] %s\n",[string UTF8String]);
}

@end
