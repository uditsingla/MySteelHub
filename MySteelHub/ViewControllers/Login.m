//
//  Login.m
//  Sourcefuse
//
//  Created by Abhishek Singla on 10/03/16.
//  Copyright © 2016 Sourcefuse. All rights reserved.
//

#import "Login.h"
#import "LoginManager.h"

@interface Login ()
{
    UIStoryboard *mainStoryboard;
    UIViewController *loginController;
    NSMutableDictionary *dictLoginParams;
    
}
@end

@implementation Login

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    txtEmail=[self customtxtfield:txtEmail withplaceholder:@"Username"withIcon:[UIImage imageNamed:@"user.png"]];
    txtPassword=[self customtxtfield:txtPassword withplaceholder:@"Password" withIcon:[UIImage imageNamed:@"password.png"]];
    //dictLoginParams = [NSMutableDictionary new];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:self.view.window];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:self.view.window];
    
    self.navigationController.navigationBar.hidden=YES;
    /*
    BOOL isUserAuthorised = TRUE;
    if (isUserAuthorised)
    {
       Home *homeVC =  [kMainStoryboard instantiateInitialViewController];
        [self.navigationController pushViewController:homeVC animated:YES];
    }
     */
}
- (void)viewWillDisappear:(BOOL)animated
{
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Custom Methods -
-(IBAction)loginUser:(id)sender
{
    
    
    
  
//    
//    if ([self validEmail:txtEmail.text] != 0 && [[txtPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] != 0 )
//    {
//        
////        if ([self validEmail:txtOptionalEmail.text])
////        {
////            dictLoginParams = [[NSMutableDictionary alloc] initWithObjectsAndKeys:txtEmail.text,@"email",txtPassword.text,@"password", [NSNumber numberWithInt:2], @"SystemApplicationID", [NSNumber numberWithInt:1], @"AuthenticationSourceID", [[NSUserDefaults standardUserDefaults] stringForKey:@"DeviceToken"],@"DeviceID",nil];
//             dictLoginParams = [[NSMutableDictionary alloc] initWithObjectsAndKeys:txtEmail.text,@"email",txtPassword.text,@"password",nil];
//        
//       
//            [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
//            
//            [model_manager.loginManager userLogin:dictLoginParams completion:^(NSArray *addresses, NSError *error){
//                 NSLog(@"Login Response");
//                [[UIApplication sharedApplication] endIgnoringInteractionEvents];
//                if (addresses.count>0) {
//                    if (error) {
//                        
//                        [self appError:@"" jsonerror:[addresses objectAtIndex:0]];
//                        return ;
//                        //
//                    }
    
                    UIViewController *Requirements = [kMainStoryboard instantiateViewControllerWithIdentifier:@"Detail"];
                    [self.navigationController pushViewController:Requirements animated:YES];
                 //   [self callSlideMenu];
                   
//
//                }
//                
//               
//                
//            }];
    
        //hit login webservice
    //}
//    else
//    {
//        [self appError:@"email or password" jsonerror:@""];
//        
//    }

}

-(void)callSlideMenu
{
    UIViewController *HomeviewController;
    HomeviewController = [kMainStoryboard instantiateViewControllerWithIdentifier: @"Requirements"];
    
    UIViewController *leftSlider = [kMainStoryboard instantiateViewControllerWithIdentifier: @"leftslider"];
    
    
    
    MFSideMenuContainerViewController *container = [MFSideMenuContainerViewController
                                                    containerWithCenterViewController:HomeviewController
                                                    leftMenuViewController:leftSlider
                                                    rightMenuViewController:nil];
   // ((AppDelegate*)[[UIApplication sharedApplication] delegate]).slideContainer=container;
    
    [self.navigationController pushViewController:container animated:YES];
}



-(void)appError:(NSString*)appError jsonerror:(NSString*)jsonerror
{
    if ([appError isEqualToString:@""]) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:[NSString stringWithFormat:@"%@",jsonerror] preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
            // Cancel button tappped.
            [self dismissViewControllerAnimated:YES completion:^{
            }];
        }]];
        
        
        // Present action sheet.
        [self presentViewController:alert animated:YES completion:nil];
    }
    else{
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:[NSString stringWithFormat:@"Please enter a valid %@",appError] preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
            // Cancel button tappped.
            [self dismissViewControllerAnimated:YES completion:^{
            }];
        }]];
        
        
        // Present action sheet.
        [self presentViewController:alert animated:YES completion:nil];
    }
    
   
    
    
    
    
    
}



