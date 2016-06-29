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
    self.navigationController.navigationBarHidden = YES;
    
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

#pragma mark - custom textfield

-(UITextField*)customtxtfield:(UITextField*)txtField withrightIcon:(UIImage*)image borderLeft:(BOOL)l borderRight:(BOOL)r borderBottom:(BOOL)b borderTop:(BOOL)t
{
    
    UITextField *tf = txtField;
    tf.frame = CGRectMake(tf.frame.origin.x, tf.frame.origin.y
                          , self.view.frame.size.width-20, 40);
    
    NSLog(@"self frame : %f",self.view.frame.size.width);
    
    float wid = (self.view.frame.size.width-20)/2;
    
    if ((txtField.tag == 1) || (txtField.tag == 3))
    {
        
        tf.frame = CGRectMake(tf.frame.origin.x, tf.frame.origin.y
                              , wid, 40);
        
    }
    if ((txtField.tag == 2) || (txtField.tag == 4))
    {
        tf.frame = CGRectMake(wid, tf.frame.origin.y
                              , wid, 40);
    }
    
    
    CGFloat borderWidth = 1;
    UIColor *graycolor = [UIColor lightGrayColor];
    
    
    CGFloat custWidth = txtField.frame.size.width;
    CGFloat custHeight = 40;
    
    //    CGFloat custWidth = self.view.frame.size.width-20;
    //    CGFloat custHeight = 40;
    
    
    //Top Border
    if (t) {
        
        CALayer *border = [CALayer layer];
        border.borderColor = graycolor.CGColor;
        border.frame = CGRectMake(0, 0, custWidth, custHeight);
        border.borderWidth = borderWidth;
        [txtField.layer addSublayer:border];
        
    }
    
    //Bottom border
    if (b) {
        CALayer *border = [CALayer layer];
        border.borderColor = graycolor.CGColor;
        border.frame = CGRectMake(0, custHeight - borderWidth, custWidth, custHeight);
        border.borderWidth = borderWidth;
        [txtField.layer addSublayer:border];
        
    }
    //
    
    //right border
    if (r) {
        CALayer *rightBorder = [CALayer layer];
        rightBorder.frame = CGRectMake(custWidth - 1, 0, 1, custHeight);
        rightBorder.borderColor = graycolor.CGColor;
        rightBorder.borderWidth = borderWidth;
        [txtField.layer addSublayer:rightBorder];
        
    }
    
    
    //left border
    if (l) {
        CALayer *leftBorder = [CALayer layer];
        leftBorder.frame = CGRectMake(0, 0, 1, custHeight);
        leftBorder.borderColor = graycolor.CGColor;
        leftBorder.borderWidth = borderWidth;
        [txtField.layer addSublayer:leftBorder];
    }
    
    
    
    //    if ((txtField.tag == 1) || (txtField.tag == 3)) {
    //        
    //    }
    //    
    //    if ((txtField.tag == 2) || (txtField.tag == 4)){
    //        
    //    }
    //    
    
    //txtField.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 41)];
    paddingView.backgroundColor=[UIColor clearColor];
    txtField.leftView=paddingView;
    txtField.leftViewMode = UITextFieldViewModeAlways;
    //txtField.layer.borderWidth= 1.0f;
    UIImageView*icon=[[UIImageView alloc]initWithFrame:CGRectMake(custWidth-25, custHeight/2-6, 16, 16)];
    icon.image=image;
    [txtField addSubview:icon];
    
    return txtField;
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
