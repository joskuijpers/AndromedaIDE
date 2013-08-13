//
//  JSXFile.h
//  JSphereX
//
//  Created by Jos Kuijpers on 8/7/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDEFile : NSObject

- (id)initWithFileData:(NSData *)data;
- (NSData *)fileData;

@end
