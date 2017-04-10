//
//  PendingOrdersVC.m
//  MySteelHub
//
//  Created by Abhishek Singla on 13/03/17.
//  Copyright © 2017 MySteelHub. All rights reserved.
//

#import "PendingOrdersVC.h"
#import "PendingOrdersCell.h"
#import "OrderI.h"
#import "EnterRTGS.h"
#import "PickAddressVC.h"

@interface PendingOrdersVC ()
{
    NSArray *arrayOrders;
    __weak IBOutlet UITableView *tablePending;
}
@end

@implementation PendingOrdersVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self refreshData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Custom Functions

-(void)refreshData
{
    NSLog(@"Refresh data called");
    NSMutableDictionary *dictOrderParams = [[NSMutableDictionary alloc]init];
    [dictOrderParams setValue:@"buyer" forKey:@"type"];
    [dictOrderParams setValue:[NSNumber numberWithInt:0] forKey:@"status"];
    
    [[ModelManager modelManager].profileManager getOrderswithOrdertype:dictOrderParams completionBlock:^(NSDictionary *json, NSError *error)
     {
         if([[json valueForKey:@"success"] isEqualToString:@"true"])
         {
             arrayOrders = model_manager.profileManager.arrayPendingOrders;
             
             [tablePending reloadData];
         }
     }];
}


#pragma mark

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:YES];
    NSLog(@"call aa gyi");
}


#pragma mark - table view data sources and delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0)
        return model_manager.profileManager.arrayRejectedOrders.count;
    else
        return model_manager.profileManager.arrayPendingOrders.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName = @"Incorrect RTGS";
            break;
        case 1:
            sectionName = @"Pending RTGS";
            break;
        default:
            sectionName = @"";
            break;
    }
    return sectionName;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section==0)
    {
        if(model_manager.profileManager.arrayRejectedOrders.count>0)
            return 30;
        else
            return 0;
    }
    else if(section==1)
    {
        if(model_manager.profileManager.arrayPendingOrders.count>0)
            return 30;
        else
            return 0;
    }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PendingOrdersCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pendingcell"];
       
    OrderI *order;
    if(indexPath.section==0)
        order = [model_manager.profileManager.arrayRejectedOrders objectAtIndex:indexPath.row];
    else
        order = [model_manager.profileManager.arrayPendingOrders objectAtIndex:indexPath.row];

    cell.lblCity.text = order.req.city;
    cell.lblState.text = order.req.state;
    cell.lbldate.text = order.req.requiredByDate;
    cell.lblAmount.text = order.finalAmount;

    
    //[[json valueForKey:@"data"] valueForKey:@"order_status"];

   
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderI *order;
    if(indexPath.section==0)
        order = [model_manager.profileManager.arrayRejectedOrders objectAtIndex:indexPath.row];
    else
        order = [model_manager.profileManager.arrayPendingOrders objectAtIndex:indexPath.row];
    
    if([order.billingID intValue]==0 && [order.shippingID intValue]==0)
    {
        PickAddressVC *viewcontroller = [shippingStoryboard instantiateViewControllerWithIdentifier: @"pickAddress"];
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        viewcontroller.isFromMenu = NO;
        viewcontroller.selectedOrder = order;
        [navigationController pushViewController:viewcontroller animated:NO];
        
    }
    else if([order.RTGS intValue]==0)
    {
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        
        EnterRTGS *viewcontroller = [kMainStoryboard instantiateViewControllerWithIdentifier: @"enterRTGS"];
        viewcontroller.selectedOrder = order;
        [navigationController pushViewController:viewcontroller animated:YES];
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
