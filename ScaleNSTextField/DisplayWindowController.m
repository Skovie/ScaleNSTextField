//
//  DisplayWindowController.m
//  ConferenceWatch
//
//  Created by Rene Skov on 28/07/15.

//  Free for personal or commercial use, with or without modification.
//  No warranty is expressed or implied.

#import "DisplayWindowController.h"

@interface DisplayWindowController ()

@end

@implementation DisplayWindowController
@synthesize frameForNonFullScreenMode;

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    
    // listen for these notifications so we can update our image based on the full-screen state
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(willEnterFull:)
                                                 name:NSWindowWillEnterFullScreenNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(willExitFull:)
                                                 name:NSWindowWillExitFullScreenNotification
                                               object:nil];

}


// -------------------------------------------------------------------------------
//	dealloc
// -------------------------------------------------------------------------------
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:NSWindowWillEnterFullScreenNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:NSWindowDidExitFullScreenNotification
                                                  object:nil];
  
}


// -------------------------------------------------------------------------------
//	didEnterFull:notif
// -------------------------------------------------------------------------------
- (void)willExitFull:(NSNotification *)notif
{
    // our window "exited" full screen mode
    NSLog(@" ude af full screen ");
    [[NSNotificationCenter defaultCenter]postNotificationName:@"exitedFullScreen" object:nil];
}

// -------------------------------------------------------------------------------
//	willEnterFull:notif
// -------------------------------------------------------------------------------
- (void)willEnterFull:(NSNotification *)notif
{
    // our window "entered" full screen mode
    
     //NSLog(@" full screen ");
    [[NSNotificationCenter defaultCenter]postNotificationName:@"enteredFullScreen" object:nil];
}

// -------------------------------------------------------------------------------
//	window:willUseFullScreenPresentationOptions:proposedOptions
//
//  Delegate method to determine the presentation options the window will use when
//  transitioning to full-screen mode.
// -------------------------------------------------------------------------------
- (NSApplicationPresentationOptions)window:(NSWindow *)window willUseFullScreenPresentationOptions:(NSApplicationPresentationOptions)proposedOptions
{
    // customize our appearance when entering full screen:
    // we don't want the dock to appear but we want the menubar to hide/show automatically
    //
    return (NSApplicationPresentationFullScreen |       // support full screen for this window (required)
            NSApplicationPresentationHideDock |         // completely hide the dock
            NSApplicationPresentationAutoHideMenuBar);  // yes we want the menu bar to show/hide
}




@end
