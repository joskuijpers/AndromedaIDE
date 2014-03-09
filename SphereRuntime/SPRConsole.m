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
	NSArray *arguments;

	arguments = [L8Runtime currentArguments];

	// If the string does not contain any formatting elements,
	// assume the function just received a variable number of objects to log
	if([string rangeOfString:@"%"].location == NSNotFound) {
		for(L8Value *arg in arguments)
			fprintf(stdout,"[LOG ] %s\n",[[arg toString] UTF8String]);
	} else {
		NSLog(@"To Implement: printf-like formatting!");
		fprintf(stdout,"[LOG ] %s\n",[string UTF8String]);
	}
}

- (void)error:(NSString *)string
{
	fprintf(stderr,"[ERR ] %s\n",[string UTF8String]);
}

@end
