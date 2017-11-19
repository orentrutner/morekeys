//
//  KeyboardEvent.m
//  MoreKeys
//
//  Created by Oren Trutner on 7/3/17.
//  Copyright © 2017 Factual Composites. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#include <IOKit/hid/IOHIDValue.h>
#import "KeyboardEvent.h"

#define ALL_DEVICE_MODIFIERS_MASK (NX_ALPHASHIFTMASK | NX_SHIFTMASK | \
    NX_CONTROLMASK | NX_ALTERNATEMASK | NX_COMMANDMASK | NX_NUMERICPADMASK | \
    NX_HELPMASK | NX_SECONDARYFNMASK | NX_ALPHASHIFT_STATELESS_MASK | \
    NX_DEVICELCTLKEYMASK | NX_DEVICELSHIFTKEYMASK | NX_DEVICERSHIFTKEYMASK | \
    NX_DEVICELCMDKEYMASK | NX_DEVICERCMDKEYMASK | NX_DEVICELALTKEYMASK | \
    NX_DEVICERALTKEYMASK | NX_DEVICE_ALPHASHIFT_STATELESS_MASK | \
    NX_DEVICERCTLKEYMASK)

@implementation KeyboardEvent

- (instancetype)initWithCgEvent:(CGKeyboardEvent*)cgEvent
                       hidEvent:(IOHIDKeyboardEvent*)hidEvent
                       andProxy:(CGEventTapProxy)proxy {
    
    if (!(self = [super init])) {
        return nil;
    }

    self.cgEvent = cgEvent;
    self.hidEvent = hidEvent;
    self.proxy = proxy;

    return self;
}

- (CGEventTimestamp)timestamp {
    return CGEventGetTimestamp(self.cgEvent.event);
}

- (KeyboardDevice*)device {
    return self.hidEvent.device;
}

- (int64_t)keycode {
    return CGEventGetIntegerValueField(self.cgEvent.event, kCGKeyboardEventKeycode);
}

- (NSData*)hidValue {
    long length = IOHIDValueGetLength(self.hidEvent.value);
    const uint8_t *data = IOHIDValueGetBytePtr(self.hidEvent.value);
    return [NSData dataWithBytes:data length:length];
}

- (int32_t)scancode {
    IOHIDElementRef element = IOHIDValueGetElement(self.hidEvent.value);
    return IOHIDElementGetUsage(element);
}

- (NSString *)string {
    UniChar buffer[10];
    UniCharCount length;
    CGEventKeyboardGetUnicodeString(self.cgEvent.event, 10, &length, buffer);
    return [NSString stringWithCharacters:buffer length:length];
}

- (NSString *)stringWithoutModifiers {
    return (self.cgEvent.type == kCGEventKeyDown || self.cgEvent.type == kCGEventKeyUp)
        ? [[NSEvent eventWithCGEvent:self.cgEvent.event].charactersIgnoringModifiers uppercaseString]
        : @"";
}

- (NSString*)labelString {
    NSString *s = [self stringWithoutModifiers];
    return [s isEqualToString:@" "]
        ? @"Space"
        : [s isEqualToString:@"\t"]
            ? @"Tab"
            : s;
}

- (int64_t)keyboardType {
    return CGEventGetIntegerValueField(self.cgEvent.event, kCGKeyboardEventKeyboardType);
}

- (BOOL)isRepeat {
    return !!CGEventGetIntegerValueField(self.cgEvent.event, kCGKeyboardEventAutorepeat);
}

- (BOOL)capsLock {
    return (CGEventGetFlags(self.cgEvent.event) & kCGEventFlagMaskAlphaShift) == kCGEventFlagMaskAlphaShift;
}

- (BOOL)shift {
    return (CGEventGetFlags(self.cgEvent.event) & kCGEventFlagMaskShift) == kCGEventFlagMaskShift;
}

- (BOOL)leftShift {
    return (CGEventGetFlags(self.cgEvent.event) & NX_DEVICELSHIFTKEYMASK) == NX_DEVICELSHIFTKEYMASK;
}

- (BOOL)rightShift {
    return (CGEventGetFlags(self.cgEvent.event) & NX_DEVICERSHIFTKEYMASK) == NX_DEVICERSHIFTKEYMASK;
}

- (BOOL)control {
    return (CGEventGetFlags(self.cgEvent.event) & kCGEventFlagMaskControl) == kCGEventFlagMaskControl;
}

- (BOOL)leftControl {
    return (CGEventGetFlags(self.cgEvent.event) & NX_DEVICELCTLKEYMASK) == NX_DEVICELCTLKEYMASK;
}

- (BOOL)rightControl {
    return (CGEventGetFlags(self.cgEvent.event) & NX_DEVICERCTLKEYMASK) == NX_DEVICERCTLKEYMASK;
}

- (BOOL)option {
    return (CGEventGetFlags(self.cgEvent.event) & kCGEventFlagMaskAlternate) == kCGEventFlagMaskAlternate;
}

- (BOOL)leftOption {
    return (CGEventGetFlags(self.cgEvent.event) & NX_DEVICELALTKEYMASK) == NX_DEVICELALTKEYMASK;
}

- (BOOL)rightOption {
    return (CGEventGetFlags(self.cgEvent.event) & NX_DEVICERALTKEYMASK) == NX_DEVICERALTKEYMASK;
}

- (BOOL)command {
    return (CGEventGetFlags(self.cgEvent.event) & kCGEventFlagMaskCommand) == kCGEventFlagMaskCommand;
}

- (BOOL)leftCommand {
    return (CGEventGetFlags(self.cgEvent.event) & NX_DEVICELCMDKEYMASK) == NX_DEVICELCMDKEYMASK;
}

- (BOOL)rightCommand {
    return (CGEventGetFlags(self.cgEvent.event) & NX_DEVICERCMDKEYMASK) == NX_DEVICERCMDKEYMASK;
}

- (BOOL)fn {
    return (CGEventGetFlags(self.cgEvent.event) & kCGEventFlagMaskSecondaryFn) == kCGEventFlagMaskSecondaryFn;
}

- (BOOL)numpad {
    return (CGEventGetFlags(self.cgEvent.event) & kCGEventFlagMaskNumericPad) == kCGEventFlagMaskNumericPad;
}

- (NSString *)debugDescription {
    NSString *type = @"?";
    switch (self.cgEvent.type) {
        case kCGEventKeyDown: type = @"down"; break;
        case kCGEventKeyUp: type = @"up"; break;
        case kCGEventFlagsChanged: type = @"flags"; break;
        default: [NSString stringWithFormat:@"?(%d)", self.cgEvent.type];
    }

    return [NSString stringWithFormat:@"%s%s%s%s%s%s%s%s%s%s%@ (%lld/%@/%d) %@%s",
        (self.leftShift ? "LShift+" : ""),
        (self.rightShift ? "RShift+" : ""),
        (self.leftControl ? "LCtrl+" : ""),
        (self.rightControl ? "RCtrl+" : ""),
        (self.leftOption ? "LOption+" : ""),
        (self.rightOption ? "ROption+" : ""),
        (self.leftCommand ? "LCmd+" : ""),
        (self.rightCommand ? "RCmd+" : ""),
        (self.fn ? "FN+" : ""),
        (self.numpad ? "Num " : ""),
        self.labelString,
        self.keycode,
        self.hidValue,
        (self.scancode),
        type,
        (self.isRepeat ? " repeat" : "")];
}

@end
