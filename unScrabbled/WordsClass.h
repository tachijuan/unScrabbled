//
//  WordsClass.h
//  unScrabble
//
//  Created by Juan Orlandini on 3/27/11.
//  Copyright 2011 Jacket Data. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WordsClass : NSObject {
    NSString *word;
    int wordValue;
}

@property (retain) NSString *word;
@property int wordValue;

- (id)initWithWord:(NSString *)newword;
NSComparisonResult sortByValue(id firstItem, id secondItem, void *context);
NSComparisonResult sortByLength(id firstItem, id secondItem, void *context);

@end
