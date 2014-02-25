//
//  SRKFileSGM.h
//  Sphere
//
//  Created by Jos Kuijpers on 24/02/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

#import "SRKFile.h"

@interface SRKFileSGM : SRKFile

@property (readonly,copy) NSString *name;
@property (readonly,copy) NSString *author;
@property (readonly,copy) NSString *gameDescription;
@property (readonly,assign) NSSize screenSize;
@property (readonly,copy) NSString *mainScript;

@end
