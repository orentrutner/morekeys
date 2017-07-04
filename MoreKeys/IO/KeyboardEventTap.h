//
//  KeyboardEventTap.h
//  MoreKeys
//
//  Created by Oren Trutner on 7/3/17.
//  Copyright © 2017 Factual Composites. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KeyboardEventTapDelegate.h"
#import "CGKeyboardEventTapDelegate.h"
#import "IOHIDKeyboardEventTapDelegate.h"

@interface KeyboardEventTap : NSObject <CGKeyboardEventTapDelegate, IOHIDKeyboardEventTapDelegate>

@property id<KeyboardEventTapDelegate> delegate;

- (instancetype)init;
- (void)start;
- (void)stop;

@end
