//
//  RequirementI.m
//  MySteelHub
//
//  Created by Amit Yadav on 10/07/16.
//  Copyright © 2016 MySteelHub. All rights reserved.
//

#import "RequirementI.h"

@implementation RequirementI

@synthesize userID,isChemical,isPhysical,isTestCertificateRequired,length,type,budget,city,state,requiredByDate,arrayGradesRequired,arrayPreferedBrands,arraySpecifications;

- (id)init
{
    self = [super init];
    if (self) {
        userID=@"";
        length=@"";
        type=@"";
        budget=@"";
        city=@"";
        state=@"";
        arraySpecifications = [NSMutableArray new];
        arrayPreferedBrands = [NSMutableArray new];
        arrayGradesRequired = [NSMutableArray new];

    }
    return self;
}

@end
