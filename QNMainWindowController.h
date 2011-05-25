//
//  MainWindowController.h
//  QuantumNoise
//
//  Created by jrk on 08.09.09.
//  Copyright 2009 flux forge. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "QNLeftSidebarViewController.h"

@interface QNMainWindowController : NSWindowController 
{
	IBOutlet NSView *leftSidebarView;
	QNLeftSidebarViewController *leftSidebarViewController;

}

- (IBAction) doShit: (id) sender;

@end
