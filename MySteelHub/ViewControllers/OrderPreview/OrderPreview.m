//
//  OrderPreview.m
//  MySteelHub
//
//  Created by Abhishek Singla on 16/04/17.
//  Copyright © 2017 MySteelHub. All rights reserved.
//

#import "OrderPreview.h"

#import "QuantityCell.h"
#import "GenralInfoCell.h"
#import "AdressInfoCell.h"
#import "FinalAmountCell.h"
#import "EnterRTGS.h"
#import "AddAddressVC.h"

@interface OrderPreview ()

@property (weak, nonatomic) IBOutlet UITableView *tableOrders;

@end

@implementation OrderPreview
@synthesize selectedOrder;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitleLabel:@"Order Detail"];
    [self setMenuButton];
    [self setBackButton];
    
    NSLog(@"%@",selectedOrder);
    NSLog(@"%@",selectedOrder.req.arraySpecifications);
    
    if(_hideProceedButton)
    {
        _btnProceed.hidden = true;
        _tblBottomSpaceConstraint.constant = 0;
    }
}

- (void) viewWillAppear:(BOOL)animated
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"ID == %@", selectedOrder.addressBilling.ID];
    NSArray *filteredArray = [model_manager.profileManager.arrayBillingAddress filteredArrayUsingPredicate:predicate];
    
    if(filteredArray.count>0) {
        selectedOrder.addressBilling = [filteredArray firstObject];
        
    }
    
    NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"ID == %@", selectedOrder.addressShipping.ID];
    NSArray *filteredArray2 = [model_manager.profileManager.arrayShippingAddress filteredArrayUsingPredicate:predicate2];
    
    if(filteredArray2.count>0) {
        selectedOrder.addressShipping = [filteredArray2 firstObject];
        
    }
    
    [_tableOrders reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setTitleLabel:(NSString*)title
{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont fontWithName:@"Raleway-Regular" size:15];
    label.text = title;
    label.frame = CGRectMake(0, 20, self.view.frame.size.width, 50);
    label.textColor=[UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
}

-(void)setBackButton
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 20, 50, 50);
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
}

