//
//  SPRNetwork.h
//  Sphere
//
//  Created by Jos Kuijpers on 08/03/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

#import "SPRJSClass.h"

@protocol SPRNetwork <JSExport>

// Properties:
// + NSString *localName
// + NSString *localAddress

JSExportAs(listen,
+ (BOOL)listenOnPort:(uint16_t)port
);

@end

@interface SPRNetwork : NSObject <SPRNetwork, SPRJSClass>

+ (NSString *)localName;
+ (NSString *)localAddress;

@end
