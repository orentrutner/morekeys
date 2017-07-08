//
//  PreferencesWindowController.h
//  MoreKeys
//
//  Created by Oren Trutner on 7/2/17.
//  Copyright © 2017 Factual Composites. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "../IO/KeyboardEventTapDelegate.h"
#import "../IO/KeyboardRegistryDelegate.h"

@interface PreferencesWindowController : NSWindowController<KeyboardEventTapDelegate, KeyboardRegistryDelegate, NSTableViewDelegate, NSTableViewDataSource>

@property NSMutableArray<KeyboardDevice*> *devices;
@property (weak) IBOutlet NSTableView *devicesView;

- (CGEventRef)keyboardEventTap:(KeyboardEventTap*)sender
               didReceiveEvent:(KeyboardEvent*)event;

- (void)keyboardRegistry:(KeyboardRegistry*)sender
            didAddDevice:(KeyboardDevice*)device;
- (void)keyboardRegistry:(KeyboardRegistry*)sender
         didRemoveDevice:(KeyboardDevice*)device;

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row;
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView;

@end
