//
//  KeyboardAction.m
//  MoreKeys
//
//  Created by Oren Trutner on 7/23/17.
//  Copyright © 2017 Factual Composites. All rights reserved.
//

#import "KeyboardAction.h"


@interface KeyboardAction ()

@property NSArray<KeyPressSpec*>* keys;

@end


@implementation KeyboardAction

- (instancetype)initWithKeys:(NSArray<KeyPressSpec *> *)keys {

    if (!(self = [super init])) {
        return nil;
    }
    
    self.keys = keys;
    
    return self;
}

- (void)applyInContext:(ActionContext *)context {
    for (KeyPressSpec *key in self.keys) {
        [self postKey:key toProxy:context.proxy];
    }
}

- (void)postKey:(KeyPressSpec*)key toProxy:(CGEventTapProxy)proxy {
    [self postEvents:[key asEvents] toProxy:proxy];
}

- (void)postEvents:(NSArray<CGKeyboardEvent*>*)events
           toProxy:(CGEventTapProxy)proxy {

    for (CGKeyboardEvent *event in events) {
        CGEventTapPostEvent(proxy, event.event);
    }
}

@end
