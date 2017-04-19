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
#import "EnterRTGS.h"
#import "OrderPreview.h"
#import "Conversation.h"

#define kBtnSelectedBackgroundColor [UIColor colorWithRed:8/255.0 green:188/255.0 blue:211/255.0 alpha:1]

#define kBnSelectedTextColor [UIColor colorWithRed:34/255.00 green:152/255.00 blue:168/255.00 alpha:1]

#define kBtnRegularBackgroundColor [UIColor clearColor]
#define kBtnRegularTextColor [UIColor colorWithRed:8/255.0 green:188/255.0 blue:211/255.0 alpha:1]

@interface PickAddressVC ()
{
    __weak IBOutlet NSLayoutConstraint *contraintPlaceOrder;
    __weak IBOutlet UISegmentedControl *segControl;

    __weak IBOutlet UIButton *btnShippingAddress;
    __weak IBOutlet UIButton *btnBillingAddress;
    NSString *selectedAddressTab;
}

@end

@implementation PickAddressVC

@synthesize isFromMenu,selectedOrder;

-(void)resetButtonsUI
{
   // btnShippingAddress.backgroundColor = kBtnRegularBackgroundColor;
    //btnBillingAddress.backgroundColor = kBtnRegularBackgroundColor;
    //btnShippingAddress.titleLabel.textColor = kBtnRegularTextColor;
    //btnBillingAddress.titleLabel.textColor = kBtnRegularTextColor;
    
   // btnShippingAddress.titleEdgeInsets = UIEdgeInsetsMake(8,0,0, 0);
    //btnBillingAddress.titleEdgeInsets = UIEdgeInsetsMake(8,0,0, 0);


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
    if(isFromMenu)
    {
        _btnPlaceOrder.hidden = YES;
        contraintPlaceOrder.constant = 0;
    }
    else
    {
        _btnPlaceOrder.hidden = NO;
        contraintPlaceOrder.constant = 45;

    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [_tblViewBilling reloadData];
    [_tblViewShipping reloadData];
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
        
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
        
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - Segment Controll


- (IBAction)clkSegment:(id)sender {
    
   // [self hideAllContainers];
    
    switch (segControl.selectedSegmentIndex) {
        case 0:
            _tblViewBilling.hidden = NO;
            _tblViewShipping.hidden = YES;
            selectedAddressTab = @"billing";
            
            break;
            
        case 1:
            _tblViewBilling.hidden = YES;
            _tblViewShipping.hidden = NO;
            selectedAddressTab = @"shipping";
            break;
            
            
        default:
            break;
    }
    
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
                
                [model_manager.profileManager deleteAddress:[model_manager.profileManager.arrayShippingAddress objectAtIndex:indexPath.row] completion:^(NSDictionary *json, NSError *error) {
                    
                    //[_tblViewBilling reloadData];
                    [_tblViewShipping reloadData];
                }];
               
            }
            else
            {
                NSIndexPath *indexPath;
                indexPath = [_tblViewBilling indexPathForCell:cell];
                
                [model_manager.profileManager deleteAddress:[model_manager.profileManager.arrayBillingAddress objectAtIndex:indexPath.row] completion:^(NSDictionary *json, NSError *error) {
                    
                    [_tblViewBilling reloadData];
                }];

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
    
    btnBillingAddress.backgroundColor = [UIColor colorWithRed:8/255.0 green:188/255.0 blue:211/255.0 alpha:1];
    
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
    
    NSString *shippingID,*billingID = @"";
    NSIndexPath *selectedIndexPath = [_tblViewBilling indexPathForSelectedRow];
    Address *selectedBillingAddress = [model_manager.profileManager.arrayBillingAddress objectAtIndex:selectedIndexPath.row];
    
    if(selectedIndexPath==nil)
    {
        //pick billing address
        [self showError:@"Please select billing address"];
    }
    else
    {
        billingID = selectedBillingAddress.ID;
    }
    
    selectedIndexPath = [_tblViewShipping indexPathForSelectedRow];
    Address *selectedShippngAddress = [model_manager.profileManager.arrayShippingAddress objectAtIndex:selectedIndexPath.row];
    
    if(selectedIndexPath==nil)
    {
        //pick shipping address
        [self showError:@"Please select shipping address"];
        return;
    }
    else
    {
        shippingID = selectedShippngAddress.ID;
    }
    
    [SVProgressHUD show];
    [selectedOrder buyerSaveAddress:shippingID withBilling:billingID withCompletion:^(NSDictionary *json, NSError *error) {
        [SVProgressHUD dismiss];
        if([[json valueForKey:@"success"] boolValue])
        {
            if([selectedOrder.RTGS intValue]==0)
            {
                
                
                UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
                
    
                
                OrderPreview *viewcontroller = [kMainStoryboard instantiateViewControllerWithIdentifier: @"orderpreview"];
                
                //set data here
                
                
                //if(self.selectedOrder.req.arrayConversations)
                    
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"isAccepted == %@", @YES];
                NSArray *filteredArray = [self.selectedOrder.req.arrayConversations filteredArrayUsingPredicate:predicate];
                
                
                int finalAmount ;
                
                if(filteredArray.count > 0) {
                    
                    Conversation *objConversation = filteredArray.firstObject;
                    
                    
                    if([objConversation.bargainAmount intValue] >  0)
                    {
                        finalAmount = [objConversation.bargainAmount intValue];                    }
                    else
                    {
                        finalAmount = [objConversation.initialAmount intValue];
                    }
                    
                }
                
                self.selectedOrder.finalAmount = [NSString stringWithFormat:@"%d",finalAmount];
                self.selectedOrder.addressBilling = selectedBillingAddress;
                self.selectedOrder.addressShipping = selectedShippngAddress;
                viewcontroller.selectedOrder = self.selectedOrder;
                [navigationController pushViewController:viewcontroller animated:YES];
                
                
                
            }
            else
            {
                [self.navigationController popViewControllerAnimated:YES];
            }

        }
        else
        {
            [self showError:@"Something went wrong. Please try again"];
        }
    }];

}

-(void)showError:(NSString*)error
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:[NSString stringWithFormat:@"%@", error] preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        // Cancel button tappped.
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    
    // Present action sheet.
    [self presentViewController:alert animated:YES completion:nil];
    
}


@end
