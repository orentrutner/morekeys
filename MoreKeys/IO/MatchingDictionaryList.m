//
//  MatchingDictionaryList.m
//  MoreKeys
//
//  Created by Oren Trutner on 7/2/17.
//  Copyright © 2017 Factual Composites. All rights reserved.
//

#import "MatchingDictionaryList.h"
#import "MatchingDictionary.h"

@interface MatchingDictionaryList ()

@property NSArray<MatchingDictionary*>* dictionaries;

+ (NSArray<MatchingDictionary*>*) matchingDictionariesFromDictionaries: (NSArray<NSDictionary*>*)dictionaries;

@end

@implementation MatchingDictionaryList

- (instancetype)initWithDictionaries:(NSArray<NSDictionary*>*)dictionaries {
    if (!(self = [super init])) {
        return nil;
    }
    
    @try {
        self.dictionaries = [MatchingDictionaryList matchingDictionariesFromDictionaries:dictionaries];
    }
    @catch (NSException *e) {
        self = nil;
    }
    
    return self;
}

- (void)dealloc {
}

- (CFArrayRef)cfArray {
    NSUInteger count = self.dictionaries.count;

    CFMutableDictionaryRef *dictionaries = malloc(sizeof(NSDictionary*) * count);
    for (int i = 0; i < count; ++i) {
        dictionaries[i] = [self.dictionaries objectAtIndex:i].cfDict;
    }

    CFArrayRef cfDictionaries = CFArrayCreate(kCFAllocatorDefault, (const void **)dictionaries, count, NULL);

    free(dictionaries);
    
    return cfDictionaries;
}

+ (NSArray<MatchingDictionary*>*) matchingDictionariesFromDictionaries: (NSArray<NSDictionary*>*)dictionaries {
    NSUInteger count = dictionaries.count;

    NSMutableArray<MatchingDictionary*>* matchingDictionaries = [NSMutableArray array];
    for (int i = 0; i < count; ++i) {
        MatchingDictionary *matchingDictionary = [[MatchingDictionary alloc] initWithDictionary:[dictionaries objectAtIndex:i]];
        [matchingDictionaries addObject:matchingDictionary];
    }
    
    return [matchingDictionaries copy];
}

@end
