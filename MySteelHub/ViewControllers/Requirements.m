//
//  Requirements.m
//  MySteelHub
//
//  Created by Apple on 07/05/16.
//  Copyright © 2016 MySteelHub. All rights reserved.
//

#import "Requirements.h"
#import "Home.h"
#import "Constants.h"
#import "SWTableViewCell.h"


@interface Requirements ()<UITableViewDelegate,UITableViewDataSource,RequirementListingDelegate,SWTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tblView;


@end

@implementation Requirements
{
    //Home *homeVC;
}

-(void)viewWillAppear:(BOOL)animated
{
    //check for navigation of controller
 //   homeVC.isRequirmentDetailsClicked = false;
    
    [_tblView reloadData];
    
    if(model_manager.requirementManager.arrayPostedRequirements.count==0)
    {
        [SVProgressHUD show];
    }
    
    [model_manager.requirementManager getPostedRequirements:^(NSDictionary *json, NSError *error) {
        [SVProgressHUD dismiss];
        [_tblView reloadData];
    }];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitleLabel:@"REQUIREMENTS"];
    [self setMenuButton];
    
    [model_manager.profileManager getBillingAddressesWithCompletion:nil];
    [model_manager.profileManager getShippingAddressesWithCompletion:nil];

    
    [SVProgressHUD show];
    
    [model_manager.requirementManager getStates:^(NSDictionary *json, NSError *error) {
        [_tblView reloadData];
    }];
    
    model_manager.requirementManager.requirementListingDelegate = self;
    
    //homeVC = [kMainStoryboard instantiateViewControllerWithIdentifier:@"home"];
    
    //    self.navigationController.navigationBar.barTintColor=BlackBackground;
    //    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    //    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back.png"]
    //                                                                   style:UIBarButtonItemStylePlain
    //                                                                  target:self
    //                                                                  action:@selector(Back)];
    //    UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settings.png"]
    //                                                                   style:UIBarButtonItemStylePlain
    //                                                                  target:self
    //                                                                  action:@selector(settings)];
    //    
    //    self.navigationItem.leftBarButtonItem = backButton;
    //    self.navigationItem.rightBarButtonItem = settingsButton;
    //    
    //    self.navigationController.navigationBar.topItem.title=@"";
    //    
    //    UILabel *label = [[UILabel alloc] init];
    //    label.text = @"REQUIREMENTS";
    //    label.frame = CGRectMake(0, 0, 100, 30);
    //    label.textColor=[UIColor whiteColor];
    //    label.textAlignment = NSTextAlignmentCenter;
    //    UIBarButtonItem *customLabel = [[UIBarButtonItem alloc] initWithCustomView:label];
    //    self.navigationItem.titleView = customLabel.customView;
}

-(void)newUpdateReceived
{
    [_tblView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)settings
{
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    //    NSString *string=[[NSString alloc]init];
    
    UIAlertAction *button = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction *action){
                                                       //add code to make something happen once tapped
                                                   }];
    
    //
    [actionSheet addAction:button];
    
    
    NSMutableArray *arr=[[NSMutableArray alloc]initWithObjects:@"Change Password",@"Contact Us",@"Logout" ,nil];
    for (int i=0; i<arr.count; i++) {
        
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:[arr objectAtIndex:i] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self dismissViewControllerAnimated:YES completion:nil];
            if ([action.title isEqualToString:@"Change Password"]) {
                //
            }
            if ([action.title isEqualToString:@"Contact Us"]) {
                //
            }
            
            if ([action.title isEqualToString:@"Logout"]) {
                //
            }
            
            
            
            
            // Cancel button tappped do nothing.
            
        }]];
    }
    //
    
    [self presentViewController:actionSheet animated:YES completion:nil];
    
    
}
-(void)Back
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark table view data sources and delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return model_manager.requirementManager.arrayPostedRequirements.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SWTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RequirementCell"];
    UIView *view=(UIView*)[cell.contentView viewWithTag:1];
    [view.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [view.layer setBorderWidth:1.0f];
    
    
    
    NSArray *arrayRightBtns = [self rightButtons];

    [cell setRightUtilityButtons:arrayRightBtns WithButtonWidth:70];

    [cell setDelegate:self];
    
    RequirementI *requirement = [model_manager.requirementManager.arrayPostedRequirements objectAtIndex:indexPath.row];
    
    UILabel *lblCity=(UILabel*)[view viewWithTag:111];
    UILabel *lblState=(UILabel*)[view viewWithTag:222];
    UILabel *lblDate=(UILabel*)[view viewWithTag:333];
    UILabel *lblAmount=(UILabel*)[view viewWithTag:444];
    UIImageView *imgViewStatus=(UIImageView*)[view viewWithTag:777];
    UIImageView *imgViewNotification=(UIImageView*)[view viewWithTag:66];
    
    
    lblCity.text=[requirement.city capitalizedString];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(SELF.name contains[cd] %@)",requirement.state];
    
    NSArray *filteredArray = [model_manager.requirementManager.arrayStates filteredArrayUsingPredicate:predicate];
    
    if(filteredArray.count>0) {
        NSLog(@"selected state....%@",[[filteredArray firstObject] valueForKey:@"code"]);
        lblState.text = [[filteredArray firstObject] valueForKey:@"code"];

    }
    else
        lblState.text=[requirement.state capitalizedString];
    
   
    lblDate.text=[requirement.requiredByDate capitalizedString];
    
    
    lblAmount.text= [NSString stringWithFormat:@"%@.00/- Rs",requirement.budget];
    
    
    //set text fonts and respectiver Image
    
    if(requirement.isUnreadFlag == true)
    {
        imgViewStatus.backgroundColor = RedColor;
        
        lblCity.font = fontRalewayBold12;
        lblState.font = fontRalewayBold12;
        lblDate.font = fontRalewayBold12;
        lblAmount.font = fontRalewayBold12;
    }
    else
    {
        imgViewStatus.backgroundColor = kBlueColor;
        
        lblCity.font = fontRaleway13;
        lblState.font = fontRaleway13;
        lblDate.font = fontRaleway13;
        lblAmount.font = fontRaleway13;
    }

    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   Home * homeVC = [kMainStoryboard instantiateViewControllerWithIdentifier:@"home"];
    
    homeVC.selectedRequirement = [model_manager.requirementManager.arrayPostedRequirements objectAtIndex:indexPath.row];
    
    
    [self.navigationController pushViewController:homeVC animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}


- (IBAction)btnNewRequirement:(id)sender {
    

    UIViewController *homeVC = [kMainStoryboard instantiateViewControllerWithIdentifier:@"home"];
    
    [self.navigationController pushViewController:homeVC animated:YES];
}

#pragma mark - Swipe Cell Delegate
- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell {
    return YES;
}


- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    
    UIButton *btn_accept = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_accept setFrame:CGRectMake(0, 0, 40, 40)];
    [btn_accept setBackgroundColor:[UIColor redColor]];
    [btn_accept setTitle:NSLocalizedString(@"Delete",nil) forState:UIControlStateNormal];
    [btn_accept setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightUtilityButtons addObject:btn_accept];
    
    
    return rightUtilityButtons;
}


- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    
    NSIndexPath *indexPath;
    indexPath = [_tblView indexPathForCell:cell];
    
    RequirementI *requirement = [model_manager.requirementManager.arrayPostedRequirements objectAtIndex:indexPath.row];
    
    [model_manager.requirementManager deleteRequirement:requirement completion:^(NSDictionary *json, NSError *error) {
        if (json) {
            [_tblView reloadData];
        }
        else
        {
            NSLog(@"not deleted");
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
