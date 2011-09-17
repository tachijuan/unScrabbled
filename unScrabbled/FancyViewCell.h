//
//  FancyViewCell.h
//  unScrabbled
//
//  Created by Juan Orlandini on 9/16/11.
//  Copyright (c) 2011 Gigantical. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FancyViewCell : UITableViewCell {
    IBOutlet UILabel *wordNameLabel;
    IBOutlet UILabel *wordValueLabel;
}

@property (retain, nonatomic) IBOutlet UILabel *wordNameLabel;
@property (retain, nonatomic) IBOutlet UILabel *wordValueLabel;

@end
