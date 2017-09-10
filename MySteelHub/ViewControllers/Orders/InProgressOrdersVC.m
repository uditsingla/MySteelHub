//
//  InProgressOrdersVC.m
//  MySteelHub
//
//  Created by Abhishek Singla on 13/03/17.
//  Copyright © 2017 MySteelHub. All rights reserved.
//

#import "InProgressOrdersVC.h"
#import "OrderI.h"
#import "InProgressOrdersCell.h"
#import "OrderPreview.h"

@interface InProgressOrdersVC ()
{
    __weak IBOutlet UITableView *tableInProgress;
    NSArray *arrayOrders;

}
@end

@implementation InProgressOrdersVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    tableInProgress.tableFooterView = [UIView new];

}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark table view data sources and delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"Rows count : %lu",(unsigned long)model_manager.profileManager.arrayInprogressOrders.count);
    return model_manager.profileManager.arrayInprogressOrders.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    InProgressOrdersCell *cell = [tableView dequeueReusableCellWithIdentifier:@"inprogresscell"];
    
    
    UIView *view=(UIView*)[cell.contentView viewWithTag:1];
    [view.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [view.layer setBorderWidth:1.0f];
    
    OrderI *order = [model_manager.profileManager.arrayInprogressOrders objectAtIndex:indexPath.row];
    
    cell.lblCity.text = order.req.city.capitalizedString;
    cell.lblState.text = order.req.state;
    cell.lbldate.text = order.req.requiredByDate;
    cell.lblAmount.text = [NSString stringWithFormat:@"%@.00/- Rs",order.finalAmount];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(SELF.name contains[cd] %@)",order.req.state];
    
    NSArray *filteredArray = [model_manager.requirementManager.arrayStates filteredArrayUsingPredicate:predicate];
    
    if(filteredArray.count>0) {
        NSLog(@"selected state....%@",[[filteredArray firstObject] valueForKey:@"code"]);
        cell.lblState.text = [[filteredArray firstObject] valueForKey:@"code"];
        
    }
    else
        cell.lblState.text=[order.req.state capitalizedString];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
    
    OrderPreview *viewcontroller = [kMainStoryboard instantiateViewControllerWithIdentifier: @"orderpreview"];
    OrderI *order = [model_manager.profileManager.arrayInprogressOrders objectAtIndex:indexPath.row];
    viewcontroller.selectedOrder = order;
    viewcontroller.hideProceedButton = true;
    [navigationController pushViewController:viewcontroller animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

-(void)refreshData
{
    NSLog(@"Refresh data called");
    NSMutableDictionary *dictOrderParams = [[NSMutableDictionary alloc]init];
    [dictOrderParams setValue:@"buyer" forKey:@"type"];
    [dictOrderParams setValue:[NSNumber numberWithInt:3] forKey:@"status"];
    
    [[ModelManager modelManager].profileManager getOrderswithOrdertype:dictOrderParams completionBlock:^(NSDictionary *json, NSError *error)
     {
         if([[json valueForKey:@"success"] isEqualToString:@"true"])
         {
             arrayOrders = model_manager.profileManager.arrayInprogressOrders;
             
             [tableInProgress reloadData];
         }
     }];
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
