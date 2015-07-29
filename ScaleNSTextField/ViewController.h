//
//  ViewController.h
//  ScaleNSTextField
//
//  Created by Rene Skov on 29/07/15.

//  Free for personal or commercial use, with or without modification.
//  No warranty is expressed or implied.

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController {

    CGFloat clockWithInt;
    CGFloat clockHeightInt;
    CGFloat clockWithp;
    CGFloat clockHeightp;
    CGFloat clockPosionX;
    CGFloat clockPosionY;
    CGFloat clockX;
    CGFloat clockY;

}

@property (strong, nonatomic) IBOutlet NSTextField *displayWatch;

@end

