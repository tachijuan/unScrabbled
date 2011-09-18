//
//  DefinitionViewController.m
//  unScrabbled
//
//  Created by Juan Orlandini on 9/18/11.
//  Copyright (c) 2011 Gigantical. All rights reserved.
//

#import "DefinitionViewController.h"

@implementation DefinitionViewController
@synthesize definitionView;
@synthesize wordToSend;
@synthesize bigWordLabel;

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
    
    NSString *wordToShow = [[wordToSend word] lowercaseString];
    NSString *tmpString = [NSString stringWithFormat:@"%@%@",@"http://orlandini.us/cgi-bin/dict.cgi?word=",wordToShow];
            
    NSString *wordfield99 = [NSString stringWithContentsOfURL:[NSURL URLWithString:tmpString] encoding:NSUTF8StringEncoding error:nil];
    
    [definitionView setText:wordfield99];
    [bigWordLabel setText:wordToShow];

}

- (void)viewDidUnload
{
    [self setDefinitionView:nil];
    definitionView = nil;
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
