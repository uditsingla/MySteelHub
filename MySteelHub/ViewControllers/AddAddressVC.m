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
{
    UIView *pickerViewState;

    NSMutableArray *arrayStates;
    
    NSString *selectedState;


}
@end

@implementation AddAddressVC

@synthesize addressType,selectedAddress,selectedOrder;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSLog(@"%@",addressType);
    
    
    [self setTitleLabel:@"Add New Address"];
    [self setMenuButton];
    [self setBackButton];
    
    [self setupTextFields];
    
    
    //Address APi
//    [self addAddress];
//    [self updateAddress];
    
    if(selectedAddress)
    {
        _txtFieldName.text = selectedAddress.firmName;
        _txtFieldCity.text = selectedAddress.city;
        _txtFieldState.text = selectedAddress.state;
        _txtFieldZipCode.text = selectedAddress.pin;
        _txtFieldContact.text = selectedAddress.mobile;
        _txtFieldLandline.text = selectedAddress.landLine;
        _txtFieldAddress1.text = selectedAddress.address1;
        _txtFieldAddress2.text = selectedAddress.address2;
        _txtFieldLandmark.text = selectedAddress.landmark;
        
    }
    

    
    
    //initialize picker for states
    pickerViewState = [[UIView alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height-216, self.view.frame.size.width,216)];
    [pickerViewState setBackgroundColor:[UIColor whiteColor]];
    [self createPickerWithTag:777 inView:pickerViewState];
    [self.view addSubview:pickerViewState];
    pickerViewState.hidden = YES;
    
    arrayStates = [NSMutableArray arrayWithArray:model_manager.requirementManager.arrayStates];
    
    [model_manager.requirementManager getStates:^(NSDictionary *json, NSError *error) {
        if(model_manager.requirementManager.arrayStates.count>0)
        {
            arrayStates = [NSMutableArray arrayWithArray:model_manager.requirementManager.arrayStates];
            UIPickerView *pickerView = [pickerViewState viewWithTag:777];
            [pickerView reloadAllComponents];
        }
    }];

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

    addressObj.addressType = addressType;
    addressObj.firmName = _txtFieldName.text;
    addressObj.city = _txtFieldCity.text;
    addressObj.state = _txtFieldState.text;
    addressObj.pin = _txtFieldZipCode.text;
    addressObj.mobile = _txtFieldContact.text;
    addressObj.landLine = _txtFieldLandline.text;
    addressObj.address1= _txtFieldAddress1.text;
    addressObj.address2= _txtFieldAddress2.text;
    addressObj.landmark = _txtFieldLandmark.text;
    
    
    [SVProgressHUD show];
    
    [model_manager.profileManager addNewAddress:addressObj completion:^(NSDictionary *json, NSError *error) {
        
        [SVProgressHUD dismiss];
        
        if(json)
        {
            [self.navigationController popViewControllerAnimated:YES];
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
    
    addressObj.ID = selectedAddress.ID;
    
    addressObj.addressType = selectedAddress.addressType;
    addressObj.firmName = _txtFieldName.text;
    addressObj.city = _txtFieldCity.text;
    addressObj.state = _txtFieldState.text;
    addressObj.pin = _txtFieldZipCode.text;
    addressObj.mobile = _txtFieldContact.text;
    addressObj.landLine = _txtFieldLandline.text;
    addressObj.address1= _txtFieldAddress1.text;
    addressObj.address2= _txtFieldAddress2.text;
    addressObj.landmark = _txtFieldLandmark.text;
    
    
    
    [SVProgressHUD show];
    
    [model_manager.profileManager editAddress:addressObj completion:^(NSDictionary *json, NSError *error) {
        
        [SVProgressHUD dismiss];
        
        if(json)
        {
            selectedAddress = addressObj;
            [self.navigationController popViewControllerAnimated:YES];
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
    
    
    UIToolbar *pickerToolbar = [[UIToolbar alloc] init];
    [pickerToolbar sizeToFit];
    pickerToolbar.barStyle = UIBarStyleBlackOpaque;
    [pickerToolbar setBackgroundImage:[UIImage new]
                   forToolbarPosition:UIToolbarPositionAny
                           barMetrics:UIBarMetricsDefault];
    
    [pickerToolbar setBackgroundColor:kBlueColor];
    
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                style:UIBarButtonItemStyleDone target:self
                                                               action:@selector(doneClicked:)];
    
    
    [doneBtn setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], NSForegroundColorAttributeName,
                                     nil] forState:UIControlStateNormal];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [pickerToolbar setItems:[NSArray arrayWithObjects:flexSpace,doneBtn, nil]];
    _txtFieldContact.inputAccessoryView = pickerToolbar;
    
    _txtFieldLandmark = [self customtxtfield:_txtFieldLandmark withrightIcon:[UIImage imageNamed:@"pin.png"] borderLeft:YES borderRight:YES borderBottom:YES borderTop:NO];
    _txtFieldLandmark.delegate = self;
    
    _txtFieldCity = [self customtxtfield:_txtFieldCity withrightIcon:[UIImage imageNamed:@"pin.png"] borderLeft:YES borderRight:YES borderBottom:YES borderTop:NO];
    _txtFieldCity.delegate = self;
    
    _txtFieldState = [self customtxtfield:_txtFieldState withrightIcon:[UIImage imageNamed:@"pin.png"] borderLeft:YES borderRight:YES borderBottom:YES borderTop:NO];
    _txtFieldState.delegate = self;
    
    
    _txtFieldZipCode = [self customtxtfield:_txtFieldZipCode withrightIcon:[UIImage imageNamed:@"zip.png"] borderLeft:YES borderRight:YES borderBottom:YES borderTop:NO];
    _txtFieldZipCode.delegate = self;
    
    _txtFieldZipCode.inputAccessoryView = pickerToolbar;
    
    _txtFieldLandline = [self customtxtfield:_txtFieldLandline withrightIcon:[UIImage imageNamed:@"phone.png"] borderLeft:YES borderRight:YES borderBottom:YES borderTop:NO];
    _txtFieldLandline.delegate = self;
    
    _txtFieldLandline.inputAccessoryView = pickerToolbar;
    
    
    
    if(selectedOrder)
    {
        if ([self.addressType isEqualToString:@"shipping"])
        {
            _txtFieldCity.text = selectedOrder.req.city;
            _txtFieldState.text = selectedOrder.req.state;
            
            _txtFieldState.enabled = false;
            _txtFieldCity.enabled = false;
        }
        else
        {
            _txtFieldState.enabled = true;
            _txtFieldCity.enabled = true;
        }
    }
    else
    {
        _txtFieldState.enabled = true;
        _txtFieldCity.enabled = true;
    }

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
        [_txtFieldCity becomeFirstResponder];
    else if(textField == _txtFieldCity)
    {
        pickerViewState.hidden = NO;
        [self.view bringSubviewToFront:pickerViewState];
        
        if(arrayStates.count>0)
            selectedState = [NSString stringWithFormat:@"%@",[[arrayStates objectAtIndex: 0] valueForKey:@"code"]];
        
        UIPickerView *pickerView = [pickerViewState viewWithTag:777];
        
        [pickerView selectRow:0 inComponent:0 animated:NO];
        [_txtFieldZipCode resignFirstResponder];
    }
    
    else if(textField == _txtFieldZipCode)
        [_txtFieldContact becomeFirstResponder];
    else if(textField == _txtFieldContact)
        [_txtFieldLandline becomeFirstResponder];
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField==_txtFieldState)
    {
        [textField resignFirstResponder];
        [self.view endEditing:YES];
        
        pickerViewState.hidden = NO;
        [self.view bringSubviewToFront:pickerViewState];
        
        if(arrayStates.count>0)
            selectedState = [NSString stringWithFormat:@"%@",[[arrayStates objectAtIndex: 0] valueForKey:@"name"]];
        
        UIPickerView *pickerView = [pickerViewState viewWithTag:777];
        
        [pickerView selectRow:0 inComponent:0 animated:NO];
        
        return NO;
        
    }
    else
    {
        pickerViewState.hidden = YES;
    }
    
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


-(void)createPickerWithTag:(int)tag inView:(UIView*)parentview
{
    UIPickerView *pickerView=[[UIPickerView alloc]init];
    pickerView.frame=CGRectMake(0,0,self.view.frame.size.width, 216);
    pickerView.showsSelectionIndicator = YES;
    [pickerView setDataSource: self];
    [pickerView setDelegate: self];
    pickerView.tag = tag;
    pickerView.backgroundColor = [UIColor whiteColor];
    
    
    [parentview addSubview:pickerView];
    
    
    UIToolbar *pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    pickerToolbar.barStyle = UIBarStyleBlackOpaque;
    [pickerToolbar sizeToFit];
    
    [pickerToolbar setBackgroundImage:[UIImage new]
                   forToolbarPosition:UIToolbarPositionAny
                           barMetrics:UIBarMetricsDefault];
    
    [pickerToolbar setBackgroundColor:kBlueColor];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneButtonPressed)];
    
    [doneBtn setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], NSForegroundColorAttributeName,
                                     nil] forState:UIControlStateNormal];
    
    [pickerToolbar setItems:@[flexSpace, doneBtn] animated:YES];
    
    [parentview addSubview:pickerToolbar];
}

