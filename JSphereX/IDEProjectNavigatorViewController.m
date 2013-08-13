//
//  JSXProjectNavigatorViewController.m
//  JSphereX
//
//  Created by Jos Kuijpers on 8/10/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "IDEProjectNavigatorViewController.h"
#import "IDEProjectNavigatorItem.h"
#import "IDEProjectNavigatorFileItem.h"
#import "IDEProjectNavigatorRowView.h"

@interface IDEProjectNavigatorViewController ()
{
	IDEProjectNavigatorItem *_rootItem;
	NSArray *_itemsBeingDragged;
}
@end

@implementation IDEProjectNavigatorViewController

- (id)init
{
	self = [super initWithNibName:@"IDEProjectNavigatorView" bundle:nil];
	if(self) {
		_rootItem = [[IDEProjectNavigatorItem alloc] init];
		_rootItem.title = @"Project";
		_rootItem.type = JSXProjectNavigatorItemProject;
		_rootItem.image = [NSImage imageNamed:@"nl.jarvix.sphere.image.project"];
		
		IDEProjectNavigatorItem *item;
		for(int i = 0; i < 5; i++) {
			item = [[IDEProjectNavigatorFileItem alloc] init];
			item.url = [NSURL URLWithString:@"file:///Users/jos/Documents/Jarvix/Production/SplitViewProblemCase.zip"];

			[_rootItem.children addObject:item];
		}
		
		for(int i = 0; i < 2; i++) {
			item = [[IDEProjectNavigatorItem alloc] init];
			item.title = [NSString stringWithFormat:@"Group%d",i];
			item.type = JSXProjectNavigatorItemGroup;
			item.url = [NSURL URLWithString:[NSString stringWithFormat:@"mypr://%@",item.title]];
			item.image = [NSImage imageNamed:@"nl.jarvix.sphere.image.navgroup"];
			
			[_rootItem.children addObject:item];
		}
	}
	return self;
}

- (void)loadView
{
	[super loadView];
	
	_outlineView.dataSource = self;
	_outlineView.delegate = self;
	
	[_outlineView registerForDraggedTypes:@[(id)kUTTypeURL]];
	[_outlineView setDraggingSourceOperationMask:NSDragOperationEvery forLocal:NO];
}

#pragma mark - Data Source

- (NSInteger)outlineView:(NSOutlineView *)outlineView
  numberOfChildrenOfItem:(IDEProjectNavigatorItem *)item
{
	return (item == nil) ? 1 : item.children.count;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView
   isItemExpandable:(IDEProjectNavigatorItem *)item
{
	return (item == nil) ? YES : ![item isLeaf];
}

- (id)outlineView:(NSOutlineView *)outlineView
			child:(NSInteger)index
		   ofItem:(IDEProjectNavigatorItem *)item
{
	return (item == nil) ? _rootItem : item.children[index];
}

- (id)outlineView:(NSOutlineView *)outlineView
objectValueForTableColumn:(NSTableColumn *)tableColumn
		   byItem:(IDEProjectNavigatorItem *)item
{
	return item;
}

- (NSView *)outlineView:(NSOutlineView *)outlineView
	 viewForTableColumn:(NSTableColumn *)tableColumn
				   item:(IDEProjectNavigatorItem *)item
{
	if(item.isProject)
		return [outlineView makeViewWithIdentifier:@"ProjectCell"
											 owner:self];
	return [outlineView makeViewWithIdentifier:@"ItemCell"
								  owner:self];
}

#pragma mark - OutlineView Delegate

// TODO: get rid of this
- (CGFloat)outlineView:(NSOutlineView *)outlineView
	 heightOfRowByItem:(IDEProjectNavigatorItem *)item
{
	if(item.isProject)
		return 32.0f;
	return 18.0f;
}

- (void)outlineViewSelectionDidChange:(NSNotification *)notification
{
	if(_outlineView.selectedRowIndexes.count != 1)
		return;

	NSInteger row = _outlineView.selectedRow;
	IDEProjectNavigatorItem *item = [_outlineView itemAtRow:row];
	NSLog(@"Selected %@",item);
}

#pragma mark - Drag and Drop

- (id<NSPasteboardWriting>)outlineView:(NSOutlineView *)outlineView
			   pasteboardWriterForItem:(IDEProjectNavigatorItem *)item
{
	if(item.isProject)
		return nil;
	return item;
}

- (NSDragOperation)outlineView:(NSOutlineView *)outlineView
				  validateDrop:(id<NSDraggingInfo>)info
				  proposedItem:(IDEProjectNavigatorItem *)item
			proposedChildIndex:(NSInteger)index
{
	if(index == -1 || item == nil)
		return NSDragOperationNone;

	info.animatesToDestination = YES;
	
	return NSDragOperationMove;
}

- (void)outlineView:(NSOutlineView *)outlineView
	draggingSession:(NSDraggingSession *)session
   willBeginAtPoint:(NSPoint)screenPoint
		   forItems:(NSArray *)draggedItems
{
	_itemsBeingDragged = draggedItems;
}

- (void)_performDragReorderWithDragInfo:(id<NSDraggingInfo>)info
							 sourceItem:(IDEProjectNavigatorItem *)sourceItem
							   fromItem:(IDEProjectNavigatorItem *)fromItem
							  fromIndex:(NSInteger)fromIndex
								 toItem:(IDEProjectNavigatorItem *)toItem
								toIndex:(NSInteger)toIndex
{
	if(fromItem == toItem) {
		if(fromIndex < toIndex)
			toIndex--;
		
		if(fromIndex == toIndex)
			return;
	}
	
	[fromItem.children removeObject:sourceItem
							inRange:NSMakeRange(fromIndex, 1)];
	
	[toItem.children insertObject:sourceItem
						  atIndex:toIndex];
	
	[_outlineView moveItemAtIndex:fromIndex
						 inParent:fromItem
						  toIndex:toIndex
						 inParent:toItem];
}

- (BOOL)outlineView:(NSOutlineView *)outlineView
		 acceptDrop:(id<NSDraggingInfo>)info
			   item:(IDEProjectNavigatorItem *)toItem
		 childIndex:(NSInteger)toIndex
{
	__block NSInteger insertionIndex = toIndex;
	[_itemsBeingDragged enumerateObjectsUsingBlock:^(IDEProjectNavigatorItem *sourceItem, NSUInteger idx, BOOL *stop) {
		
		IDEProjectNavigatorItem *fromItem = [_outlineView parentForItem:sourceItem];
		NSInteger fromIndex = [fromItem.children indexOfObject:sourceItem];
		
		NSInteger actualIndex = insertionIndex;
		if(toIndex > fromIndex && fromItem == toItem) {
			actualIndex -= idx;
		}
		
		[self _performDragReorderWithDragInfo:info
								   sourceItem:sourceItem
									 fromItem:fromItem
									fromIndex:fromIndex
									   toItem:toItem
									  toIndex:actualIndex];
		
		insertionIndex++;
	}];
	
	return YES;
}

@end