//
//  KeyboardRegistryDelegate.h
//  MoreKeys
//
//  Created by Oren Trutner on 7/5/17.
//  Copyright © 2017 Factual Composites. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KeyboardEvent.h"

@class KeyboardRegistry;

@protocol KeyboardRegistryDelegate

- (void)keyboardRegistry:(KeyboardRegistry*)sender
            didAddDevice:(KeyboardDevice*)device;
- (void)keyboardRegistry:(KeyboardRegistry*)sender
         didRemoveDevice:(KeyboardDevice*)device;

@end
