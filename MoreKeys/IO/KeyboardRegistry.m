//
//  KeyboardRegistry.m
//  MoreKeys
//
//  Created by Oren Trutner on 7/5/17.
//  Copyright © 2017 Factual Composites. All rights reserved.
//

#import "KeyboardRegistry.h"
#import "MatchingDictionaryList.h"


@interface KeyboardRegistry ()

@property IOHIDManagerRef hidManager;
@property NSMutableDictionary<NSNumber*, KeyboardDevice*>* devices;

- (void)didMatchDevice:(IOHIDDeviceRef)device withResult:(IOReturn)result andSender:(void*)sender;
- (void)didRemoveDevice:(IOHIDDeviceRef)device withResult:(IOReturn)result andSender:(void*)sender;

@end


static void matchCallback(void* context, IOReturn result, void* sender, IOHIDDeviceRef device)
{
    [((__bridge KeyboardRegistry*)context) didMatchDevice:device withResult:result andSender:sender];
}

static void removeCallback(void* context, IOReturn result, void* sender, IOHIDDeviceRef device)
{
    [((__bridge KeyboardRegistry*)context) didRemoveDevice:device withResult:result andSender:sender];
}

@implementation KeyboardRegistry

- (instancetype)init {
    if (!(self = [super init])) {
        return nil;
    }

    self.hidManager = IOHIDManagerCreate(kCFAllocatorDefault, kIOHIDOptionsTypeNone);
    self.devices = [[NSMutableDictionary alloc] init];

    MatchingDictionaryList *matches = [[MatchingDictionaryList alloc] initWithDictionaries:@[
        @{ @kIOHIDDeviceUsagePageKey: @0x01, @kIOHIDDeviceUsageKey: @0x06 },
        @{ @kIOHIDDeviceUsagePageKey: @0x01, @kIOHIDDeviceUsageKey: @0x07 }
    ]];
    IOHIDManagerSetDeviceMatchingMultiple(self.hidManager, [matches cfArray]);
    IOHIDManagerRegisterDeviceMatchingCallback(self.hidManager, matchCallback, (__bridge void * _Nullable)self);
    IOHIDManagerRegisterDeviceRemovalCallback(self.hidManager, removeCallback, (__bridge void * _Nullable)self);
    IOHIDManagerScheduleWithRunLoop(self.hidManager, CFRunLoopGetMain(), kCFRunLoopDefaultMode);
    IOHIDManagerOpen(self.hidManager, kIOHIDOptionsTypeNone);
    
    return self;
}

- (void)dealloc {
    if (self.hidManager) {
        IOHIDManagerUnscheduleFromRunLoop((self.hidManager), CFRunLoopGetMain(), kCFRunLoopDefaultMode);
        CFRelease(self.hidManager);
        self.hidManager = NULL;
    }
}

- (void)didMatchDevice:(IOHIDDeviceRef)device withResult:(IOReturn)result andSender:(void*)sender {
    KeyboardDevice *keyboardDevice = [[KeyboardDevice alloc] initWithDevice:device];
    [self.devices setObject:keyboardDevice forKey:[NSNumber numberWithLong:keyboardDevice.uniqueId]];
    
    if (self.delegate) {
        [self.delegate keyboardRegistry:self didAddDevice:keyboardDevice];
    }
}

- (void)didRemoveDevice:(IOHIDDeviceRef)device withResult:(IOReturn)result andSender:(void*)sender {
    KeyboardDevice *keyboardDevice = [[KeyboardDevice alloc] initWithDevice:device];
    [self.devices removeObjectForKey:[NSNumber numberWithLong:keyboardDevice.uniqueId]];
    
    if (self.delegate) {
        [self.delegate keyboardRegistry:self didRemoveDevice:keyboardDevice];
    }
}

@end
