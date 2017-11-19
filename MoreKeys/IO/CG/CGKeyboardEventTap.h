//
//  CGKeyboardEventTap.h
//  MoreKeys
//
//  Created by Oren Trutner on 7/4/17.
//  Copyright © 2017 Factual Composites. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CGKeyboardEventTapDelegate.h"

@interface CGKeyboardEventTap : NSObject

@property id<CGKeyboardEventTapDelegate> delegate;

- (instancetype)init;
- (void)dealloc;
- (void)start;
- (void)stop;

@end
