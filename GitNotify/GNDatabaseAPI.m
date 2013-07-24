//
//  GNDatabaseAPI.m
//  GitNotify
//
//  Created by Max Lam on 7/23/13.
//  Copyright (c) 2013 Max Lam. All rights reserved.
//

#import "GNDatabaseAPI.h"

@implementation GNDatabaseAPI

/* Method sharedAPI
 * -------------------------
 * Returns a shared api instance.
 */
+(GNDatabaseAPI *)sharedAPI {
    static GNDatabaseAPI *api;
    
    @synchronized(self) {
        if (!api) {
            api = [[GNDatabaseAPI alloc] init];
        }
        return api;
    }
}

/* Method init
 * -----------------------------
 * Responsible for initializing
 * data. Creates a network calls object.
 */
-(id)init {
    self = [super init];
    
    //Create network object 
    self.net = [[GNNetworkCalls alloc]init];
    
    return self;
}

/* Method createUser
 * ------------------------
 * Does a post request to the database
 * backend to create a user
 *
 * @username - user's name to create
 */
-(void)createUser:(NSString *)username andId:(NSString *)uid {
    NSString *url = CREATE_URL;
    NSString *data = [NSString stringWithFormat:CREATE_USER_FORMAT, username, uid];
    
    [self.net postRequest:url withData:data];
}

@end
