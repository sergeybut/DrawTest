//
//  RectView.m
//  DrawTest
//
//  Created by sergey on 7/26/17.
//  Copyright © 2017 sergey. All rights reserved.
//

#import "PLRectView.h"

@implementation PLRectView

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    [[NSColor blueColor] set];
    NSRectFill([self bounds]);
    
    if (self.selected)
    {
        NSBezierPath *border = [NSBezierPath bezierPathWithRect:dirtyRect];
        [[NSColor redColor] setStroke];
        [border setLineWidth:8.0];
        [border stroke];
    }
}

- (BOOL)acceptsFirstMouse:(NSEvent *)theEvent
{
    return YES;
}

- (void)mouseDown:(NSEvent *)theEvent
{
    self.selected = !self.selected;
    
    if (nil != self.selectedViewHandler)
    {
        [self.selectedViewHandler viewDidSelected:self];
    }
}

- (void)mouseDragged:(NSEvent *)theEvent
{
    NSPoint newPoint = NSMakePoint(self.frame.origin.x + theEvent.deltaX, self.frame.origin.y - theEvent.deltaY);
    
    [self setFrameOrigin:newPoint];
}
@end
