//
//  RequirementManager.m
//  MySteelHub
//
//  Created by Amit Yadav on 10/07/16.
//  Copyright © 2016 MySteelHub. All rights reserved.
//

#import "RequirementManager.h"
#import "Conversation.h"

@implementation RequirementManager

@synthesize arrayPostedRequirements,arraySteelBrands,arraySteelSizes,arraySteelGrades,arrayTaxTypes;

- (id)init
{
    self = [super init];
    if (self) {
        arrayPostedRequirements = [NSMutableArray new];
        arraySteelBrands = [NSMutableArray new];
        arraySteelSizes = [NSMutableArray new];
        arraySteelGrades = [NSMutableArray new];
        arrayTaxTypes = [NSMutableArray new];
    }
    return self;
}

-(void)postRequirement:(RequirementI *)requirement completion:(void(^)(NSDictionary *json, NSError *error))completionBlock
{
    //create dictParam with requirement object
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] initWithObjectsAndKeys:requirement.userID,@"user_id",  requirement.arraySpecifications,@"specification",requirement.gradeRequired,@"grade_required",[NSNumber numberWithBool:requirement.isPhysical],@"physical",[NSNumber numberWithBool: requirement.isChemical],@"chemical",[NSNumber numberWithBool:requirement.isTestCertificateRequired],@"test_certificate_required",requirement.length,@"length",requirement.type,@"type",requirement.arrayPreferedBrands,@"preffered_brands",requirement.requiredByDate,@"required_by_date",requirement.budget,@"budget",requirement.city,@"city",requirement.state,@"state",nil];

    
    [RequestManager asynchronousRequestWithPath:@"buyer/post" requestType:RequestTypePOST params:dictParams timeOut:60 includeHeaders:NO onCompletion:^(long statusCode, NSDictionary *json) {
        NSLog(@"Here comes the json %@",json);
        if (statusCode==200) {
            
            if([[[json valueForKey:@"data"] firstObject] valueForKey:@"requirement_id"])
            {
                requirement.requirementID = [NSString stringWithFormat:@"%i",[[[[json valueForKey:@"data"] firstObject] valueForKey:@"requirement_id"] intValue]];
                
                [model_manager.requirementManager.arrayPostedRequirements addObject:requirement];
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

-(void)getPostedRequirements:(void(^)(NSDictionary *json, NSError *error))completionBlock;
{
    //create dictParam with requirement object
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"],@"user_id",nil];
    
    
    [RequestManager asynchronousRequestWithPath:@"posted/requirements" requestType:RequestTypePOST params:dictParams timeOut:60 includeHeaders:NO onCompletion:^(long statusCode, NSDictionary *json) {
        NSLog(@"Here comes the json %@",json);
        if (statusCode==200) {
            
            [arrayPostedRequirements removeAllObjects];
            NSArray *array = [json valueForKey:@"data"];
            for (int i=0; i < array.count; i++) {
                RequirementI *requirement = [RequirementI new];
                requirement.userID = [NSString stringWithFormat:@"%i", [[[array objectAtIndex:i] valueForKey:@"user_id"] intValue]];
                
                requirement.requirementID = [NSString stringWithFormat:@"%i", [[[array objectAtIndex:i] valueForKey:@"requirement_id"] intValue]];
                
                requirement.isPhysical = [[[array objectAtIndex:i] valueForKey:@"physical"] boolValue];
                
                requirement.isChemical = [[[array objectAtIndex:i] valueForKey:@"chemical"] boolValue];

                requirement.isTestCertificateRequired = [[[array objectAtIndex:i] valueForKey:@"test_certificate_required"] boolValue];

                requirement.length = [[array objectAtIndex:i] valueForKey:@"length"];
                
                requirement.type = [[array objectAtIndex:i] valueForKey:@"type"];

                requirement.budget = [NSString stringWithFormat:@"%@",[[array objectAtIndex:i] valueForKey:@"budget"]];

                requirement.city = [NSString stringWithFormat:@"%@",[[array objectAtIndex:i] valueForKey:@"city"]];

                requirement.state = [[array objectAtIndex:i] valueForKey:@"state"];
                
                requirement.requiredByDate = [NSString stringWithFormat:@"%@",[[array objectAtIndex:i] valueForKey:@"required_by_date"]];

                requirement.arraySpecifications = [[array objectAtIndex:i] valueForKey:@"quantity"];
                
                requirement.gradeRequired = [NSString stringWithFormat:@"%i",[[[array objectAtIndex:i] valueForKey:@"grade_required"] intValue]];

                requirement.arrayPreferedBrands = [[array objectAtIndex:i] valueForKey:@"preffered_brands"];
                
                NSArray *arrayResponse = [[array objectAtIndex:i] valueForKey:@"response"];
        

                for (int j=0; j < arrayResponse.count; j++) {
                    
                    Conversation *obj = [Conversation new];
                    obj.initialAmount = [NSString stringWithFormat:@"%@",[[arrayResponse objectAtIndex:j] valueForKey:@"initial_amt"]];
                    
                    obj.bargainAmount = [NSString stringWithFormat:@"%@",[[arrayResponse objectAtIndex:j] valueForKey:@"bargain_amt"]];
                    
                    obj.isBestPrice = [[[arrayResponse objectAtIndex:j] valueForKey:@"is_best_price"] boolValue];
                    
                    obj.isBuyerRead = [[[arrayResponse objectAtIndex:j] valueForKey:@"is_buyer_read"] boolValue];
                    
                    obj.isBuyerReadBargain = [[[arrayResponse objectAtIndex:j] valueForKey:@"is_buyer_read_bargain"] boolValue];
                    
                    obj.isAccepted = [[[arrayResponse objectAtIndex:j] valueForKey:@"is_accepted"] boolValue];
                    
                    obj.isBargainRequired = [[[arrayResponse objectAtIndex:j] valueForKey:@"req_for_bargain"] boolValue];
                    
                    obj.isDeleted = [[[arrayResponse objectAtIndex:j] valueForKey:@"is_buyer_deleted"] boolValue];
                    
                    obj.initialAmount = [NSString stringWithFormat:@"%@",[[arrayResponse objectAtIndex:j] valueForKey:@"initial_amt"]];

                    obj.sellerID = [NSString stringWithFormat:@"%i",[[[arrayResponse objectAtIndex:j] valueForKey:@"seller_id"] intValue]];
                    
                    obj.sellerName = [NSString stringWithFormat:@"%i",[[[arrayResponse objectAtIndex:j] valueForKey:@"seller_name"] intValue]];


                    
                    [requirement.arrayConversations addObject:obj];
                }

                [arrayPostedRequirements addObject:requirement];
                

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

-(void)getSteelBrands:(void(^)(NSDictionary *json, NSError *error))completionBlock
{
    [RequestManager asynchronousRequestWithPath:@"brands" requestType:RequestTypeGET params:nil timeOut:60 includeHeaders:NO onCompletion:^(long statusCode, NSDictionary *json) {
        NSLog(@"Here comes the json %@",json);
        if (statusCode==200) {
            
            [arraySteelBrands removeAllObjects];
            NSArray *array = [json valueForKey:@"data"];
            for (int i=0; i < array.count; i++) {
                [arraySteelBrands addObject:[array objectAtIndex:i]];
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

-(void)getSteelSizes:(void(^)(NSDictionary *json, NSError *error))completionBlock
{
    [RequestManager asynchronousRequestWithPath:@"steelsizes" requestType:RequestTypeGET params:nil timeOut:60 includeHeaders:NO onCompletion:^(long statusCode, NSDictionary *json) {
        NSLog(@"Here comes the json %@",json);
        if (statusCode==200) {
            
            [arraySteelSizes removeAllObjects];
            NSArray *array = [json valueForKey:@"data"];
            for (int i=0; i < array.count; i++) {
                [arraySteelSizes addObject:[array objectAtIndex:i]];
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

-(void)getSteelGrades:(void(^)(NSDictionary *json, NSError *error))completionBlock
{
    [RequestManager asynchronousRequestWithPath:@"grades" requestType:RequestTypeGET params:nil timeOut:60 includeHeaders:NO onCompletion:^(long statusCode, NSDictionary *json) {
        NSLog(@"Here comes the json %@",json);
        if (statusCode==200) {
            
            [arraySteelGrades removeAllObjects];
            NSArray *array = [json valueForKey:@"data"];
            for (int i=0; i < array.count; i++) {
                [arraySteelGrades addObject:[array objectAtIndex:i]];
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

-(void)getTaxTypes:(void(^)(NSDictionary *json, NSError *error))completionBlock
{
    [RequestManager asynchronousRequestWithPath:@"tax/types" requestType:RequestTypeGET params:nil timeOut:60 includeHeaders:NO onCompletion:^(long statusCode, NSDictionary *json) {
        NSLog(@"Here comes the json %@",json);
        if (statusCode==200) {
            
            [arrayTaxTypes removeAllObjects];
            NSArray *array = [json valueForKey:@"data"];
            for (int i=0; i < array.count; i++) {
                [arrayTaxTypes addObject:[array objectAtIndex:i]];
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


-(void)resetData
{
    [arrayPostedRequirements removeAllObjects];
}

@end
