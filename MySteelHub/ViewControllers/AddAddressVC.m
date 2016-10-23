//
//  AddAddressVC.m
//  MySteelHub
//
//  Created by Amit Yadav on 16/10/16.
//  Copyright © 2016 MySteelHub. All rights reserved.
//

#import "AddAddressVC.h"
#import "Address.h"

@interface AddAddressVC ()

@end

@implementation AddAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitleLabel:@"Add New Address"];
    [self setMenuButton];
    [self setBackButton];
    
    [self setupTextFields];
    
    
    //Address APi
//    [self addAddress];
//    [self updateAddress];

}


-(BOOL)validateAddress
{
    if([[_txtFieldName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0)
    {
        [self showAlert:@"Please enter name"];
        return false;
    }
    
    else if([[_txtFieldAddress1.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0)
    {
        [self showAlert:@"Please enter Address"];
        return false;
    }

    else if([[_txtFieldCity.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)
    {
        [self showAlert:@"Please enter city"];
        return false;
    }
    
    else if([[_txtFieldState.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)
    {
        [self showAlert:@"Please enter state"];
        return false;
    }
    
    else if([[_txtFieldZipCode.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)
    {
        [self showAlert:@"Please enter zipcode"];
        return false;
    }
    
    else if([[_txtFieldContact.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)
    {
        [self showAlert:@"Please enter Contact No."];
        return false;
    }
    return true;
}


-(void)addAddress
{
    
    if (![self validateAddress]) {
        return;
    }
    
    Address *addressObj = [Address new];

    addressObj.addressType = @"billing";
    addressObj.firmName = @"Abhishek";
    addressObj.city = @"Mohali";
    addressObj.state = @"Punjab";
    addressObj.pin = @"123456";
    addressObj.mobile = @"9316645607";
    addressObj.landLine = @"01724607365";
    addressObj.address1= @"Phase 3B2";
    addressObj.address2= @"";
    addressObj.landmark = @"Near temple";
    
    
    [SVProgressHUD show];
    
    [model_manager.profileManager addNewAddress:addressObj completion:^(NSDictionary *json, NSError *error) {
        
        [SVProgressHUD dismiss];
        
        if(json)
        {
            //[self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [self showAlert:@"Unable to save new address"];
        }

    }];
    
}


-(void)updateAddress
{
    if (![self validateAddress]) {
        return;
    }
    
    Address *addressObj = [Address new];
    
    addressObj.ID = @"update this ID";
    
    addressObj.addressType = @"billing";
    addressObj.firmName = @"Abhishek";
    addressObj.city = @"Mohali";
    addressObj.state = @"Punjab";
    addressObj.pin = @"123456";
    addressObj.mobile = @"9316645607";
    addressObj.landLine = @"01724607365";
    addressObj.address1= @"Phase 3B2";
    addressObj.address2= @"";
    addressObj.landmark = @"Near temple";
    
    
    
    [SVProgressHUD show];
    
    [model_manager.profileManager editAddress:addressObj completion:^(NSDictionary *json, NSError *error) {
        
        [SVProgressHUD dismiss];
        
        if(json)
        {
            //[self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [self showAlert:@"Unable to update address"];
        }
        
    }];
    

    
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

-(void)setupTextFields
{
    [self.view layoutIfNeeded];
    _txtFieldName = [self customtxtfield:_txtFieldName withrightIcon:[UIImage imageNamed:@"user.png"] borderLeft:YES borderRight:YES borderBottom:YES borderTop:YES];
    _txtFieldName.delegate = self;
    
    _txtFieldAddress1 = [self customtxtfield:_txtFieldAddress1 withrightIcon:[UIImage imageNamed:@"pin.png"] borderLeft:YES borderRight:YES borderBottom:YES borderTop:NO];
    _txtFieldAddress1.delegate = self;

    
    _txtFieldAddress2 = [self customtxtfield:_txtFieldAddress2 withrightIcon:[UIImage imageNamed:@"pin.png"] borderLeft:YES borderRight:YES borderBottom:YES borderTop:NO];
    _txtFieldAddress2.delegate = self;

    
    
    _txtFieldContact = [self customtxtfield:_txtFieldContact withrightIcon:[UIImage imageNamed:@"phone.png"] borderLeft:YES borderRight:YES borderBottom:YES borderTop:NO];
    _txtFieldContact.delegate = self;

    
    UIToolbar *keyboardDoneButtonView = [[UIToolbar alloc] init];
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStyleDone target:self
                                                                  action:@selector(doneClicked:)];
    keyboardDoneButtonView.barStyle = UIBarStyleBlackOpaque;
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:flexSpace,doneButton, nil]];
    _txtFieldContact.inputAccessoryView = keyboardDoneButtonView;
    
    _txtFieldLandmark = [self customtxtfield:_txtFieldLandmark withrightIcon:[UIImage imageNamed:@"pin.png"] borderLeft:YES borderRight:YES borderBottom:YES borderTop:NO];
    _txtFieldLandmark.delegate = self;

    _txtFieldCity = [self customtxtfield:_txtFieldCity withrightIcon:[UIImage imageNamed:@"pin.png"] borderLeft:YES borderRight:YES borderBottom:YES borderTop:NO];
    _txtFieldCity.delegate = self;

    _txtFieldState = [self customtxtfield:_txtFieldState withrightIcon:[UIImage imageNamed:@"pin.png"] borderLeft:YES borderRight:YES borderBottom:YES borderTop:NO];
    _txtFieldState.delegate = self;

    
    _txtFieldZipCode = [self customtxtfield:_txtFieldZipCode withrightIcon:[UIImage imageNamed:@"zip.png"] borderLeft:YES borderRight:YES borderBottom:YES borderTop:NO];
    _txtFieldZipCode.delegate = self;

    _txtFieldZipCode.inputAccessoryView = keyboardDoneButtonView;
    
    _txtFieldLandline = [self customtxtfield:_txtFieldLandline withrightIcon:[UIImage imageNamed:@"phone.png"] borderLeft:YES borderRight:YES borderBottom:YES borderTop:NO];
    _txtFieldLandline.delegate = self;
    
    _txtFieldLandline.inputAccessoryView = keyboardDoneButtonView;

    
}

-(void)showKeyboard:(NSNotification*)notification
{
    NSLog(@"Keyboard shown");
    
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(20,0, kbSize.height, 0);
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
    
    
}
-(void)hideKeyboard:(NSNotification*)notification
{
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(20,0,0, 0);
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
    
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    if(textField == _txtFieldName)
        [_txtFieldAddress1 becomeFirstResponder];
    else if(textField == _txtFieldAddress1)
        [_txtFieldAddress2 becomeFirstResponder];
    else if(textField == _txtFieldAddress2)
        [_txtFieldLandmark becomeFirstResponder];
    else if(textField == _txtFieldLandmark)
        [_txtFieldCity becomeFirstResponder];
    else if(textField == _txtFieldCity)
        [_txtFieldState becomeFirstResponder];
    else if(textField == _txtFieldState)
        [_txtFieldZipCode becomeFirstResponder];
    else if(textField == _txtFieldZipCode)
        [_txtFieldContact becomeFirstResponder];
    else if(textField == _txtFieldContact)
        [_txtFieldLandline becomeFirstResponder];
    
    return YES;
}

- (void)doneClicked:(id)sender
{
    NSLog(@"Done Clicked.");
    [self.view endEditing:YES];
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

- (IBAction)saveBtnAction:(UIButton *)sender {
}
@end
