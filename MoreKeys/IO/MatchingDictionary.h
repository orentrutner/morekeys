//
//  MatchingDictionary.h
//  MoreKeys
//
//  Created by Oren Trutner on 7/2/17.
//  Copyright © 2017 Factual Composites. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MatchingDictionary : NSObject

@property CFMutableDictionaryRef cfDict;

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;
- (void)dealloc;
- (void)setNumber:(UInt32)number forKey:(NSString*)key;

@end
