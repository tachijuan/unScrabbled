//
//  FancyViewCell.m
//  unScrabbled
//
//  Created by Juan Orlandini on 9/16/11.
//  Copyright (c) 2011 Gigantical. All rights reserved.
//

#import "FancyViewCell.h"

@implementation FancyViewCell
@synthesize wordNameLabel;
@synthesize wordValueLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
