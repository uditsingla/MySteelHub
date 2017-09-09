//
//  AddAddressVC.h
//  MySteelHub
//
//  Created by Amit Yadav on 16/10/16.
//  Copyright © 2016 MySteelHub. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderI.h"

@interface AddAddressVC : BaseViewController<UITextFieldDelegate>
{
    __weak IBOutlet UITextField *_txtFieldName;
    __weak IBOutlet UITextField *_txtFieldAddress1;
    __weak IBOutlet UITextField *_txtFieldAddress2;
    __weak IBOutlet UITextField *_txtFieldLandmark;
    __weak IBOutlet UITextField *_txtFieldCity;
    __weak IBOutlet UITextField *_txtFieldState;
    __weak IBOutlet UITextField *_txtFieldZipCode;
    __weak IBOutlet UITextField *_txtFieldContact;
    __weak IBOutlet UITextField *_txtFieldLandline;
    __weak IBOutlet UIScrollView *_scrollView;

}

- (IBAction)saveBtnAction:(UIButton *)sender;

@property(nonatomic,retain) NSString *addressType;

@property(nonatomic,retain) Address *selectedAddress;

@property(nonatomic,weak)OrderI *selectedOrder;


@end
