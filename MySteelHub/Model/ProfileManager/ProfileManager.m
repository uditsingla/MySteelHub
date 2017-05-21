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
                                       //address.landmark,@"landmark",
                                       address.mobile,@"mobile",
                                       address.landLine,@"landline",nil];
    
    
    [RequestManager asynchronousRequestWithPath:@"editAddress" requestType:RequestTypePOST params:dictParams timeOut:60 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json)
     {
         NSLog(@"Here comes save new address json %@",json);
         
         if (statusCode==200) {
             
             if([json valueForKey:@"address_id"])
             {
                 address.ID = [json valueForKey:@"address_id"];
                 
                 NSLog(@"Address count : %lu",(unsigned long)model_manager.profileManager.arraySavedAddress.count);
                 
                 if([address.addressType isEqualToString:@"billing"])
                 {
                     for (int i = 0 ; i < model_manager.profileManager.arrayBillingAddress.count; i++)
                     {
                         Address *addressExisting = [model_manager.profileManager.arrayBillingAddress objectAtIndex:i];
                         
                         if (address.ID == addressExisting.ID)
                         {
                             [model_manager.profileManager.arrayBillingAddress replaceObjectAtIndex:i withObject:address];
                             
                             break;
                         }
                         
                     }
                 }
                 else if ([address.addressType isEqualToString:@"shipping"])
                 {
                     for (int i = 0 ; i < model_manager.profileManager.arrayShippingAddress.count; i++)
                     {
                         Address *addressExisting = [model_manager.profileManager.arrayShippingAddress objectAtIndex:i];
                         
                         if (address.ID == addressExisting.ID)
                         {
                             [model_manager.profileManager.arrayShippingAddress replaceObjectAtIndex:i withObject:address];
                             
                             break;
                         }
                         
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

-(void)deleteAddress:(Address *)address completion:(void(^)(NSDictionary *json, NSError *error))completionBlock
{
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                       address.ID,@"id",
                                       address.addressType,@"addressType",
                                      nil];
    
    
    [RequestManager asynchronousRequestWithPath:@"deleteAddress" requestType:RequestTypePOST params:dictParams timeOut:60 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json)
     {
         NSLog(@"Here comes save new address json %@",json);
         
         if (statusCode==200) {
             
             if([json valueForKey:@"address_id"])
             {
                 address.ID = [json valueForKey:@"address_id"];
                 
                 NSLog(@"Address count : %lu",(unsigned long)model_manager.profileManager.arraySavedAddress.count);
                 
                 if([address.addressType isEqualToString:@"billing"])
                 {
                     for (int i = 0 ; i < model_manager.profileManager.arrayBillingAddress.count; i++)
                     {
                         Address *addressExisting = [model_manager.profileManager.arrayBillingAddress objectAtIndex:i];
                         
                         if (address.ID == addressExisting.ID)
                         {
                             [model_manager.profileManager.arrayBillingAddress removeObjectAtIndex:i];
                             
                             break;
                         }
                         
                     }
                 }
                 else if ([address.addressType isEqualToString:@"shipping"])
                 {
                     for (int i = 0 ; i < model_manager.profileManager.arrayShippingAddress.count; i++)
                     {
                         Address *addressExisting = [model_manager.profileManager.arrayShippingAddress objectAtIndex:i];
                         
                         if (address.ID == addressExisting.ID)
                         {
                             [model_manager.profileManager.arrayShippingAddress removeObjectAtIndex:i];
                             
                             break;
                         }
                         
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
     }];
    

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
                     
                  
                     
                     NSArray *arrBilling = [[arrData objectAtIndex:i] valueForKey:@"billing_address"];
                     
                     if(arrBilling.count > 0)
                     {
                     
                     NSDictionary *dictBillingAddress = [arrBilling objectAtIndex:0];
                     
                     NSLog(@"Billing : %@",dictBillingAddress);
                     
                     order.addressBilling.ID = [dictBillingAddress valueForKey:@"id"];
                     order.addressBilling.firmName = [NSString stringWithFormat:@"%@",[dictBillingAddress valueForKey:@"firm_name"]];
                     order.addressBilling.addressType = [NSString stringWithFormat:@"%@",[dictBillingAddress valueForKey:@"addressType"]];
                     order.addressBilling.address1 = [NSString stringWithFormat:@"%@",[dictBillingAddress valueForKey:@"address1"]];
                     order.addressBilling.address2 = [NSString stringWithFormat:@"%@",[dictBillingAddress valueForKey:@"address2"]];
                     order.addressBilling.city = [NSString stringWithFormat:@"%@",[dictBillingAddress valueForKey:@"city"]];
                     order.addressBilling.state = [NSString stringWithFormat:@"%@",[dictBillingAddress valueForKey:@"state"]];
                     order.addressBilling.pin = [NSString stringWithFormat:@"%@", [dictBillingAddress valueForKey:@"pincode"]];
                     order.addressBilling.landmark = [NSString stringWithFormat:@"%@",[dictBillingAddress valueForKey:@"landmark"]];
                     order.addressBilling.mobile = [NSString stringWithFormat:@"%@",[dictBillingAddress valueForKey:@"mobile"]];
                     order.addressBilling.landLine = [NSString stringWithFormat:@"%@",[dictBillingAddress valueForKey:@"landline"]];
                     }
                     
                     
                     NSArray *arrShipping = [[arrData objectAtIndex:i] valueForKey:@"shipping_address"];
                     if(arrShipping.count > 0)
                     {
                     
                     NSDictionary *dictShippingAddress = [arrShipping objectAtIndex:0];
                     
                     NSLog(@"Shipping : %@",dictShippingAddress);

                     
                     order.addressShipping.ID = [dictShippingAddress valueForKey:@"id"];
                     order.addressShipping.firmName = [NSString stringWithFormat:@"%@",[dictShippingAddress valueForKey:@"firm_name"]];
                     order.addressShipping.addressType = [NSString stringWithFormat:@"%@",[dictShippingAddress valueForKey:@"addressType"]];
                     order.addressShipping.address1 = [NSString stringWithFormat:@"%@",[dictShippingAddress valueForKey:@"address1"]];
                     order.addressShipping.address2 = [NSString stringWithFormat:@"%@",[dictShippingAddress valueForKey:@"address2"]];
                     order.addressShipping.city = [NSString stringWithFormat:@"%@",[dictShippingAddress valueForKey:@"city"]];
                     order.addressShipping.state = [NSString stringWithFormat:@"%@",[dictShippingAddress valueForKey:@"state"]];
                     order.addressShipping.pin = [NSString stringWithFormat:@"%@", [dictShippingAddress valueForKey:@"pincode"]];
                     order.addressShipping.landmark = [NSString stringWithFormat:@"%@",[dictShippingAddress valueForKey:@"landmark"]];
                     order.addressShipping.mobile = [NSString stringWithFormat:@"%@",[dictShippingAddress valueForKey:@"mobile"]];
                     order.addressShipping.landLine = [NSString stringWithFormat:@"%@",[dictShippingAddress valueForKey:@"landline"]];
                     }
                     
                     NSDictionary *dict = [[arrData objectAtIndex:i] valueForKey:@"postdata"];
                     order.req.gradeRequired = [dict valueForKey:@"grade_required"];
                     order.req.budget = [dict valueForKey:@"budget"];
                     order.req.state = [dict valueForKey:@"state"];
                     order.req.requiredByDate = [dict valueForKey:@"required_by_date"];
                     order.req.city = [dict valueForKey:@"city"];
                     order.req.arrayPreferedBrands = [[dict valueForKey:@"preffered_brands"] mutableCopy];
                     order.req.isChemical = [dict valueForKey:@"chemical"];
                     order.req.isPhysical = [dict valueForKey:@"physical"];
                     order.req.length = [dict valueForKey:@"length"];
                     order.req.type = [dict valueForKey:@"type"];
                     order.req.taxType = [NSString stringWithFormat:@"%i", [[dict valueForKey:@"tax_type"] intValue]];
                     order.req.isTestCertificateRequired = [dict valueForKey:@"test_certificate_required"];
                     
                     
                     
                     order.req.requirementID = [[arrData objectAtIndex:i] valueForKey:@"requirement_id"];
                     order.finalAmount = [NSString stringWithFormat:@"%i",[[[arrData objectAtIndex:i] valueForKey:@"final_amt"] intValue]];
                     order.statusCode = [[[arrData objectAtIndex:i] valueForKey:@"order_status"] intValue];
                     order.RTGS = [[arrData objectAtIndex:i] valueForKey:@"RTGS"];
                     order.billingID = [[arrData objectAtIndex:i] valueForKey:@"billing_id"];
                     order.shippingID = [[arrData objectAtIndex:i] valueForKey:@"shipping_id"];
                     order.buyerID = [[arrData objectAtIndex:i] valueForKey:@"buyer_id"];
                     order.sellerID = [[arrData objectAtIndex:i] valueForKey:@"seller_id"];
                     order.orderID = [NSString stringWithFormat:@"%i",[[[arrData objectAtIndex:i] valueForKey:@"order_id"] intValue]];
                     
                     NSArray *arr = [dict valueForKey:@"quantity"];
                     for(int i = 0; i < arr.count ; i++)
                     {
                         [order.req.arraySpecifications addObject:[arr objectAtIndex:i]];
                         
                        // NSLog(@"%@",order.req.arraySpecifications);
                     }
                     
                     
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

-(void)getUserProfile:(void (^)(NSDictionary *, NSError *))completionBlock
{
    
    [RequestManager asynchronousRequestWithPath:@"getProfile" requestType:RequestTypeGET params:nil timeOut:60 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json)
     {
         NSLog(@"Here comes orders json %@",json);
         
         if (statusCode == 200) {
             
             if([json valueForKey:@"data"])
             {
                 NSDictionary *dictData = [json valueForKey:@"data"];
                 owner.email = [dictData valueForKey:@"email"];
                 owner.name = [dictData valueForKey:@"name"];
                 owner.address = [dictData valueForKey:@"address"];
                 if([dictData valueForKey:@"brand"] && ![[dictData valueForKey:@"brand"] isEqual:[NSNull null]])
                     owner.brands = [dictData valueForKey:@"brand"];
                 owner.city = [dictData valueForKey:@"city"];
                 owner.companyName = [dictData valueForKey:@"company_name"];
                 owner.contactNo = [NSString stringWithFormat:@"%.0f", [[dictData valueForKey:@"contact"] doubleValue]];
                 if([dictData valueForKey:@"customer_type"] != nil && [dictData valueForKey:@"customer_type"] != [NSNull null])
                     owner.customerType = [[dictData valueForKey:@"customer_type"] mutableCopy];
                 owner.expectedQuantity = [NSString stringWithFormat:@"%.0f",[[dictData valueForKey:@"exp_quantity"] doubleValue]];
                 owner.userID = [NSString stringWithFormat:@"%i",[[dictData valueForKey:@"id"] intValue]];
                 owner.latitude = [[dictData valueForKey:@"latitude"] doubleValue];
                 owner.longitude = [[dictData valueForKey:@"longitude"] doubleValue];
                 owner.pan = [NSString stringWithFormat:@"%@",[dictData valueForKey:@"pan"]];
                 owner.role = [dictData valueForKey:@"role"];
                 owner.state = [dictData valueForKey:@"state"];
                 owner.tin = [NSString stringWithFormat:@"%.0f",[[dictData valueForKey:@"tin"] doubleValue]];
                 owner.zip = [NSString stringWithFormat:@"%.0f",[[dictData valueForKey:@"zip"] doubleValue]];
                 
             }
             
             if(completionBlock)
                 completionBlock(json,nil);

         }
         else{
             if(completionBlock)
                 completionBlock(nil,nil);
             //show error
         }
         
         
     }];
}

- (void)updateProfile:(NSDictionary *)dictParam completion:(void(^)(NSDictionary *response, NSError *error))completionBlock
{
    [RequestManager asynchronousRequestWithPath:@"update/profile" requestType:RequestTypePOST params:dictParam timeOut:60 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json) {
        NSLog(@"Here comes the json %@",json);
        if (statusCode==200) {
            completionBlock(json,nil);
            
        }
        else{
            completionBlock(nil,nil);
            //show error
        }
        
    } ];
    
    
}


@end
