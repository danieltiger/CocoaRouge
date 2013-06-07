//
//  CocoaRougeTests.m
//  CocoaRougeTests
//
//  Created by Arik Devens on 6/5/13.
//  Copyright (c) 2013 Arik Devens. All rights reserved.
//

#import "CocoaRougeTests.h"
#import "CRCategories.h"


@implementation CocoaRougeTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}


- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}


- (void)testUnless
{
    __block BOOL ranUnless = NO;
    
    unless(1 != 1) {
        ranUnless = YES;
    }
    STAssertTrue(ranUnless, @"1 does != 1");
    
    ranUnless = NO;
    unless(1 == 1) {
        ranUnless = YES;
    }
    STAssertFalse(ranUnless, @"1 does == 1");
    
    ranUnless = NO;
    unless(1 == 1) {
        ranUnless = NO;
    } else {
        ranUnless = YES;
    }
    STAssertTrue(ranUnless, @"else should be called if unless is false");
}


- (void)testArrayMap
{
    NSArray *unmapped = @[@"funny", @"little", @"frog"];
    
    NSArray *mapped = [unmapped map:(id)^(id item) {
       return @"yes";
    }];
    
    STAssertTrue(mapped.count == 3, @"The mapped array should also have 3 objects");
    
    [@(3) timesWithIndex:^(int i) {
        STAssertTrue([mapped[i] isEqualToString:@"yes"], @"Every item in mapped should be a string equal to yes");
    }];
}


- (void)testArrayJoin
{
    NSArray *array = @[@"funny", @"little", @"frog"];
    
    NSString *joinedWithSpace = [array join];
    STAssertTrue([joinedWithSpace isEqualToString:@"funny little frog"],
                 @"With no argument join should default to a space.");
    
    NSString *joinedWithDash = [array join:@"-"];
    STAssertTrue([joinedWithDash isEqualToString:@"funny-little-frog"],
                 @"With the argument - provided the string should be joined with -'s");
}


- (void)testArrayIsEmpty
{
    NSMutableArray *array = [NSMutableArray array];
    
    BOOL isEmpty = [array isEmpty];
    STAssertTrue(isEmpty == YES, @"An empty array should return yes for isEmpty");
    
    [array addObject:@"funny little frog"];
    isEmpty = [array isEmpty];
    STAssertFalse(isEmpty, @"An array with something in it should return no for isEmpty");
}


- (void)testArrayAny
{
    NSArray *test = @[@"funny", @"little", @"frog"];
    
    BOOL any = [test any:^BOOL(id item) {
        NSString *word = (NSString *)item;
        
        return [word isEqualToString:@"funny"];
    }];
    
    STAssertTrue(any, @"The array should pass a test for the word funny");
    
    any = [test any:^BOOL(id item) {
        NSString *word = (NSString *)item;
        
        return [word isEqualToString:@"belle"];
    }];
    
    STAssertFalse(any, @"The array should not pass a test for the word belle");
}


- (void)testArraySelect
{
    NSArray *test = @[@"funny", @"little", @"frog"];

    NSArray *selectedTest = [test select:^BOOL(id item) {
        NSString *word = (NSString *)item;
        
        return [word isEqualToString:@"funny"];
    }];
    
    STAssertTrue(selectedTest.count == 1, @"The new array should only have one item in it");
    STAssertTrue([selectedTest[0] isEqualToString:@"funny"], @"The item should be equal to the string we tested for");
    
    selectedTest = [test select:^BOOL(id item) {
        NSString *word = (NSString *)item;
        
        return [word isEqualToString:@"belle"];
    }];
    
    STAssertTrue(selectedTest.count == 0, @"The array should be empty");
}


- (void)testArrayReject
{
    NSArray *test = @[@"funny", @"little", @"frog"];
    
    NSArray *selectedTest = [test reject:^BOOL(id item) {
        NSString *word = (NSString *)item;
        
        return [word isEqualToString:@"funny"];
    }];
    
    STAssertTrue(selectedTest.count == 2, @"The new array should have the last two items in it");
    STAssertTrue([selectedTest[0] isEqualToString:@"little"], @"The first item should be equal to the string little");
    
    selectedTest = [test reject:^BOOL(id item) {
        NSString *word = (NSString *)item;
        
        return [word isEqualToString:@"belle"];
    }];
    
    STAssertTrue(selectedTest.count == 3, @"The array should have all the original items");
    STAssertTrue([selectedTest[0] isEqualToString:@"funny"], @"The first item should be the same as it was before");
}


- (void)testArrayEach
{
    __block int numberOfTimes = 0;
    NSArray *test = @[@"funny", @"little", @"frog"];
    
    [test each:^(id item) {
        NSString *word = (NSString *)item;
        
        STAssertTrue([word isEqualToString:[test objectAtIndex:numberOfTimes]],
                     @"The item should equal to word in the array");
        
        numberOfTimes++;
    }];
    
    STAssertTrue(numberOfTimes == 3, @"The block should have been called once for each item in the array");
}


