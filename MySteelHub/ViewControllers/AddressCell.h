//
//  AddressCell.h
//  MySteelHub
//
//  Created by Amit Yadav on 23/10/16.
//  Copyright © 2016 MySteelHub. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"


@interface AddressCell : SWTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblAddressLine1;
@property (weak, nonatomic) IBOutlet UILabel *lblAddressLine2;
@property (weak, nonatomic) IBOutlet UILabel *lblAreaInfo;
@property (weak, nonatomic) IBOutlet UILabel *lblContactInfo;
@property (weak, nonatomic) IBOutlet UIButton *btnRadio;
@property (weak, nonatomic) IBOutlet UIImageView *imgTick;

@end
