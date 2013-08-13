//
//  SPXProject.h
//  JSphereX
//
//  Created by Jos Kuijpers on 8/13/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SPXGroup;

@interface SPXProject : NSObject

// ORGANIZATIONNAME
@property (strong) NSDictionary *attributes;
@property (strong) SPXGroup *mainGroup;

// Whatfor?
@property (strong) NSString *projectDirPath;
@property (strong) NSString *projectRoot;

@end
