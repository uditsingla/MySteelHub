//
//  RequirementI.m
//  MySteelHub
//
//  Created by Amit Yadav on 10/07/16.
//  Copyright © 2016 MySteelHub. All rights reserved.
//

#import "RequirementI.h"

@implementation RequirementI

@synthesize requirementID,userID,isChemical,isPhysical,isTestCertificateRequired,length,type,budget,city,state,requiredByDate,gradeRequired,arrayPreferedBrands,arraySpecifications,createdDate,modifiedDate,arrayConversations,taxType,isUnreadFlag;

- (id)init
{
    self = [super init];
    if (self) {
        requirementID=@"";
        userID=@"";
        length=@"";
        type=@"";
        budget=@"";
        city=@"";
        state=@"";
        requiredByDate = @"";
        arraySpecifications = [NSMutableArray new];
        arrayPreferedBrands = [NSMutableArray new];
        gradeRequired = @"";
        arrayConversations = [NSMutableArray new];
        taxType = @"";
        isUnreadFlag = NO;
    }
    return self;
}

-(void)postBargainForSeller:(NSString*)sellerID withCompletion:(void(^)(NSDictionary *json, NSError *error))completionBlock
{
    //create dictParam
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] initWithObjectsAndKeys:self.requirementID,@"requirement_id" ,sellerID,@"seller_id", /*self.userID,@"buyer_id",*/ [NSNumber numberWithInt:1],@"req_for_bargain",@"buyerReqForBargain",@"type", nil];
    
    
    [RequestManager asynchronousRequestWithPath:@"updateConversationStatus" requestType:RequestTypePOST params:dictParams timeOut:60 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json) {
        NSLog(@"Here comes the json %@",json);
        if (statusCode==200) {
            
            
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

-(void)acceptRejectDeal:(NSString*)sellerID status:(BOOL)action withCompletion:(void(^)(NSDictionary *json, NSError *error))completionBlock
{
    //create dictParam
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] initWithObjectsAndKeys:self.requirementID,@"requirement_id" ,sellerID,@"seller_id", /*self.userID,@"buyer_id",*/[NSNumber numberWithBool:action],@"is_accepted", @"buyerAcceptedOrNot",@"type", nil];
    
    
    [RequestManager asynchronousRequestWithPath:@"updateConversationStatus" requestType:RequestTypePOST params:dictParams timeOut:60 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json) {
        NSLog(@"Here comes the json %@",json);
        if (statusCode==200) {
            
            
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

-(void)updateBuyerReadStatus:(NSString*)sellerID withCompletion:(void(^)(NSDictionary *json, NSError *error))completionBlock
{
    //create dictParam
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] initWithObjectsAndKeys:self.requirementID,@"requirement_id" ,sellerID,@"seller_id", /*self.userID,@"buyer_id",*/ @"buyerReadStatus",@"type", nil];
    
    
    [RequestManager asynchronousRequestWithPath:@"updateConversationStatus" requestType:RequestTypePOST params:dictParams timeOut:60 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json) {
        NSLog(@"Here comes the json %@",json);
        if (statusCode==200) {
            
            
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

-(void)updateBuyerReadBargainStatus:(NSString*)sellerID withCompletion:(void(^)(NSDictionary *json, NSError *error))completionBlock
{
    //create dictParam
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] initWithObjectsAndKeys:self.requirementID,@"requirement_id" ,sellerID,@"seller_id", /*self.userID,@"buyer_id",*/[NSNumber numberWithInt:1],@"is_buyer_read_bargain", @"buyerReadBargainStatus",@"type", nil];
    
    
    [RequestManager asynchronousRequestWithPath:@"updateConversationStatus" requestType:RequestTypePOST params:dictParams timeOut:60 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json) {
        NSLog(@"Here comes the json %@",json);
        if (statusCode==200) {
            
            
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

-(void)buyerDeletedPost:(NSString*)sellerID withCompletion:(void(^)(NSDictionary *json, NSError *error))completionBlock
{
    //create dictParam
    NSMutableDictionary *dictParams = [[NSMutableDictionary alloc] initWithObjectsAndKeys:self.requirementID,@"requirement_id" ,sellerID,@"seller_id", /*self.userID,@"buyer_id",*/[NSNumber numberWithInt:1],@"is_buyer_deleted", nil];
    
    
    [RequestManager asynchronousRequestWithPath:@"deletePost" requestType:RequestTypePOST params:dictParams timeOut:60 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json) {
        NSLog(@"Here comes the json %@",json);
        if (statusCode==200) {
            
            
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
