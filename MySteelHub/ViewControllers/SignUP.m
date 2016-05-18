//
//  SignUP.m
//  MySteelHub
//
//  Created by Abhishek Singla on 02/04/16.
//  Copyright © 2016 MySteelHub. All rights reserved.
//

#import "SignUP.h"

@interface SignUP ()
{
    NSString *errorType;
}

@end

@implementation SignUP
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden=NO;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.barTintColor=BlueColor;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hideKeyboard:) name:UIKeyboardDidHideNotification object:nil ];
   
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showKeyboard:) name:UIKeyboardDidShowNotification object:nil ];
    self.navigationController.navigationBar.barTintColor=BlackBackground;
     self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back.png"]
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(Back)];
    
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationItem.rightBarButtonItem = nil;

    self.navigationController.navigationBar.topItem.title=@"";

    UILabel *label = [[UILabel alloc] init];
    label.text = @"COMPLETE YOUR PROFILE";
    label.frame = CGRectMake(0, 0, 100, 30);
    label.textColor=[UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    UIBarButtonItem *customLabel = [[UIBarButtonItem alloc] initWithCustomView:label];
    self.navigationItem.titleView = customLabel.customView;
    
    
    [self setupTextFields];
  
   
    
}
-(void)setupTextFields
{
     _txtFieldEmail=[self customtxtfield:_txtFieldEmail withrightIcon:[UIImage imageNamed:@"mail.png"]];
     _txtFieldUsername=[self customtxtfield:_txtFieldUsername withrightIcon:[UIImage imageNamed:@"user"]];
     _txtFieldContact=[self customtxtfield:_txtFieldContact withrightIcon:[UIImage imageNamed:@"phone.png"]];
     _txtFieldAddress=[self customtxtfield:_txtFieldAddress withrightIcon:[UIImage imageNamed:@"pin.png"]];
     _txtFieldCity=[self customtxtfield:_txtFieldCity withrightIcon:[UIImage imageNamed:@"pin.png"]];
     _txtFieldState=[self customtxtfield:_txtFieldState withrightIcon:[UIImage imageNamed:@"pin.png"]];
     _txtFieldPassword=[self customtxtfield:_txtFieldPassword withrightIcon:[UIImage imageNamed:@"passwordW.png"]];
    _txtFieldConfirmPass=[self customtxtfield:_txtFieldConfirmPass withrightIcon:[UIImage imageNamed:@"passwordW.png"]];
    txtFieldBrand=[self customtxtfield:txtFieldBrand withrightIcon:[UIImage imageNamed:@"brand.png"]];
    
    _txtFieldPan=[self customtxtfield:_txtFieldPan withrightIcon:[UIImage imageNamed:@"wallet.png"]]; _txtFieldZipCode=[self customtxtfield:_txtFieldZipCode withrightIcon:[UIImage imageNamed:@"zip.png"]];
     _txtFieldTin=[self customtxtfield:_txtFieldTin withrightIcon:[UIImage imageNamed:@"wallet.png"]];
     _txtFieldExpected=[self customtxtfield:_txtFieldExpected withrightIcon:[UIImage imageNamed:@"user.png"]];
     _txtFieldCompanyName=[self customtxtfield:_txtFieldCompanyName withrightIcon:[UIImage imageNamed:@"company.png"]];
   
    
}
-(void)Back
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)showKeyboard:(NSNotification*)notification
{
    NSLog(@"Keyboard shown");
   
        NSDictionary *info = [notification userInfo];
        CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
        UIEdgeInsets contentInsets = UIEdgeInsetsMake(self.navigationController.navigationBar.frame.origin.y+self.navigationController.navigationBar.frame.size.height,0, kbSize.height, 0);
        _scrollView.contentInset = contentInsets;
        _scrollView.scrollIndicatorInsets = contentInsets;
   
   
}
-(void)hideKeyboard:(NSNotification*)notification
{

     UIEdgeInsets contentInsets = UIEdgeInsetsMake(self.navigationController.navigationBar.frame.origin.y+self.navigationController.navigationBar.frame.size.height,0,0, 0);
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
    
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}
- (IBAction)btnSubmit:(id)sender {
    
    if ([_txtFieldUsername.text isEqual:@""]) {
        errorType=@"username";
        [self showError:errorType];
        return;
    }
    if ([_txtFieldPassword.text isEqual:@""]) {
        errorType=@"password";
         [self showError:errorType];

        return;
    }

    if ([_txtFieldConfirmPass.text isEqual:@""]) {
        errorType=@"confirm password";
         [self showError:errorType];
        return;
    }
    if (![_txtFieldConfirmPass.text isEqual:_txtFieldPassword.text]  ) {
          errorType=@"password and confirm password";
        [self showError:errorType];
        return;
    }

    if ([_txtFieldCompanyName.text isEqual:@""]) {
        errorType=@"company name";
         [self showError:errorType];
        return;
    }

    if (![self validEmail:_txtFieldEmail.text]) {
        errorType=@"email";
         [self showError:errorType];
        return;
    }

    if ([_txtFieldAddress.text isEqual:@""]) {
        errorType=@"address";
         [self showError:errorType];
        return;
    }
    if ([_txtFieldContact.text isEqual:@""]) {
        errorType=@"contact";
         [self showError:errorType];
        return;
    }

    if ([_txtFieldCity.text isEqual:@""]) {
        errorType=@"city";
         [self showError:errorType];
        return;
    }
    if ([_txtFieldState.text isEqual:@""]) {
        errorType=@"state";
         [self showError:errorType];
        return;
    }
    if ([_txtFieldZipCode.text isEqual:@""]) {
        errorType=@"zipcode";
         [self showError:errorType];
        return;
    }
    if ([_txtFieldTin.text isEqual:@""]) {
        errorType=@"tin";
         [self showError:errorType];
        return;
    }
    if ([_txtFieldPan.text isEqual:@""]) {
        errorType=@"pan";
         [self showError:errorType];
        return;
    }
    if ([_txtFieldExpected.text isEqual:@""]) {
        errorType=@"expected";
         [self showError:errorType];
        return;
    }
    
//    NSLog(@"hit service");
    NSDictionary *dictSignupParams=[[NSDictionary alloc]initWithObjectsAndKeys:_txtFieldEmail.text,@"email",_txtFieldPassword.text,@"password",_txtFieldUsername.text,@"name",_txtFieldContact.text,@"contact",_txtFieldAddress.text,@"address",_txtFieldState.text,@"state",_txtFieldCity.text,@"city",_txtFieldZipCode.text,@"zip",_txtFieldTin.text,@"tin",_txtFieldCompanyName.text,@"company_name",_txtFieldPan.text,@"pan",@"aa",@"role", @"haha",@"brand",nil];
//   NSDictionary *dictSignupParams=[[NSDictionary alloc]initWithObjectsAndKeys:@"abcd@gmail.com",@"email",@"aa",@"password",@"aa",@"name",@"987555",@"contact",@"aa",@"address",@"aa",@"state",@"aa",@"city",@"aa",@"zip",@"aa",@"tin",@"bla",@"brand",@"aa",@"company_name",@"blabla",@"role",@"123456",@"pan", nil];
  [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
//    
    [model_manager.loginManager userSignUp:dictSignupParams completion:^(NSArray *addresses, NSError *error){
         [[UIApplication sharedApplication] endIgnoringInteractionEvents];
       
            UIAlertController *alertController = [UIAlertController
                                                  alertControllerWithTitle:@""
                                                  message:[addresses objectAtIndex:0]
                                                  preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction
                                       actionWithTitle:@"Ok"
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                           [self dismissViewControllerAnimated:YES completion:nil];
                                           [self.navigationController popViewControllerAnimated:YES];
                                           NSLog(@"OK action");
                                       }];
            
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
            //
            //        NSLog(@"Login Response");
            //
            //
        }];

    
        
//    UIViewController *viewController;
//    viewController = [kMainStoryboard instantiateInitialViewController];
//    [self.navigationController pushViewController:viewController animated:YES];
    

//    []
    
    
    
}

-(BOOL)validEmail:(NSString*)emailString
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:emailString];
}
-(void)showError:(NSString*)error
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:[NSString stringWithFormat:@"Please enter a valid %@",error] preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        // Cancel button tappped.
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    
    // Present action sheet.
    [self presentViewController:alert animated:YES completion:nil];
    
    
    
}


-(UITextField*)customtxtfield:(UITextField*)txtField withrightIcon:(UIImage*)image
{
    txtField.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 41)];
    paddingView.backgroundColor=[UIColor clearColor];
    txtField.leftView=paddingView;
      txtField.leftViewMode = UITextFieldViewModeAlways;
    txtField.layer.borderWidth= 1.0f;
       UIImageView*icon=[[UIImageView alloc]initWithFrame:CGRectMake(txtField.frame.size.width-25, txtField.frame.size.height/2-6, 16, 16)];
    icon.image=image;
    [txtField addSubview:icon];
 
    return txtField;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
