//
//  SPRImage.h
//  Sphere
//
//  Created by Jos Kuijpers on 23/02/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JSExport;
@protocol SPRImage <JSExport>

- (instancetype)initWithPath:(NSString *)path; // new Image('')

@end


@interface SPRImage : NSObject <SPRImage>

@end
