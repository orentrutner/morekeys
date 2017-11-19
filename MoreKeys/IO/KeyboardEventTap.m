//
//  KeyboardEventTap.m
//  MoreKeys
//
//  Created by Oren Trutner on 7/3/17.
//  Copyright © 2017 Factual Composites. All rights reserved.
//

#import "CG/CGKeyboardEventTap.h"
#import "IOHID/IOHIDKeyboardEventTap.h"
#import "KeyboardEventTap.h"


@interface KeyboardEventTap ()

@property CGKeyboardEventTap *cgTap;
@property IOHIDKeyboardEventTap *hidTap;
@property IOHIDKeyboardEvent *lastHIDEvent;

- (CGEventRef)cgKeyboardEventTap:(CGKeyboardEventTap*)sender
                 didReceiveEvent:(CGKeyboardEvent*)event
                       withProxy:(CGEventTapProxy)proxy;
- (void)hidKeyboardEventTap:(IOHIDKeyboardEventTap*)sender
            didReceiveEvent:(IOHIDKeyboardEvent*)event;

@end


@implementation KeyboardEventTap

- (instancetype)init {
    if (!(self = [super init])) {
        return nil;
    }

    self.lastHIDEvent = nil;

    self.cgTap = [[CGKeyboardEventTap alloc] init];
    self.cgTap.delegate = self;

    self.hidTap = [[IOHIDKeyboardEventTap alloc] init];
    self.hidTap.delegate = self;
    
    return self;
}

- (void)start {
    [self.hidTap start];
    [self.cgTap start];
}

- (void)stop {
    [self.cgTap stop];
    [self.hidTap stop];
}

// Event handler for the CG keyboard tap
- (CGEventRef)cgKeyboardEventTap:(CGKeyboardEventTap*)sender
                 didReceiveEvent:(CGKeyboardEvent*)event
                       withProxy:(CGEventTapProxy)proxy {

    if (self.delegate) {
        KeyboardEvent *keyboardEvent = [[KeyboardEvent alloc] initWithCgEvent:event
                                                                     hidEvent:self.lastHIDEvent
                                                                     andProxy:proxy];
        CGEventRef result = [self.delegate keyboardEventTap:self
                                            didReceiveEvent:keyboardEvent];
        
        return result;
    } else {
        return event.event;
    }
}

// Event handler for the HID keyboard tap
- (void)hidKeyboardEventTap:(IOHIDKeyboardEventTap*)sender
            didReceiveEvent:(IOHIDKeyboardEvent*)event {

    self.lastHIDEvent = event;
}

@end
