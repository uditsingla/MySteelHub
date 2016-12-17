//
//  OrderConfirmation.h
//  MySteelHub
//
//  Created by Abhishek Singla on 30/11/16.
//  Copyright © 2016 MySteelHub. All rights reserved.
//
#import "BaseViewController.h"
#import "Conversation.h"

#import <UIKit/UIKit.h>
@interface OrderConfirmation : BaseViewController

@property(nonatomic,strong) RequirementI *selectedRequirement;
@property(nonatomic,strong) Conversation *selectedConversation;


@end
