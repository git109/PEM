//
//  PEMAppDelegate.h
//  PEM
//
//  Created by Vladimir Hartmann on 12/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PEMDataCenter.h"

@interface PEMAppDelegate : UIResponder <UIApplicationDelegate> {
    
    PEMDataCenter *dataCenter;
    NSManagedObject *user;
}

@property (strong, nonatomic) PEMDataCenter *dataCenter;
@property (strong, nonatomic) NSManagedObject *user;

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end
