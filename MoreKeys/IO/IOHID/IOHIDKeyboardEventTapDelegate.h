//
//  IOHIDKeyboardEventTapDelegate.h
//  MoreKeys
//
//  Created by Oren Trutner on 7/4/17.
//  Copyright © 2017 Factual Composites. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IOHIDKeyboardEvent.h"

@class IOHIDKeyboardEventTap;

@protocol IOHIDKeyboardEventTapDelegate

- (void)hidKeyboardEventTap:(IOHIDKeyboardEventTap*)sender
            didReceiveEvent:(IOHIDKeyboardEvent*)event;

@end
