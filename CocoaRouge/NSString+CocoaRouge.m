//
//  NSString+CocoaRouge.m
//  CocoaRouge
//
//  Created by Arik Devens on 6/5/13.
//  Copyright (c) 2013 Arik Devens. All rights reserved.
//

#import "NSString+CocoaRouge.h"


@implementation NSString (CocoaRouge)

- (NSString *)join:(NSString *)string
{
    return [self join:string with:@" "];
}


- (NSString *)join:(NSString *)string with:(NSString *)seperator
{
    return [NSString stringWithFormat:@"%@%@%@", self, seperator, string];
}


- (BOOL)isEmpty
{
    if (self.length > 0) return NO;
    
    return YES;
}


- (NSString *)chomp
{
    return [self chomp:@"\n"];
}


- (NSString *)chomp:(NSString *)string
{
    if ([self hasSuffix:string] == NO) return self;
    
    return [self substringToIndex:self.length - string.length];
}

@end