- (void)testArrayEachWithIndex
{
    __block int numberOfTimes = 0;
    NSArray *test = @[@"funny", @"little", @"frog"];
    
    [test eachWithIndex:^(id item, int index) {
        NSString *word = (NSString *)item;
        
        STAssertTrue([word isEqualToString:[test objectAtIndex:index]],
                     @"The item should equal to word in the array");
        
        numberOfTimes++;
    }];
    
    STAssertTrue(numberOfTimes == 3, @"The block should have been called once for each item in the array");    
}


- (void)testNumberTimes
{
    __block int numberOfTimes = 0;
    
    [@(4) times:^(void) {
        numberOfTimes++;
    }];
    
    STAssertTrue(numberOfTimes == 4, @"After running 4 times the number should equal 4");
}


- (void)testNumberTimesWithIndex
{
    __block int numberOfTimes = 0;
    
    [@(4) timesWithIndex:^(int index) {
        numberOfTimes += index;
    }];
    
    STAssertTrue(numberOfTimes == 6, @"After running 4 times the number should equal 6");
}


- (void)testNumberToString
{
    STAssertTrue([[@(42) toString] isEqualToString:@"42"], @"@(42) should be converted to a string of '42'");
}


- (void)testStringJoin
{
    NSString *test = [[@"funny" join:@"little"] join:@"frog"];

    STAssertTrue([test isEqualToString:@"funny little frog"], @"With no argument join should default to a space.");
    
    test = [[@"funny" join:@"little" with:@"-"] join:@"frog" with:@"-"];
    
    STAssertTrue([test isEqualToString:@"funny-little-frog"],
                 @"With the argument - provided the string should be joined with -s'");
}


- (void)testStringIsEmpty
{
    NSString *test = @"";
    
    BOOL isEmpty = [test isEmpty];
    STAssertTrue(isEmpty, @"An empty string should return yes for isEmpty");
    
    test = @"funny little frog";
    isEmpty = [test isEmpty];
    STAssertFalse(isEmpty, @"A string with text in it should return no for isEmpty");
}


- (void)testStringChomp
{
    NSString *test = @"funny little frog\n";
    NSString *chompedTest = [test chomp];
    STAssertTrue([chompedTest isEqualToString:@"funny little frog"],
                 @"Chomp should remove newlines from the end of the string");
    
    chompedTest = [chompedTest chomp];
    STAssertTrue([chompedTest isEqualToString:@"funny little frog"],
                 @"Chomp should do nothing if there are no newlines at the end of the string");
    
    test = @"funny\n little frog";
    chompedTest = [test chomp];
    STAssertTrue([chompedTest isEqualToString:@"funny\n little frog"],
                 @"Chomp should do nothing if the newlines aren't at the end of the string");
    
    test = @"funny little frog";
    chompedTest = [test chomp:@"frog"];
    STAssertTrue([chompedTest isEqualToString:@"funny little "],
                 @"If a string is passed and it is the end of the original string it should be removed");
    
    test = @"funny little frog";
    chompedTest = [test chomp:@"belle"];
    STAssertTrue([chompedTest isEqualToString:@"funny little frog"],
                 @"If a string is passed and it is not the end of the string nothing should be done");
}


- (void)testStringToNum
{
    NSString *test = @"42";
    
    STAssertTrue([[test toNum] isEqualToNumber:@(42)], @"Should convert '42' to @(42)");
}


- (void)testStringToInt
{
    NSString *test = @"42";
    
    STAssertTrue([test toInt] == 42, @"Should convert '42' to an int that equals 42");
}


- (void)testStringToFloat
{
    NSString *test = @"4.2";
    
    STAssertTrue([test toFloat] == 4.2f, @"Should convert '4.2' to a float that equals 4.2");
}


- (void)testStringToGsub
{
    NSString *test = @"Adam";
    
    STAssertTrue([[test gsub:@"Adam" with:@"Pete"] isEqualToString:@"Pete"], @"Adam should now equal Pete");
}


- (void)testStringSplit
{
    NSString *test = @"funny little frog";
    
    NSArray *splitTest = [test split];
    STAssertTrue(splitTest.count == 3, @"There should be 3 elements in splitTest");
    STAssertTrue([splitTest[1] isEqualToString:@"little"], @"The second element should be 'little'");
}


- (void)testStringSplitSeparator
{
    NSString *test = @"funny-little-frog";
    
    NSArray *splitTest = [test split:@"-"];
    STAssertTrue(splitTest.count == 3, @"There should be 3 elements in splitTest");
    STAssertTrue([splitTest[1] isEqualToString:@"little"], @"The second element should be 'little'");
    
    test = @"funny-little frog";
    splitTest = [test split:@"-"];
    STAssertTrue(splitTest.count == 2, @"There should be 2 elements in splitTest");
    STAssertTrue([splitTest[1] isEqualToString:@"little frog"], @"The second element should be 'little frog'");
}


- (void)testStringIndex
{
    NSString *test = @"funny little frog";

    int index = [test index:@"little"];
    STAssertTrue(index == 6, @"The first occurance of 'little' is at index 6");
    
    index = [test index:@"belle"];
    STAssertTrue(index == -1, @"There is no occurance of the string 'belle' in 'funny little frog'");
}

@end
