//
//  KeyboardDevice.h
//  MoreKeys
//
//  Created by Oren Trutner on 7/5/17.
//  Copyright © 2017 Factual Composites. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <IOKit/hid/IOHIDValue.h>

@interface KeyboardDevice : NSObject

@property (nonatomic) IOHIDDeviceRef device;

- (instancetype)initWithDevice:(IOHIDDeviceRef)device;
- (void)dealloc;

- (int32_t)countryCode;
- (NSString*)manufacturer;
- (int32_t)primaryUsage;
- (int32_t)primaryUsagePage;
- (NSString*)product;
- (int32_t)productId;
- (NSString*)serialNumber;
- (NSString*)transport;
- (int64_t)uniqueId;
- (int32_t)vendorId;
- (int32_t)versionNumber;

- (NSString*)debugDescription;

@end
