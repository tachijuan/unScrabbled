//
//  TableViewController.m
//  unScrabbled
//
//  Created by Juan Orlandini on 9/12/11.
//  Copyright (c) 2011 Gigantical. All rights reserved.
//

#import "TableViewController.h"
#import "WordsClass.h"

@implementation TableViewController

@synthesize currentword;
@synthesize regexpattern;
@synthesize maxwordsize;
@synthesize dictionary;
@synthesize swipe;

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender 
{
    if ([[segue identifier] isEqualToString:@"defineTheWord"]) {
        DefinitionViewController *myTableViewController = [segue destinationViewController];
        myTableViewController.wordToSend = [wordResults objectAtIndex:[self.tableView indexPathForSelectedRow].row-1];
    }
}

#pragma mark - The code for the searching thing

- (void)findMyWords {

    NSString *field1 = currentword;                            // first "big" field (the tiles)
    NSMutableString *matchword = [[NSMutableString alloc] init];    // the combined tiles (big+connector)
    NSRange range;                                                  // range used during string compares
    BOOL matchfailed;                                               // YES if a tile is not found in dictionary word
    WordsClass *wordWithValue;
    int curwordlen;
    NSString *curword;
    NSMutableArray *foundWords;
        
    foundWords = [[NSMutableArray alloc] init];
    [wordResults removeAllObjects];                                 // clear my word result table
    
    for (curword in dictionary) {                              // iterate through the word list
        int matchescount=0;                                         // initialize vars
        matchfailed = YES;                                          // assume we failed until we test for size
        [matchword setString:field1];      
        curwordlen = [curword length];                             // get length once to make it easier to read below
        
        if ((curwordlen <= [matchword length]) && (curwordlen <= maxwordsize)) // short circuit big words
        {
            matchfailed=NO;                                         // make it cool
            
            for (int i=0;i<curwordlen && matchfailed == NO;i++) {   //iterate through each character in the word & see if we find it
                range=[matchword rangeOfString:[curword substringWithRange:NSMakeRange(i, 1)] options:NSCaseInsensitiveSearch];
                if (range.location == NSNotFound ) {                                     // if we don't find the letter
                    range = [matchword rangeOfString:@"."];                              // see if we have a wild card left
                    if (range.location != NSNotFound ) {                                 // if we do have one
                        matchescount++;                                                  // account for it
                        [matchword replaceCharactersInRange:range withString:@" "];      // and get rid of the match
                        // Capitalize the letter so that we don't count it toward word value
                        curword = [curword stringByReplacingCharactersInRange:NSMakeRange(i,1) withString:[[curword substringWithRange:NSMakeRange(i, 1)] capitalizedString]];
                    } else {
                        matchfailed = YES;                                               // we didn't match the character - FAIL
                    }
                } else {
                    [matchword replaceCharactersInRange:range withString:@" "];   // we do match. account for it and remove from available tiles
                    matchescount++;
                }
                
            }
        }
        
        // add the word to the list if we found one
        if (matchfailed != YES && matchescount<=[field1 length] ) {              
            wordWithValue = [[WordsClass alloc] initWithWord:[curword substringToIndex:curwordlen]];
            [foundWords addObject:wordWithValue];
        }
        
    }
    
    // regex the pattern
    for (WordsClass *currword in foundWords) {
        NSString *wordword = [[currword word] lowercaseString];     // get rid of the uppercase we used for wild cards
        if ([regexpattern length]>0) {
            range = [wordword rangeOfString:regexpattern options:NSRegularExpressionSearch];
            if (range.location != NSNotFound) {
                [wordResults addObject:currword];
            } 
        } else {
            [wordResults addObject:currword];
        }
    }
    
    
    // Change sort order between value(0) and length(1)
    if ([sortSelector selectedSegmentIndex]==0) {
        [wordResults sortUsingFunction:sortByValue context:@""];
    } else {
        [wordResults sortUsingFunction:sortByLength context:@""];
    }
    
//    NSLog(@"findmywords finished");

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

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    wordResults = [[NSMutableArray alloc] init];
    [self findMyWords];
//    NSLog(@"dictionary size: %d, words matched:%d",[dictionary count],[wordResults count]);
//    self.tableView.rowHeight=25;
    
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

# pragma mar - TableView Stuff
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [wordResults count]+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
    //                                                    reuseIdentifier:@"UITableViewCell"] autorelease];
    //    
    NSInteger row = indexPath.row;
//    NSLog(@"row: %d",row);
    
    FancyViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myFancyWordCell"];
    
    if (!cell) {
        cell = [[FancyViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                 reuseIdentifier:@"myFancyWordCell"];
    }
    
    if (row == 0) {
        cell.wordNameLabel.text = [NSString stringWithFormat:@"Words (total:%d)",[wordResults count]];
        cell.wordValueLabel.text =@"Value";
    } else {
        cell.wordNameLabel.text = [[[wordResults objectAtIndex:row-1] word] lowercaseString];
        cell.wordValueLabel.text = [NSString stringWithFormat:@"%i",[[wordResults objectAtIndex:row-1] wordValue]];
    }

    
    return cell;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return @"Words";
//}

- (IBAction)sortSelectorChanged:(id)sender
{
    if ([sortSelector selectedSegmentIndex]==0) {
        [wordResults sortUsingFunction:sortByValue context:@""];
    } else {
        [wordResults sortUsingFunction:sortByLength context:@""];
    }

    [self.tableView reloadData];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];

}


@end
