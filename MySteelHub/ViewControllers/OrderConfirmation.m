//
//  OrderConfirmation.m
//  MySteelHub
//
//  Created by Abhishek Singla on 30/11/16.
//  Copyright © 2016 MySteelHub. All rights reserved.
//

#import "OrderConfirmation.h"
#import "OrderI.h"
#import "PickAddressVC.h"

@interface OrderConfirmation ()
@property (weak, nonatomic) IBOutlet UITableView *tableOrderDescription;

@property (weak, nonatomic) IBOutlet UIButton *btnAccept;
@end

@implementation OrderConfirmation
@synthesize selectedRequirement,selectedConversation;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //self.contentView.backgroundColor = kBlueColor;
    
    [self setBackButton];
    [self setMenuButton];
    [self setTitleLabel:@"Confirm Order"];
    
    if(selectedConversation.isAccepted)
        _btnAccept.hidden = YES;
    
    self.tableOrderDescription.tableFooterView = [UIView new];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -TableView Delegates
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return selectedConversation.arraySpecificationsResponse.count + 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
  static NSString *_simpleTableIdentifier = @"Cell";
        
        UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:_simpleTableIdentifier];
        // Configure the cell...
        if(cell==nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_simpleTableIdentifier];
        }
    
    
    float height = 21;
    
    UILabel *lbl1 = (UILabel *)[cell.contentView viewWithTag:1];
    if(indexPath.row==0)
        lbl1.text = @"Size";
    else
        lbl1.text = [[selectedConversation.arraySpecificationsResponse objectAtIndex:indexPath.row-1]valueForKey:@"size"];
    
    UILabel *lbl2 = (UILabel *)[cell.contentView viewWithTag:2];
    if(indexPath.row==0)
        lbl2.text = @"Quantity";
    else
        lbl2.text = [[selectedConversation.arraySpecificationsResponse objectAtIndex:indexPath.row-1]valueForKey:@"quantity"];
    
    UILabel *lbl3 = (UILabel *)[cell.contentView viewWithTag:3];
    lbl3.hidden = YES;

    UILabel *lbl4 = (UILabel *)[cell.contentView viewWithTag:4];
    lbl4.hidden = YES;
    
    lbl1.frame = CGRectMake(0, 12, (cell.frame.size.width/2), height);
    lbl2.frame = CGRectMake((cell.frame.size.width/2), 12, (cell.frame.size.width/2), height);
    
    int currentRow = (int)indexPath.row;
    
    if(currentRow>0)
        currentRow = (int)indexPath.row - 1;
    
    if([[selectedConversation.arraySpecificationsResponse objectAtIndex:currentRow]valueForKey:@"unit price"])
    {
        lbl3.hidden = NO;
        if(indexPath.row==0)
            lbl3.text = @"Rate";
        else
            lbl3.text = [[selectedConversation.arraySpecificationsResponse objectAtIndex:indexPath.row-1]valueForKey:@"unit price"];
        
        lbl1.frame = CGRectMake(0, 12, (cell.frame.size.width/3), height);
        lbl2.frame = CGRectMake((cell.frame.size.width/3), 12, (cell.frame.size.width/3), height);
        lbl3.frame = CGRectMake(((cell.frame.size.width/3)*2), 12, (cell.frame.size.width/3), height);
    }
    
    if([[selectedConversation.arraySpecificationsResponse objectAtIndex:currentRow]valueForKey:@"new unit price"])
    {
        lbl4.hidden = NO;
        if(indexPath.row==0)
            lbl4.text = @"New Rate";
        else
            lbl4.text = [[selectedConversation.arraySpecificationsResponse objectAtIndex:indexPath.row-1]valueForKey:@"new unit price"];
        
        lbl1.frame = CGRectMake(0, 12, (cell.frame.size.width/4), height);
        lbl2.frame = CGRectMake((cell.frame.size.width/4),12 , (cell.frame.size.width/4), height);
        lbl3.frame = CGRectMake(((cell.frame.size.width/4)*2), 12, (cell.frame.size.width/4), height);
        lbl4.frame = CGRectMake(((cell.frame.size.width/4)*3),12 , (cell.frame.size.width/4), height);
    }
    
    [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    
        return cell;
}
    

- (IBAction)clkSubmit:(id)sender {
    
    NSLog(@"Click Submit");
    
    if(!selectedConversation.isAccepted)
    {
        [SVProgressHUD show];
        [selectedRequirement acceptRejectDeal:selectedConversation.sellerID status:YES withCompletion:^(NSDictionary *json, NSError *error)
         {
             [SVProgressHUD dismiss];
             
             if(json)
             {
                 selectedConversation.isAccepted = YES;
                 
                 selectedConversation.isBuyerRead = true;
                 
                 _btnAccept.hidden = YES;
                 
                 [self pushToAddressScreen:[json valueForKey:@"order_id"] seller:selectedConversation.sellerID];
             }
             else
             {
                 [self showAlert:@"Some error occured. Please try again"];
             }
         }];
    }
}

-(void)pushToAddressScreen:(NSString*)orderID seller:(NSString *)sellerId
{
    OrderI *order = [OrderI new];
    order.orderID = orderID;
    order.sellerID = sellerId;
    order.req = selectedRequirement;
    
    PickAddressVC *viewcontroller = [shippingStoryboard instantiateViewControllerWithIdentifier: @"pickAddress"];
    UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
    viewcontroller.isFromMenu = NO;
    viewcontroller.selectedOrder = order;
    [navigationController pushViewController:viewcontroller animated:NO];
}


-(void)showAlert:(NSString *)errorMsg
{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@""
                                  message:errorMsg
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleCancel
                         handler:^(UIAlertAction * action)
                         {
                             //Do some thing here
                             //   [view dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    [alert addAction:ok];
    
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
