//
//  RequirementManager.m
//  MySteelHub
//
//  Created by Amit Yadav on 10/07/16.
//  Copyright © 2016 MySteelHub. All rights reserved.
//

#import "RequirementManager.h"

@implementation RequirementManager

@synthesize arrayPostedRequirements;

- (id)init
{
    self = [super init];
    if (self) {
        arrayPostedRequirements = [NSMutableArray new];
    }
    return self;
}

-(void)postRequirement:(RequirementI *)requirement completion:(void(^)(NSDictionary *json, NSError *error))completionBlock
{
    //create dictParam with requirement object
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] initWithObjectsAndKeys:requirement.userID,@"user_id",  requirement.arraySpecifications,@"specification",requirement.gradeRequired,@"grade_required",[NSNumber numberWithBool:requirement.isPhysical],@"physical",[NSNumber numberWithBool: requirement.isChemical],@"chemical",[NSNumber numberWithBool:requirement.isTestCertificateRequired],@"test_certificate_required",requirement.length,@"length",requirement.type,@"type",requirement.arrayPreferedBrands,@"preffered_brands",@"",@"required_by_date",requirement.budget,@"budget",requirement.city,@"city",requirement.state,@"state",nil];

    
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
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"24",@"user_id",nil];
    
    
    [RequestManager asynchronousRequestWithPath:@"posted/requirements" requestType:RequestTypePOST params:dictParams timeOut:60 includeHeaders:NO onCompletion:^(long statusCode, NSDictionary *json) {
        NSLog(@"Here comes the json %@",json);
        if (statusCode==200) {
            completionBlock(json,nil);
            
            [arrayPostedRequirements removeAllObjects];
            NSArray *array = [json valueForKey:@"data"];
            for (int i=0; i < array.count; i++) {
                RequirementI *requirement = [RequirementI new];
                requirement.userID = [NSString stringWithFormat:@"%i", [[[array objectAtIndex:i] valueForKey:@"user_id"] intValue]];
                
            }
            
        }
        else{
            completionBlock(nil,nil);
            //show error
        }
        
    } ];
    
}

@end
