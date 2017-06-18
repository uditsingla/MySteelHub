//
//  OrderI.m
//  MySteelHub
//
//  Created by Abhishek Singla on 12/03/17.
//  Copyright © 2017 MySteelHub. All rights reserved.
//

#import "OrderI.h"
#import "RequirementI.h"

@implementation OrderI

@synthesize addressBilling, addressShipping, req, statusCode, orderID , finalAmount, RTGS, billingID, shippingID, buyerID, sellerID;

- (id)init
{
    self = [super init];
    if (self) {
        addressBilling = [Address new];
        addressShipping = [Address new];
        req = [RequirementI new];
        finalAmount = @"";
        statusCode = 0;
        orderID = @"";
        RTGS = @"";
        billingID = @"";
        shippingID = @"";
        buyerID = @"";
        sellerID = @"";
    }
    return self;
}

-(void)buyerPostRTGS:(NSString*)rtgsNumber toSeller:(NSString*)sellerId withCompletion:(void(^)(NSDictionary *json, NSError *error))completionBlock
{
    //create dictParam
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] initWithObjectsAndKeys:self.req.requirementID,@"requirement_id" ,sellerId,@"seller_id", /*self.userID,@"buyer_id",*/rtgsNumber,@"RTGS", nil];
    
    
    [RequestManager asynchronousRequestWithPath:@"saveRTGS" requestType:RequestTypePOST params:dictParams timeOut:60 includeHeaders:YES onCompletion:^(long status, NSDictionary *json) {
        NSLog(@"Here comes the json %@",json);
        if (status==200) {
            
            //remove order from pending list
            NSPredicate *predicateOrderId = [NSPredicate predicateWithFormat:@"orderID == %@",self.orderID];
            NSArray *filteredArray = [model_manager.profileManager.arrayPendingOrders filteredArrayUsingPredicate:predicateOrderId];
            if (filteredArray.count>0)
                [model_manager.profileManager.arrayPendingOrders removeObject:filteredArray.firstObject];
            
            if(completionBlock)
                completionBlock(json,nil);
            
        }
        else{
            if(completionBlock)
                completionBlock(nil,nil);
            //show error
        }
        
    } ];
    
}

-(void)buyerSaveAddress:(NSString*)shippingId withBilling:(NSString*)billingId withCompletion:(void(^)(NSDictionary *json, NSError *error))completionBlock
{
    //create dictParam
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] initWithObjectsAndKeys:self.req.requirementID,@"requirement_id" ,shippingId,@"shipping_id", billingId,@"billing_id",self.orderID,@"id", nil];
    
    
    [RequestManager asynchronousRequestWithPath:@"saveOrderAddress" requestType:RequestTypePOST params:dictParams timeOut:60 includeHeaders:YES onCompletion:^(long status, NSDictionary *json) {
        NSLog(@"Here comes the json %@",json);
        if (status==200) {
            
            
            if(completionBlock)
                completionBlock(json,nil);
            
        }
        else{
            if(completionBlock)
                completionBlock(nil,nil);
            //show error
        }
        
    } ];
    
}

@end
