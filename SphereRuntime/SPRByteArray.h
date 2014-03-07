//
//  SPRByteArray.h
//  Sphere
//
//  Created by Jos Kuijpers on 07/03/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SPRByteArray;

@protocol SPRByteArray <JSExport>

- (instancetype)init;

JSExportAs(concat,
- (SPRByteArray *)byteArrayByAppendingByteArray:(SPRByteArray *)byteArray
);

JSExportAs(slice,
- (SPRByteArray *)subArrayWithStart:(size_t)start end:(size_t)end
);

- (size_t)size;
- (NSString *)makeString;
- (NSString *)md5hash;

@end

@interface SPRByteArray : NSObject <SPRByteArray>

@end
