//
//  SPRModule.h
//  Sphere
//
//  Created by Jos Kuijpers on 08/03/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

#import "SPRJSClass.h"

@protocol SPRModule <L8Export>

@end

@interface SPRModule : NSObject <SPRModule, SPRJSClass>

@end
