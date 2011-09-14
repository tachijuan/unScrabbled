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


#pragma mark - The code for the searching thing

- (void)findMyWords {

    NSString *field1 = currentword;                            // first "big" field (the tiles)
    NSMutableString *matchword = [[NSMutableString alloc] init];    // the combined tiles (big+connector)
    NSRange range;                                                  // range used during string compares
    BOOL matchfailed;                                               // YES if a tile is not found in dictionary word
    WordsClass *wordWithValue;
    int curlength;
    NSString *curword;
    NSMutableArray *foundWords;
        
    foundWords = [[NSMutableArray alloc] init];
    [wordResults removeAllObjects];                                 // clear my word result table
    
    for (curword in dictionary) {                              // iterate through the word list
        int matchescount=0;                                         // initialize vars
        matchfailed = YES;                                          // assume we failed until we test for size
        [matchword setString:field1];      
        curlength = [curword length]-1;                             // calculate real length. need to fix this so word doesn't have null
        
        if ((curlength <= [matchword length]) && (curlength <= maxwordsize)) // short circuit big words
        {
            matchfailed=NO;                                         // make it cool
            
            for (int i=0;i<curlength && matchfailed == NO;i++) {   //iterate through each character in the word & see if we find it
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
            wordWithValue = [[WordsClass alloc] initWithWord:[curword substringToIndex:curlength]];
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
    
    // Build the string to show. If we have a reg-ex compare that first. Otherwise, add all the strings we have found
//    for (WordsClass *currword in wordResults) {
//        NSString *wordword = [[currword word] lowercaseString];     // get rid of the uppercase we used for wild cards
//        if ([field2 length]>0) {
//            range = [wordword rangeOfString:field2 options:NSRegularExpressionSearch];
//            if (range.location != NSNotFound) {
//                [string appendString:[NSString stringWithFormat:@"%-15.15@ %i\n",wordword,[currword wordValue]]];
//            } 
//        } else {
//            [string appendString:[NSString stringWithFormat:@"%-15.15@ %i\n",wordword,[currword wordValue]]];
//        }
//    }
    NSLog(@"findmywords finished");

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
    wordResults = [[NSMutableArray alloc] init];
    [self findMyWords];
    NSLog(@"dictionary size: %d, words matched:%d",[dictionary count],[wordResults count]);
    self.tableView.rowHeight=25;
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
//    return [possesions count];
    return [wordResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
    //                                                    reuseIdentifier:@"UITableViewCell"] autorelease];
    //    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myWordCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2
                 reuseIdentifier:@"myWordCell"];
    }
    
    NSInteger row = indexPath.row;
    cell.textLabel.text = [[[wordResults objectAtIndex:row] word] lowercaseString];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%i",[[wordResults objectAtIndex:row] wordValue]];
    
//    CGRect frame = cell.accessoryView.bounds;
//    UILabel *myLabel = [[UILabel alloc] initWithFrame:frame];
//    myLabel.text = [NSString stringWithFormat:@"%i",maxwordsize];
//    [cell.accessoryView addSubview:myLabel];
    
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
