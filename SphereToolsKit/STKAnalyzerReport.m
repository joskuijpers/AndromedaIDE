//
//  STKAnalyzerReport.m
//  Sphere
//
//  Created by Jos Kuijpers on 8/29/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "STKAnalyzerReport.h"
#import "STKAnalyzerReport_Private.h"

@implementation STKAnalyzerReport

- (instancetype)initWithMessage:(NSString *)message
						   file:(SXFile *)file
						   line:(NSNumber *)line
						 column:(NSNumber *)column
{
	self = [super init];
	if(self) {
		_message = [message copy];
		_file = file;
		_line = line;
		_column = column;
	}
	return self;
}

@end

@implementation STKAnalyzerError
@end

@implementation STKAnalyzerWarning
@end