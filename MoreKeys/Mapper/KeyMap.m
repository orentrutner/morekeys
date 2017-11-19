//
//  KeyMap.m
//  MoreKeys
//
//  Created by Oren Trutner on 7/22/17.
//  Copyright © 2017 Factual Composites. All rights reserved.
//

#import "KeyMap.h"


@interface KeyMap ()

@property NSArray<Mapping*> *mappings;

@end


@implementation KeyMap

- (instancetype)init {
    return [self initWithMappings:@[]];
}

- (instancetype)initWithMappings:(NSArray<Mapping *> *)mappings {
    if (!(self = [super init])) {
        return nil;
    }
    
    self.mappings = mappings;
    
    return self;
}

- (Action*)actionForTrigger:(KeyboardEvent*)event {
    for (Mapping *mapping in self.mappings) {
        if ([mapping.trigger matchesEvent:event]) {
            return mapping.action;
        }
    }

    return nil;
}

@end
