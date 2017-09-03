//
//  OrderPreview.h
//  MySteelHub
//
//  Created by Abhishek Singla on 16/04/17.
//  Copyright © 2017 MySteelHub. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderI.h"

@interface OrderPreview : BaseViewController

@property(nonatomic,strong) OrderI *selectedOrder;
@property(nonatomic,assign) BOOL hideProceedButton;

@property (weak, nonatomic) IBOutlet UIButton *btnProceed;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tblBottomSpaceConstraint;
@end
