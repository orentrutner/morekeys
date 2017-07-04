//
//  PreferencesWindowController.m
//  MoreKeys
//
//  Created by Oren Trutner on 7/2/17.
//  Copyright © 2017 Factual Composites. All rights reserved.
//

#import "PreferencesWindowController.h"
#import "../IO/KeyboardEventTap.h"

void hidKeyboardCallback( void* context,  IOReturn result,  void* sender,  IOHIDValueRef value )
{
    IOHIDElementRef elem = IOHIDValueGetElement(value);
    if (IOHIDElementGetUsagePage(elem) != 0x07)
        return;
    
    IOHIDDeviceRef device = sender;
    int32_t pid = 1;
    CFNumberGetValue(IOHIDDeviceGetProperty(device, CFSTR("idProduct")), kCFNumberSInt32Type, &pid);
    
    uint32_t scancode = IOHIDElementGetUsage(elem);
    
    if (scancode < 4 || scancode > 231)
        return;
    
    long pressed = IOHIDValueGetIntegerValue(value);
    
    printf("scancode: %d, pressed: %ld, keyboardId=%d\n", scancode, pressed, pid);
}

@interface PreferencesWindowController ()

@property KeyboardEventTap *tap;

@end

@implementation PreferencesWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    self.tap = [[KeyboardEventTap alloc] init];
    self.tap.delegate = self;
}

- (CGEventRef)keyboardEventTap:(KeyboardEventTap*)sender
               didReceiveEvent:(KeyboardEvent*)event {

    return event.cgEvent.event;
}

@end
