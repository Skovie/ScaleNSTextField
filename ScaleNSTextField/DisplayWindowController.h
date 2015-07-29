//
//  DisplayWindowController.h
//  ConferenceWatch
//
//  Created by Rene Skov on 28/07/15.

//  Free for personal or commercial use, with or without modification.
//  No warranty is expressed or implied.

#import <Cocoa/Cocoa.h>

@interface DisplayWindowController : NSWindowController{

    
    NSRect frameForNonFullScreenMode;
}

@property (assign) NSRect frameForNonFullScreenMode;


@end
