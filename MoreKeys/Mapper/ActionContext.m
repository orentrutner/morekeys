//
//  ActionContext.m
//  MoreKeys
//
//  Created by Oren Trutner on 7/22/17.
//  Copyright © 2017 Factual Composites. All rights reserved.
//

#import "ActionContext.h"

@interface ActionContext ()

@property CGEventTapProxy proxy;

@end


@implementation ActionContext

- (instancetype)initWithProxy:(CGEventTapProxy)proxy {
    if (!(self = [super init])) {
        return nil;
    }
    
    self.proxy = proxy;

    return self;
}

@end
