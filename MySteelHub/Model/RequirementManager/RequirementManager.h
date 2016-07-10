//
//  RequirementManager.h
//  MySteelHub
//
//  Created by Amit Yadav on 10/07/16.
//  Copyright © 2016 MySteelHub. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequirementI.h"

@interface RequirementManager : NSObject

-(void)postRequirement:(RequirementI *)requirement completion:(void(^)(NSDictionary *json, NSError *error))completionBlock;

@end
