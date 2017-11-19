//
//  CGKeyboardEvent.h
//  MoreKeys
//
//  Created by Oren Trutner on 7/3/17.
//  Copyright © 2017 Factual Composites. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGKeyboardEvent : NSObject

@property CGEventRef event;

- (instancetype)initWithEvent:(CGEventRef)event;
- (instancetype)initWithVirtualKey:(CGKeyCode)virtualKey
                              type:(CGEventType)type
                          andFlags:(CGEventFlags)flags;

- (CGEventType)type;

@end
