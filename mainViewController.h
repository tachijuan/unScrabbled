//
//  mainViewController.h
//  unScrabbled
//
//  Created by Juan Orlandini on 9/12/11.
//  Copyright (c) 2011 Gigantical. All rights reserved.
//

#import <UIKit/UIKit.h>

int maxwordsize;

@interface mainViewController : UIViewController {
    UIButton *doIt;
    UITextField *tiles;
    UITextField *regexstring;
    IBOutlet UISlider *maxWordLengthSlider;
}

@property (nonatomic, retain) IBOutlet UITextField *tiles;
@property (nonatomic, retain) IBOutlet UITextField *regexstring;

- (IBAction)doItButton:(id)sender;

@end
