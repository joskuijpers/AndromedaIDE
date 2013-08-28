//
//  STKAnalyzerReport.h
//  Sphere
//
//  Created by Jos Kuijpers on 8/29/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SXFile;

@interface STKAnalyzerReport : NSObject

@property(strong,readonly) NSString *message;
@property(strong,readonly) SXFile *file;
@property(strong,readonly) NSNumber *line;
@property(strong,readonly) NSNumber *column;

@end

@interface STKAnalyzerError : STKAnalyzerReport
@end

@interface STKAnalyzerWarning : STKAnalyzerReport
@end