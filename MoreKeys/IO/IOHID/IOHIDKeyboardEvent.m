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
    self.device = [[KeyboardDevice alloc] initWithDevice:device];
    _value = (IOHIDValueRef)CFRetain(value);
    
    return self;
}

- (void)dealloc {
    if (_value) {
        CFRelease(_value);
    }
}

- (void)setValue:(IOHIDValueRef)value {
    if (_value != value) {
        IOHIDValueRef oldValue = _value;
        
        _value = (IOHIDValueRef)CFRetain(value);
        
        if (oldValue) {
            CFRelease(oldValue);
        }
    }
}

@end
