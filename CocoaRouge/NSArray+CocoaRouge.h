//
//  NSArray+CocoaRouge.h
//  CocoaRouge
//
//  Created by Arik Devens on 6/5/13.
//  Copyright (c) 2013 Arik Devens. All rights reserved.
//


@interface NSArray (CocoaRouge)

- (NSArray *)map:(id (^)(id))block;
- (NSString *)join;
- (NSString *)join:(NSString *)separator;
- (BOOL)isEmpty;
- (BOOL)any:(BOOL (^)(id item))block;
- (NSArray *)select:(BOOL (^)(id item))block;
- (NSArray *)reject:(BOOL (^)(id item))block;
- (void)each:(void (^)(id item))block;
- (void)eachWithIndex:(void (^)(id item, int index))block;

@end
