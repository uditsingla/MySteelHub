//
//  RequirementI.h
//  MySteelHub
//
//  Created by Amit Yadav on 10/07/16.
//  Copyright © 2016 MySteelHub. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequirementI : NSObject

@property(strong,nonatomic) NSString *requirementID;
@property(strong,nonatomic) NSString *userID;
@property(assign,nonatomic) BOOL isPhysical;
@property(assign,nonatomic) BOOL isChemical;
@property(assign,nonatomic) BOOL isTestCertificateRequired;
@property(strong,nonatomic) NSString *length;
@property(strong,nonatomic) NSString *type;
@property(strong,nonatomic) NSString *budget;
@property(strong,nonatomic) NSString *city;
@property(strong,nonatomic) NSString *state;
@property(strong,nonatomic) NSString *requiredByDate;
@property(strong,nonatomic) NSDate *createdDate;
@property(strong,nonatomic) NSDate *modifiedDate;
@property(strong,nonatomic) NSString *taxType;


@property(strong,nonatomic) NSMutableArray *arraySpecifications;
@property(strong,nonatomic) NSString *gradeRequired;
@property(strong,nonatomic) NSMutableArray *arrayPreferedBrands;

@property(strong,nonatomic) NSMutableArray *arrayConversations;


-(void)postBargainForSeller:(NSString*)sellerID withCompletion:(void(^)(NSDictionary *json, NSError *error))completionBlock;

-(void)acceptRejectDeal:(NSString*)sellerID status:(BOOL)action withCompletion:(void(^)(NSDictionary *json, NSError *error))completionBlock;

-(void)updateBuyerReadStatus:(NSString*)sellerID withCompletion:(void(^)(NSDictionary *json, NSError *error))completionBlock;

-(void)updateBuyerReadBargainStatus:(NSString*)sellerID withCompletion:(void(^)(NSDictionary *json, NSError *error))completionBlock;

-(void)buyerDeletedPost:(NSString*)sellerID withCompletion:(void(^)(NSDictionary *json, NSError *error))completionBlock;

@end
