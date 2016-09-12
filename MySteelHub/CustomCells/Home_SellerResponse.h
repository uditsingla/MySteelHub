//
//  Home_SellerResponse.h
//  MySteelHub
//
//  Created by Abhishek Singla on 13/09/16.
//  Copyright © 2016 MySteelHub. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"

@interface Home_SellerResponse : SWTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblSellerName;
@property (weak, nonatomic) IBOutlet UILabel *lblAmount;
@property (weak, nonatomic) IBOutlet UILabel *lblBargainStatus;

@end
