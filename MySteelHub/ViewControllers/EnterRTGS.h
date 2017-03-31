//
//  EnterRTGS.h
//  MySteelHub
//
//  Created by Amit Yadav on 30/03/17.
//  Copyright © 2017 MySteelHub. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderI.h"

@interface EnterRTGS : BaseViewController<UITextFieldDelegate>

@property(nonatomic,strong) OrderI *selectedOrder;

@end
