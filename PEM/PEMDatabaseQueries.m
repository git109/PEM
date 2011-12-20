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

// 1 attribute fetch query
- (NSArray *)fetchSelectedFromDatabase: (NSString *)entityName:
(NSString *)dbAttribute:
(NSString *)value {
    
    NSString *predicateBegining = @"(";
    NSString *predicateEnd = @" = %@)";
    NSString *predicateFormat = [NSString stringWithFormat:@"%@ %@ %@", predicateBegining, dbAttribute, predicateEnd];
    
    PEMAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSEntityDescription *entityDesc = 
    [NSEntityDescription entityForName:entityName 
                inManagedObjectContext:context];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entityDesc];
    
    NSPredicate *predicate = 
    [NSPredicate predicateWithFormat:predicateFormat, value];
    [fetchRequest setPredicate:predicate];
    
    NSError *error;
    NSArray *results = [context executeFetchRequest:fetchRequest error:&error];
    
    return results;

}


- (void) insertProfileDataToDatabase:
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
    [newProfile setValue:firstName forKey:@"firstName"];
    [newProfile setValue:lastName forKey:@"lastName"];
    [newProfile setValue:email forKey:@"email"];
    [newProfile setValue:password forKey:@"password"];
    
    
    NSError *error;
    [context save:&error];

}

@end
