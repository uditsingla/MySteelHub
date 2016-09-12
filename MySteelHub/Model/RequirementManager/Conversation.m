//
//  Conversation.m
//  MySteelHub
//
//  Created by Amit Yadav on 12/09/16.
//  Copyright © 2016 MySteelHub. All rights reserved.
//

#import "Conversation.h"

@implementation Conversation

@synthesize sellerID,sellerName,initialAmount,bargainAmount,isBestPrice,isBuyerRead,isBuyerReadBargain,isAccepted,isBargainRequired,isDeleted;

- (id)init
{
    self = [super init];
    if (self) {
        
        sellerID = @"";
        sellerName = @"";
        initialAmount = @"";
        bargainAmount = @"";
        isBestPrice = NO;
        isBuyerRead = NO;
        isBuyerReadBargain = NO;
        isAccepted = NO;
        isBargainRequired = NO;
        isDeleted = NO;
        
    }
    return self;
}

@end
