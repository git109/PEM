//
//  PEMDatabaseQueries.h
//  PEM
//
//  Created by Vladimir Hartmann on 15/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PEMAppDelegate.h"

@interface PEMDatabaseQueries : NSObject {

    
}

- (NSArray *)fetchSelectedFromDatabase:
(NSString *)entityName:
(NSString *)query:
(NSString *)value;



@end

