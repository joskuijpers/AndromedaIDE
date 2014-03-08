//
//  SPRSocket.h
//  Sphere
//
//  Created by Jos Kuijpers on 08/03/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

#import "SPRJSClass.h"

@class SPRByteArray;

@protocol SPRSocket <JSExport>

/// Whether the socket is (still) connected
@property (readonly,assign,getter=isConnected) BOOL connected;

- (instancetype)init;

// something with getPendingReadSize()

JSExportAs(read,
- (SPRByteArray *)readBytes:(size_t)size
);

JSExportAs(write,
- (void)writeByteArray:(SPRByteArray *)byteArray
);

/**
 * Closes current connection
 */
- (void)close;

@end

@interface SPRSocket : NSObject <SPRSocket, SPRJSClass>

- (instancetype)initWithAddress:(NSString *)address
						   port:(uint16_t)port;

- (instancetype)initWithService:(NSNetService *)service;

@end
