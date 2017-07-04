//
//  MatchingDictionary.m
//  MoreKeys
//
//  Created by Oren Trutner on 7/2/17.
//  Copyright © 2017 Factual Composites. All rights reserved.
//

#import "MatchingDictionary.h"

@implementation MatchingDictionary

- (instancetype)initWithDictionary:(NSDictionary*)dictionary {
    if (!(self = [super init])) {
        return nil;
    }

    @try {
        if (!(self.cfDict = CFDictionaryCreateMutable(
            kCFAllocatorDefault,
            0,
            &kCFTypeDictionaryKeyCallBacks,
            &kCFTypeDictionaryValueCallBacks))) {

            @throw [NSException exceptionWithName:@"InitFailed" reason:@"" userInfo:nil];
        };
        
        for (id key in dictionary) {
            [self setNumber:((NSNumber*)[dictionary objectForKey:key]).unsignedIntValue forKey:key];
        }
    }
    @catch (NSException *e) {
        if (self.cfDict) { CFRelease(self.cfDict); }
        self = nil;
    }

    return self;
}

- (void)dealloc {
    CFRelease(self.cfDict);
}

- (void)setNumber:(UInt32)number forKey:(NSString*)key {
    CFNumberRef numberRef;
    if (!(numberRef = CFNumberCreate(kCFAllocatorDefault, kCFNumberIntType, &number))) {
        @throw [NSException exceptionWithName:NSGenericException reason:@"CFNumberCreate failed" userInfo:nil];
    }
    
    CFDictionarySetValue(self.cfDict, (__bridge_retained CFStringRef)key, numberRef);
    CFRelease(numberRef);
}

@end
