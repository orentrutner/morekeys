//
//  CGKeyboardEventTapDelegate.h
//  MoreKeys
//
//  Created by Oren Trutner on 7/4/17.
//  Copyright © 2017 Factual Composites. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CGKeyboardEvent.h"

@class CGKeyboardEventTap;

@protocol CGKeyboardEventTapDelegate

- (CGEventRef)cgKeyboardEventTap:(CGKeyboardEventTap*)sender
                 didReceiveEvent:(CGKeyboardEvent*)event
                       withProxy:(CGEventTapProxy)proxy;

@end
