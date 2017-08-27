//
//  PLSelectableView.h
//  DrawTest
//
//  Created by sergey on 7/26/17.
//  Copyright © 2017 sergey. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PLViewSelectedHandler.h"
#import "PLSavableView.h"

@interface PLSelectableView : NSView<PLSavableView>

@property (nonatomic, weak) id<PLViewSelectedHandler> selectedViewHandler;

@property (nonatomic, assign) BOOL selected;

@end
