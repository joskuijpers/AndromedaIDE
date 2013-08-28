//
//  STKAnalyzerResult.m
//  Sphere
//
//  Created by Jos Kuijpers on 8/29/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "STKAnalyzerResult.h"
#import "STKAnalyzerResult_Private.h"
#import "STKAnalyzerReport.h"

@interface STKAnalyzerResult ()
{
	NSArray *_reports;
}
@end

@implementation STKAnalyzerResult

- (instancetype)initWithReports:(NSArray *)reports
{
	self = [super init];
	if(self) {
		_reports = reports;
	}
	return self;
}

- (NSArray *)reports
{
	return _reports;
}

- (NSArray *)warnings
{
	NSPredicate *predicate;
	predicate = [NSPredicate predicateWithBlock:^BOOL(STKAnalyzerReport *evaluatedObject,
													  NSDictionary *bindings) {
		return [evaluatedObject isKindOfClass:[STKAnalyzerWarning class]];
	}];

	return [_reports filteredArrayUsingPredicate:predicate];
}

- (NSArray *)errors
{
	NSPredicate *predicate;
	predicate = [NSPredicate predicateWithBlock:^BOOL(STKAnalyzerReport *evaluatedObject,
													  NSDictionary *bindings) {
		return [evaluatedObject isKindOfClass:[STKAnalyzerError class]];
	}];

	return [_reports filteredArrayUsingPredicate:predicate];
}

@end
