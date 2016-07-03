//
//  Requirements.m
//  MySteelHub
//
//  Created by Apple on 07/05/16.
//  Copyright © 2016 MySteelHub. All rights reserved.
//

#import "Requirements.h"

@interface Requirements ()

@end

@implementation Requirements

-(void)viewWillAppear:(BOOL)animated
{

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitleLabel:@"REQUIREMENTS"];
    [self setMenuButton];
    [self setBackButton];
    
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
    
    return 4;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RequirementCell"];
    UIView *view=(UIView*)[cell.contentView viewWithTag:1];
    [view.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [view.layer setBorderWidth:1.0f];
    
    UILabel *lbl=(UILabel*)[view viewWithTag:2];
    lbl.text=@"hahah";
    return cell;
    
}
- (IBAction)btnNewRequirement:(id)sender {
    
    UIViewController *homeVC = [kMainStoryboard instantiateInitialViewController];
        [self.navigationController pushViewController:homeVC animated:YES];
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
