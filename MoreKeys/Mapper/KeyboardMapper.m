//
//  KeyboardMapper.m
//  MoreKeys
//
//  Created by Oren Trutner on 7/15/17.
//  Copyright © 2017 Factual Composites. All rights reserved.
//

#import "KeyboardMapper.h"
#import "KeyPressSpec.h"
#import "../IO/KeyboardEventTap.h"


@interface KeyboardMapper () <KeyboardEventTapDelegate>

@property KeyboardEventTap *tap;

- (CGEventRef)keyboardEventTap:(KeyboardEventTap*)sender
               didReceiveEvent:(KeyboardEvent*)event;

@end


@implementation KeyboardMapper

- (instancetype)init {
    if (!(self = [super init])) {
        return nil;
    }
    
    if (!(self.tap = [[KeyboardEventTap alloc] init])) {
        self = nil;
    }
    self.tap.delegate = self;
    
    return self;
}

- (void)dealloc {
}

- (void)start {
    [self.tap start];
}

- (void)stop {
    [self.tap stop];
}

- (CGEventRef)keyboardEventTap:(KeyboardEventTap*)sender
               didReceiveEvent:(KeyboardEvent*)event {

    if (event.cgEvent.type == kCGEventKeyDown) {
        NSLog(@"mapped it! %@", event.debugDescription);
        [self postKey:[[KeyPressSpec alloc] initWithKey:(CGKeyCode)6 andFlags:0] toProxy:event.proxy];
    }
    return nil;
}

- (void)postKey:(KeyPressSpec*)key toProxy:(CGEventTapProxy)proxy {
    [self postEvents:[key asEvents] toProxy:proxy];
}

- (void)postEvents:(NSArray<CGKeyboardEvent*>*)events toProxy:(CGEventTapProxy)proxy {
    for (CGKeyboardEvent *event in events) {
        CGEventTapPostEvent(proxy, event.event);
    }
}

@end
