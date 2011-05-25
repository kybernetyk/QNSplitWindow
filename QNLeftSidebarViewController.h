//
//  LeftSidebarViewController.h
//  QuantumNoise
//
//  Created by jrk on 08.09.09.
//  Copyright 2009 flux forge. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface QNLeftSidebarViewController : NSViewController
{
//@public
	NSArray						*contents; //array of LeftSidebaritems
	NSSet						*selectedItems; //set of QNLeftSidebarItem
	NSArray						*keywordsFilteredBySelectedItems; //array of QNKeyword
	id							delegate;
	
//@protected
	NSDictionary				*iconCache; //dictionary with objects: NSImage forkeys: [QNLeftSidebarItem type] (NSString)
	IBOutlet NSOutlineView		*outlineView;
}

//expects an ns dictionary with:
//key = LeftSidebarItem type
//value = NSImage *
@property (readwrite, retain) NSDictionary *iconCache;

//set with selected QNLeftSidebarItems
@property (readonly) NSSet *selectedItems;

//the delegate for this controller
@property (readwrite, assign) id delegate;
//our outline view
@property (readonly) IBOutlet NSOutlineView *outlineView;


//sets the contents
//array of LeftSidebarItems
//the controller will build a tree representation from this
- (void)setContents:(NSArray*)newContents;
- (NSArray*)contents;

//returns a default collection of images
//for standard node types
+ (NSDictionary *) defaultImages;

//returns a dummy array of sidebar items
//for testing
+ (NSArray *) dummyContents;


@end
