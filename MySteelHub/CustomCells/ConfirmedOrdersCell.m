//
//  ConfirmedOrdersCell.m
//  MySteelHub
//
//  Created by Abhishek Singla on 19/03/17.
//  Copyright © 2017 MySteelHub. All rights reserved.
//

#import "ConfirmedOrdersCell.h"

@implementation ConfirmedOrdersCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    _lblCity.font = fontRaleway13;
    _lblState.font = fontRaleway13;
    _lbldate.font = fontRaleway13;
    _lblAmount.font = fontRaleway13;
}

@end
