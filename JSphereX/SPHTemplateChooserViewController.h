//
//  SPHTemplateChooserViewController.h
//  JSphereX
//
//  Created by Jos Kuijpers on 8/22/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SPHTemplateChooserViewController : NSViewController

@property (weak,nonatomic) IBOutlet NSOutlineView *navigator;
@property (weak,nonatomic) IBOutlet NSCollectionView *itemView;
@property (weak,nonatomic) IBOutlet NSView *detailView; // custom view

@property (strong) NSMutableArray *templates;

@end
