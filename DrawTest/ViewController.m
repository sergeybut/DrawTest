//
//  ViewController.m
//  DrawTest
//
//  Created by sergey on 7/25/17.
//  Copyright © 2017 sergey. All rights reserved.
//

#import "ViewController.h"
#import "PLCircleView.h"
#import "PLRectView.h"

@interface ViewController ()<PLViewSelectedHandler>

@property (nonatomic, weak) PLSelectableView *selectedView;
@property (nonatomic, strong) NSMutableArray *selectedViews;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.canvas.layer.backgroundColor = [NSColor colorWithCalibratedRed:0.227f
                                                              green:0.251f
                                                               blue:0.337
                                                              alpha:0.8].CGColor;
    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject
{
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (IBAction)circleButtonClicked:(NSButton *)sender
{
    PLCircleView *circle = [[PLCircleView alloc] initWithFrame:NSMakeRect(0.0, 0.0, 102.0, 102.0)];
    circle.selectedViewHandler = self;
    
    [self.canvas addSubview:circle];
    
}
- (IBAction)rectButtonClicked:(NSButton *)sender
{
    PLRectView *rect = [[PLRectView alloc] initWithFrame:NSMakeRect(0.0, 0.0, 100.0, 100.0)];
    rect.selectedViewHandler = self;
    rect.selected = NO;
    
    [self.canvas addSubview:rect];
}

- (IBAction)removeButtonClicked:(NSButton *)sender
{
    if (nil != self.selectedView)
    {
        [self.selectedView removeFromSuperview];
    }
}

- (IBAction)saveButtonClicked:(NSButton *)sender
{
    NSSavePanel *panel = [NSSavePanel savePanel];
    
    NSInteger clicked = [panel runModal];
    
    if (clicked == NSFileHandlingPanelOKButton)
    {
        [self writeViewToURL:[panel URL]];
    }
}

- (IBAction)openButtonClicked:(NSButton *)sender
{
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setCanChooseFiles:YES];
    [panel setCanChooseDirectories:YES];
    [panel setAllowsMultipleSelection:NO]; // yes if more than one dir is allowed
    
    NSInteger clicked = [panel runModal];
    
    if (clicked == NSFileHandlingPanelOKButton)
    {
        [self restoreViewsFromURL:[panel URL]];
    }
}

#pragma -mark selected protocol
- (void)viewDidSelected:(PLSelectableView *)view
{
    if (nil != self.selectedView && view != self.selectedView)
    {
        //deselect current selected view
        self.selectedView.selected = NO;
    }

    //select new view
    self.selectedView = view;
}

- (void)writeViewToURL:(NSURL *)url;
{
    NSMutableArray *arrayToSave = [NSMutableArray new];
    for (NSView *v in self.canvas.subviews)
    {
        if ([v conformsToProtocol:@protocol(PLSavableView)])
        {
            [arrayToSave addObject:[(id<PLSavableView>)v viewToDict]];
        }
    }
    
    [arrayToSave writeToURL:url atomically:YES];
}

- (void)restoreViewsFromURL:(NSURL *)url
{
    // clean canvas
    [self.canvas.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    
    NSArray *viewsArray = [NSArray arrayWithContentsOfURL:url];
    
    for (NSDictionary *viewDict in viewsArray)
    {
        NSString *className = viewDict[@"class"];
        NSRect rect = NSRectFromString(viewDict[@"frame"]);
        
        Class requiredClass = NSClassFromString (className);
        PLSelectableView *newView = [[requiredClass alloc] init];
        newView.frame = rect;
        
        [self.canvas addSubview:newView];
    }
}

@end
