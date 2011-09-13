//
//  WordsClass.m
//  unScrabble
//
//  Created by Juan Orlandini on 3/27/11.
//  Copyright 2011 Jacket Data. All rights reserved.
//

#import "WordsClass.h"


@implementation WordsClass

@synthesize word;
@synthesize wordValue;

NSComparisonResult sortByValue(id firstItem, id secondItem, void *context) {
    NSComparisonResult result;
    
    if ([firstItem wordValue] < [secondItem wordValue]) {
        result = NSOrderedDescending;
    } else if ([firstItem wordValue] > [secondItem wordValue]) {
        result = NSOrderedAscending;
    } else {
        result = NSOrderedSame;
    } 

    return result;
}

NSComparisonResult sortByLength(id firstItem, id secondItem, void *context) {
    NSComparisonResult result;
    if ([[firstItem word] length] < [[secondItem word] length]) {
        result = NSOrderedDescending;
    } else if ([[firstItem word] length] > [[secondItem word] length]) {
        result = NSOrderedAscending;
    } else {
        result = NSOrderedSame;
    }  
    
    return result;
}


- (int)calculateWordValue
{
    int wwftilevalues[26] = {1,4,4,2,1,4,3,3,1,10,5,2,4,2,1,4,10,1,1,1,2,5,4,8,3,10};

    NSString *calcWord = [self word];
    int newValue = 0;
    
    for (int i=0;i<[calcWord length];i++) {
        char charc = [calcWord characterAtIndex:i];
        if ((charc-'a')>=0) {                           // Ignore anything that's not lowercase. Hack for . characters.
            newValue = newValue + wwftilevalues[charc-'a'];
        } 
    }
    
//    [calcWord release];
    
    return newValue;
}

- (id)init {
    if ( self == [self initWithWord:@""] ) {
        
    }
    
    return self;
}



- (id)initWithWord:(NSString *)newword  
{
    if (self == [super init] ) {
        self.word = [NSString stringWithString:newword];
        self.wordValue = [self calculateWordValue];
    }
    
    return self;
}

- (NSString *) description {  
    NSString *desc;
    desc = [NSString stringWithFormat:@"My word is [%@,%d]", self.word, self.wordValue];
    return desc; 
} 

@end
