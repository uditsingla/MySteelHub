//
//  OrderI.h
//  MySteelHub
//
//  Created by Abhishek Singla on 12/03/17.
//  Copyright © 2017 MySteelHub. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequirementI.h"
@interface OrderI : NSObject

@property(nonatomic,strong)RequirementI *req;
@property(nonatomic,assign) int statusCode;
@property(strong,nonatomic) NSString *orderID;
@property(strong,nonatomic) NSString *finalAmount;
@property(strong,nonatomic) NSString *RTGS;
@property(strong,nonatomic) NSString *billingID;
@property(strong,nonatomic) NSString *shippingID;
@property(strong,nonatomic) NSString *buyerID;
@property(strong,nonatomic) NSString *sellerID;

-(void)buyerPostRTGS:(NSString*)rtgsNumber toSeller:(NSString*)sellerId withCompletion:(void(^)(NSDictionary *json, NSError *error))completionBlock;

-(void)buyerSaveAddress:(NSString*)shippingId withBilling:(NSString*)billingId withCompletion:(void(^)(NSDictionary *json, NSError *error))completionBlock;

@end
