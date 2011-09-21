//
//  mainViewController.h
//  unScrabbled
//
//  Created by Juan Orlandini on 9/12/11.
//  Copyright (c) 2011 Gigantical. All rights reserved.
//

#import <UIKit/UIKit.h>

int maxwordsize;
NSMutableArray *dictionary;

@interface mainViewController : UIViewController <UIGestureRecognizerDelegate> {
    UIButton *doIt;
    UITextField *tiles;
    UITextField *regexstring;
    IBOutlet UISlider *maxWordLengthSlider;
    IBOutlet UILabel *maxWordLabel;
    
    UISwipeGestureRecognizer *swipe;

}

@property (nonatomic, retain) UISwipeGestureRecognizer *swipe;
@property (nonatomic, retain) IBOutlet UITextField *tiles;
@property (nonatomic, retain) IBOutlet UITextField *regexstring;
@property (nonatomic, retain) IBOutlet UISlider *maxWordLengthSlider;

- (IBAction)doItButton:(id)sender;
- (IBAction)maxWordLengthSlider:(id)sender;


@end
