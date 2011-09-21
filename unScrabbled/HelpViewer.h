//
//  HelpViewer.h
//  unScrabbled
//
//  Created by Juan Orlandini on 9/16/11.
//  Copyright (c) 2011 Gigantical. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpViewer : UIViewController <UIGestureRecognizerDelegate> {

    IBOutlet UITextView *helpViewer;
    
    UISwipeGestureRecognizer *swipe;

}

@property (nonatomic, retain) UISwipeGestureRecognizer *swipe;
@property (retain, nonatomic) IBOutlet UITextView *helpViewer;

@end
