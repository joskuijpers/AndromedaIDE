//
//  SPRModule.h
//  Sphere
//
//  Created by Jos Kuijpers on 08/03/14.
//  Copyright (c) 2014 Jarvix. All rights reserved.
//

#import "SPRJSClass.h"

@protocol SPRNativeModule <JSExport>

@property (readonly,strong) NSString *filename;
@property (readonly,strong) NSString *identifier;
@property (readonly,assign) BOOL loaded;
@property (readonly,strong) NSMutableDictionary *exports;

JSExportAs(require,
+ (id)requireWithIdentifier:(NSString *)identifier
);

@end

@interface SPRNativeModule : NSObject <SPRNativeModule, SPRJSClass>

@end
