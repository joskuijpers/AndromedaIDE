//
//  SPRBonjour.h
//  Sphere
//
//  Created by Jos Kuijpers on 08/03/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

#import "SPRJSClass.h"

@class SPRSocket;

@protocol SPRBonjour <L8Export>

- (instancetype)init;

// publish
//: name, type, domain, port
L8ExportAs(publish,
- (BOOL)publishWithName:(NSString *)name
				   type:(NSString *)type
				   port:(uint16_t)port
			   inDomain:(NSString *)domain
);

// discover
//: type, domain => name (+ port?)
L8ExportAs(discover,
- (void)discoverPeersWithType:(NSString *)type
		   domain:(NSString *)domain
		   callback:(void (^)(NSString *name))callback
);

// resolve -> toSocket
//: name => addr + port
L8ExportAs(resolve,
- (SPRSocket *)resolvePeerWithName:(NSString *)name
);

@end

@interface SPRBonjour : NSObject <SPRBonjour, SPRJSClass>

@end
