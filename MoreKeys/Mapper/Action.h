//
//  Action.h
//  MoreKeys
//
//  Created by Oren Trutner on 7/22/17.
//  Copyright © 2017 Factual Composites. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActionContext.h"

@interface Action : NSObject

- (void)applyInContext:(ActionContext*)context;

@end
