/*
 *  TypeDefinitions.h
 *  QuantumNoise
 *
 *  Created by jrk on 09.09.09.
 *  Copyright 2009 flux forge. All rights reserved.
 *
 */

#define kQNHeaderType @"header"
#define kQNFolderType @"folder"
#define kQNLeafType @"leaf"

/*

 *                                       ` `-/osyyyhdddhhhhs+-`                                       
 *                                     `/shdmmmmmmmdhddhddhhdhy/:`                                    
 *                                  `.+hdmmmmdddhhdmmmdddddhhhhhhs.                                   
 *                                 -sdhddmmddddddmdhdddhdddhhhdhhhyys-                                
 *                               -smdhhhhddddhhdddhdddddddyssyddddhhyso-                              
 *                              +hhhmmmdmddhyddhhhydhhddhyhyyyhddddddhhh:                             
 *                             :hddmmmmmdhhyyhddyhdmddhhssyyshhhyhdddddhdy.                           
 *                            `hmmmddddmdddhhhhdhddhhhhyshyyhhdhyydmmdddddy                           
 *                            `ymmddhhhhyhhhhddddmdhyyyyhddhddddhyhhdddddhho                          
 *                            `ymmmmmhyddyyhhhddddhdhhdddhhhhhhhhyyyhhhddhhs                          
 *                             +ddmmdyyddhyyyyyyhhhdhhhyyysoosyyyyyyyhhhhhhs                          
 *                             yhyddhhhyhhys+/:///osooo++//++ossyhhhdhhhhhh/                          
 *                             :dddyso+/++/:---..-:::::::://+syhhdhdhhddhhh/                          
 *                              ydyo//::-----....------:::+oshddddddhhhhhhy`                          
 *                              /do/:::----.......------::+oyhhddhhhhysooh/                           
 *                              .hs+/:--------......----:://++shhhhyo:/:+h-                           
 *                               .yyso+/:----:::://++/////////oyhho+--::sh.                           
 *                                +oo:+oo+///++oso+oso++++/://oyho-:--:/hs                            
 *                                +:///:://:::::/-:/:::::-:://oys/-:--/yo`                            
 *                                +::---:/:-:--.--:-------::+++++/:-:oyhy-`                           
 *            `                   +:::--//--:--------..--://+//++++ohhhhdds+/-.`                      
 *         `--::`                 /+/////:------:---.---://///+osyhhddhhddhhhyy+/-.`                  
 *         -:--//                 `+oo++/---:://:://::://///++osyysyhshdddddddhhhhhhs+-`` `...        
 *         -/---/.                 -s//+oo+oo//:::://///+//++osyhssyyoddddddddddddddddhys+:-.::-.`````
 *         `/:::/.               :yddy/:oo++/////+o+//:/+++oosydyssys+ddddddddddddddddddho---:yyyyyso:
 *          //:/+/            `-hmmmmmh:/+///:--:::--:/+++osyhdysssso+dmdddddddddddmmmdddo:--:ohhhhdd+
 *         `//:/+/          `/ymNNNmmdho:++++////:--:/+++oshddsoosso+ymmdddddddddmmmmmmddy+:-:/hhddddo
 *        .::-::/+.       .odmNNNNNmdddy::////::---:/++oyhdhsoooooo+sdmmdddmdddmmmmmmmmmddy+/:/+yddddo
 *    `-/++++/-://o`    -ydmNNNNNNmdmmmdo////:----/+oshddhso+++ooo+odmmmmhhdddmmmmmmmmmmddh+/:::/yhhdo
 *   ./o+++/+o:::/+: `/ymNNNNNNNNdddmmmdyso+++++osyddmmdyoo+++oooyodmmmmdhhdmddmdmmmmmmmddo:::::/+oyho
 *  `-//+s/::oo/:/oyyddddNNNNNNmmmmmNmhyydmdhhhdmmmmmdhsoo+++ooydsymmmmmmddmmmmmmmmmmmddhs/:///:/+/+y+
 * `:----+ssshs:---/oydmmNNNNNmmmmNNmddhydmmNmmmmmmmyo+++oooosdmhommmmmmddmdmmmmmmddddhyyo-:/++/+o+/o+
 * `/:::::/shdy/----+osmmNNNNNmmmmmdhdmNdmmNNNNmmNNmhs+++syhmmmmodmmmmmmmmmdmmmmmddy/---::+oyyyss+::++
 * `////:::/+o+////oyydmNNNNmNmNNdhdmNNNNmNNNNNyhNNNNmmmmmNNNmmshmmddmmmmmdhdmmmmddo-..---ohhyo/----++
 * `/:-------------/dmNNNNNNmmmmmmmNNMMMNmNNmNNmsmNNNNNNNNNNmmyymmdmmdmmdhmdddmdmmdyo/:::-:oo:-----:o+
 * `s+///:::/:/:::/ommNNNNMNNNMNNNNMMMMMNmNNNNNNydNNNNNNNNmmNNmmdmmhdmddhmmdddddmmdds::::://-----::/o+
 * `ss:::::::::::+ymmNNNNMMMNNNMMMMMMMMMmNNNNNNNmymNNNNNNdNMMMMmmmmyhdhmdmdhhhddmddho-.---:------..-/+
 *-shs+/:::::::::+dmNNNNMMMMNNNMMMMMMMMMNNNNNNNNNhdNNNNNNNMMMNNmmmmhhhmdmNmmmmmd+///+o+++++//::::::/so
 *dhsoshysoossyydmNNNMMMMMMMNNNNMMMMMMMMNNNNmNNNNmhmNNNNNNNMMNMmdNmddhdNmNmmmmmmhs+::-:------------oyo
 *dyoooymmmmmmNNNNNNNMMMMMMMNNMMMNNMMMNNNNNNNNNNNNdymNNNNmyNNdNdNNmyNdmNmmdhddmNNmdhso+/::::-----:/yhs
 *dso+++osymMNMMNMMMMMMMMMMMMMMMMMMMNmdNNNmNNNNNNNNydNNmmymNNNNhNNNdNNNNNNmdNNNNMMNNNNNNmmdyyyssyhdmms
 *ds++++++yNMMMMMMMMMMMMMMMMMMMMMMNdmdmNNNNNNNNNNNNNsdNmhmNNNNmdNNmdMNNNmNNNNNmNNNmNNMNNNMMMNNNNNNNNNd
 *hs++++sdNNMMMMMMNNNMMMMMMMMMMNNMNmmmMNNNNNNNNNNNNNmsdhmNNNNmdhNmhdNNNNNNNmNNdmNNNNNMMMMMMMNMMMMMMMMd
 *ysosydmNMMMMMMMNdhmNMMMNNmmdmNNNmmmNNNNNNNNNNNNNNmmy+dmNNNNNmmdmdmNNMMNmNmmmmdmNNNNMMMMMMMMMMMMMMMMd
 *shdmNNNMMMMMMMMMNddddhhhhmmmmNNmmdmMNMNNNNNNNNNmNmo...+mmNNNNmNmNNNMMMNNNNmmmmdmNNNmNNNmdNNNhhNMMMMm
*/