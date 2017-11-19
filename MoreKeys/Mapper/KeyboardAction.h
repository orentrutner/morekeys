//
//  KeyboardAction.h
//  MoreKeys
//
//  Created by Oren Trutner on 7/23/17.
//  Copyright © 2017 Factual Composites. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Action.h"
#import "KeyPressSpec.h"

@interface KeyboardAction : Action

- (instancetype)initWithKeys:(NSArray<KeyPressSpec*>*)keys;
- (void)applyInContext:(ActionContext *)context;

@end
