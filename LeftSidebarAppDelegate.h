//
//  QuantumNoiseAppDelegate.h
//  QuantumNoise
//
//  Created by jrk on 08.09.09.
//  Copyright 2009 flux forge. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "QNMainWindowController.h"

@interface LeftSidebarAppDelegate : NSObject <NSApplicationDelegate> 
{
    NSWindow *window;
	QNMainWindowController *mainWindowController;
}

@property (assign) IBOutlet NSWindow *window;


- (IBAction) showMainWindow: (id) sender;

@end
