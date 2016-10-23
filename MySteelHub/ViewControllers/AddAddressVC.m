//
//  AddAddressVC.m
//  MySteelHub
//
//  Created by Amit Yadav on 16/10/16.
//  Copyright © 2016 MySteelHub. All rights reserved.
//

#import "AddAddressVC.h"

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
