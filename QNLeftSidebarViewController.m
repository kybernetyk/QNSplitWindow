//
//  LeftSidebarViewController.m
//  QuantumNoise
//
//  Created by jrk on 08.09.09.
//  Copyright 2009 flux forge. All rights reserved.
//

#import "QNLeftSidebarViewController.h"
#import "QNLeftSidebarItem.h"

#import "QNImageAndTextCell.h"
#import "QNTypeDefinitions.h"

/*
 Private Categories
 
 */

@interface QNLeftSidebarViewController (ItemSelection)
- (void) addNodeAndItsChildren: (NSTreeNode *) theNode toMutableSet: (NSMutableSet *) theSet;
- (void) buildSelectedItemsList;
@end

@interface QNLeftSidebarViewController (InterfaceInteraction)
- (void) expandAllItems;
@end


/*
 Implementation
 
 */

@implementation QNLeftSidebarViewController
@synthesize iconCache;
@synthesize selectedItems;
@synthesize delegate;
@synthesize outlineView;

#pragma mark ctor and dtor
- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)nibBundle
{
	self = [super initWithNibName: nibName bundle: nibBundle];
	if (self)
	{
		[self setIconCache: [QNLeftSidebarViewController defaultImages]];
		
		//NSLog(@"outline view: %@",outlineView);
	}
	return self;
}

- (void) dealloc
{
	NSLog(@"LeftSidebarViewController dealloc");
	[contents release];
	contents = nil;
	
	[selectedItems release];
	selectedItems = nil;
	
	
	[keywordsFilteredBySelectedItems release];
	keywordsFilteredBySelectedItems = nil;
	
	[iconCache release];
	iconCache = nil;
	
	[super dealloc];
}

#pragma mark contents
// -------------------------------------------------------------------------------
//	setContents:newContents
// -------------------------------------------------------------------------------
- (void)setContents:(id)newContents
{
	if (contents != newContents)
	{
		[contents release];
		contents = [[NSArray alloc] initWithArray:newContents];
		
		NSLog(@"setting new contents: %@",newContents);
		
		[outlineView reloadData];
		
		//if the outline view seems only to show headers
		//do a expandAll!
		[self expandAllItems];
	}
}

// -------------------------------------------------------------------------------
//	contents:
// -------------------------------------------------------------------------------
- (NSArray *)contents
{
	return contents;
}

#pragma mark user selected items
//achtunk achtunk rekurstion
//adds a QNLeftSidebarItem and all its children to the given set
//uses recursion
- (void) addSidebarItemAndItsChildren: (QNLeftSidebarItem *) anItem toMutableSet: (NSMutableSet *) theSet
{
	for (id child in [anItem childItems])
	{
		[self addSidebarItemAndItsChildren: child toMutableSet: theSet];
		[theSet addObject: child];
	}
	[theSet addObject: anItem];
}

//called when the user selection changes
//iterates through the user selection
//and stores all selected QNLeftSidebarItems in a set 
//to avoid multiple selections of the same item. this happens if the user selects
//a folder _AND_ its children nodes. we want just one reference to each selected item
- (void) buildSelectedItemsList
{
	NSIndexSet *selections = [outlineView selectedRowIndexes];
	NSMutableSet *tempSet = [NSMutableSet set];
	
    NSUInteger index = [selections firstIndex];
	for (NSUInteger i = 0; i < [selections count]; i++)
	{
		id item = [outlineView itemAtRow: index];
		[self addSidebarItemAndItsChildren: item toMutableSet: tempSet];
		
		index = [selections indexGreaterThanIndex: index];
	}
	
	[selectedItems release];
	selectedItems = [[NSSet alloc] initWithSet: tempSet];
	
}

#pragma mark Interface Interaction
//expands all items in the outline view
- (void) expandAllItems
{
	//	NSLog(@"outline view: %@",outlineView);
	[outlineView expandItem: nil expandChildren: YES];
}


#pragma mark outlineView delegate 
- (void)outlineViewSelectionDidChange:(NSNotification *)notification
{
	[self buildSelectedItemsList];

	//message our delegate of the change
	if ([delegate respondsToSelector:@selector(leftSidebarViewController: selectedItemsChangedTo:)])
		[delegate leftSidebarViewController: self selectedItemsChangedTo: selectedItems];
	
}

