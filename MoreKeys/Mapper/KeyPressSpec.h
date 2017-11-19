//
//  KeyPressSpec.h
//  MoreKeys
//
//  Created by Oren Trutner on 7/20/17.
//  Copyright © 2017 Factual Composites. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../IO/KeyboardEvent.h"
#import "../IO/CG/CGKeyboardEvent.h"

@interface KeyPressSpec : NSObject

@property CGKeyCode virtualKey;
@property CGEventFlags flags;

- (instancetype)initWithKey:(CGKeyCode)virtualKey andFlags:(CGEventFlags)flags;

- (BOOL)matchesEvent:(KeyboardEvent*)event;
- (NSArray<CGKeyboardEvent*>*)asEvents;

@end
