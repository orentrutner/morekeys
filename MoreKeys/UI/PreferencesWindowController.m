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

@property (weak) IBOutlet NSTableView *devicesView;
@property (weak) IBOutlet NSSegmentedCell *devicesActions;

@property (strong) IBOutlet NSWindow *addDeviceSheet;
@property (weak) IBOutlet NSTextField *deviceNameLabel;
@property (weak) IBOutlet NSButton *commitAddDeviceButton;

@property KeyboardEventTap *tap;
@property BOOL waitingForKeyPress;
@property KeyboardDevice *lastPressedKeyboardDevice;

- (CGEventRef)keyboardEventTap:(KeyboardEventTap*)sender
               didReceiveEvent:(KeyboardEvent*)event;

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row;
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView;

- (IBAction)selectedDeviceChanged:(id)sender;
- (IBAction)addOrRemoveDevice:(id)sender;
- (IBAction)commitAddDevice:(id)sender;
- (IBAction)cancelAddDevice:(id)sender;

@end


@implementation PreferencesWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    self.waitingForKeyPress = NO;
    
    self.tap = [[KeyboardEventTap alloc] init];
    self.tap.delegate = self;
    [self.tap start];
    
    if (!self.devices) {
        self.devices = [[NSMutableSet alloc] init];
    }
    
    [NSBundle.mainBundle loadNibNamed:@"AddDeviceSheet" owner:self topLevelObjects:nil];
    
    [self enableControls];
}

- (CGEventRef)keyboardEventTap:(KeyboardEventTap*)sender
               didReceiveEvent:(KeyboardEvent*)event {

    if (self.waitingForKeyPress) {
        self.deviceNameLabel.stringValue = event.device.product;
        self.lastPressedKeyboardDevice = event.device;
        [self enableControls];
        return nil;
    }

    return event.cgEvent.event;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {

    NSArray *devices = [self.devices allObjects];
    NSArray *sortedDevices = [devices sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"product" ascending:YES]]];
    return [[sortedDevices objectAtIndex:row] valueForKey:[tableColumn identifier]];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [self.devices count];
}

- (IBAction)selectedDeviceChanged:(id)sender {
    [self enableControls];
}

- (IBAction)addOrRemoveDevice:(id)sender {
    NSInteger clickedTag = [[sender cell] tagForSegment:[sender selectedSegment]];
    switch (clickedTag) {
        case 0:
            [self addDevice];
            break;
        case 1:
            [self removeDevice];
            break;
        default:
            break;
    }
}

- (void)addDevice {
    self.deviceNameLabel.stringValue = @"Press a key to add a keyboard";
    self.lastPressedKeyboardDevice = nil;
    self.waitingForKeyPress = YES;
    [self enableControls];

    [self.window beginSheet:self.addDeviceSheet completionHandler:^(NSInteger result) {
        self.waitingForKeyPress = NO;
        
        if (result == NSModalResponseOK) {
            [self.devices addObject:self.lastPressedKeyboardDevice];
            [self.devicesView reloadData];
        }
    }];
}

- (void)removeDevice {
}

- (IBAction)commitAddDevice:(id)sender {
    [self.window endSheet:self.addDeviceSheet returnCode:NSModalResponseOK];
}

- (IBAction)cancelAddDevice:(id)sender {
    [self.window endSheet:self.addDeviceSheet returnCode:NSModalResponseCancel];
}

- (void) enableControls {
    [self.devicesActions setEnabled:self.devicesView.selectedRow >= 0 forSegment:1];
    self.commitAddDeviceButton.enabled = !!self.lastPressedKeyboardDevice && ![self.devices containsObject:self.lastPressedKeyboardDevice];
}

@end
