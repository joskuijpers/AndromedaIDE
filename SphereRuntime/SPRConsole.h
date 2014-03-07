//
//  SPRConsole.h
//  Sphere
//
//  Created by Jos Kuijpers on 23/02/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

@protocol SPRConsole <JSExport>

- (void)log:(NSString *)string;

@end

@interface SPRConsole : NSObject <SPRConsole>
@end
