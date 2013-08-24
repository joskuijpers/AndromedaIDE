//
//  SPHNewProjectSheetController.h
//  JSphereX
//
//  Created by Jos Kuijpers on 8/23/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "IDESheetController.h"

@interface SPHNewProjectSheetController : IDESheetController

@property (strong) NSString *productName;
@property (strong) NSString *organizationName;
@property (strong) NSString *productDescription;
@property (strong) NSNumber *screenWidth;
@property (strong) NSNumber *screenHeight;

@property (assign) BOOL nextButtonEnabled;

@end
