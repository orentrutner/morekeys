//
//  IOHIDKeyboardEventTap.h
//  MoreKeys
//
//  Created by Oren Trutner on 7/4/17.
//  Copyright © 2017 Factual Composites. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IOHIDKeyboardEventTapDelegate.h"

@interface IOHIDKeyboardEventTap : NSObject

@property id<IOHIDKeyboardEventTapDelegate> delegate;

- (instancetype)init;
- (void)dealloc;
- (void)start;
- (void)stop;

@end
