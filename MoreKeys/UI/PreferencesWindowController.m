//
//  PreferencesWindowController.m
//  MoreKeys
//
//  Created by Oren Trutner on 7/2/17.
//  Copyright © 2017 Factual Composites. All rights reserved.
//

#import "PreferencesWindowController.h"
#import "../IO/KeyboardEventTap.h"
#import "../IO/KeyboardRegistry.h"


@interface PreferencesWindowController ()

@property KeyboardEventTap *tap;
@property KeyboardRegistry *registry;

@end


@implementation PreferencesWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    self.tap = [[KeyboardEventTap alloc] init];
    self.tap.delegate = self;
    [self.tap start];
    
    self.registry = [[KeyboardRegistry alloc] init];
    self.registry.delegate = self;
    
    self.devices = [[NSMutableArray alloc] init];
}

- (CGEventRef)keyboardEventTap:(KeyboardEventTap*)sender
               didReceiveEvent:(KeyboardEvent*)event {

    NSLog(@"------------");
    NSLog(@"kbd %lld", event.keyboardType);
    NSLog(@"key %@", event.debugDescription);
    NSLog(@"device %@", event.device.debugDescription);

    return event.cgEvent.event;
}

- (void)keyboardRegistry:(KeyboardRegistry*)sender
            didAddDevice:(KeyboardDevice*)device {
    NSLog(@"add device %@", device.debugDescription);
    [self.devices addObject:device];
    [self.devicesView reloadData];
}

- (void)keyboardRegistry:(KeyboardRegistry*)sender
         didRemoveDevice:(KeyboardDevice*)device {
    NSLog(@"remove device %@", device.debugDescription);
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {

    return [[self.devices objectAtIndex:row] valueForKey:[tableColumn identifier]];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [self.devices count];
}

@end
