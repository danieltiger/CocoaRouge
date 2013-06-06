//
//  NSNumber+CocoaRouge.m
//  CocoaRouge
//
//  Created by Arik Devens on 6/5/13.
//  Copyright (c) 2013 Arik Devens. All rights reserved.
//

#import "NSNumber+CocoaRouge.h"


@implementation NSNumber (CocoaRouge)

- (void)times:(void (^)(int i))block
{
    for (int i = 0; i < self.intValue; i++) {
        block(i);
    }
}

@end
