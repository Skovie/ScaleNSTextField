//
//  ViewController.m
//  ScaleNSTextField
//
//  Created by Rene Skov on 29/07/15.

//  Free for personal or commercial use, with or without modification.
//  No warranty is expressed or implied.

#import "ViewController.h"

@implementation ViewController
@synthesize displayWatch;

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
    // add opserver....
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(enteredFullScreen)
                                                 name:@"enteredFullScreen"
                                               object:nil];
    
    // add opserver....
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(exitedFullScreen)
                                                 name:@"exitedFullScreen"
                                               object:nil];
    
    
    [self showTime];


}

- (void)dealloc {
    
    // remove opserver....
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"enteredFullScreen"
                                                  object:nil];
    
    // remove opserver....
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"exitedFullScreen"
                                                  object:nil];
 
}


- (void)viewDidAppear {

    //............ get the  wiew size  ..........
    
    
    NSSize size = self.view.frame.size;
    
    
    NSString *sizeString = NSStringFromSize(size);
    
    NSString *newSizeString =  [sizeString stringByReplacingOccurrencesOfString:@"{" withString:@""];
    NSString *newSizeString1 =  [newSizeString stringByReplacingOccurrencesOfString:@"}" withString:@""];
    
    NSArray *strings = [newSizeString1 componentsSeparatedByString:@","];
    
    NSString *with = [ strings objectAtIndex:0];
    NSString *height = [strings objectAtIndex:1 ];
    
    
    //............ get the  clock size in % of the view  ..........
    
    NSSize clocksize = displayWatch.frame.size;
    NSString *clocksizeString = NSStringFromSize(clocksize);
    
    NSString *clocknewSizeString =  [clocksizeString stringByReplacingOccurrencesOfString:@"{" withString:@""];
    NSString *clocknewSizeString1 =  [clocknewSizeString stringByReplacingOccurrencesOfString:@"}" withString:@""];
    
    NSArray *clockstrings = [clocknewSizeString1 componentsSeparatedByString:@","];
    
    NSString *clockwith = [ clockstrings objectAtIndex:0];
    NSString *clockheight = [clockstrings objectAtIndex:1 ];
    
    
    CGFloat viewWithInt = [with doubleValue ];
    CGFloat viewHeightInt = [height doubleValue ];
    
    
    clockWithInt = [clockwith doubleValue ];
    clockHeightInt = [clockheight doubleValue ];
    
    
    clockWithp = clockWithInt / ( viewWithInt / 100);
    clockHeightp = clockHeightInt / ( viewHeightInt / 100);
    
    //............ get the  clock posion in % of the view  ..........
    NSRect textFieldFrame = [displayWatch frame];
    
    NSPoint textFieldLocation = textFieldFrame.origin;
    
    clockPosionX = textFieldLocation.x;
    clockPosionY = textFieldLocation.y;
    
    clockX = clockPosionX / ( viewWithInt / 100);
    clockY = clockPosionY / ( viewHeightInt / 100);

    
}

- (void)showTime{
    // get the current time from NSdate.......
    
    NSString *date =[NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle] ;
    
    [displayWatch setStringValue:date];
    
    [self performSelector:@selector(showTime) withObject:self afterDelay:1.0];
}


- (void)enteredFullScreen {
    // -------------------------------------------------------------------------------
    //	....... Get the screen size when entering fullscreen...........
    // -------------------------------------------------------------------------------
    
    
    int width = [[NSScreen mainScreen] frame].size.width;
    int height = [[NSScreen mainScreen] frame].size.height;
    
    // ................redraw the watch acording to the % of the full screen .........
    
    int newClockWith =  width /100 *clockWithp;
    int newClockHeight = height /100 *clockHeightp ;
    
    int newClockx =  width /100 *clockX;
    int newClocky = height /100 *clockY;
    
    
    
    [displayWatch setFrame:NSMakeRect(newClockx, newClocky, newClockWith, newClockHeight)];
    displayWatch.font = [self fontSizedForAreaSize:displayWatch.frame.size withString:displayWatch.stringValue usingFont:displayWatch.font];
    
}

-(float)scaleToAspectFit:(CGSize)source into:(CGSize)into padding:(float)padding {
    
    return MIN((into.width-padding) / source.width, (into.height-padding) / source.height);
}

-(NSFont*)fontSizedForAreaSize:(NSSize)size withString:(NSString*)string usingFont:(NSFont*)font {
    
    NSFont* sampleFont = [NSFont fontWithDescriptor:font.fontDescriptor size:250.];
    CGSize sampleSize = [string sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:sampleFont, NSFontAttributeName, nil]];
    float scale = [self scaleToAspectFit:sampleSize into:size padding:5];
    return [NSFont fontWithDescriptor:font.fontDescriptor size:scale * sampleFont.pointSize];
}


- (void)exitedFullScreen {
    
    // ................redraw the displayWatch to the org. size when exit full screen .........
    
    [displayWatch setFrame:NSMakeRect(clockPosionX, clockPosionY, clockWithInt, clockHeightInt)];
    displayWatch.font = [self fontSizedForAreaSize:displayWatch.frame.size withString:displayWatch.stringValue usingFont:displayWatch.font];
    
    
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

@end
