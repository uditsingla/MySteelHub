//
//  PickAddressVC.m
//  MySteelHub
//
//  Created by Amit Yadav on 23/10/16.
//  Copyright © 2016 MySteelHub. All rights reserved.
//

#import "PickAddressVC.h"
#import "AddressCell.h"
#import "ShippingAddressCell.h"
#import "AddAddressVC.h"

#define kBtnSelectedBackgroundColor [UIColor darkGrayColor]
#define kBnSelectedTextColor [UIColor colorWithRed:34/255.00 green:152/255.00 blue:168/255.00 alpha:1]

#define kBtnRegularBackgroundColor [UIColor colorWithRed:170/255.00 green:170/255.00 blue:170/255.00 alpha:1]
#define kBtnRegularTextColor [UIColor whiteColor]

@interface PickAddressVC ()
{
    __weak IBOutlet UIButton *btnShippingAddress;
    __weak IBOutlet UIButton *btnBillingAddress;
    NSString *selectedAddressTab;
}

@end

@implementation PickAddressVC

@synthesize isFromMenu;

-(void)resetButtonsUI
{
    btnShippingAddress.backgroundColor = kBtnRegularBackgroundColor;
    btnBillingAddress.backgroundColor = kBtnRegularBackgroundColor;
    btnShippingAddress.titleLabel.textColor = kBtnRegularTextColor;
    btnBillingAddress.titleLabel.textColor = kBtnRegularTextColor;
    
    btnShippingAddress.titleEdgeInsets = UIEdgeInsetsMake(8,0,0, 0);
    btnBillingAddress.titleEdgeInsets = UIEdgeInsetsMake(8,0,0, 0);


}


#pragma mark - Default Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitleLabel:@"Pick Address"];
    [self setBackButton];
    
    [self.view bringSubviewToFront:_btnAdd];
    
    _tblViewBilling.dataSource = self;
    _tblViewBilling.delegate = self;
    
    _tblViewShipping.dataSource = self;
    _tblViewShipping.delegate = self;
    
    _tblViewBilling.hidden = NO;
    _tblViewShipping.hidden = YES;

    [self btnBillingAction:nil];
//    selectedAddressTab = @"billing";
}

#pragma mark table view data sources and delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == _tblViewShipping)
        return model_manager.profileManager.arrayShippingAddress.count;
    else if(tableView == _tblViewBilling)
        return model_manager.profileManager.arrayBillingAddress.count;
    
    return 0;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView == _tblViewShipping)
    {
        ShippingAddressCell *cell = (ShippingAddressCell*)[tableView dequeueReusableCellWithIdentifier:@"shipping"];
        
        Address *selectedAddress = [model_manager.profileManager.arrayShippingAddress objectAtIndex:indexPath.row];
        
        cell.lblName.text = selectedAddress.firmName;
        cell.lblAddressLine1.text = selectedAddress.address1;
        cell.lblAddressLine2.text = selectedAddress.address2;
        cell.lblAreaInfo.text = [NSString stringWithFormat:@"%@, %@",selectedAddress.city,selectedAddress.state];
        cell.lblContactInfo.text = [NSString stringWithFormat:@"%@, %@",selectedAddress.mobile,selectedAddress.landLine];

        
        NSArray *arrayRightBtns = [self rightButtons];
        [cell setRightUtilityButtons:arrayRightBtns WithButtonWidth:80];
        [cell setDelegate:self];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if(tableView == _tblViewBilling)
    {
        AddressCell *cell = (AddressCell*)[tableView dequeueReusableCellWithIdentifier:@"billing"];
        
        Address *selectedAddress = [model_manager.profileManager.arrayBillingAddress objectAtIndex:indexPath.row];
        
        cell.lblName.text = selectedAddress.firmName;
        cell.lblAddressLine1.text = selectedAddress.address1;
        cell.lblAddressLine2.text = selectedAddress.address2;
        cell.lblAreaInfo.text = [NSString stringWithFormat:@"%@, %@",selectedAddress.city,selectedAddress.state];
        cell.lblContactInfo.text = [NSString stringWithFormat:@"%@, %@",selectedAddress.mobile,selectedAddress.landLine];

        
        NSArray *arrayRightBtns = [self rightButtons];
        [cell setRightUtilityButtons:arrayRightBtns WithButtonWidth:80];
        [cell setDelegate:self];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - Swipe Cell Delegate
- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell {
    return YES;
}


- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:248/255.00 green:123/255.00 blue:1/255.00 alpha:1]
                                                title:@"Edit"];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor redColor]
                                                title:@"Delete"];
    
    return rightUtilityButtons;
}


- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    switch (index) {
            
        case 0:
        {
            NSLog(@"Edit CLicked");
            
            if ([cell isKindOfClass:[ShippingAddressCell class]])
            {
                NSIndexPath *indexPath;
                indexPath = [_tblViewShipping indexPathForCell:cell];
                AddAddressVC *viewcontroller = [shippingStoryboard instantiateViewControllerWithIdentifier: @"addAddress"];
                UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
                viewcontroller.addressType = selectedAddressTab;
                viewcontroller.selectedAddress = [model_manager.profileManager.arrayShippingAddress objectAtIndex:indexPath.row];
                [navigationController pushViewController:viewcontroller animated:NO];

            }
            else
            {
                NSIndexPath *indexPath;
                indexPath = [_tblViewBilling indexPathForCell:cell];
                AddAddressVC *viewcontroller = [shippingStoryboard instantiateViewControllerWithIdentifier: @"addAddress"];
                UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
                viewcontroller.addressType = selectedAddressTab;
                viewcontroller.selectedAddress = [model_manager.profileManager.arrayBillingAddress objectAtIndex:indexPath.row];
                [navigationController pushViewController:viewcontroller animated:NO];

            }
            
            break;
        }
        case 1:
        {
            NSLog(@"Delete CLicked");
            
            if ([cell isKindOfClass:[ShippingAddressCell class]])
            {
                NSIndexPath *indexPath;
                indexPath = [_tblViewShipping indexPathForCell:cell];
            }
            else
            {
                NSIndexPath *indexPath;
                indexPath = [_tblViewBilling indexPathForCell:cell];
            }
            
            break;
        }
            
        default: break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnBillingAction:(UIButton *)sender {
    
    [self resetButtonsUI];
    
    btnBillingAddress.backgroundColor = kBtnSelectedBackgroundColor;
    
    _tblViewBilling.hidden = NO;
    _tblViewShipping.hidden = YES;
    selectedAddressTab = @"billing";
}

- (IBAction)btnShippingAction:(UIButton *)sender {
    
    [self resetButtonsUI];
    
    btnShippingAddress.backgroundColor = kBtnSelectedBackgroundColor;
    
    _tblViewBilling.hidden = YES;
    _tblViewShipping.hidden = NO;
    selectedAddressTab = @"shipping";
}

- (IBAction)btnAddAction:(UIButton *)sender {
    
    AddAddressVC *viewcontroller = [shippingStoryboard instantiateViewControllerWithIdentifier: @"addAddress"];
    UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
    viewcontroller.addressType = selectedAddressTab;
    [navigationController pushViewController:viewcontroller animated:NO];
}

- (IBAction)btnPlaceOrderAction:(UIButton *)sender {
}
@end
