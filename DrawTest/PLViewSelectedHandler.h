//
//  PLViewSelectedHandler.h
//  DrawTest
//
//  Created by sergey on 7/26/17.
//  Copyright © 2017 sergey. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PLSelectableView;
@protocol PLViewSelectedHandler <NSObject>

@required

- (void)viewDidSelected:(PLSelectableView *)view;

@end
