//
//  SPRSocket.h
//  Sphere
//
//  Created by Jos Kuijpers on 08/03/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

#import "SPRJSClass.h"

@class SPRByteArray;

@protocol SPRSocket <L8Export>

/// Whether the socket is (still) connected
@property (readonly,assign,getter=isConnected) BOOL connected;

- (instancetype)init;

// something with getPendingReadSize()

L8ExportAs(read,
- (SPRByteArray *)readBytes:(size_t)size
);

L8ExportAs(write,
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
