//
//  KeyboardEventTapDelegate.h
//  MoreKeys
//
//  Created by Oren Trutner on 7/3/17.
//  Copyright © 2017 Factual Composites. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KeyboardEvent.h"

@class KeyboardEventTap;

@protocol KeyboardEventTapDelegate

- (CGEventRef)keyboardEventTap:(KeyboardEventTap*)sender
               didReceiveEvent:(KeyboardEvent*)event;

@end
