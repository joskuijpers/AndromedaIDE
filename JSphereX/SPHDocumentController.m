//
//  SPHDocumentController.m
//  JSphereX
//
//  Created by Jos Kuijpers on 8/23/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "SPHDocumentController.h"

@implementation SPHDocumentController

- (void)openDocument:(id)sender
{
	[super openDocument:sender];
	NSLog(@"%@ %@",NSStringFromSelector(_cmd),sender);
}

- (id)openUntitledDocumentAndDisplay:(BOOL)displayDocument
							   error:(NSError *__autoreleasing *)outError
{
	NSLog(@"%@ %d",NSStringFromSelector(_cmd),displayDocument);
	id x = [super openUntitledDocumentAndDisplay:displayDocument error:outError];
	NSLog(@"%@",x);
	return x;
}

@end
