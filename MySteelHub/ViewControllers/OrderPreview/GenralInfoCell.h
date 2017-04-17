//
//  GenralInfoCell.h
//  MySteelHub
//
//  Created by Abhishek Singla on 16/04/17.
//  Copyright © 2017 MySteelHub. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GenralInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UISwitch *isPhysical;
@property (weak, nonatomic) IBOutlet UISwitch *isChemical;
@property (weak, nonatomic) IBOutlet UISwitch *isCertificateRequired;
@property (weak, nonatomic) IBOutlet UISegmentedControl *legthRequired;
@property (weak, nonatomic) IBOutlet UISegmentedControl *typeRequired;
@property (weak, nonatomic) IBOutlet UILabel *lblPreferdBrands;
@property (weak, nonatomic) IBOutlet UILabel *lblGraderequired;
@property (weak, nonatomic) IBOutlet UILabel *lblRequiredByDate;
@property (weak, nonatomic) IBOutlet UILabel *lblDeliveryCity;
@property (weak, nonatomic) IBOutlet UILabel *lblDeliveryState;
@property (weak, nonatomic) IBOutlet UILabel *lblTax;


@end
