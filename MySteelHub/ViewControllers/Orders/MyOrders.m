//
//  MyOrders.m
//  MySteelHub
//
//  Created by Abhishek Singla on 12/03/17.
//  Copyright © 2017 MySteelHub. All rights reserved.
//

#import "MyOrders.h"

@interface MyOrders ()
{
    
    __weak IBOutlet UISegmentedControl *segControl;
    __weak IBOutlet UIView *contPending;
    __weak IBOutlet UIView *contConfirmed;
    __weak IBOutlet UIView *contInProgress;
    __weak IBOutlet UIView *contHistory;
    
    PendingOrdersVC *pVC;
    ConfirmedOrdersVC *cVC;
    InProgressOrdersVC * iVC;
    HistoryVC *hVC;
    

}
@end

@implementation MyOrders

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self setTitleLabel:@"My Orders"];
    [self setMenuButton];
    [self setBackButton];
    
    [self hideAllContainers];
    
    contPending.hidden = false;
    
    pVC = [self.childViewControllers objectAtIndex:0];
    
    [pVC didMoveToParentViewController:self];
    
    cVC = [self.childViewControllers objectAtIndex:1];
    
    [cVC didMoveToParentViewController:self];

    iVC = [self.childViewControllers objectAtIndex:2];

    [iVC didMoveToParentViewController:self];

    hVC = [self.childViewControllers objectAtIndex:3];
    [hVC didMoveToParentViewController:self];
    
    [segControl setTintColor:kBlueColor];

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

-(void)hideAllContainers
{
    contHistory.hidden = true;
    contPending.hidden = true;
    contConfirmed.hidden = true;
    contInProgress.hidden = true;
}



#pragma mark - Clk Actions
- (IBAction)clkSegment:(id)sender {
    
    [self hideAllContainers];
    
    switch (segControl.selectedSegmentIndex) {
        case 0:
            pVC = [self.childViewControllers objectAtIndex:0];
            
            [pVC refreshData];
            contPending.hidden = false;

            break;
            
        case 1:
            cVC = [self.childViewControllers objectAtIndex:1];
            [cVC refreshData];

            contConfirmed.hidden = false;
            
            break;
            
        case 2:
            iVC = [self.childViewControllers objectAtIndex:2];
            [iVC refreshData];

            contInProgress.hidden = false;
            
            break;
            
        case 3:
            hVC = [self.childViewControllers objectAtIndex:3];
            [hVC refreshData];

            contHistory.hidden = false;
            
            break;
            
        default:
            break;
    }
    
}

-(void)backButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightMenuAction
{
    NSLog(@"right menu pressed");
    [self.menuContainerViewController toggleRightSideMenuCompletion:^{}];
    
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
