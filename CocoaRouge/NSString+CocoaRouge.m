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


- (NSString *)join:(NSString *)string with:(NSString *)separator
{
    return [NSString stringWithFormat:@"%@%@%@", self, separator, string];
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


- (NSNumber *)toNum
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    return [formatter numberFromString:self];
}


- (int)toInt
{
    return [[self toNum] intValue];
}


- (float)toFloat
{
    return [[self toNum] floatValue];
}


- (NSString *)gsub:(NSString *)match with:(NSString *)replacement
{
    return [self stringByReplacingOccurrencesOfString:match withString:replacement];
}


- (NSArray *)split
{
    return [self split:@" "];
}


- (NSArray *)split:(NSString *)separator
{
    return [self componentsSeparatedByString:separator];
}


- (int)index:(NSString *)match
{
    NSRange matchRange = [self rangeOfString:match];
    if (matchRange.location == NSNotFound) return -1;
    
    return matchRange.location;
}

@end
