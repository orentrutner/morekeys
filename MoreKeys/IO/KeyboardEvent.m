//
//  KeyboardEvent.m
//  MoreKeys
//
//  Created by Oren Trutner on 7/3/17.
//  Copyright © 2017 Factual Composites. All rights reserved.
//

#import "KeyboardEvent.h"

@implementation KeyboardEvent

- (instancetype)initWithCgEvent:(CGKeyboardEvent*)cgEvent
                    andHidEvent:(IOHIDKeyboardEvent*)hidEvent {
    
    if (!(self = [super init])) {
        return nil;
    }

    self.cgEvent = cgEvent;
    self.hidEvent = hidEvent;

    return self;
}

@end
