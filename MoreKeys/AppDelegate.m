//
//  AppDelegate.m
//  MoreKeys
//
//  Created by Oren Trutner on 7/2/17.
//  Copyright © 2017 Factual Composites. All rights reserved.
//

#import "AppDelegate.h"
#import "UI/PreferencesWindowController.h"

@interface AppDelegate ()

@property NSStatusItem *statusItem;
@property NSMenu *statusBarMenu;
@property PreferencesWindowController *preferencesWindowController;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.statusBarMenu = [[NSMenu alloc] init];
    [self.statusBarMenu addItem:[[NSMenuItem alloc] initWithTitle:@"Preferences..." action:@selector(showPreferences) keyEquivalent:@","]];
    [self.statusBarMenu addItem:[NSMenuItem separatorItem]];
    [self.statusBarMenu addItem:[[NSMenuItem alloc] initWithTitle:@"Quit MoreKeys" action:@selector(terminate:) keyEquivalent:@"q"]];

    NSStatusBar *statusBar = [NSStatusBar systemStatusBar];
    self.statusItem = [statusBar statusItemWithLength:NSSquareStatusItemLength];
    self.statusItem.image = [NSImage imageNamed:@"StatusBarButtonImage"];
    self.statusItem.menu = self.statusBarMenu;
    
    self.preferencesWindowController = [[PreferencesWindowController alloc] initWithWindowNibName:@"PreferencesWindow"];
    self.preferencesWindowController.shouldCascadeWindows = NO;
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (void)showPreferences {
    [self.preferencesWindowController showWindow:self];
    [[self.preferencesWindowController window] makeKeyAndOrderFront:self];
}


@end
