//
//  KeyPressSpec.m
//  MoreKeys
//
//  Created by Oren Trutner on 7/20/17.
//  Copyright © 2017 Factual Composites. All rights reserved.
//

#import "KeyPressSpec.h"

@implementation KeyPressSpec

- (instancetype)initWithKey:(CGKeyCode)virtualKey andFlags:(CGEventFlags)flags {
    if (!(self = [super init])) {
        return nil;
    }

    self.virtualKey = virtualKey;
    self.flags = flags;
    
    return self;
}

- (BOOL)matchesEvent:(KeyboardEvent*)event {
    return self.virtualKey == event.keycode
        && self.flags == CGEventGetFlags(event.cgEvent.event);
}

- (NSArray<CGKeyboardEvent*>*)asEvents {
    return @[
        [[CGKeyboardEvent alloc] initWithVirtualKey:self.virtualKey type:kCGEventKeyDown andFlags:self.flags],
        [[CGKeyboardEvent alloc] initWithVirtualKey:self.virtualKey type:kCGEventKeyUp andFlags:self.flags]
    ];
}

@end
