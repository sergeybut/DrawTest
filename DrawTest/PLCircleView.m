//
//  CircleView.m
//  DrawTest
//
//  Created by sergey on 7/25/17.
//  Copyright © 2017 sergey. All rights reserved.
//

#import "PLCircleView.h"

@implementation PLCircleView

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    
    // Draw border if selected
    if (self.selected)
    {
        NSBezierPath *border = [NSBezierPath bezierPathWithRect:dirtyRect];
        [[NSColor redColor] setStroke];
        [border setLineWidth:8.0];
        [border stroke];
    }
    // Get the graphics context that we are currently executing under
    NSGraphicsContext* gc = [NSGraphicsContext currentContext];
    
    // Save the current graphics context settings
    [gc saveGraphicsState];
    
    // Set the color in the current graphics context for future draw operations
    [[NSColor blackColor] setStroke];
    [[NSColor redColor] setFill];
    
    // Create our circle path
    NSRect rect = NSMakeRect(1, 1, 100, 100);
    NSBezierPath* circlePath = [NSBezierPath bezierPath];
    [circlePath appendBezierPathWithOvalInRect: rect];
    
    // Outline and fill the path
    [circlePath stroke];
    [circlePath fill];
    
    // Restore the context to what it was before we messed with it
    [gc restoreGraphicsState];
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
