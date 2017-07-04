//
//  IOHIDKeyboardEventTap.m
//  MoreKeys
//
//  Created by Oren Trutner on 7/4/17.
//  Copyright © 2017 Factual Composites. All rights reserved.
//

#import "IOHIDKeyboardEvent.h"
#import "IOHIDKeyboardEventTap.h"
#import "MatchingDictionaryList.h"


@interface IOHIDKeyboardEventTap ()

@property IOHIDManagerRef hidManager;

- (void)eventWasReceivedWithResult:(IOReturn)result
                            sender:(void*)sender
                          andValue:(IOHIDValueRef)value;

@end


void callback(void* context,  IOReturn result,  void* sender,  IOHIDValueRef value)
{
    [((__bridge IOHIDKeyboardEventTap*)context) eventWasReceivedWithResult:result sender:sender andValue:value];
}


@implementation IOHIDKeyboardEventTap

- (instancetype)init {
    if (!(self = [super init])) {
        return nil;
    }

    self.hidManager = IOHIDManagerCreate(kCFAllocatorDefault, kIOHIDOptionsTypeNone);
    MatchingDictionaryList *matches = [[MatchingDictionaryList alloc] initWithDictionaries:@[
        @{ @kIOHIDDeviceUsagePageKey: @0x01, @kIOHIDDeviceUsageKey: @0x06 },
        @{ @kIOHIDDeviceUsagePageKey: @0x01, @kIOHIDDeviceUsageKey: @0x07 }
    ]];
    IOHIDManagerSetDeviceMatchingMultiple(self.hidManager, [matches cfArray]);
    IOHIDManagerRegisterInputValueCallback(self.hidManager, callback, (__bridge void * _Nullable)(self));
    IOHIDManagerScheduleWithRunLoop(self.hidManager, CFRunLoopGetMain(), kCFRunLoopDefaultMode);
    IOHIDManagerOpen(self.hidManager, kIOHIDOptionsTypeNone);
    
    return self;
}

- (void)dealloc {
    [self stop];

    if (self.hidManager) {
        IOHIDManagerUnscheduleFromRunLoop((self.hidManager), CFRunLoopGetMain(), kCFRunLoopDefaultMode);
        CFRelease(self.hidManager);
        self.hidManager = NULL;
    }
}

- (void)start {
}

- (void)stop {
    IOHIDManagerClose(self.hidManager, kIOHIDOptionsTypeNone);
}

- (void)eventWasReceivedWithResult:(IOReturn)result
                            sender:(void*)sender
                          andValue:(IOHIDValueRef)value {

    if (self.delegate) {
        [self.delegate hidKeyboardEventTap:self
                           didReceiveEvent:[[IOHIDKeyboardEvent alloc] initWithResult:result
                                                                               device:sender
                                                                             andValue:value]];
    }
}

@end
