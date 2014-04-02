/*
 * Copyright (c) 2014 Jos Kuijpers. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
 * USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "ADEProjectNavigatorViewController.h"
#import "ADEProjectNavigatorItem.h"
#import "ADEProjectNavigatorRowView.h"

#import "ADEProjectDocument.h"
#import "ACXProject.h"
#import "ACXGroup.h"
#import "ACXReference.h"

@interface ADEProjectNavigatorViewController ()
{
	ADEProjectNavigatorItem *_rootItem;
	NSArray *_itemsBeingDragged;
}
@end

@implementation ADEProjectNavigatorViewController

- (id)init
{
	self = [super initWithNibName:@"ADEProjectNavigatorView" bundle:nil];
	if(self) {
	}
	return self;
}

- (void)loadView
{
	[super loadView];

	dispatch_async(dispatch_get_main_queue(), ^{
		ADEProjectDocument *document = [self.view.window.windowController document];
		ACXProject *project = document.project;

		_rootItem = [ADEProjectNavigatorItem itemWithProject:project];

		[_outlineView reloadData];
	});

	_outlineView.dataSource = self;
	_outlineView.delegate = self;
	
	[_outlineView registerForDraggedTypes:@[(id)kUTTypeURL]];
	[_outlineView setDraggingSourceOperationMask:NSDragOperationEvery forLocal:NO];
}

#pragma mark - Data Source

- (NSInteger)outlineView:(NSOutlineView *)outlineView
  numberOfChildrenOfItem:(ADEProjectNavigatorItem *)item
{
	return (item == nil) ? 1 : item.children.count;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView
   isItemExpandable:(ADEProjectNavigatorItem *)item
{
	return (item == nil) ? YES : (item.type != ADEProjectNavigatorItemFile);
}

- (id)outlineView:(NSOutlineView *)outlineView
			child:(NSInteger)index
		   ofItem:(ADEProjectNavigatorItem *)item
{
	return (item == nil) ? _rootItem : item.children[index];
}

- (id)outlineView:(NSOutlineView *)outlineView
objectValueForTableColumn:(NSTableColumn *)tableColumn
		   byItem:(ADEProjectNavigatorItem *)item
{
	return item;
}

- (NSView *)outlineView:(NSOutlineView *)outlineView
	 viewForTableColumn:(NSTableColumn *)tableColumn
				   item:(ADEProjectNavigatorItem *)item
{
	if(item.type == ADEProjectNavigatorItemProject)
		return [outlineView makeViewWithIdentifier:@"ProjectCell"
											 owner:self];
	return [outlineView makeViewWithIdentifier:@"ItemCell"
								  owner:self];
}

#pragma mark - OutlineView Delegate

- (CGFloat)outlineView:(NSOutlineView *)outlineView
	 heightOfRowByItem:(ADEProjectNavigatorItem *)item
{
	if(item.type == ADEProjectNavigatorItemProject)
		return 32.0f;
	return 18.0f;
}

- (void)outlineViewSelectionDidChange:(NSNotification *)notification
{
	if(_outlineView.selectedRowIndexes.count != 1)
		return;

	NSInteger row = _outlineView.selectedRow;
	ADEProjectNavigatorItem *item = [_outlineView itemAtRow:row];
	NSLog(@"Selected %@",item);
}

#pragma mark - Control

- (void)reload
{
	NSLog(@"RELOAD");
}

- (void)reloadGroup:(ACXGroup *)group
{
	NSLog(@"RELOAD %@",group);
}

- (ACXGroup *)selectedGroup
{
//	return _rootItem.reference;
	return nil;
}

#pragma mark - Drag and Drop
/*
- (id<NSPasteboardWriting>)outlineView:(NSOutlineView *)outlineView
			   pasteboardWriterForItem:(ADEProjectNavigatorItem *)item
{
	if(item.isProject)
		return nil;
	return item;
}

- (NSDragOperation)outlineView:(NSOutlineView *)outlineView
				  validateDrop:(id<NSDraggingInfo>)info
				  proposedItem:(ADEProjectNavigatorItem *)item
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
							 sourceItem:(ADEProjectNavigatorItem *)sourceItem
							   fromItem:(ADEProjectNavigatorItem *)fromItem
							  fromIndex:(NSInteger)fromIndex
								 toItem:(ADEProjectNavigatorItem *)toItem
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
			   item:(ADEProjectNavigatorItem *)toItem
		 childIndex:(NSInteger)toIndex
{
	__block NSInteger insertionIndex = toIndex;
	[_itemsBeingDragged enumerateObjectsUsingBlock:^(ADEProjectNavigatorItem *sourceItem, NSUInteger idx, BOOL *stop) {
		
		ADEProjectNavigatorItem *fromItem = [_outlineView parentForItem:sourceItem];
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
}*/

@end