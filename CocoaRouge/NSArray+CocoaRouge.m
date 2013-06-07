//
//  NSArray+CocoaRouge.m
//  CocoaRouge
//
//  Created by Arik Devens on 6/5/13.
//  Copyright (c) 2013 Arik Devens. All rights reserved.
//

#import "NSArray+CocoaRouge.h"
#import "NSNumber+CocoaRouge.h"


@implementation NSArray (CocoaRouge)

- (NSArray *)map:(id (^)(id))block
{
    NSMutableArray *array = [NSMutableArray array];
    
    for (id item in self) {
        id mappedItem = block(item);
        
        [array addObject:mappedItem];
    }
    
    return array;
}


- (NSString *)join
{
    return [self join:@" "];
}


- (NSString *)join:(NSString *)separator
{
    return [self componentsJoinedByString:separator];
}


- (BOOL)isEmpty
{
    if (self.count > 0) return NO;
    
    return YES;
}


- (BOOL)any:(BOOL (^)(id item))block
{
    __block BOOL any = NO;
    
    for (id item in self) {
        BOOL passesTest = block(item);
        
        if (passesTest == YES) any = YES;
    }
    
    return any;
}


- (NSArray *)select:(BOOL (^)(id item))block
{
    NSMutableArray *array = [NSMutableArray array];
    
    for (id item in self) {
        BOOL passesTest = block(item);
        
        if (passesTest == YES) [array addObject:item];
    }
    
    return array;
}


- (NSArray *)reject:(BOOL (^)(id item))block
{
    NSMutableArray *array = [NSMutableArray array];
    
    for (id item in self) {
        BOOL passesTest = block(item);
        
        if (passesTest == NO) [array addObject:item];
    }
    
    return array;
}


- (void)each:(void (^)(id item))block
{
    for (id item in self) block(item);
}


- (void)eachWithIndex:(void (^)(id item, int index))block
{
    [@(self.count) timesWithIndex:^(int i) {
        id item = self[i];
        
        block(item, i);
    }];
}

@end
