//
//  NSNumber+CocoaRouge.h
//  CocoaRouge
//
//  Created by Arik Devens on 6/5/13.
//  Copyright (c) 2013 Arik Devens. All rights reserved.
//


@interface NSNumber (CocoaRouge)

- (void)times:(void (^)(int i))block;

@end
