//
//  Conversation.h
//  MySteelHub
//
//  Created by Amit Yadav on 12/09/16.
//  Copyright © 2016 MySteelHub. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Conversation : NSObject

@property(strong,nonatomic) NSString *sellerID;
@property(strong,nonatomic) NSString *sellerName;
@property(strong,nonatomic) NSString *initialAmount;
@property(strong,nonatomic) NSString *bargainAmount;
@property(assign,nonatomic) BOOL isBestPrice;
@property(assign,nonatomic) BOOL isBuyerRead;
@property(assign,nonatomic) BOOL isBuyerReadBargain;
@property(assign,nonatomic) BOOL isAccepted;
@property(assign,nonatomic) BOOL isBargainRequired;
@property(assign,nonatomic) BOOL isDeleted;

@property(strong,nonatomic) NSMutableArray *arraySpecificationsResponse;

@property(strong,nonatomic) NSMutableArray *arrayBrands;

@end
