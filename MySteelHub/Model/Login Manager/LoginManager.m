//
//  TaskManager.m
//  Eventuosity
//
//  Created by Leo Macbook on 13/02/14.
//  Copyright (c) 2014 Eventuosity. All rights reserved.
//

#import "LoginManager.h"
//#import "ProfileManager.h"
#import "AppDelegate.h"
//#import <GooglePlus/GooglePlus.h>


@implementation LoginManager


- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark Service Calls




- (void)userLogin:(NSDictionary *)dictParam completion:(void(^)(NSArray *addresses, NSError *error))completionBlock
{
    [RequestManager asynchronousRequestWithPath:@"auth/securelogin" requestType:RequestTypePOST params:dictParam timeOut:60 includeHeaders:NO onCompletion:^(long statusCode, NSDictionary *json) {
               if (statusCode==200) {
            NSLog(@"Here comes the json %@",json);
            NSMutableArray *arr=(NSMutableArray*)[json objectForKey:@"msg"];
            completionBlock(arr,nil);
        }
        else{
            NSMutableArray *arr=(NSMutableArray*)[json objectForKey:@"msg"];
            NSError *error=[json objectForKey:@"error"];
            completionBlock(arr,error);
        }
       
    } ];
}


    /*
    [rm asynchronousRequestWithPath:(NSString *) requestType:<#(RequestType)#> params:<#(NSDictionary *)#> timeOut:<#(NSInteger)#> includeHeaders:(BOOL) onCompletion:^(long statusCode, NSDictionary *json)
     {
         
         if(statusCode == 200)
         {
             //sucess
             //preapre dictionary
             completionBlock();
         }
         else
         {
             
         }
         
    }];
    
    // Afnetworking call which u will get from its example
    NSError *error;
    
    if(!error)
    {
        // Create array of addresses model
        
        //completionBlock(addresses,nil);
        
    }
    else {
        //completionBlock(nil,error);
    }
     */


-(void)validateUsername:(NSString*)username
{
    [RequestManager asynchronousRequestWithPath:@"auth/register" requestType:RequestTypePOST params:nil timeOut:60 includeHeaders:NO onCompletion:^(long statusCode, NSDictionary *json) {
        NSLog(@"Here comes the json %@",json);
        NSMutableArray *arr=(NSMutableArray*)[json objectForKey:@"data"];
     //   completionBlock(arr,nil);
    } ];
}

- (void)userSignUp:(NSDictionary *)dictParam completion:(void(^)(NSArray *addresses, NSError *error))completionBlock
{
    [RequestManager asynchronousRequestWithPath:@"auth/register" requestType:RequestTypePOST params:dictParam timeOut:60 includeHeaders:NO onCompletion:^(long statusCode, NSDictionary *json) {
        NSLog(@"Here comes the json %@",json);
        if (statusCode==200) {
            NSMutableArray *arr=(NSMutableArray*)[json objectForKey:@"msg"];
            completionBlock(arr,nil);

        }
        else{
            completionBlock(nil,nil);
            //show error
        }
        
    } ];

    
}

