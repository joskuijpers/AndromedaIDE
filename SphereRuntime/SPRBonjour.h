//
//  SPRBonjour.h
//  Sphere
//
//  Created by Jos Kuijpers on 08/03/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

#import "SPRJSClass.h"

@class SPRSocket;

@protocol SPRBonjour <JSExport>

- (instancetype)init;

// publish
//: name, type, domain, port
JSExportAs(publish,
- (BOOL)publishWithName:(NSString *)name
				   type:(NSString *)type
				   port:(uint16_t)port
			   inDomain:(NSString *)domain
);

// discover
//: type, domain => name (+ port?)
JSExportAs(discover,
- (void)discoverPeersWithType:(NSString *)type
		   domain:(NSString *)domain
		   callback:(void (^)(NSString *name))callback
);

// resolve -> toSocket
//: name => addr + port
JSExportAs(resolve,
- (SPRSocket *)resolvePeerWithName:(NSString *)name
);

@end

@interface SPRBonjour : NSObject <SPRBonjour, SPRJSClass>

@end
