//
//  PickAddressVC.h
//  MySteelHub
//
//  Created by Amit Yadav on 23/10/16.
//  Copyright © 2016 MySteelHub. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"

@interface PickAddressVC : BaseViewController<UITableViewDelegate,UITableViewDataSource,SWTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UIButton *btnAdd;

@property (weak, nonatomic) IBOutlet UITableView *tblViewBilling;

@property (weak, nonatomic) IBOutlet UITableView *tblViewShipping;

@property (assign, nonatomic) BOOL isFromMenu;

@property (weak, nonatomic) IBOutlet UIButton *btnPlaceOrder;

- (IBAction)btnBillingAction:(UIButton *)sender;

- (IBAction)btnShippingAction:(UIButton *)sender;

- (IBAction)btnAddAction:(UIButton *)sender;

- (IBAction)btnPlaceOrderAction:(UIButton *)sender;

@end
