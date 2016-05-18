//
//  BaseViewController.m
//  Sourcefuse
//
//  Created by Abhishek Singla on 10/03/16.
//  Copyright © 2016 Sourcefuse. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initializeNavBar];
    [self setbarButtonItems];
   
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)initializeNavBar
{
    self.navigationController.navigationBar.barTintColor = BlueColor;
}


-(void)setbarButtonItems
{
   
    UIBarButtonItem *btnLeftMenu = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(clk_btnLeftMenu:)];
    btnLeftMenu.image = [UIImage imageNamed:@"settings.png"];
    
    self.navigationItem.leftBarButtonItems = @[btnLeftMenu];
    
    /* Image in navigationBar */
    UIImage * logoInNavigationBar = [UIImage imageNamed:@"01_logo.png"];
    UIImageView * logoView = [[UIImageView alloc] init];
    [logoView setImage:logoInNavigationBar];
    self.navigationController.navigationItem.titleView = logoView;
    
    /* Right Bar Buttons */
    UIBarButtonItem *btnMessage = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(clk_btnMessage:)];
    btnMessage.image = [UIImage imageNamed:@"settings.png"];
    
    
    self.navigationItem.rightBarButtonItems = @[btnMessage];
    
}



#pragma mark - Clk Actions
-(void)clk_btnLeftMenu:(id)sender
{
    NSLog(@"clk_btnLeftMenu");
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
    
}

-(void)clk_btnQRCode:(id)sender
{
    NSLog(@"clk_btnQRCode");
    
}
-(void)clk_btnMessage:(id)sender
{
    NSLog(@"clk_btnMessage");
    
}
-(void)clk_btnSearch:(id)sender
{
    NSLog(@"clk_btnSearch");
    
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
