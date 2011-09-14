//
//  mainViewController.m
//  unScrabbled
//
//  Created by Juan Orlandini on 9/12/11.
//  Copyright (c) 2011 Gigantical. All rights reserved.
//

#import "mainViewController.h"
#import "TableViewController.h"
#import "WordsClass.h"

@implementation mainViewController
@synthesize tiles;
@synthesize regexstring;
@synthesize maxWordLengthSlider;


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender 
{
    if ([[segue identifier] isEqualToString:@"showTable"]) {
        TableViewController *myTableViewController = [segue destinationViewController];
        myTableViewController.currentword = [tiles text];
        myTableViewController.regexpattern = [regexstring text];
        myTableViewController.maxwordsize = maxwordsize;
        myTableViewController.dictionary = dictionary;
    }
}

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
    maxwordsize = [maxWordLengthSlider value];
    
    dictionary = [[NSMutableArray alloc] init];
    
    FILE *myfile;
    char readword[50];
    
    NSString *ourHome = NSHomeDirectory();
    NSString *wordsFile = [ourHome stringByAppendingPathComponent:@"unScrabbled.app/enable1.txt"];
    NSLog(@"Path: %@",wordsFile);
    
    myfile = fopen([wordsFile UTF8String], "r");
    while (fgets(readword,sizeof(readword),myfile)) {
        [dictionary addObject:[[NSString alloc] initWithUTF8String:readword]];
        //        [dictionary addObject:[[NSString alloc] initWithCString:readword encoding:NSASCIIStringEncoding]];
    }

    NSLog(@"Loaded words: %d",[dictionary count]);    
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

- (IBAction)doItButton:(id)sender {
    [regexstring resignFirstResponder];
    [tiles resignFirstResponder];
    
}


- (IBAction)maxWordLengthSlider:(id)sender {
    maxwordsize = [maxWordLengthSlider value];
    [maxWordLabel setText:[NSString stringWithFormat:@"%i",maxwordsize]];
}


@end
