//
//  PEMDataCenter.h
//  PEM
//
//  Created by Vladimir Hartmann on 23/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//



@interface PEMDataCenter : NSObject {

    NSManagedObject *user;
}

@property(strong, nonatomic) NSManagedObject *user;

+(id)shareDataCenter;

@end
