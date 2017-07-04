//
//  PreferencesWindowController.h
//  MoreKeys
//
//  Created by Oren Trutner on 7/2/17.
//  Copyright © 2017 Factual Composites. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "../IO/KeyboardEventTapDelegate.h"

@interface PreferencesWindowController : NSWindowController<KeyboardEventTapDelegate>

- (CGEventRef)keyboardEventTap:(KeyboardEventTap*)sender
               didReceiveEvent:(KeyboardEvent*)event;

@end
