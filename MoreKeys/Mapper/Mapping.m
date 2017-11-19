//
//  Mapping.m
//  MoreKeys
//
//  Created by Oren Trutner on 7/22/17.
//  Copyright © 2017 Factual Composites. All rights reserved.
//

#import "Mapping.h"

@implementation Mapping

- (instancetype)initWithTrigger:(KeyPressSpec*)trigger andAction:(Action*)action {
    if (!(self = [super init])) {
        return nil;
    }
    
    self.trigger = trigger;
    self.action = action;

    return self;
}

@end