- (BOOL)outlineView:(NSOutlineView *)outlineView shouldShowOutlineCellForItem:(id)item
{
	QNLeftSidebarItem *sidebarItem = item;// [item representedObject];
	if ([[sidebarItem type] isEqualToString: kQNHeaderType])
		return NO;
	
	return YES;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView shouldSelectItem:(id)item
{
	QNLeftSidebarItem *sidebarItem = item;//[item representedObject];
	if ([[sidebarItem type] isEqualToString: kQNHeaderType])
		return NO;
	
	return YES;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView shouldEditTableColumn:(NSTableColumn *)tableColumn item:(id)item
{
	QNLeftSidebarItem *sidebarItem = item;//[item representedObject];
	if ([[sidebarItem type] isEqualToString: kQNLeafType])
		return YES;
	
	return NO;
}

/*- (NSString *)outlineView:(NSOutlineView *)outlineView toolTipForCell:(NSCell *)cell rect:(NSRectPointer)rect tableColumn:(NSTableColumn *)tc item:(id)item mouseLocation:(NSPoint)mouseLocation
{
	NSDictionary *repObject = [item representedObject];
	return [repObject objectForKey:kQNTitleKey];
}*/

- (void)outlineView:(NSOutlineView *)outlineView willDisplayCell:(NSCell *)cell forTableColumn:(NSTableColumn *)tableColumn item:(id)item 
{    
	QNImageAndTextCell *laCell = (QNImageAndTextCell *)cell;
	QNLeftSidebarItem *sidebarItem = item;//[item representedObject];
	NSImage *img = [[self iconCache] objectForKey: [sidebarItem type]];

	
	
	[laCell setImage: img];
}


#pragma mark outlineView data source
- (int)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item
{
	//item == nil -> top level angefragt.
	//wir geben hier die anzahl unserer header nodes im view zurueck
	// == anzahl der items in [self contents]
	if (item == nil)
	{	
		return [[self contents] count];//[[self treeRepresentation] count];
	}
	
	//ansonsten geben wir die anzahl der kinder des items zurueck
	return [[item childItems] count];
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item
{
	//items ohne kinder sollten nicht expandable sein!
	if ([[item childItems] count] == 0)
		return NO;
	
	return YES;
}

- (id)outlineView:(NSOutlineView *)outlineView child:(int)index ofItem:(id)item
{
	//item == nil -> top level angefragt
	//wir zeigen einfach die header node mit dem passenden index an
	//diese steckt in [self contents]
	if (item == nil)
	{
		return [[self contents] objectAtIndex: index];
	}

	//ansonsten item zurueckgeben
	return [[item childItems] objectAtIndex: index];
}

- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item
{
	QNLeftSidebarItem *sidebarItem = item;
	return [sidebarItem title];
}

#pragma mark default images
+ (NSDictionary *) defaultImages
{
	NSMutableDictionary *tempDict = [NSMutableDictionary dictionary];
	NSImage *folderImage = [NSImage imageNamed:@"NSFolderSmart"];
	[folderImage setSize:NSMakeSize(16.0,16.0)];
	[tempDict setObject: folderImage forKey: kQNFolderType];

	NSImage *leafImage = [[NSWorkspace sharedWorkspace] iconForFileType:NSFileTypeForHFSTypeCode(kInternetLocationHTTPIcon)];
	[leafImage setSize:NSMakeSize(16.0,16.0)];
	[tempDict setObject: leafImage forKey: kQNLeafType];
	
	/*NSImage *headerImage = nil;
	[headerImage setSize:NSMakeSize(16.0,16.0)];
	[tempDict setObject: headerImage forKey: kQNHeaderType];*/
	
	return [NSDictionary dictionaryWithDictionary: tempDict];
}

#pragma mark dummy testing
+ (NSArray *) dummyContents
{
	QNLeftSidebarItem *root = [QNLeftSidebarItem leftSidebarItemWithTitle: @"header" andType: kQNHeaderType];
	QNLeftSidebarItem *item = [QNLeftSidebarItem leftSidebarItemWithTitle: @"lol" andType: kQNFolderType];
	QNLeftSidebarItem *item2 = [QNLeftSidebarItem leftSidebarItemWithTitle: @"rofl" andType: kQNLeafType];
	QNLeftSidebarItem *item3 = [QNLeftSidebarItem leftSidebarItemWithTitle: @"Omega" andType: kQNFolderType];
	
	[item addChildItem: item2];
	[item2 addChildItem: item3];
	[root addChildItem: item];
	
	
	QNLeftSidebarItem *root2 = [QNLeftSidebarItem leftSidebarItemWithTitle: @"header2" andType: kQNHeaderType];
	QNLeftSidebarItem *item_ = [QNLeftSidebarItem leftSidebarItemWithTitle: @"lol2" andType: kQNFolderType];
	QNLeftSidebarItem *item2_ = [QNLeftSidebarItem leftSidebarItemWithTitle: @"rofl2" andType: kQNLeafType];
	QNLeftSidebarItem *item3_ = [QNLeftSidebarItem leftSidebarItemWithTitle: @"Omega2" andType: kQNFolderType];
	
	[item_ addChildItem: item2_];
	[item2_ addChildItem: item3_];
	[root2 addChildItem: item_];
	
	
	return [NSArray arrayWithObjects: root,root2,nil];
	
}


@end
