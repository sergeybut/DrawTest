//
//  PLSavableView.h
//  DrawTest
//
//  Created by sergey on 7/27/17.
//  Copyright © 2017 sergey. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PLSavableView <NSObject>

@required

- (NSDictionary *)viewToDict;

@end
