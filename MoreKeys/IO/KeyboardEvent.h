//
//  KeyboardEvent.h
//  MoreKeys
//
//  Created by Oren Trutner on 7/3/17.
//  Copyright © 2017 Factual Composites. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CGKeyboardEvent.h"
#import "IOHIDKeyboardEvent.h"

@interface KeyboardEvent : NSObject

@property CGKeyboardEvent *cgEvent;
@property IOHIDKeyboardEvent *hidEvent;

- (instancetype)initWithCgEvent:(CGKeyboardEvent*)cgEvent
                    andHidEvent:(IOHIDKeyboardEvent*)hidEvent;

@end
