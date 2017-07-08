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
@property CGEventType type;
@property CGEventTapProxy proxy;
@property void *refcon;

- (instancetype)initWithEvent:(CGEventRef)event type:(CGEventType)type andProxy:(CGEventTapProxy)proxy;

@end
