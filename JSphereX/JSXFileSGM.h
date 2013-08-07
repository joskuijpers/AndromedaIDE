//
//  JSXGameInfoFile.h
//  JSphereX
//
//  Created by Jos Kuijpers on 8/7/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSXFile.h"

@interface JSXFileSGM : JSXFile

@property (copy) NSString *author;
@property (copy) NSString *gameDescription;
@property (copy) NSString *name;
@property (copy) NSNumber *screenHeight;
@property (copy) NSNumber *screenWidth;
@property (copy) NSString *script;

- (NSSize)screenSize;

@end
