//
//  AdressInfoCell.h
//  MySteelHub
//
//  Created by Abhishek Singla on 16/04/17.
//  Copyright © 2017 MySteelHub. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdressInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblAddressType;

@property (weak, nonatomic) IBOutlet UILabel *lblName;

@property (weak, nonatomic) IBOutlet UILabel *lblAddress1;

@property (weak, nonatomic) IBOutlet UILabel *lblAddress2;

@property (weak, nonatomic) IBOutlet UILabel *lblArea;

@property (weak, nonatomic) IBOutlet UILabel *lblContact;

@end
