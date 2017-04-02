//
//  ProfileManager.m
//  MySteelHub
//
//  Created by Amit Yadav on 15/08/16.
//  Copyright © 2016 MySteelHub. All rights reserved.
//

#import "ProfileManager.h"
#import "OrderI.h"
@implementation ProfileManager
@synthesize owner;
@synthesize arraySavedAddress,arrayBillingAddress,arrayShippingAddress,arrayPendingOrders,arrayInprogressOrders,arrayConfirmedOrders,arrayDeliveredOrders,arrayRejectedOrders;

- (id)init
{
    self = [super init];
    if (self) {
        
        owner = [UserI new];
        arraySavedAddress = [NSMutableArray new];
        arrayBillingAddress = [NSMutableArray new];
        arrayShippingAddress = [NSMutableArray new];
        
        arrayPendingOrders = [NSMutableArray new];
        arrayInprogressOrders = [NSMutableArray new];
        arrayConfirmedOrders = [NSMutableArray new];
        arrayDeliveredOrders = [NSMutableArray new];
        arrayRejectedOrders = [NSMutableArray new];

    }
    return self;
}



-(void)addNewAddress:(Address *)address completion:(void(^)(NSDictionary *json, NSError *error))completionBlock
{
    
        NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                           address.firmName,@"firm_name",
                                           address.addressType,@"addressType",
                                           address.address1,@"address1",
                                           address.address2,@"address2",
                                           address.city,@"city",
                                           address.state,@"state",
                                           address.pin,@"pincode",
                                           address.landmark,@"landmark",
                                           address.mobile,@"mobile",
                                           address.landLine,@"landline",
                                           [NSNumber numberWithInt:1],@"current",
                                           nil];

    
    [RequestManager asynchronousRequestWithPath:@"addNewAddress" requestType:RequestTypePOST params:dictParams timeOut:60 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json)
    {
        NSLog(@"Here comes save new address json %@",json);
        
        if (statusCode==200) {
            
            if([json valueForKey:@"address_id"])
            {
                address.ID = [json valueForKey:@"address_id"];
                
//                requirement.requirementID = [NSString stringWithFormat:@"%i",[[[[json valueForKey:@"data"] firstObject] valueForKey:@"requirement_id"] intValue]];
                
                [model_manager.profileManager.arraySavedAddress addObject:address];
                
                if([address.addressType isEqualToString:@"billing"])
                    [model_manager.profileManager.arrayBillingAddress addObject:address];
                else
                    [model_manager.profileManager.arrayShippingAddress addObject:address];
            }
            
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


-(void)editAddress:(Address *)address completion:(void(^)(NSDictionary *json, NSError *error))completionBlock
{
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                       address.ID,@"id",
                                       address.firmName,@"firm_name",
                                       address.addressType,@"addressType",
                                       address.address1,@"address1",
                                       address.address2,@"address2",
                                       address.city,@"city",
                                       address.state,@"state",
                                       address.pin,@"pincode",
                                       address.landmark,@"landmark",
                                       address.mobile,@"mobile",
                                       address.landLine,@"landline",nil];
    
    
    [RequestManager asynchronousRequestWithPath:@"editAddress" requestType:RequestTypePOST params:dictParams timeOut:60 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json)
     {
         NSLog(@"Here comes save new address json %@",json);
         
         if (statusCode==200) {
             
             if([[[json valueForKey:@"data"] firstObject] valueForKey:@"id"])
             {
                 address.ID = [[[json valueForKey:@"data"] firstObject] valueForKey:@"id"];
                 
                 //                requirement.requirementID = [NSString stringWithFormat:@"%i",[[[[json valueForKey:@"data"] firstObject] valueForKey:@"requirement_id"] intValue]];
                 
                 for (int i = 0 ; i < model_manager.profileManager.arraySavedAddress.count; i++)
                 {
                     Address *addressExisting = [model_manager.profileManager.arraySavedAddress objectAtIndex:i];
                     
                     if (address.ID == addressExisting.ID)
                     {
                         [model_manager.profileManager.arraySavedAddress replaceObjectAtIndex:i withObject:address];
                         
                         break;
                     }
                     
                 }
                 
             }
             
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

-(void)getShippingAddressesWithCompletion:(void(^)(NSDictionary *json, NSError *error))completionBlock
{
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                       @"shipping",@"addressType",
                                       nil];
    
    
    [RequestManager asynchronousRequestWithPath:@"fetchAddress" requestType:RequestTypePOST params:dictParams timeOut:60 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json)
     {
         NSLog(@"Here comes shipping address json %@",json);
         
         if (statusCode==200) {
             
             if([json valueForKey:@"data"])
             {
                 NSArray *array = [json valueForKey:@"data"];
                 [arrayShippingAddress removeAllObjects];
                 
                 for(int i=0; i<array.count; i++)
                 {
                     Address *address = [Address new];
                     address.ID = [[array objectAtIndex:i] valueForKey:@"id"];
                     address.firmName = [[array objectAtIndex:i] valueForKey:@"firm_name"];
                     address.addressType = [[array objectAtIndex:i] valueForKey:@"addressType"];
                     address.address1 = [[array objectAtIndex:i] valueForKey:@"address1"];
                     address.address2 = [[array objectAtIndex:i] valueForKey:@"address2"];
                     address.city = [[array objectAtIndex:i] valueForKey:@"city"];
                     address.state = [[array objectAtIndex:i] valueForKey:@"state"];
                     address.pin = [NSString stringWithFormat:@"%@",[[array objectAtIndex:i] valueForKey:@"pincode"]];
                     address.landmark = [[array objectAtIndex:i] valueForKey:@"landmark"];
                     address.mobile = [NSString stringWithFormat:@"%@",[[array objectAtIndex:i] valueForKey:@"mobile"]];
                     address.landLine = [NSString stringWithFormat:@"%@",[[array objectAtIndex:i] valueForKey:@"landline"]];
                     
                     [arrayShippingAddress addObject:address];
                 }
                 
             }
         }
         else{
             if(completionBlock)
                 completionBlock(nil,nil);
             //show error
         }
         
     } ];
    
    
}

-(void)getBillingAddressesWithCompletion:(void(^)(NSDictionary *json, NSError *error))completionBlock
{
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                       @"billing",@"addressType",
                                       nil];
    
    
    [RequestManager asynchronousRequestWithPath:@"fetchAddress" requestType:RequestTypePOST params:dictParams timeOut:60 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json)
     {
         NSLog(@"Here comes billing address json %@",json);
         
         if (statusCode==200) {
             
             if([json valueForKey:@"data"])
             {
                 NSArray *array = [json valueForKey:@"data"];
                 [arrayBillingAddress removeAllObjects];
                 
                 for(int i=0; i<array.count; i++)
                 {
                     Address *address = [Address new];
                     address.ID = [[array objectAtIndex:i] valueForKey:@"id"];
                     address.firmName = [[array objectAtIndex:i] valueForKey:@"firm_name"];
                     address.addressType = [[array objectAtIndex:i] valueForKey:@"addressType"];
                     address.address1 = [[array objectAtIndex:i] valueForKey:@"address1"];
                     address.address2 = [[array objectAtIndex:i] valueForKey:@"address2"];
                     address.city = [[array objectAtIndex:i] valueForKey:@"city"];
                     address.state = [[array objectAtIndex:i] valueForKey:@"state"];
                     address.pin = [NSString stringWithFormat:@"%@", [[array objectAtIndex:i] valueForKey:@"pincode"]];
                     address.landmark = [[array objectAtIndex:i] valueForKey:@"landmark"];
                     address.mobile = [NSString stringWithFormat:@"%@",[[array objectAtIndex:i] valueForKey:@"mobile"]];
                     address.landLine = [NSString stringWithFormat:@"%@",[[array objectAtIndex:i] valueForKey:@"landline"]];
                     
                     [arrayBillingAddress addObject:address];
                 }
                 
             }
         }
         else{
             if(completionBlock)
                 completionBlock(nil,nil);
             //show error
         }
         
     } ];
}