#pragma mark - UIPickerView delgates

// Number of components.
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// Total rows in our component.
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{

    if(pickerView.tag==777)
        return [arrayStates count];
    else
        return 0;
    
}

// Display each row's data.
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{

    if(pickerView.tag==777)
        return [NSString stringWithFormat:@"%@ (%@)",[[arrayStates objectAtIndex: row] valueForKey:@"name"],[[arrayStates objectAtIndex: row] valueForKey:@"code"]];
    
    else
        return @"";
}

// Do something with the selected row.
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{

    if(pickerView.tag==777)
    {
        NSLog(@"You selected this: %@", [[arrayStates objectAtIndex: row] valueForKey:@"name"]);
        selectedState = [[arrayStates objectAtIndex: row] valueForKey:@"name"];
    }
    
}

-(void)pickerDoneButtonPressed
{
    
    pickerViewState.hidden = YES;
    if(selectedState.length>0)
    {
        _txtFieldState.text = [selectedState capitalizedString];
    }
    
    [_txtFieldZipCode becomeFirstResponder];
    
//    UIEdgeInsets contentInsets = UIEdgeInsetsMake(20,0, 0, 0);
//    _scrollView.contentInset = contentInsets;
//    _scrollView.scrollIndicatorInsets = contentInsets;
    
}


- (IBAction)saveBtnAction:(UIButton *)sender {
    
    if(selectedAddress)
        [self updateAddress];
    else
        [self addAddress];
}
@end
