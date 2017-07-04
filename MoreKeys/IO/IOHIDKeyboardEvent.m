//
//  IOHIDKeyboardEvent.m
//  MoreKeys
//
//  Created by Oren Trutner on 7/3/17.
//  Copyright © 2017 Factual Composites. All rights reserved.
//

#import "IOHIDKeyboardEvent.h"

@implementation IOHIDKeyboardEvent

- (instancetype)initWithResult:(IOReturn)result device:(IOHIDDeviceRef)device andValue:(IOHIDValueRef)value {
    if (!(self = [super init])) {
        return nil;
    }
    
    self.result = result;
    self.device = device;
    self.value = value;
    
    return self;
}

@end
