//
//  IOHIDKeyboardEvent.h
//  MoreKeys
//
//  Created by Oren Trutner on 7/3/17.
//  Copyright © 2017 Factual Composites. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <IOKit/hid/IOHIDValue.h>
#import "KeyboardDevice.h"

@interface IOHIDKeyboardEvent : NSObject

@property IOReturn result;
@property KeyboardDevice *device;
@property (nonatomic) IOHIDValueRef value;

- (instancetype)initWithResult:(IOReturn)result device:(IOHIDDeviceRef)device andValue:(IOHIDValueRef)value;
- (void)dealloc;

@end
