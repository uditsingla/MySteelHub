//
//  RequirementManager.m
//  MySteelHub
//
//  Created by Amit Yadav on 10/07/16.
//  Copyright © 2016 MySteelHub. All rights reserved.
//

#import "RequirementManager.h"

@implementation RequirementManager

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)postRequirement:(RequirementI *)requirement completion:(void(^)(NSDictionary *json, NSError *error))completionBlock
{
    //create dictParam with requirement object
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"12",@"user_id",  requirement.arraySpecifications,@"specification",@"A-Grade",@"grade_required",[NSNumber numberWithBool:requirement.isPhysical],@"physical",[NSNumber numberWithBool: requirement.isChemical],@"chemical",[NSNumber numberWithBool:requirement.isTestCertificateRequired],@"test_certificate_required",requirement.length,@"length",requirement.type,@"type",requirement.arrayPreferedBrands,@"preffered_brands",@"",@"required_by_date",requirement.budget,@"budget",requirement.city,@"city",requirement.state,@"state",nil];

    
    [RequestManager asynchronousRequestWithPath:@"buyer/post" requestType:RequestTypePOST params:dictParams timeOut:60 includeHeaders:NO onCompletion:^(long statusCode, NSDictionary *json) {
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

-(void)getPostedRequirements:(void(^)(NSDictionary *json, NSError *error))completionBlock;
{
    //create dictParam with requirement object
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"],@"user_id",nil];
    
    
    [RequestManager asynchronousRequestWithPath:@"buyer/post" requestType:RequestTypePOST params:dictParams timeOut:60 includeHeaders:NO onCompletion:^(long statusCode, NSDictionary *json) {
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
