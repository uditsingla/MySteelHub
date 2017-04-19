//
//  ProfileManager.h
//  MySteelHub
//
//  Created by Amit Yadav on 15/08/16.
//  Copyright © 2016 MySteelHub. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserI.h"
#import "Address.h"

@interface ProfileManager : NSObject

@property(strong,nonatomic) UserI *owner;
@property(strong,nonatomic) NSMutableArray *arraySavedAddress;
@property(strong,nonatomic) NSMutableArray *arrayShippingAddress;
@property(strong,nonatomic) NSMutableArray *arrayBillingAddress;


@property(strong,nonatomic) NSMutableArray *arrayPendingOrders;
@property(strong,nonatomic) NSMutableArray *arrayInprogressOrders;
@property(strong,nonatomic) NSMutableArray *arrayConfirmedOrders;
@property(strong,nonatomic) NSMutableArray *arrayDeliveredOrders;
@property(strong,nonatomic) NSMutableArray *arrayRejectedOrders;

-(void)addNewAddress:(Address *)address completion:(void(^)(NSDictionary *json, NSError *error))completionBlock;

-(void)editAddress:(Address *)address completion:(void(^)(NSDictionary *json, NSError *error))completionBlock;

-(void)deleteAddress:(Address *)address completion:(void(^)(NSDictionary *json, NSError *error))completionBlock;

-(void)getShippingAddressesWithCompletion:(void(^)(NSDictionary *json, NSError *error))completionBlock;

-(void)getBillingAddressesWithCompletion:(void(^)(NSDictionary *json, NSError *error))completionBlock;

-(void)getOrderswithOrdertype:(NSMutableDictionary*)dictOrderParam completionBlock:(void(^)(NSDictionary *json, NSError *error))completionBlock
;

@end
