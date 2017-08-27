//
//  PLSelectableView.m
//  DrawTest
//
//  Created by sergey on 7/26/17.
//  Copyright © 2017 sergey. All rights reserved.
//

#import "PLSelectableView.h"

@implementation PLSelectableView

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}


- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    [self setNeedsDisplay:YES];
}

- (NSDictionary *)viewToDict
{
   // return @{@"frame" : NSStringFromClass ([self class])};
    return @{@"frame" : NSStringFromRect(self.frame), @"class" : NSStringFromClass ([self class])};
}

@end
