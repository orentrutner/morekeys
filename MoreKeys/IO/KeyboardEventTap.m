//
//  KeyboardEventTap.m
//  MoreKeys
//
//  Created by Oren Trutner on 7/3/17.
//  Copyright © 2017 Factual Composites. All rights reserved.
//

#import "KeyboardEventTap.h"
#import "CGKeyboardEventTap.h"
#import "IOHIDKeyboardEventTap.h"


@interface KeyboardEventTap ()

@property CGKeyboardEventTap *cgTap;
@property IOHIDKeyboardEventTap *hidTap;
@property IOHIDKeyboardEvent *lastHidEvent;

- (CGEventRef)cgKeyboardEventTap:(CGKeyboardEventTap*)sender
                 didReceiveEvent:(CGKeyboardEvent*)event;
- (void)hidKeyboardEventTap:(IOHIDKeyboardEventTap*)sender
            didReceiveEvent:(IOHIDKeyboardEvent*)event;

@end


@implementation KeyboardEventTap

- (instancetype)init {
    if (!(self = [super init])) {
        return nil;
    }

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

- (CGEventRef)cgKeyboardEventTap:(CGKeyboardEventTap*)sender
                 didReceiveEvent:(CGKeyboardEvent*)event {

    if (self.delegate) {
        return [self.delegate keyboardEventTap:self
                               didReceiveEvent:[[KeyboardEvent alloc] initWithCgEvent:event
                                                                          andHidEvent:self.lastHidEvent]];
    } else {
        return event.event;
    }
}

- (void)hidKeyboardEventTap:(IOHIDKeyboardEventTap*)sender
            didReceiveEvent:(IOHIDKeyboardEvent*)event {
    self.lastHidEvent = event;
}

@end
