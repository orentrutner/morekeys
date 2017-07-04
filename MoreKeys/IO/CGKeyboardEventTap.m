//
//  CGKeyboardEventTap.m
//  MoreKeys
//
//  Created by Oren Trutner on 7/4/17.
//  Copyright © 2017 Factual Composites. All rights reserved.
//


#import "CGKeyboardEventTap.h"


@interface CGKeyboardEventTap ()

@property CFMachPortRef eventTap;
@property CFRunLoopSourceRef runLoopSource;

- (CGEventRef)eventWasReceived: (CGEventRef)event ofType:(CGEventType)type andProxy:(CGEventTapProxy)proxy;

@end


CGEventRef callback(CGEventTapProxy proxy, CGEventType type, CGEventRef event, void *refcon) {
    return [((__bridge CGKeyboardEventTap*)refcon) eventWasReceived:event ofType:type andProxy:proxy];
}


@implementation CGKeyboardEventTap

- (instancetype)init {
    if (!(self = [super init])) {
        return nil;
    }

    @try {
        if (!(self.eventTap = CGEventTapCreate(
            kCGHIDEventTap,
            kCGHeadInsertEventTap,
            kCGEventTapOptionDefault,
            CGEventMaskBit(kCGEventKeyDown) | CGEventMaskBit(kCGEventKeyUp) | CGEventMaskBit(NX_SYSDEFINED),
            callback,
            (__bridge void * _Nullable)self))) {

            @throw [NSException exceptionWithName:@"InitFailed" reason:@"" userInfo:nil];
        }

        self.runLoopSource = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, self.eventTap, 0);
        CFRunLoopAddSource(CFRunLoopGetCurrent(), self.runLoopSource, kCFRunLoopCommonModes);
    }
    @catch (NSException *e) {
        if (self.runLoopSource) {
            CFRelease(self.runLoopSource);
            self.runLoopSource = NULL;
        }
        if (self.eventTap) {
            CFRelease(self.eventTap);
            self.eventTap = NULL;
        }
        self = nil;
    }

    return self;
}

- (void)dealloc {
    [self stop];

    if (self.runLoopSource) {
        CFRelease(self.runLoopSource);
        self.runLoopSource = NULL;
    }
    if (self.eventTap) {
        CFRelease(self.eventTap);
        self.eventTap = NULL;
    }
}

- (void)start {
    CGEventTapEnable(self.eventTap, true);
}

- (void)stop {
    CGEventTapEnable(self.eventTap, false);
}

- (CGEventRef)eventWasReceived: (CGEventRef)event ofType:(CGEventType)type andProxy:(CGEventTapProxy)proxy {
    return self.delegate
        ? [self.delegate cgKeyboardEventTap:self
                            didReceiveEvent:[[CGKeyboardEvent alloc] initWithEvent:event
                                                                              type:type
                                                                          andProxy:proxy]]
        : event;
}

@end
