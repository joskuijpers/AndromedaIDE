//
//  STKAnalyzerDelegate.h
//  Sphere
//
//  Created by Jos Kuijpers on 8/29/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import <Foundation/Foundation.h>

@class STKAnalyzer, SXFile, STKAnalyzerResult;

@protocol STKAnalyzerDelegate <NSObject>

- (void)analyzer:(STKAnalyzer *)analyzer
	didIndexFile:(SXFile *)file
		  result:(STKAnalyzerResult *)result;

@end
