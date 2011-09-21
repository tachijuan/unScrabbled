//
//  TableViewController.h
//  unScrabbled
//
//  Created by Juan Orlandini on 9/12/11.
//  Copyright (c) 2011 Gigantical. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FancyViewCell.h"
#import "DefinitionViewController.h"

NSMutableArray *wordResults;

@interface TableViewController : UITableViewController <UIGestureRecognizerDelegate> {
    IBOutlet UISegmentedControl *sortSelector;
    UISwipeGestureRecognizer *swipe;

}

@property (retain) NSString *currentword;
@property (retain) NSString *regexpattern;
@property int maxwordsize;
@property (retain) NSMutableArray *dictionary;
@property (nonatomic, retain) UISwipeGestureRecognizer *swipe;


- (IBAction)sortSelectorChanged:(id)sender;

@end
