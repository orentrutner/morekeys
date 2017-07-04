//
//  IOHIDKeyboardEvent.h
//  MoreKeys
//
//  Created by Oren Trutner on 7/3/17.
//  Copyright © 2017 Factual Composites. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <IOKit/hid/IOHIDValue.h>

@interface IOHIDKeyboardEvent : NSObject

@property IOReturn result;
@property IOHIDDeviceRef device;
@property IOHIDValueRef value;

- (instancetype)initWithResult:(IOReturn)result device:(IOHIDDeviceRef)device andValue:(IOHIDValueRef)value;

@end
