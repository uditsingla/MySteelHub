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
    
    //dictLoginParams = [NSMutableDictionary new];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:self.view.window];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:self.view.window];
    
    
    /*
    BOOL isUserAuthorised = TRUE;
    if (isUserAuthorised)
    {
       Home *homeVC =  [kMainStoryboard instantiateInitialViewController];
        [self.navigationController pushViewController:homeVC animated:YES];
    }
     */
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Custom Methods -
-(IBAction)loginUser:(id)sender
{
    UIViewController *homeVC = [kMainStoryboard instantiateInitialViewController];
    [self.navigationController pushViewController:homeVC animated:YES];
    
    if ([self validEmail:txtEmail.text] != 0 && [[txtPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] != 0 )
    {
        
        if ([self validEmail:txtOptionalEmail.text])
        {
            dictLoginParams = [[NSMutableDictionary alloc] initWithObjectsAndKeys:txtEmail.text,@"Email",txtPassword.text,@"Password", [NSNumber numberWithInt:2], @"SystemApplicationID", [NSNumber numberWithInt:1], @"AuthenticationSourceID", [[NSUserDefaults standardUserDefaults] stringForKey:@"DeviceToken"],@"DeviceID",nil];
        }
        
        //hit login webservice
        else
            [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        
        [model_manager.loginManager userLogin:dictLoginParams completion:^(NSArray *addresses, NSError *error){
            
            NSLog(@"Login Response");
            
        }];
        
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
    
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0);
    scrollview.contentInset = contentInsets;
    scrollview.scrollIndicatorInsets = contentInsets;
}


- (void)keyboardWillHide:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    CGRect keyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    UIEdgeInsets contentInset = scrollview.contentInset;
    contentInset.bottom = keyboardRect.size.height;
    scrollview.contentInset = contentInset;
}

-(IBAction)signUpUser:(id)sender
{
    
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



- (void)viewWillDisappear:(BOOL)animated
{
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
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