-(void)getOrderswithOrdertype:(NSMutableDictionary*)dictOrderParam completionBlock:(void(^)(NSDictionary *json, NSError *error))completionBlock
{
    [RequestManager asynchronousRequestWithPath:@"getOrders" requestType:RequestTypePOST params:dictOrderParam timeOut:60 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json)
     {
         NSLog(@"Here comes orders json %@",json);
         
         int orderType = [[dictOrderParam valueForKey:@"status"] intValue];
         
         NSLog(@"Order type : %d",orderType);
         
         
         if (statusCode == 200) {
             
             if([json valueForKey:@"data"])
             {
                 int orderType = [[dictOrderParam valueForKey:@"status"] intValue];
                 
                 NSArray *arrData = [json valueForKey:@"data"];
                 
                 NSLog(@"Order type : %d",orderType);
                 switch (orderType) {
                     case 0:
                         [arrayPendingOrders removeAllObjects];
                         break;
                     case 1:
                         [arrayConfirmedOrders removeAllObjects];
                         break;
                     case 2:
                         [arrayRejectedOrders removeAllObjects];
                         break;
                     case 3:
                         [arrayInprogressOrders removeAllObjects];
                         break;
                     case 4:
                         [arrayDeliveredOrders removeAllObjects];
                         break;
                     default:
                         break;
                 }
                 
                 for (int i = 0 ; i < arrData.count; i++) {
                     
                     OrderI *order = [OrderI new];
                     NSDictionary *dict = [[arrData objectAtIndex:i] valueForKey:@"postdata"];
                     order.req.budget = [dict valueForKey:@"budget"];
                     order.req.state = [dict valueForKey:@"state"];
                     order.req.requiredByDate = [dict valueForKey:@"required_by_date"];
                     order.req.city = [dict valueForKey:@"city"];
                     order.req.requirementID = [[arrData objectAtIndex:i] valueForKey:@"requirement_id"];
                     
                     order.finalAmount = [[arrData objectAtIndex:i] valueForKey:@"final_amt"];
                     order.statusCode = [[[arrData objectAtIndex:i] valueForKey:@"order_status"] intValue];
                     order.RTGS = [[arrData objectAtIndex:i] valueForKey:@"RTGS"];
                     order.billingID = [[arrData objectAtIndex:i] valueForKey:@"billing_id"];
                     order.shippingID = [[arrData objectAtIndex:i] valueForKey:@"shipping_id"];
                     order.buyerID = [[arrData objectAtIndex:i] valueForKey:@"buyer_id"];
                     order.sellerID = [[arrData objectAtIndex:i] valueForKey:@"seller_id"];
                     order.orderID = [[arrData objectAtIndex:i] valueForKey:@"order_id"];
                     
                     if(orderType == 0)
                     {
                         [arrayPendingOrders addObject:order];
                     }
                     else if (orderType == 1)
                     {
                         [arrayConfirmedOrders addObject:order];
                     }
                     else if (orderType == 2)
                     {
                         [arrayRejectedOrders addObject:order];
                     }
                     else if (orderType == 3)
                     {
                         [arrayInprogressOrders addObject:order];
                     }
                     else if (orderType == 4)
                     {
                         [arrayDeliveredOrders addObject:order];
                     }
                 }
             }
             
             NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:@"true",@"success", nil];
             completionBlock(dict,nil);
         }
         else{
             if(completionBlock)
                 completionBlock(nil,nil);
             //show error
         }
         
     } ];
    
    
}

@end
