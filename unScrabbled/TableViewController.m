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
@synthesize maxwordsize;

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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

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
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
    //                                                    reuseIdentifier:@"UITableViewCell"] autorelease];
    //    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myWordCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                 reuseIdentifier:@"myWordCell"];
    }
    
//    if ([indexPath section] == 0) {
//        Possession *p = [possesions objectAtIndex:[indexPath row]];
//        [[cell textLabel] setText:[p description]];
//    } else {
//        Possession *p = [possesions2 objectAtIndex:[indexPath row]];
//        [[cell textLabel] setText:[p description]];
//    }

    [[cell textLabel] setText:[NSString stringWithFormat:@"%@ - %i",currentword,maxwordsize]];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Words";
}


@end
