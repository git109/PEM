//
//  PEMDatabaseQueries.m
//  PEM
//
//  Created by Vladimir Hartmann on 15/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PEMDatabaseQueries.h"
#import "PEMAppDelegate.h"

@implementation PEMDatabaseQueries 

// fetch query
- (NSArray *)fetchSelectedFromDatabase: (NSString *)entityName:
(NSString *)query:
(NSString *)value {
    
    PEMAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSEntityDescription *entityDesc = 
    [NSEntityDescription entityForName:entityName 
                inManagedObjectContext:context];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entityDesc];
    
    NSPredicate *predicate = 
    [NSPredicate predicateWithFormat:query, value];
    [fetchRequest setPredicate:predicate];
    
    NSError *error;
    NSArray *results = [context executeFetchRequest:fetchRequest error:&error];
    
    return results;

}

// insert query
- (void) insertProfileDataToDatabase:
(NSManagedObjectID *)ID:
(NSString *)firstName:
(NSString *)lastName:
(NSString *)email:
(NSString *)password {
    
    PEMAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = 
    [appDelegate managedObjectContext];
    
    NSManagedObject *newProfile;
    newProfile = [NSEntityDescription
                  insertNewObjectForEntityForName:@"Profiles"
                  inManagedObjectContext:context];
    static int tempID = 0;
    [newProfile setValue:[NSNumber numberWithInt:++tempID] forKey:@"id"];
    [newProfile setValue:firstName forKey:@"firstName"];
    [newProfile setValue:lastName forKey:@"lastName"];
    [newProfile setValue:email forKey:@"email"];
    [newProfile setValue:password forKey:@"password"];
    
    
    NSError *error;
    [context save:&error];

}

@end
