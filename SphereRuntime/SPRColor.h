//
//  SPRColor.h
//  Sphere
//
//  Created by Jos Kuijpers on 07/03/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

@protocol SPRColor <JSExport>

@property (assign) uint8_t red;
@property (assign) uint8_t green;
@property (assign) uint8_t blue;
@property (assign) uint8_t alpha;

- (instancetype)init;

@end

@interface SPRColor : NSObject <SPRColor>

- (instancetype)initWithRed:(uint8_t)red
					  green:(uint8_t)green
					   blue:(uint8_t)blue;

- (instancetype)initWithRed:(uint8_t)red
					  green:(uint8_t)green
					   blue:(uint8_t)blue
					  alpha:(uint8_t)alpha;

- (instancetype)initWithNSColor:(NSColor *)color;

- (NSColor *)toNSColor;

@end
