//
//  JSXProjectMetaData.m
//  JSphereX
//
//  Created by Jos Kuijpers on 8/7/13.
//  Copyright (c) 2013 Jarvix. All rights reserved.
//

#import "JSXFileMetaData.h"

NSString * const kJSXMetaDataFormatVersion = @"FormatVersion";
NSString * const kJSXMetaDataGameName = @"GameName";
NSString * const kJSXMetaDataGameDescription = @"GameDescription";
NSString * const kJSXMetaDataAuthor = @"Author";
NSString * const kJSXMetaDataGameScreenWidth = @"ScreenWidth";
NSString * const kJSXMetaDataGameScreenHeight = @"ScreenHeight";
NSString * const kJSXMetaDataMainScript = @"MainScript";

@interface JSXFileMetaData()
{
	NSMutableDictionary *_data;
}
@end

@implementation JSXFileMetaData

- (id)initWithFileData:(NSData *)fileData
{
	self = [super initWithFileData:nil];
	if(self) {
		_data = [NSPropertyListSerialization propertyListWithData:fileData
														 options:NSPropertyListMutableContainersAndLeaves
														  format:NULL
														   error:NULL];
		if(![_data isKindOfClass:[NSMutableDictionary class]])
			return nil;
	}
	return self;
}

- (NSData *)fileData
{
	return [NSPropertyListSerialization dataWithPropertyList:_data
													  format:NSPropertyListXMLFormat_v1_0
													 options:0
													   error:NULL];
}

@end
