//
//  JSXProjectNavigatorController.m
//  JSphereX
//
//  Created by Jos Kuijpers on 8/8/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "JSXProjectNavigatorController.h"
#import "JSXProjectNavigatorItem.h"

@interface JSXProjectNavigatorController()

@end

@implementation JSXProjectNavigatorController

- (id)init
{
    self = [super init];
    if (self) {
        _items = [@[] mutableCopy];

		JSXProjectNavigatorItem *item, *subItem;

		for(int i = 0; i < 5; i++) {
			item = [[JSXProjectNavigatorItem alloc] init];
			item.title = @"test";
			item.subTitle = @"hehe";
			item.image = [NSImage imageNamed:@"ProjectIcon"];
			item.type = JSXProjectNavigatorItemProject;
			[_items addObject:item];
			
			if(i == 4) {
				subItem = [[JSXProjectNavigatorItem alloc] init];
				subItem.title = @"tesSSt";
				subItem.image = [NSImage imageNamed:@"ProjectIcon"];
				subItem.type = JSXProjectNavigatorItemFile;
				[item.children addObject:subItem];
			}
		}
		
		
    }
    return self;
}

- (void)awakeFromNib
{
	[super awakeFromNib];
}

- (NSView *)outlineView:(NSOutlineView *)outlineView
	 viewForTableColumn:(NSTableColumn *)tableColumn
				   item:(NSTreeNode *)node
{
	if([node.representedObject isProject]) {
		return [outlineView makeViewWithIdentifier:@"ProjectCell"
											 owner:self];
	}
	return [outlineView makeViewWithIdentifier:@"DataCell"
										 owner:self];
}

- (CGFloat)outlineView:(NSOutlineView *)outlineView
	 heightOfRowByItem:(NSTreeNode *)node
{
	if([node.representedObject isProject])
		return 32.0f;
	return 18.0f;
}

@end
