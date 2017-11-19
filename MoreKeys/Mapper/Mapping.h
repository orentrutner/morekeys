//
//  Mapping.h
//  MoreKeys
//
//  Created by Oren Trutner on 7/22/17.
//  Copyright © 2017 Factual Composites. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Action.h"
#import "KeyPressSpec.h"

@interface Mapping : NSObject

@property KeyPressSpec *trigger;
@property Action *action;

- (instancetype)initWithTrigger:(KeyPressSpec*)trigger andAction:(Action*)action;

@end
