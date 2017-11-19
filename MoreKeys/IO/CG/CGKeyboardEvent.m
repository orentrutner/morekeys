//
//  CGKeyboardEvent.m
//  MoreKeys
//
//  Created by Oren Trutner on 7/3/17.
//  Copyright © 2017 Factual Composites. All rights reserved.
//

#import "CGKeyboardEvent.h"

@implementation CGKeyboardEvent

- (instancetype)initWithEvent:(CGEventRef)event {
    if (!(self = [super init])) {
        return nil;
    }
    
    self.event = event;
    
    return self;
}

- (instancetype)initWithVirtualKey:(CGKeyCode)virtualKey
                              type:(CGEventType)type
                          andFlags:(CGEventFlags)flags {

    if (!(self = [super init])) {
        return nil;
    }

    BOOL keyDown = type == kCGEventKeyDown;
    self.event = CGEventCreateKeyboardEvent(NULL, virtualKey, keyDown);
    CGEventSetFlags(self.event, flags);
    
    return self;
}

- (CGEventType)type {
    return CGEventGetType(self.event);
}

@end