- (void)keyboardWillShow:(NSNotification *)notification
{
//    NSDictionary *info = [notification userInfo];
//    CGRect keyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
//    
//    UIEdgeInsets contentInset = scrollview.contentInset;
//    contentInset.bottom = keyboardRect.size.height;
//    scrollview.contentInset = contentInset;
    
//    NSDictionary *info = [notification userInfo];
//    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
//    UIEdgeInsets contentInsets = UIEdgeInsetsMake(self.view.frame.origin.y, 0.0, kbSize.height, 0);
//    scrollview.contentInset = contentInsets;
//    scrollview.scrollIndicatorInsets = contentInsets;
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(self.navigationController.navigationBar.frame.origin.y,0, kbSize.height, 0);
    scrollview.contentInset = contentInsets;
    scrollview.scrollIndicatorInsets = contentInsets;

}


- (void)keyboardWillHide:(NSNotification *)notification
{
//    NSDictionary *info = [notification userInfo];
//    CGRect keyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
//     UIEdgeInsets contentInsets =UIEdgeInsetsMake(self.view.frame.origin.y, 0,0, 0);
//  //  UIEdgeInsets contentInset = scrollview.contentInset;
//    contentInsets.bottom = keyboardRect.size.height;
//    scrollview.contentInset = contentInsets;
//     scrollview.scrollIndicatorInsets = contentInsets;
    
//    CGPoint bottomOffset = CGPointMake(0, scrollview.contentSize.height - scrollview.bounds.size.height);
//    [UIScrollView setContentOffset:bottomOffset animated:YES];
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(self.navigationController.navigationBar.frame.origin.y,0,0, 0);
    scrollview.contentInset = contentInsets;
    scrollview.scrollIndicatorInsets = contentInsets;
}

-(IBAction)signUpUser:(id)sender
{
    UIViewController *signUpVc = [kLoginStoryboard instantiateViewControllerWithIdentifier:@"signUp"];
    [self.navigationController pushViewController:signUpVc animated:YES];
    
}
-(IBAction)forgotPassword:(id)sender
{
    
}
-(BOOL)validEmail:(NSString*)emailString
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:emailString];
}

-(UITextField*)customtxtfield:(UITextField*)txtField withplaceholder:(NSString*)placeholder withIcon:(UIImage*)image
{
    txtField.attributedPlaceholder = [[NSAttributedString alloc]
                                       initWithString:placeholder
                                       attributes:@{NSForegroundColorAttributeName:
                                                        [UIColor whiteColor]}];
    
    
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, txtField.frame.size.width/2-25, 41)];
    paddingView.backgroundColor=[UIColor clearColor];
    UIImageView*icon=[[UIImageView alloc]initWithFrame:CGRectMake(paddingView.frame.size.width-22, paddingView.frame.size.height/2-8, 16, 16)];
    icon.image=image;
    [paddingView addSubview:icon];
    txtField.leftView = paddingView;
    txtField.leftViewMode = UITextFieldViewModeAlways;
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, txtField.frame.size.height-2, txtField.frame.size.width, 2)];
    lineView.backgroundColor = [UIColor whiteColor];
    [txtField addSubview:lineView];
    
    return txtField;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField==txtEmail) {
        [textField resignFirstResponder];
        [txtPassword becomeFirstResponder];
    }
    else{
        [textField resignFirstResponder];
    }
    
    return YES;
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
