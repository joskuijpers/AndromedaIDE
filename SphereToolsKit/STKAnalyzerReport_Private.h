//
//  STKAnalyzerReport_Private.h
//  Sphere
//
//  Created by Jos Kuijpers on 8/29/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "STKAnalyzerReport.h"

@interface STKAnalyzerReport ()

- (instancetype)initWithMessage:(NSString *)message
						   file:(SXFile *)file
						   line:(NSNumber *)line
						 column:(NSNumber *)column;

@end
