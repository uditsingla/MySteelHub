//
//  AddAddressVC.h
//  MySteelHub
//
//  Created by Amit Yadav on 16/10/16.
//  Copyright © 2016 MySteelHub. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddAddressVC : BaseViewController
{
    __weak IBOutlet UITextField *_txtFieldName;
    __weak IBOutlet UITextField *_txtFieldAddress1;
    
    __weak IBOutlet UITextField *_txtFieldAddress2;
    __weak IBOutlet UITextField *_txtFieldCity;
    __weak IBOutlet UITextField *_txtFieldState;
    __weak IBOutlet UITextField *_txtFieldZipCode;
    __weak IBOutlet UITextField *_txtFieldContact;
    __weak IBOutlet UIButton *btnCategory;

}

- (IBAction)btnCategoryAction:(UIButton *)sender;
- (IBAction)saveBtnAction:(UIButton *)sender;

@end
