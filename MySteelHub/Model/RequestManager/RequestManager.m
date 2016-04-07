//
//  RequestManager.m
//  Voice
//
//  Created by Kabir Chandoke on 7/8/14.
//  Copyright (c) 2014 Kabir Chandoke. All rights reserved.
//

#import "RequestManager.h"
#import "AppDelegate.h"

@implementation RequestManager
{
    //Reachability *_internetReachable;
}
@synthesize requestType;
@synthesize isInternetReachable;

#pragma mark - Send asynchronous request
+(void)asynchronousRequestWithPath:(NSString *)strPath
                       requestType:(RequestType)type
                            params:(NSDictionary *)dictParams
                           timeOut:(NSInteger)timeOut
                    includeHeaders:(BOOL)include
                      onCompletion:(JSONResponseBlock)completionBlock
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *baseURL = [NSURL URLWithString:@"" relativeToURL:kBaseUrl];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:baseURL];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    [urlRequest setValue:@"true" forHTTPHeaderField:@"Auth"];
    
    switch (type)
    {
        case 0:
            [urlRequest setHTTPMethod:@"POST"];
            break;
        case 1:
            [urlRequest setHTTPMethod:@"GET"];
            break;
        case 2:
            [urlRequest setHTTPMethod:@"DELETE"];
            break;
        case 3:
            [urlRequest setHTTPMethod:@"PUT"];
            break;
    }
    
    NSURLSessionDataTask * session = [sessionManager dataTaskWithRequest:urlRequest completionHandler:^(NSURLResponse *response, id responseObject, NSError *error)
    {
        if (error)
        {
            NSLog(@"Error: %@", error);
        }
        else
        {
            completionBlock(200,responseObject);
            NSLog(@"%@ %@", response, responseObject);
        }
    }];
    
    [session resume];
}
/*
#pragma mark - Send synchronous request

-(void)synchronousRequestWithPath:(NSString *)strPath
                requestType:(RequestType)type
                     params:(NSDictionary *)dictParams
                    timeOut:(NSInteger)timeOut
             includeHeaders:(BOOL)include
               onCompletion:(JSONResponseBlock)completionBlock
{
    if([appdelegate checkInternetConnectivity])
    {
        NSMutableURLRequest *urlRequest = [self requestWithPath:strPath requestType:type timeOut:timeOut includeHeader:include paramsDict:dictParams];
        [urlRequest setTimeoutInterval:timeOut];
        NSError *error = nil;
        
        NSHTTPURLResponse *response = nil;
        NSData *responseData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
        
        if (!error)
        {
            
            NSNumber *statusCode = [NSNumber numberWithLong:response.statusCode];
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
            
            if([[dict valueForKey:@"ErrorCode"] intValue]==701)
            {
                [appdelegate.objLoader hide];
                [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error" message:@"Your login session got expired, please login again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                alert=nil;
                
                //[appdelegate logout];
                return ;
            }
            
            completionBlock(statusCode.intValue,dict);
        }
        else
        {
            NSNumber *statusCode = [NSNumber numberWithLong:response.statusCode];
             completionBlock(statusCode.intValue,nil);
        }
    }
    
}
#pragma mark - Return URL Request
// Returns an instance of NSMutableURLRequest with specified parameters.
-(NSMutableURLRequest *) requestWithPath:(NSString *)strPath
                             requestType:(RequestType)type
                                 timeOut:(NSInteger)time
                           includeHeader:(BOOL)includeHeaders
                              paramsDict:(NSDictionary *)parameterDictionary
{
    requestType=type;
    
    NSString *strUrl = [NSString stringWithFormat:@"%@%@",kServerDomain,strPath];
    NSURL *requestUrl = [NSURL URLWithString:strUrl];
    NSMutableURLRequest *urlRequest;
    
    if (requestType == RequestTypeGet)
    {
        urlRequest = [[NSMutableURLRequest alloc] initWithURL:requestUrl cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:time];
        [urlRequest setHTTPMethod:@"GET"];
    }
    else if (requestType == RequestTypePost)
    {
        urlRequest = [[NSMutableURLRequest alloc] initWithURL:requestUrl cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:time];
        [urlRequest setHTTPMethod:@"POST"];
    }
    else if(requestType == RequestTypePut)
    {
        urlRequest = [[NSMutableURLRequest alloc] initWithURL:requestUrl cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:time];
        [urlRequest setHTTPMethod:@"PUT"];
    }
    else if(requestType == RequestTypeDelete)
    {
        urlRequest = [[NSMutableURLRequest alloc] initWithURL:requestUrl cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:time];
        [urlRequest setHTTPMethod:@"DELETE"];
    }
    
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    //include headers if required
    if(includeHeaders)
    {
        // values
//        NSString *token=[[NSUserDefaults standardUserDefaults] valueForKey:@"x_auth_token"];
//        [urlRequest setValue:token  forHTTPHeaderField:@"x-auth-token"];
    }
    
    // Attach HTTP body if required
    if (parameterDictionary)
    {
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameterDictionary
                                                           options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                             error:&error];
        [urlRequest setHTTPBody:jsonData];
        
    }

    return urlRequest;
}
 */
@end