-(void)setMenuButton
{
    UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    menuButton.frame = CGRectMake(self.view.frame.size.width-50, 20, 50, 50);
    [menuButton setImage:[UIImage imageNamed:@"settings.png"] forState:UIControlStateNormal];
    [menuButton addTarget:self action:@selector(rightMenuAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:menuButton];
}

- (IBAction)clkProceed:(id)sender {
    
    NSLog(@"Proceed Button clicked");
    
    UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
    
    EnterRTGS *viewcontroller = [kMainStoryboard instantiateViewControllerWithIdentifier: @"enterRTGS"];
    
    viewcontroller.selectedOrder = self.selectedOrder;
    [navigationController pushViewController:viewcontroller animated:YES];
}




#pragma mark table view data sources and delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    switch (section) {
        case 0:
            return selectedOrder.req.arraySpecifications.count;
            break;
        case 1:
            return 1;
        case 2:
            return 2;
            break;
        case 3:
            return 1;
            break;
            
        default:
            break;
    }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if(indexPath.section == 0)
    {
        QuantityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuantityCell"];
        
        cell.txtSize.text = [[selectedOrder.req.arraySpecifications objectAtIndex:indexPath.row] valueForKey:@"size"];
        cell.txtQuantity.text = [[selectedOrder.req.arraySpecifications objectAtIndex:indexPath.row] valueForKey:@"quantity"];
        
        
        return cell;
    }
    
    else if (indexPath.section == 1)
    {
        GenralInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GenralInfoCell"];
        
        cell.lblTax.text = selectedOrder.req.taxType;
        [cell.isPhysical setOn:selectedOrder.req.isPhysical];
        [cell.isChemical setOn:selectedOrder.req.isChemical];
        [cell.isCertificateRequired setOn:selectedOrder.req.isTestCertificateRequired];
        
        if([selectedOrder.req.type  isEqual: @"0"])
            [cell.typeRequired setSelectedSegmentIndex:0];
        else
            [cell.typeRequired setSelectedSegmentIndex:1];
        
       if([selectedOrder.req.length  isEqual: @"0"])
            [cell.legthRequired setSelectedSegmentIndex:0];
        else
            [cell.legthRequired setSelectedSegmentIndex:1];
        
        
        cell.lblPreferdBrands.text = [NSString stringWithFormat:@"Brands : %@", [selectedOrder.req.arrayPreferedBrands componentsJoinedByString:@", "]];
        
        cell.lblGraderequired.text = [NSString stringWithFormat:@"Grade Type : %@",selectedOrder.req.gradeRequired];
        
        cell.lblRequiredByDate.text = [NSString stringWithFormat:@"Required By : %@",selectedOrder.req.requiredByDate];
        NSLog(@"Brands :  %@",[selectedOrder.req.arrayPreferedBrands componentsJoinedByString:@", "]);
        
        //cell.lblGraderequired.text = selectedOrder.req.gradeRequired;
        
        cell.lblDeliveryCity.text = [NSString stringWithFormat:@"Delivery city : %@",selectedOrder.req.city];
        
        cell.lblDeliveryState.text = [NSString stringWithFormat:@"Delivery state : %@",selectedOrder.req.state];
        
        cell.lblTax.text = [NSString stringWithFormat:@"Prefered Tax : %@",selectedOrder.req.taxType];
        
        
        
        return cell;
    }
    
    else if (indexPath.section == 2)
    {
        AdressInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AdressInfoCell"];
        
        NSLog(@"Address Type : %@",cell.lblAddressType.text);
        
        if(indexPath.row == 0)
        {
            cell.lblAddressType.text = [NSString stringWithFormat:@"%@ Address",[selectedOrder.addressBilling.addressType capitalizedString]];
            cell.lblName.text = [NSString stringWithFormat:@"Name : %@",[selectedOrder.addressBilling.firmName capitalizedString]];
            cell.lblAddress1.text = [NSString stringWithFormat:@"Address : %@",[selectedOrder.addressBilling.address1 capitalizedString]];
            cell.lblAddress2.text = [selectedOrder.addressBilling.address2 capitalizedString];
            cell.lblArea.text = [[NSString stringWithFormat:@"City : %@, State : %@",selectedOrder.addressBilling.city,selectedOrder.addressBilling.state] capitalizedString];
            cell.lblContact.text = [NSString stringWithFormat:@"M : %@, L : %@",selectedOrder.addressBilling.mobile,selectedOrder.addressBilling.landLine];
        }
        else if(indexPath.row == 1)
        {
            cell.lblAddressType.text = [NSString stringWithFormat:@"%@ Address",[selectedOrder.addressShipping.addressType capitalizedString]];
            cell.lblName.text = [NSString stringWithFormat:@"Name : %@",[selectedOrder.addressShipping.firmName capitalizedString]];
            cell.lblAddress1.text = [NSString stringWithFormat:@"Address : %@",[selectedOrder.addressShipping.address1 capitalizedString]];
            cell.lblAddress2.text = [selectedOrder.addressShipping.address2 capitalizedString];
            cell.lblArea.text = [[NSString stringWithFormat:@"City : %@, State : %@",selectedOrder.addressShipping.city,selectedOrder.addressShipping.state] capitalizedString];
            cell.lblContact.text = [NSString stringWithFormat:@"M : %@, L : %@",selectedOrder.addressShipping.mobile,selectedOrder.addressShipping.landLine];
        }
        
        return cell;

    }
    
    else if (indexPath.section == 3)
    {
        FinalAmountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FinalAmountCell"];
        
        cell.lblOrderId.text = [NSString stringWithFormat:@"Order No : %@",selectedOrder.orderID];
        cell.lblTotalAmount.text = [NSString stringWithFormat:@"Total Amount : %@",selectedOrder.finalAmount];
        
        return cell;

    }
    
    /*
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RequirementCell"];
    UIView *view=(UIView*)[cell.contentView viewWithTag:1];
    [view.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [view.layer setBorderWidth:1.0f];
    
    RequirementI *requirement = [model_manager.requirementManager.arrayPostedRequirements objectAtIndex:indexPath.row];
    
    UILabel *lblCity=(UILabel*)[view viewWithTag:111];
    lblCity.text=[requirement.city capitalizedString];
    
    UILabel *lblQuantity=(UILabel*)[view viewWithTag:222];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(name == %@)", [requirement.state capitalizedString]];
    NSArray *filteredArray = [model_manager.requirementManager.arrayStates filteredArrayUsingPredicate:predicate];
    
    if(filteredArray.count>0) {
        NSLog(@"selected state....%@",[[filteredArray firstObject] valueForKey:@"code"]);
        lblQuantity.text = [[filteredArray firstObject] valueForKey:@"code"];
        
    }
    else
        lblQuantity.text=[requirement.state capitalizedString];
    
    UILabel *lblDate=(UILabel*)[view viewWithTag:333];
    lblDate.text=[requirement.requiredByDate capitalizedString];
    
    UILabel *lblAmount=(UILabel*)[view viewWithTag:444];
    lblAmount.text= [NSString stringWithFormat:@"%@/-",requirement.budget];
    
    UIImageView *imgViewStatus=(UIImageView*)[view viewWithTag:777];
    if(requirement.isUnreadFlag == true)
    {
        imgViewStatus.backgroundColor = RedColor;
    }
    else
    {
        imgViewStatus.backgroundColor = kBlueColor;
    }
    
     */
    
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //UITableViewCell *cell = [UITableViewCell new];
    return [UITableViewCell new];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return 50;
            break;
            
        case 1:
            return 375;
            break;
            
        case 2:
            return 210;
            break;
            
        case 3:
            return 90;
            break;
            
        default:
            break;
    }
    
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2)
    {
        if(indexPath.row == 0)
        {
            //billing address
            AddAddressVC *viewcontroller = [shippingStoryboard instantiateViewControllerWithIdentifier: @"addAddress"];
            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
            viewcontroller.addressType = selectedOrder.addressBilling.addressType;
            viewcontroller.selectedAddress = selectedOrder.addressBilling;
            [navigationController pushViewController:viewcontroller animated:YES];
        }
        else if(indexPath.row == 1)
        {
            //shipping address
            AddAddressVC *viewcontroller = [shippingStoryboard instantiateViewControllerWithIdentifier: @"addAddress"];
            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
            viewcontroller.addressType = selectedOrder.addressShipping.addressType;
            viewcontroller.selectedAddress = selectedOrder.addressShipping;
            [navigationController pushViewController:viewcontroller animated:YES];
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
