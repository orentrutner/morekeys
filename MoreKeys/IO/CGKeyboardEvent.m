//
//  CGKeyboardEvent.m
//  MoreKeys
//
//  Created by Oren Trutner on 7/3/17.
//  Copyright © 2017 Factual Composites. All rights reserved.
//

#import "CGKeyboardEvent.h"

@implementation CGKeyboardEvent

- (instancetype)initWithEvent:(CGEventRef)event type:(CGEventType)type andProxy:(CGEventTapProxy)proxy {
    if (!(self = [super init])) {
        return nil;
    }
    
    self.event = event;
    self.type = type;
    self.proxy = proxy;
    
    return self;
}

@end
