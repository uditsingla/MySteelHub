//
//  ProfileManager.h
//  MySteelHub
//
//  Created by Amit Yadav on 15/08/16.
//  Copyright © 2016 MySteelHub. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserI.h"
#import "Address.h"

@interface ProfileManager : NSObject

@property(strong,nonatomic) UserI *owner;
@property(strong,nonatomic) NSMutableArray *arraySavedAddress;


-(void)addNewAddress:(Address *)address completion:(void(^)(NSDictionary *json, NSError *error))completionBlock;

-(void)editAddress:(Address *)address completion:(void(^)(NSDictionary *json, NSError *error))completionBlock;


@end
