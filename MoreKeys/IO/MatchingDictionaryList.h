//
//  MatchingDictionaryList.h
//  MoreKeys
//
//  Created by Oren Trutner on 7/2/17.
//  Copyright © 2017 Factual Composites. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MatchingDictionaryList : NSObject

- (instancetype)initWithDictionaries:(NSArray<NSDictionary*>*)dictionaries;
- (void)dealloc;
- (CFArrayRef)cfArray;

@end
