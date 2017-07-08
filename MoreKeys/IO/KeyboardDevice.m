//
//  KeyboardDevice.m
//  MoreKeys
//
//  Created by Oren Trutner on 7/5/17.
//  Copyright © 2017 Factual Composites. All rights reserved.
//

#import "KeyboardDevice.h"


@interface KeyboardDevice ()

- (int32_t)intProperty:(NSString*)name;
- (int64_t)longProperty:(NSString*)name;
- (NSString*)stringProperty:(NSString*)name;

@end


@implementation KeyboardDevice

- (instancetype)initWithDevice:(IOHIDDeviceRef)device {
    if (!(self = [super init])) {
        return nil;
    }
    
    _device = (IOHIDDeviceRef)CFRetain(device);
    
    return self;
}

- (void)dealloc {
    if (_device) {
        CFRelease(_device);
    }
}

- (void)setDevice:(IOHIDDeviceRef)device {
    if (_device != device) {
        IOHIDDeviceRef oldValue = _device;
        
        _device = (IOHIDDeviceRef)CFRetain(device);

        if (oldValue) {
            CFRelease(oldValue);
        }
    }
}

- (int32_t)countryCode {
    return [self intProperty:@kIOHIDCountryCodeKey];
}

- (NSString*)manufacturer {
    return [self stringProperty:@kIOHIDManufacturerKey];
}

- (int32_t)primaryUsage {
    return [self intProperty:@kIOHIDPrimaryUsageKey];
}

- (int32_t)primaryUsagePage {
    return [self intProperty:@kIOHIDPrimaryUsagePageKey];
}

- (NSString*)product {
    return [self stringProperty:@kIOHIDProductKey];
}

- (int32_t)productId {
    return [self intProperty:@kIOHIDProductIDKey];
}

- (NSString*)serialNumber {
    return [self stringProperty:@kIOHIDSerialNumberKey];
}

- (NSString*)transport {
    return [self stringProperty:@kIOHIDTransportKey];
}

- (int64_t)uniqueId {
    return [self longProperty:@kIOHIDUniqueIDKey];
}

- (int32_t)vendorId {
    return [self intProperty:@kIOHIDVendorIDKey];
}

- (int32_t)versionNumber {
    return [self intProperty:@kIOHIDVersionNumberKey];
}

- (NSString*)debugDescription {
    return [NSString stringWithFormat:@"%@ v%d by %@, product-id %d, unique-id %llx %d",
        self.product,
        self.versionNumber,
        self.manufacturer,
        self.productId,
        self.uniqueId,
        self.primaryUsagePage];
}

- (int32_t)intProperty:(NSString*)name {
    CFTypeRef property = IOHIDDeviceGetProperty(self.device, (__bridge CFStringRef)name);
    if (!property) {
        return 0;
    }

    int32_t value = 1;
    CFNumberGetValue(property, kCFNumberSInt32Type, &value);
    return value;
}

- (int64_t)longProperty:(NSString*)name {
    CFTypeRef property = IOHIDDeviceGetProperty(self.device, (__bridge CFStringRef)name);
    if (!property) {
        return 0;
    }

    int64_t value = 1;
    CFNumberGetValue(property, kCFNumberSInt64Type, &value);
    return value;
}

- (NSString*)stringProperty:(NSString*)name {
    return (__bridge NSString *)IOHIDDeviceGetProperty(self.device, (__bridge CFStringRef)name);
}

@end
