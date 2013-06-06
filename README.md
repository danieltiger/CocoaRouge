CocoaRouge
==========

Ruby inspired categories to make Objective-C a little bit nicer to use.

Usage
=====

### NSArray

Map:
Returns an array made of the return value of each call to the block

	NSArray *words = @[@"funny", @"little", @"frog"];
	
	NSArray *mappedArray = [words map:id^(id item) {
		NSString *word = (NSString *)item;
		
		return @"yes";
	}];
	
	mappedArray == @[@"yes", @"yes", @"yes"]

Join:

	NSArray *words = @[@"funny", @"little", @"frog"];
	
	[words join]; == @"funny little frog"
	[words join:@"-"]; == @"funnny-little-frog"
	
	
isEmpty:

	NSArray *words = @[@"funny", @"little", @"frog"];
	[words isEmpty]; == NO
	
	NSArray *noWords = @[];	
	[noWords isEmpty]; == YES
	
any:
	
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

	NSArray *words = @[@"funny", @"little", @"frog"];

	NSArray *selectedWords = [words select:^BOOL(id item) {
		NSString *word = (NSString *)item;
		
		return [word isEqualToString:@"funny"];
	}]; == @[@"little", @"frog"]
	
	selectedWords = [words select:^BOOL(id item) {
		NSString *word = (NSString *)item;
		
		return [word isEqualToString:@"belle"];
	}]; == @[@"funny", @"little", @"frog"]
	
each:
	
	NSArray *words = @[@"funny", @"little", @"frog"];
	
	[words each:^(id item) {
		NSLog(@"This will be called once for each item in words");
	}];
	
each_with_index:
	
	NSArray *words = @[@"funny", @"little", @"frog"];
	
	[words eachWithIndex:^(id item, int index) {
		NSLog(@"This will be called once for each item in words and pass the index of the item");
	}];
	

### NSNumber

times:
	
	[@(4) times:^(int i) {
		NSLog(@"This block will be called 4 times and will pass the count each time")
	}];
	

### NSString

join:
	
	[[@"funny" join:@"little"] join:@"frog"]; == @"funny little frog"
	
	[[@"funny" join:@"little" with:@"-"] join:@"frog" with:@"-"]; == @"funny-little-frog";
	
isEmpty:

	NSString *text = @"";	
	[text isEmpty]; == YES
	
	NSString *text = @"funny little frog";
	[text isEmpty]; == NO
	
chomp:

	NSString *text = @"funny little frog\n";
	[text chomp]; == @"funny little frog"	
	[text chomp:@"frog"]; == @"funny little "
