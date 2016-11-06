//
//  ProfileManager.m
//  MySteelHub
//
//  Created by Amit Yadav on 15/08/16.
//  Copyright © 2016 MySteelHub. All rights reserved.
//

#import "ProfileManager.h"

@implementation ProfileManager
@synthesize owner;
@synthesize arraySavedAddress;

- (id)init
{
    self = [super init];
    if (self) {
        
        owner = [UserI new];
        arraySavedAddress = [NSMutableArray new];
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
                                           address.landLine,@"landline",nil];

    
    [RequestManager asynchronousRequestWithPath:@"addNewAddress" requestType:RequestTypePOST params:dictParams timeOut:60 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json)
    {
        NSLog(@"Here comes save new address json %@",json);
        
        if (statusCode==200) {
            
            if([[[json valueForKey:@"data"] firstObject] valueForKey:@"id"])
            {
                address.ID = [[[json valueForKey:@"data"] firstObject] valueForKey:@"id"];
                
//                requirement.requirementID = [NSString stringWithFormat:@"%i",[[[[json valueForKey:@"data"] firstObject] valueForKey:@"requirement_id"] intValue]];
                
                [model_manager.profileManager.arraySavedAddress addObject:address];
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
                         
                         if(completionBlock)
                             completionBlock(json,nil);
                         break;
                     }
                     
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



@end