-(void)recoverPassword:(NSDictionary *)dictParam completion:(void(^)(NSDictionary *json, NSError *error))completionBlock
{
    [RequestManager asynchronousRequestWithPath:@"recoverpassword" requestType:RequestTypePOST params:dictParam timeOut:60 includeHeaders:NO onCompletion:^(long statusCode, NSDictionary *json) {
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

-(void)changePassword:(NSDictionary *)dictParam completion:(void(^)(NSDictionary *json, NSError *error))completionBlock
{
    [RequestManager asynchronousRequestWithPath:@"auth/changepassword" requestType:RequestTypePOST params:dictParam timeOut:60 includeHeaders:NO onCompletion:^(long statusCode, NSDictionary *json) {
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


-(void)logoutWithCompletion:(void(^)(NSDictionary *json, NSError *error))completionBlock
{
    NSDictionary *dictParams = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"ios",@"device_type",  [[NSUserDefaults standardUserDefaults] stringForKey:@"DeviceToken"],@"device_token",nil];

    
    [RequestManager asynchronousRequestWithPath:@"auth/logout" requestType:RequestTypeDELETE params:dictParams timeOut:60 includeHeaders:NO onCompletion:^(long statusCode, NSDictionary *json) {
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


/*
-(void)userSignUp:(NSDictionary *)dictParam
{
    [model_manager.requestManager asynchronousRequestWithPath:@"user/register" requestType:RequestTypePost params:dictParam timeOut:kTimeout includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json)
     
     {
         
         if(statusCode == 200)
             
         {
             
             int status =[[json valueForKey:@"ErrorCode"] intValue];
             
             if(status==0)
        
             {
                 [[NSUserDefaults standardUserDefaults] setObject:[json valueForKey:@"UserID"] forKey:@"UserID"];
                 //----Set Profile Manager----
                 
                 model_manager.profilemanager.full_name = [[json valueForKey:@"UserData"]valueForKey:@"DisplayName"];
                 model_manager.profilemanager.email = [[json valueForKey:@"UserData"]valueForKey:@"Email"];
                 model_manager.profilemanager.mobile_no = [[json valueForKey:@"UserData"]valueForKey:@"MobileNo"];
                 model_manager.profilemanager.profile_pic = [[json valueForKey:@"UserData"]valueForKey:@"UserImg"];
                 
                 //---------------------------
                 
                 // fire the notification
                 
                 [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserRegistered object:@"success"];
                 
             }
             
             else
                 
             {
                 NSString *message = [json objectForKey:@"ErrorMessage"];
                 [appdelegate showAlert:message];
                 
                 //fire the notification
                 
                 [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserRegistered object:@"failure"];
                 
             }
             
         }
         
         else if(statusCode==400)
             
         {
             NSString *message = [json objectForKey:@"ErrorMessage"];
             [appdelegate showAlert:message];
             
             //fire the notification
             
             [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserRegistered object:@"failure"];;
             
         }
         
         else if(statusCode==401)
             
         {
             NSString *message = [json objectForKey:@"ErrorMessage"];
             [appdelegate showAlert:message];
             
             //fire the notification
             
             [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserRegistered object:@"failure"];;
             
         }
         
         else if(statusCode==500)
             
         {
             NSString *message = [json objectForKey:@"ErrorMessage"];
             [appdelegate showAlert:message];
             
             //fire the notification
             
             [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserRegistered object:@"failure"];;
             
         }
         
         else
             
         {
             NSString *message = [json objectForKey:@"ErrorMessage"];
             [appdelegate showAlert:message];
             
             //fire the notification
             
             [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserRegistered object:@"failure"];;
             
         }
         
         
         
     }];
    

}

-(void)authorizeUser:(NSDictionary *)dictParam
{
    [model_manager.requestManager asynchronousRequestWithPath:@"user/login" requestType:RequestTypePost params:dictParam timeOut:kTimeout includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json)
     {
         if(statusCode == 200)
             
         {             
             int status =[[json valueForKey:@"ErrorCode"] intValue];
             
             if(status==0)
                 
             {
                 model_manager.profilemanager.user_token = [json valueForKey:@"Token"];
                 
                 //sync database with server
                 [model_manager.bookingManager syncDatabaseWithServer];
                 
                 if(model_manager.profilemanager.svp_LocationInfo==nil)
                 {
                     CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
                     if (status!=kCLAuthorizationStatusRestricted && status != kCLAuthorizationStatusDenied &&
                         status!=kCLAuthorizationStatusNotDetermined)
                         [appdelegate.location_Manager startUpdatingLocation];
                 }
                 
                 // fire the notification
                 [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserLoggedIn object:@"success"];
                 
             }
             
             else
                 
             {
                 if(![[NSUserDefaults standardUserDefaults] objectForKey:@"FBUserData"] && ![[NSUserDefaults standardUserDefaults] objectForKey:@"GPlusUserData"])
                 {
                     NSString *message = [json objectForKey:@"ErrorMessage"];
                     [appdelegate showAlert:message];
                 }
                 
                 if([[json objectForKey:@"ErrorCode"] intValue]==1000)
                 {
                     [[NSUserDefaults standardUserDefaults] setObject:@"false" forKey:@"isAutoLogin"];
                 }
                 
                 //fire the notification
                 
                 [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserLoggedIn object:@"failure"];
                 
             }
             
         }
         
         else if(statusCode==400)
             
         {
             NSString *message = [json objectForKey:@"ErrorMessage"];
             [appdelegate showAlert:message];
             
             //fire the notification
             
             [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserLoggedIn object:@"failure"];;
             
         }
         
         else if(statusCode==401)
             
         {
             NSString *message = [json objectForKey:@"ErrorMessage"];
             [appdelegate showAlert:message];
             
             //fire the notification
             
             [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserLoggedIn object:@"failure"];;
             
         }
         
         else if(statusCode==500)
             
         {
             NSString *message = [json objectForKey:@"ErrorMessage"];
             [appdelegate showAlert:message];
             
             //fire the notification
             
             [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserLoggedIn object:@"failure"];
             
         }
         
         else
             
         {
             NSString *message = [json objectForKey:@"ErrorMessage"];
             [appdelegate showAlert:message];
             
             //fire the notification
             
             [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserLoggedIn object:@"failure"];
             
         }
         
         
         
     }];
    

}

-(void)verifyCode:(NSDictionary *)dictParam
{
    [model_manager.requestManager asynchronousRequestWithPath:@"user/ValidatePhone" requestType:RequestTypePost params:dictParam timeOut:kTimeout includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json)
     
     {
         
         if(statusCode == 200)
             
         {
             
             int status =[[json valueForKey:@"ErrorCode"] intValue];
             
             if(status==0)
                 
             {
                 
                 // fire the notification
                 
                 [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserVerification object:@"success"];
                 
             }
             
             else
                 
             {
                 NSString *message = [json objectForKey:@"ErrorMessage"];
                 [appdelegate showAlert:message];
                 
                 //fire the notification
                 
                 [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserVerification object:@"failure"];
                 
             }
             
         }
         
         else if(statusCode==400)
             
         {
             NSString *message = [json objectForKey:@"ErrorMessage"];
             [appdelegate showAlert:message];
             
             //fire the notification
             
             [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserVerification object:@"failure"];;
             
         }
         
         else if(statusCode==401)
             
         {
             NSString *message = [json objectForKey:@"ErrorMessage"];
             [appdelegate showAlert:message];
             
             //fire the notification
             
             [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserVerification object:@"failure"];;
             
         }
         
         else if(statusCode==500)
             
         {
             NSString *message = [json objectForKey:@"ErrorMessage"];
             [appdelegate showAlert:message];
             
             //fire the notification
             
             [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserVerification object:@"failure"];;
             
         }
         
         else
             
         {
             NSString *message = [json objectForKey:@"ErrorMessage"];
             [appdelegate showAlert:message];
             
             //fire the notification
             
             [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserVerification object:@"failure"];;
             
         }
         
         
         
     }];

}

-(void)resendVerificationCode:(NSDictionary *)dictParam
{
    [model_manager.requestManager asynchronousRequestWithPath:@"user/ResendOTP" requestType:RequestTypePost params:dictParam timeOut:kTimeout includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json)
     
     {
         
         if(statusCode == 200)
             
         {
             
             int status =[[json valueForKey:@"ErrorCode"] intValue];
             
             if(status==0)
                 
             {
                 
                 // fire the notification
                 
                 [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationResendVCode object:@"success"];
                 
             }
             
             else
                 
             {
                 NSString *message = [json objectForKey:@"ErrorMessage"];
                 [appdelegate showAlert:message];
                 
                 //fire the notification
                 
                 [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationResendVCode object:@"failure"];
                 
             }
             
         }
         
         else if(statusCode==400)
             
         {
             NSString *message = [json objectForKey:@"ErrorMessage"];
             [appdelegate showAlert:message];
             
             //fire the notification
             
             [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationResendVCode object:@"failure"];;
             
         }
         
         else if(statusCode==401)
             
         {
             NSString *message = [json objectForKey:@"ErrorMessage"];
             [appdelegate showAlert:message];
             
             //fire the notification
             
             [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationResendVCode object:@"failure"];;
             
         }
         
         else if(statusCode==500)
             
         {
             NSString *message = [json objectForKey:@"ErrorMessage"];
             [appdelegate showAlert:message];
             
             //fire the notification
             
             [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationResendVCode object:@"failure"];;
             
         }
         
         else
             
         {
             NSString *message = [json objectForKey:@"ErrorMessage"];
             [appdelegate showAlert:message];
             
             //fire the notification
             
             [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationResendVCode object:@"failure"];;
             
         }
         
         
         
     }];

}

-(void)logout
{
    
}
 */

@end