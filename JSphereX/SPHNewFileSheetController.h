//
//  SPHNewFileSheetController.h
//  JSphereX
//
//  Created by Jos Kuijpers on 8/23/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "IDESheetController.h"

@interface SPHNewFileSheetController : IDESheetController
 <NSOutlineViewDataSource,NSOutlineViewDelegate>

@property (weak,nonatomic) IBOutlet NSOutlineView *templateList;

@property (strong) NSString *fileName;
@property (assign) BOOL nextButtonEnabled;

@end
