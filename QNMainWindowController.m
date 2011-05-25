//
//  MainWindowController.m
//  QuantumNoise
//
//  Created by jrk on 08.09.09.
//  Copyright 2009 flux forge. All rights reserved.
//

#import "QNMainWindowController.h"
#import "QNLeftSidebarItem.h"
#import "QNTypeDefinitions.h"

@implementation QNMainWindowController
#define kMinOutlineViewSplit	100.0f

#pragma mark ctor/dtor
- (id)initWithWindow:(NSWindow *)window
{
	self = [super initWithWindow: window];
	if (self)
	{	

	}
	return self;
}

- (void) dealloc
{
	NSLog(@"MainWindowController dealloc");
	
	[leftSidebarViewController release];
	leftSidebarViewController = nil;
	

	[super dealloc];
}


#pragma mark window delegate 
- (void)windowWillClose:(NSNotification *)notification
{
	NSLog(@"window will klose");
//	[self autorelease];
}
- (void)windowWillLoad
{

}

- (IBAction) doShit: (id) sender
{
	NSArray *myDatasource = [QNLeftSidebarViewController dummyContents];
	[leftSidebarViewController setContents: myDatasource];
}

- (NSArray *) buildDatasource
{
	QNLeftSidebarItem *root = [QNLeftSidebarItem leftSidebarItemWithTitle: @"aktive downloads" andType: kQNFolderType];
	QNLeftSidebarItem *item = [QNLeftSidebarItem leftSidebarItemWithTitle: @"download 1" andType: kQNLeafType];
	QNLeftSidebarItem *item2 = [QNLeftSidebarItem leftSidebarItemWithTitle: @"download 2" andType: kQNLeafType];
	
	[root addChildItem: item];
	[root addChildItem: item2];
	
	QNLeftSidebarItem *trennNutte = [QNLeftSidebarItem leftSidebarItemWithTitle:@"\n" andType:kQNHeaderType];
	

	QNLeftSidebarItem *root2 = [QNLeftSidebarItem leftSidebarItemWithTitle: @"pferdige downloads\n" andType: kQNFolderType];
	QNLeftSidebarItem *item3 = [QNLeftSidebarItem leftSidebarItemWithTitle: @"ponyhof dvd" andType: kQNLeafType];
	QNLeftSidebarItem *item4 = [QNLeftSidebarItem leftSidebarItemWithTitle: @"lolcats blueray rip" andType: kQNLeafType];
	
	[root2 addChildItem: item3];
	[root2 addChildItem: item4];
	
	
	
	return [NSArray arrayWithObjects:root,trennNutte,root2,nil];
}


- (void)windowDidLoad
{
	NSString *title =  [NSString stringWithFormat: @"%@ %@ (Build %@)",
						[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"], 
						[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"],
						[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]];
	
//	NSLog(@"%@",title);
	
	[[self window] setTitle: title];
	
	
	leftSidebarViewController = [[QNLeftSidebarViewController alloc] initWithNibName:@"LeftSidebarView" bundle: nil];
	[leftSidebarViewController setDelegate: self];
	[leftSidebarView addSubview: [leftSidebarViewController view]];
	[[leftSidebarViewController view] setFrame: [leftSidebarView bounds]];

	NSArray *myDatasource = [self buildDatasource];
	[leftSidebarViewController setContents: myDatasource];
	//[leftSidebarViewController expandAllItems];
	

}

#pragma mark Left Sidebar View Controller Delegate
//[delegate leftSidebarViewController: self selectedItemsChangedTo: selectedItems];

- (void) leftSidebarViewController: (QNLeftSidebarViewController *) aController selectedItemsChangedTo: (NSSet *) selectedItems
{
	NSLog(@"OMG SELECTION CHANGED TO: %@",selectedItems);
}


#pragma mark - Split View Delegate
// -------------------------------------------------------------------------------
//	splitView:constrainMinCoordinate:
//
//	What you really have to do to set the minimum size of both subviews to kMinOutlineViewSplit points.
// -------------------------------------------------------------------------------
- (CGFloat)splitView:(NSSplitView *)splitView constrainMinCoordinate:(CGFloat)proposedMin ofSubviewAt:(NSInteger)dividerIndex
{
	return proposedMin + kMinOutlineViewSplit;
}

// -------------------------------------------------------------------------------
//	splitView:constrainMaxCoordinate:
// -------------------------------------------------------------------------------
- (CGFloat)splitView:(NSSplitView *)splitView constrainMaxCoordinate:(CGFloat)proposedMax ofSubviewAt:(NSInteger)dividerIndex
{
	return proposedMax - kMinOutlineViewSplit*4;
}

// -------------------------------------------------------------------------------
//	splitView:resizeSubviewsWithOldSize:
//
//	Keep the left split pane from resizing as the user moves the divider line.
// -------------------------------------------------------------------------------
- (void)splitView:(NSSplitView *)splitView resizeSubviewsWithOldSize:(NSSize)oldSize
{
	if ([splitView isVertical])
	{
		NSRect newFrame = [splitView frame]; // get the new size of the whole splitView
		NSView *left = [[splitView subviews] objectAtIndex:0];
		NSRect leftFrame = [left frame];
		NSView *right = [[splitView subviews] objectAtIndex:1];
		NSRect rightFrame = [right frame];
		
		CGFloat dividerThickness = [splitView dividerThickness];
		
		leftFrame.size.height = newFrame.size.height;
		
		rightFrame.size.width = newFrame.size.width - leftFrame.size.width - dividerThickness;
		rightFrame.size.height = newFrame.size.height;
		rightFrame.origin.x = leftFrame.size.width + dividerThickness;
		
		[left setFrame:leftFrame];
		[right setFrame:rightFrame];
	}
/*	else
	{	
		//[splitView adjustSubviews];
		//return;
		
		NSRect newFrame = [splitView frame]; // get the new size of the whole splitView
		NSView *top = [[splitView subviews] objectAtIndex:0];
		NSRect topFrame = [top frame];
		
		NSView *bottom = [[splitView subviews] objectAtIndex:1];
		NSRect bottomFrame = [bottom frame];
		
		CGFloat dividerThickness = [splitView dividerThickness];
		
		topFrame.size.width = newFrame.size.width;
		
		bottomFrame.size.height = newFrame.size.height - topFrame.size.height - dividerThickness;
		bottomFrame.size.width = newFrame.size.width;
		bottomFrame.origin.y = topFrame.size.height + dividerThickness;
		
		[top setFrame:topFrame];
		[bottom setFrame:bottomFrame];
	}*/
}

@end
