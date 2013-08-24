//
//  IDESheetController.m
//  JSphereX
//
//  Created by Jos Kuijpers on 8/23/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "IDESheetController.h"

@interface IDESheetController ()

@end

@implementation IDESheetController

- (IBAction)dismiss:(id)sender
{
	[NSApp endSheet:self.window
		 returnCode:NSOKButton];
}

- (IBAction)cancel:(id)sender
{
	[NSApp endSheet:self.window
		 returnCode:NSCancelButton];
}

@end
