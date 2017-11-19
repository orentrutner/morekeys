//
//  AppDelegate.m
//  MoreKeys
//
//  Created by Oren Trutner on 7/2/17.
//  Copyright © 2017 Factual Composites. All rights reserved.
//

#import "AppDelegate.h"
#import "Mapper/KeyboardMapper.h"
#import "UI/PreferencesWindowController.h"


@interface AppDelegate ()

@property NSMutableSet<KeyboardDevice*> *devices;

@property NSStatusItem *statusItem;
@property NSMenu *statusBarMenu;
@property PreferencesWindowController *preferencesWindowController;

@property KeyboardMapper *mapper;

@end


@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.devices = [[NSMutableSet alloc] init];

    // Add a status bar icon and menu.
    self.statusBarMenu = [[NSMenu alloc] init];
    [self.statusBarMenu addItem:[[NSMenuItem alloc] initWithTitle:@"Preferences..." action:@selector(showPreferences) keyEquivalent:@","]];
    [self.statusBarMenu addItem:[NSMenuItem separatorItem]];
    [self.statusBarMenu addItem:[[NSMenuItem alloc] initWithTitle:@"Quit MoreKeys" action:@selector(terminate:) keyEquivalent:@"q"]];

    NSStatusBar *statusBar = [NSStatusBar systemStatusBar];
    self.statusItem = [statusBar statusItemWithLength:NSSquareStatusItemLength];
    self.statusItem.image = [NSImage imageNamed:@"StatusBarButtonImage"];
    self.statusItem.menu = self.statusBarMenu;
    
    // Initialize the preferences window.
    self.preferencesWindowController = [[PreferencesWindowController alloc] initWithWindowNibName:@"PreferencesWindow"];
    self.preferencesWindowController.shouldCascadeWindows = NO;
    self.preferencesWindowController.devices = self.devices;
    
    // Start the keyboard mapper.
    self.mapper = [[KeyboardMapper alloc] init];
    [self.mapper start];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    [self.mapper stop];
}

- (void)showPreferences {
    [self.preferencesWindowController showWindow:self];
    [[self.preferencesWindowController window] makeKeyAndOrderFront:self];
}

@end
