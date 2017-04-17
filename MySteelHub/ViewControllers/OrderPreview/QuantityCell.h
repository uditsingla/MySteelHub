//
//  QuantityCell.h
//  MySteelHub
//
//  Created by Abhishek Singla on 16/04/17.
//  Copyright © 2017 MySteelHub. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuantityCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *txtSize;
@property (weak, nonatomic) IBOutlet UITextField *txtQuantity;

@end
