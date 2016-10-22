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
