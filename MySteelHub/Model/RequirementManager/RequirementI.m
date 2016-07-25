//
//  RequirementI.m
//  MySteelHub
//
//  Created by Amit Yadav on 10/07/16.
//  Copyright © 2016 MySteelHub. All rights reserved.
//

#import "RequirementI.h"

@implementation RequirementI

@synthesize requirementID,userID,isChemical,isPhysical,isTestCertificateRequired,length,type,budget,city,state,requiredByDate,gradeRequired,arrayPreferedBrands,arraySpecifications,createdDate,modifiedDate;

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
    }
    return self;
}

@end
