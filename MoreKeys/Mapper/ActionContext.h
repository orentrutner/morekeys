//
//  ActionContext.h
//  MoreKeys
//
//  Created by Oren Trutner on 7/22/17.
//  Copyright © 2017 Factual Composites. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActionContext : NSObject

@property (readonly) CGEventTapProxy proxy;

- (instancetype)initWithProxy:(CGEventTapProxy)proxy;

@end
