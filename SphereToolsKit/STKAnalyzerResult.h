//
//  STKAnalyzerResult.h
//  Sphere
//
//  Created by Jos Kuijpers on 8/29/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STKAnalyzerResult : NSObject

// ... subjects
- (NSArray *)reports;

- (NSArray *)warnings;
- (NSArray *)errors;

@end
