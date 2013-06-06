//
//  NSString+CocoaRouge.h
//  CocoaRouge
//
//  Created by Arik Devens on 6/5/13.
//  Copyright (c) 2013 Arik Devens. All rights reserved.
//


@interface NSString (CocoaRouge)

- (NSString *)join:(NSString *)string;
- (NSString *)join:(NSString *)string with:(NSString *)seperator;
- (BOOL)isEmpty;
- (NSString *)chomp;
- (NSString *)chomp:(NSString *)string;

@end