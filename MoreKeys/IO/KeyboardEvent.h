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
#import "KeyboardDevice.h"

@interface KeyboardEvent : NSObject

@property CGKeyboardEvent *cgEvent;
@property IOHIDKeyboardEvent *hidEvent;

- (instancetype)initWithCgEvent:(CGKeyboardEvent*)cgEvent
                    andHidEvent:(IOHIDKeyboardEvent*)hidEvent;

- (CGEventTimestamp)timestamp;
- (KeyboardDevice*)device;

- (int64_t)keycode;
- (NSData*)hidValue;
- (int32_t)scancode;
- (NSString*)string;
- (NSString*)stringWithoutModifiers;
- (NSString*)labelString;

- (int64_t)keyboardType;
- (BOOL)isRepeat;

- (BOOL)capsLock;

- (BOOL)shift;
- (BOOL)leftShift;
- (BOOL)rightShift;

- (BOOL)control;
- (BOOL)leftControl;
- (BOOL)rightControl;

- (BOOL)option;
- (BOOL)leftOption;
- (BOOL)rightOption;

- (BOOL)command;
- (BOOL)leftCommand;
- (BOOL)rightCommand;

- (BOOL)fn;
- (BOOL)numpad;

- (NSString*)debugDescription;

@end
