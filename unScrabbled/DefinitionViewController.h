//
//  DefinitionViewController.h
//  unScrabbled
//
//  Created by Juan Orlandini on 9/18/11.
//  Copyright (c) 2011 Gigantical. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WordsClass.h"

@interface DefinitionViewController : UIViewController <UIGestureRecognizerDelegate> {
    IBOutlet UITextView *definitionView;
    IBOutlet UILabel *bigWordLabel;
    
    UISwipeGestureRecognizer *swipe;
}

@property (nonatomic, retain) UISwipeGestureRecognizer *swipe;
@property (retain) WordsClass *wordToSend;
@property (strong, nonatomic) IBOutlet UITextView *definitionView;
@property (strong, nonatomic) IBOutlet UILabel *bigWordLabel;

@end
