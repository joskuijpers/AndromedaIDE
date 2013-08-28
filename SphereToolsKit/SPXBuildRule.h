//
//  SPXBuildRule.h
//  Sphere
//
//  Created by Jos Kuijpers on 8/28/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPXBuildRule : NSObject <NSCoding>

@property (copy) NSString *fileType;
@property (copy) NSString *compilerSpecification;
//@property (strong) NSMutableArray *outputFiles;

@end
