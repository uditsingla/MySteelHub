//
//  AppDelegate.h
//  MySteelHub
//
//  Created by Abhishek Singla on 09/03/16.
//  Copyright © 2016 MySteelHub. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@property(nonatomic,strong) MFSideMenuContainerViewController *container;
@property(nonatomic,strong) LabeledActivityIndicatorView *objLoader;

@end
