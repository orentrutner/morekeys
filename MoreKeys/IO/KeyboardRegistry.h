//
//  KeyboardRegistry.h
//  MoreKeys
//
//  Created by Oren Trutner on 7/5/17.
//  Copyright © 2017 Factual Composites. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KeyboardDevice.h"
#import "KeyboardRegistryDelegate.h"

@interface KeyboardRegistry : NSObject

@property id<KeyboardRegistryDelegate> delegate;

- (instancetype)init;
- (void)dealloc;

@end
