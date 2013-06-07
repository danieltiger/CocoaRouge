CocoaRouge
==========

Ruby inspired categories to make Objective-C a little bit nicer to use.

Usage
=====

### Lanaguage Constructs

Unless:

Equivalent to if (!conditional), it runs the unless code if the conditional is false and the else if it's true.

	unless (1 != 1) {
		NSLog(@"This will be run because the conditional resolves to NO")
	} else {
		NSLog(@"This would be run if the conditional resolved to YES")
	}

### NSArray

Map:

Returns an array made of the return value of each call to the block.

	NSArray *words = @[@"funny", @"little", @"frog"];
	
	NSArray *mappedArray = [words map:id^(id item) {
		NSString *word = (NSString *)item;
		
		return @"yes";
	}];
	
	mappedArray == @[@"yes", @"yes", @"yes"]

Join:

Creates a string by joining the elements of an array with either a space or a separator.

	NSArray *words = @[@"funny", @"little", @"frog"];
	
	[words join]; == @"funny little frog"
	[words join:@"-"]; == @"funnny-little-frog"
	
	
isEmpty:

Returns true if the array has no elements and false if it has any.

	NSArray *words = @[@"funny", @"little", @"frog"];
	[words isEmpty]; == NO
	
	NSArray *noWords = @[];	
	[noWords isEmpty]; == YES
	
any:

Returns true if the array contains and elements passing the test in the block. Returns false if none pass the test.
	
	NSArray *words = @[@"funny", @"little", @"frog"];
	
	[words any:BOOL^(id item) {
		NSString *word = (NSString *)item;
		
		return [word isEqualToString:@"funny"];
	}]; == YES
	
	[words any:BOOL^(id item) {
		NSString *word = (NSString *)item;
		
		return [word isEqualToString:@"belle"];
	}]; == NO
		
select:

Returns an array of the elements from an array that pass the test in the block.

	NSArray *words = @[@"funny", @"little", @"frog"];
	
	NSArray *selectedWords = [words select:^BOOL(id item) {
		NSString *word = (NSString *)item;
		
		return [word isEqualToString:@"funny"];
	}]; == @[@"funny"]
	
	selectedWords = [words select:^BOOL(id item) {
		NSString *word = (NSString *)item;
		
		return [word isEqualToString:@"belle"];
	}]; == @[]
	
reject:

Returns an array of any elements that fail the test in the blok.

	NSArray *words = @[@"funny", @"little", @"frog"];

	NSArray *selectedWords = [words reject:^BOOL(id item) {
		NSString *word = (NSString *)item;
		
		return [word isEqualToString:@"funny"];
	}]; == @[@"little", @"frog"]
	
	selectedWords = [words reject:^BOOL(id item) {
		NSString *word = (NSString *)item;
		
		return [word isEqualToString:@"belle"];
	}]; == @[@"funny", @"little", @"frog"]
	
each:

Executes a block for each element in an array.
	
	NSArray *words = @[@"funny", @"little", @"frog"];
	
	[words each:^(id item) {
		NSLog(@"This will be called once for each item in words");
	}];
	
each_with_index:

Executes a block for each element in an array and passed in the index of the element.
	
	NSArray *words = @[@"funny", @"little", @"frog"];
	
	[words eachWithIndex:^(id item, int index) {
		NSLog(@"This will be called once for each item in words and pass the index of the item");
	}];
	

### NSNumber

times:

Executes the block however many times the number is equal to.
	
	[@(4) times:{
		NSLog(@"This block will be called 4 times.")
	}];
	

timesWithIndex:

Executes the block however many times the number is equal to. Passes in the index of the current iteration.

	[@(4) times:^(int i) {
		NSLog(@"This block will be called 4 times and will pass the count each time")
	}];
	
toString:

Converts an NSNumber to an NSString.

	[@(42) toString]; == 42
	

### NSString

join: and join:with:

Creates a new string by concatenating two strings with either a space or the specified separator.
	
	[[@"funny" join:@"little"] join:@"frog"]; == @"funny little frog"
	
	[[@"funny" join:@"little" with:@"-"] join:@"frog" with:@"-"]; == @"funny-little-frog";
	
isEmpty:

Returns true if the length of the string is 0 and false if it's greater than 0.

	NSString *text = @"";	
	[text isEmpty]; == YES
	
	NSString *text = @"funny little frog";
	[text isEmpty]; == NO
	
chomp:

Removes the specified string from the end of a string or removes \n if no string is specified.

	NSString *text = @"funny little frog\n";
	[text chomp]; == @"funny little frog"	
	[text chomp:@"frog"]; == @"funny little "

toNum:

Converts an NSString to an NSNumber.

	[@"42" toNum]; == @(42)
	
toInt:

Converts an NSString to an int

	[@"42" toInt]; == 42
	
toFloat:

Converts an NSString to a float

	[@"42" toFloat]; == 4.2f
	
gsub:with:

Replaces a matching string with the specified string.

	[@"Adam" gsub:@"Adam" with:@"Help"]; == "Pete"
	