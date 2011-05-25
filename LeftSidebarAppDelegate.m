//
//  QuantumNoiseAppDelegate.m
//  QuantumNoise
//
//  Created by jrk on 08.09.09.
//  Copyright 2009 flux forge. All rights reserved.
//

#import "LeftSidebarAppDelegate.h"
#import "QNMainWindowController.h"

@implementation LeftSidebarAppDelegate

@synthesize window;

- (IBAction) showMainWindow: (id) sender
{
	if (!mainWindowController)
		mainWindowController = [[QNMainWindowController alloc] initWithWindowNibName:@"MainWindow"];	
	
	[mainWindowController showWindow: self];
	//[mainWindow makeKeyAndOrderFront:self];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification 
{
	// Insert code here to initialize your application 
	mainWindowController = [[QNMainWindowController alloc] initWithWindowNibName:@"MainWindow"];
	
	
	[[mainWindowController window] center];
	[[mainWindowController window] makeKeyAndOrderFront: self];
//	[mainWindowController showWindow: self];

	
	/*NSLog(@"/*\n\
		  *                                       ` `-/osyyyhdddhhhhs+-`                                       \n\
		  *                                     `/shdmmmmmmmdhddhddhhdhy/:`                                    \n\
		  *                                  `.+hdmmmmdddhhdmmmdddddhhhhhhs.                                   \n\
		  *                                 -sdhddmmddddddmdhdddhdddhhhdhhhyys-                                \n\
		  *                               -smdhhhhddddhhdddhdddddddyssyddddhhyso-                              \n\
		  *                              +hhhmmmdmddhyddhhhydhhddhyhyyyhddddddhhh:                             \n\
		  *                             :hddmmmmmdhhyyhddyhdmddhhssyyshhhyhdddddhdy.                           \n\
		  *                            `hmmmddddmdddhhhhdhddhhhhyshyyhhdhyydmmdddddy                           \n\
		  *                            `ymmddhhhhyhhhhddddmdhyyyyhddhddddhyhhdddddhho                          \n\
		  *                            `ymmmmmhyddyyhhhddddhdhhdddhhhhhhhhyyyhhhddhhs                          \n\
		  *                             +ddmmdyyddhyyyyyyhhhdhhhyyysoosyyyyyyyhhhhhhs                          \n\
		  *                             yhyddhhhyhhys+/:///osooo++//++ossyhhhdhhhhhh/                          \n\
		  *                             :dddyso+/++/:---..-:::::::://+syhhdhdhhddhhh/                          \n\
		  *                              ydyo//::-----....------:::+oshddddddhhhhhhy`                          \n\
		  *                              /do/:::----.......------::+oyhhddhhhhysooh/                           \n\
		  *                              .hs+/:--------......----:://++shhhhyo:/:+h-                           \n\
		  *                               .yyso+/:----:::://++/////////oyhho+--::sh.                           \n\
		  *                                +oo:+oo+///++oso+oso++++/://oyho-:--:/hs                            \n\
		  *                                +:///:://:::::/-:/:::::-:://oys/-:--/yo`                            \n\
		  *                                +::---:/:-:--.--:-------::+++++/:-:oyhy-`                           \n\
		  *            `                   +:::--//--:--------..--://+//++++ohhhhdds+/-.`                      \n\
		  *         `--::`                 /+/////:------:---.---://///+osyhhddhhddhhhyy+/-.`                  \n\
		  *         -:--//                 `+oo++/---:://:://::://///++osyysyhshdddddddhhhhhhs+-`` `...        \n\
		  *         -/---/.                 -s//+oo+oo//:::://///+//++osyhssyyoddddddddddddddddhys+:-.::-.`````\n\
		  *         `/:::/.               :yddy/:oo++/////+o+//:/+++oosydyssys+ddddddddddddddddddho---:yyyyyso:\n\
		  *          //:/+/            `-hmmmmmh:/+///:--:::--:/+++osyhdysssso+dmdddddddddddmmmdddo:--:ohhhhdd+\n\
		  *         `//:/+/          `/ymNNNmmdho:++++////:--:/+++oshddsoosso+ymmdddddddddmmmmmmddy+:-:/hhddddo\n\
		  *        .::-::/+.       .odmNNNNNmdddy::////::---:/++oyhdhsoooooo+sdmmdddmdddmmmmmmmmmddy+/:/+yddddo\n\
		  *    `-/++++/-://o`    -ydmNNNNNNmdmmmdo////:----/+oshddhso+++ooo+odmmmmhhdddmmmmmmmmmmddh+/:::/yhhdo\n\
		  *   ./o+++/+o:::/+: `/ymNNNNNNNNdddmmmdyso+++++osyddmmdyoo+++oooyodmmmmdhhdmddmdmmmmmmmddo:::::/+oyho\n\
		  *  `-//+s/::oo/:/oyyddddNNNNNNmmmmmNmhyydmdhhhdmmmmmdhsoo+++ooydsymmmmmmddmmmmmmmmmmmddhs/:///:/+/+y+\n\
		  * `:----+ssshs:---/oydmmNNNNNmmmmNNmddhydmmNmmmmmmmyo+++oooosdmhommmmmmddmdmmmmmmddddhyyo-:/++/+o+/o+\n\
		  * `/:::::/shdy/----+osmmNNNNNmmmmmdhdmNdmmNNNNmmNNmhs+++syhmmmmodmmmmmmmmmdmmmmmddy/---::+oyyyss+::++\n\
		  * `////:::/+o+////oyydmNNNNmNmNNdhdmNNNNmNNNNNyhNNNNmmmmmNNNmmshmmddmmmmmdhdmmmmddo-..---ohhyo/----++\n\
		  * `/:-------------/dmNNNNNNmmmmmmmNNMMMNmNNmNNmsmNNNNNNNNNNmmyymmdmmdmmdhmdddmdmmdyo/:::-:oo:-----:o+\n\
		  * `s+///:::/:/:::/ommNNNNMNNNMNNNNMMMMMNmNNNNNNydNNNNNNNNmmNNmmdmmhdmddhmmdddddmmdds::::://-----::/o+\n\
		  * `ss:::::::::::+ymmNNNNMMMNNNMMMMMMMMMmNNNNNNNmymNNNNNNdNMMMMmmmmyhdhmdmdhhhddmddho-.---:------..-/+\n\
		  *-shs+/:::::::::+dmNNNNMMMMNNNMMMMMMMMMNNNNNNNNNhdNNNNNNNMMMNNmmmmhhhmdmNmmmmmd+///+o+++++//::::::/so\n\
		  *dhsoshysoossyydmNNNMMMMMMMNNNNMMMMMMMMNNNNmNNNNmhmNNNNNNNMMNMmdNmddhdNmNmmmmmmhs+::-:------------oyo\n\
		  *dyoooymmmmmmNNNNNNNMMMMMMMNNMMMNNMMMNNNNNNNNNNNNdymNNNNmyNNdNdNNmyNdmNmmdhddmNNmdhso+/::::-----:/yhs\n\
		  *dso+++osymMNMMNMMMMMMMMMMMMMMMMMMMNmdNNNmNNNNNNNNydNNmmymNNNNhNNNdNNNNNNmdNNNNMMNNNNNNmmdyyyssyhdmms\n\
		  *ds++++++yNMMMMMMMMMMMMMMMMMMMMMMNdmdmNNNNNNNNNNNNNsdNmhmNNNNmdNNmdMNNNmNNNNNmNNNmNNMNNNMMMNNNNNNNNNd\n\
		  *hs++++sdNNMMMMMMNNNMMMMMMMMMMNNMNmmmMNNNNNNNNNNNNNmsdhmNNNNmdhNmhdNNNNNNNmNNdmNNNNNMMMMMMMNMMMMMMMMd\n\
		  *ysosydmNMMMMMMMNdhmNMMMNNmmdmNNNmmmNNNNNNNNNNNNNNmmy+dmNNNNNmmdmdmNNMMNmNmmmmdmNNNNMMMMMMMMMMMMMMMMd\n\
		  *shdmNNNMMMMMMMMMNddddhhhhmmmmNNmmdmMNMNNNNNNNNNmNmo...+mmNNNNmNmNNNMMMNNNNmmmmdmNNNmNNNmdNNNhhNMMMMm\n\
		  *///");
}

@end
