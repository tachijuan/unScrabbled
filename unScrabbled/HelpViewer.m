//
//  HelpViewer.m
//  unScrabbled
//
//  Created by Juan Orlandini on 9/16/11.
//  Copyright (c) 2011 Gigantical. All rights reserved.
//

#import "HelpViewer.h"

@implementation HelpViewer
@synthesize helpViewer;
@synthesize swipe;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *myHelpContent;
    
    NSString *ourHome = NSHomeDirectory();
    NSString *helpFile = [ourHome stringByAppendingPathComponent:@"unScrabbled.app/README"];
//    NSLog(@"Path: %@",helpFile);
    myHelpContent = [NSString stringWithContentsOfFile:helpFile encoding:NSASCIIStringEncoding error:NULL];
    [helpViewer setText:myHelpContent];
    
    UIGestureRecognizer *recognizer;
    
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    self.swipe = (UISwipeGestureRecognizer *)recognizer;
    swipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:recognizer];

}

- (void)handleSwipe:(UISwipeGestureRecognizer *)recognizer {
//    NSLog(@"got recognizer");
    [[self navigationController] popViewControllerAnimated:YES];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
