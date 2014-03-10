//
//  SPRConsole.h
//  Sphere
//
//  Created by Jos Kuijpers on 23/02/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

@protocol SPRConsole <L8Export>

/**
 * Prints to stdout with newline. Uses a printf-like format,
 * unless no format string can be found as first argument.
 * Then all arguments are just printed.
 *
 * @param string Format string
 */
- (void)log:(NSString *)string;

/**
 * Prints to stderr with newline. Uses a printf-like format,
 * unless no format string can be found as first argument.
 * Then all arguments are just printed.
 *
 * @param string Format string
 */
- (void)error:(NSString *)string;

@end

@interface SPRConsole : NSObject <SPRConsole>
@end
