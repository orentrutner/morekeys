//
//  KeyMap.h
//  MoreKeys
//
//  Created by Oren Trutner on 7/22/17.
//  Copyright © 2017 Factual Composites. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mapping.h"
#import "../IO/KeyboardEvent.h"

@interface KeyMap : NSObject

- (instancetype)init;
- (instancetype)initWithMappings:(NSArray<Mapping*>*)mappings;

- (Action*)actionForTrigger:(KeyboardEvent*)event;

@end
