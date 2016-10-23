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

@interface PickAddressVC ()

@end

@implementation PickAddressVC

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

    
}

#pragma mark table view data sources and delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == _tblViewShipping)
        return 1;
    else if(tableView == _tblViewBilling)
        return 1;
    
    return 0;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView == _tblViewShipping)
    {
        ShippingAddressCell *cell = (ShippingAddressCell*)[tableView dequeueReusableCellWithIdentifier:@"shipping"];
        
        NSArray *arrayRightBtns = [self rightButtons];
        [cell setRightUtilityButtons:arrayRightBtns WithButtonWidth:80];
        [cell setDelegate:self];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if(tableView == _tblViewBilling)
    {
        AddressCell *cell = (AddressCell*)[tableView dequeueReusableCellWithIdentifier:@"billing"];
        
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
            
            break;
        }
        case 1:
        {
            NSLog(@"Delete CLicked");
            
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
    _tblViewBilling.hidden = NO;
    _tblViewShipping.hidden = YES;
}

- (IBAction)btnShippingAction:(UIButton *)sender {
    _tblViewBilling.hidden = YES;
    _tblViewShipping.hidden = NO;
}

- (IBAction)btnAddAction:(UIButton *)sender {
    
    UIViewController *viewcontroller = [shippingStoryboard instantiateViewControllerWithIdentifier: @"addAddress"];
    UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
    
    [navigationController pushViewController:viewcontroller animated:NO];
}

- (IBAction)btnPlaceOrderAction:(UIButton *)sender {
}
@end
