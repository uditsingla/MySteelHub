//
//  ConfirmedOrdersVC.m
//  MySteelHub
//
//  Created by Abhishek Singla on 13/03/17.
//  Copyright © 2017 MySteelHub. All rights reserved.
//

#import "ConfirmedOrdersVC.h"
#import "EmptyCell.h"
#import "ConfirmedOrdersCell.h"
#import "OrderI.h"

@interface ConfirmedOrdersVC ()
{
    __weak IBOutlet UITableView *tableConfirmed;
    NSArray *arrayOrders;


}
@end

@implementation ConfirmedOrdersVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    tableConfirmed.tableFooterView = [UIView new];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self refreshData];
}

#pragma mark table view data sources and delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return model_manager.profileManager.arrayConfirmedOrders.count;
    if (model_manager.profileManager.arrayConfirmedOrders.count > 0) {
        return model_manager.profileManager.arrayConfirmedOrders.count;
    }
    else
        return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if(model_manager.profileManager.arrayConfirmedOrders.count > 0)
    {
        ConfirmedOrdersCell *cell = [tableView dequeueReusableCellWithIdentifier:@"confirmedcell"];
        
        UIView *view=(UIView*)[cell.contentView viewWithTag:1];
        [view.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [view.layer setBorderWidth:1.0f];
        
        OrderI *order = [model_manager.profileManager.arrayConfirmedOrders objectAtIndex:indexPath.row];
        
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
    else
    {
        EmptyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EmptyCell"];
        
        UIView *view=(UIView*)[cell.contentView viewWithTag:1];
        [view.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [view.layer setBorderWidth:1.0f];
        
        
        
        //cell.lblMsg.text = @"No Data Received";
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    }
    
    return [UITableViewCell new];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (model_manager.profileManager.arrayConfirmedOrders.count > 0) {
        return 90;
    }
    else
        return self.view.frame.size.height;
    
}


-(void)refreshData
{
    NSLog(@"Refresh data called");
    NSMutableDictionary *dictOrderParams = [[NSMutableDictionary alloc]init];
    [dictOrderParams setValue:@"buyer" forKey:@"type"];
    [dictOrderParams setValue:[NSNumber numberWithInt:1] forKey:@"status"];
    
    [[ModelManager modelManager].profileManager getOrderswithOrdertype:dictOrderParams completionBlock:^(NSDictionary *json, NSError *error)
     {
         if([[json valueForKey:@"success"] isEqualToString:@"true"])
         {
             arrayOrders = model_manager.profileManager.arrayConfirmedOrders;
             
             [tableConfirmed reloadData];
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
