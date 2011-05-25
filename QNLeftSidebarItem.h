//
//  SidebarItemObjectProxy.h
//  QuantumNoise
//
//  Created by jrk on 09.09.09.
//  Copyright 2009 flux forge. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface QNLeftSidebarItem : NSObject 
{
	NSString *title;
	NSString *type;
	id userData;
	
	NSMutableArray *childItems;
}
@property (copy,readwrite) NSString *title;
@property (copy, readwrite) NSString *type;
@property (retain,readwrite) id userData;
@property (readonly) NSArray *childItems;

//objectOrNil is a custom user data object
//a string, dictionary or something comepletly different :[c]><
- (id) initWithTitle: (NSString *) aTitle Type: (NSString *) aType andUserDataOrNil: (id) objectOrNil;
+ (id) leftSidebarItemWithTitle: (NSString *) aTitle andType: (NSString *) aType;

//adds a child item to the childItems array
//the hoff is a loving dad
- (void) addChildItem: (QNLeftSidebarItem *) item;

@end
