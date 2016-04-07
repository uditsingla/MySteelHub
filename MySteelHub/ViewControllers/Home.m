//
//  Home.m
//  Sourcefuse
//
//  Created by Abhishek Singla on 10/03/16.
//  Copyright © 2016 Sourcefuse. All rights reserved.
//

#import "Home.h"
//#import <GoogleMaps/GoogleMaps.h>

@interface Home ()
{
    //CLLocationManager *locationManager;
}
@end

@implementation Home

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /*
    [self getUserLocation];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.868
                                                            longitude:151.2086
                                                                 zoom:6];
    //mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = camera.target;
    marker.snippet = @"Hello World";
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.map = mapView;
    self.view = mapView;
     */
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//#pragma mark - Custom Methods
//-(void)getUserLocation
//{
//    locationManager = [[CLLocationManager alloc] init];
//    locationManager.delegate = self;
//    locationManager.distanceFilter = kCLDistanceFilterNone;
//    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//    
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 &&
//        [CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse
//        //[CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedAlways
//        ) {
//        // Will open an confirm dialog to get user's approval
//        [locationManager requestWhenInUseAuthorization];
//        //[_locationManager requestAlwaysAuthorization];
//    } else {
//        [locationManager startUpdatingLocation]; //Will update location immediately
//    }
//}
-(IBAction)btnClicked:(id)sender
{
    [RequestManager asynchronousRequestWithPath:@"" requestType:RequestTypePOST params:nil timeOut:60 includeHeaders:NO onCompletion:^(long statusCode, NSDictionary *json) {
    NSLog(@"Here comes the json %@",json);
    }];
}
//#pragma mark - Core Location Delegate
//- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
//{
//    NSLog(@"didFailWithError: %@", error);
//    UIAlertView *errorAlert = [[UIAlertView alloc]
//                               initWithTitle:@"Error" message:@"Failed to get your location." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [errorAlert show];
//}
//
//- (void)locationManager:(CLLocationManager *)manager
//     didUpdateLocations:(NSArray<CLLocation *> *)locations
//{
//    CLLocation* location = [locations lastObject];
//    NSDate* eventDate = location.timestamp;
//    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
//    if (fabs(howRecent) < 15.0) {
//        // If the event is recent, do something with it.
//        NSLog(@"latitude %+.6f, longitude %+.6f\n",
//              location.coordinate.latitude,
//              location.coordinate.longitude);
//    }
//    // After fetching the user location stop updating the location.
//    [locationManager stopUpdatingLocation];
//}
//- (void)locationManager:(CLLocationManager*)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
//{
//    switch (status) {
//        case kCLAuthorizationStatusNotDetermined: {
//            NSLog(@"User still thinking..");
//        } break;
//        case kCLAuthorizationStatusDenied: {
//            NSLog(@"User hates you");
//        } break;
//        case kCLAuthorizationStatusAuthorizedWhenInUse:
//        case kCLAuthorizationStatusAuthorizedAlways: {
//            [locationManager startUpdatingLocation]; //Will update location immediately
//        } break;
//        default:
//            break;
//    }
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
