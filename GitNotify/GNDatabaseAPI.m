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
 * @uid - user's id
 */
-(void)createUser:(NSString *)username andId:(NSString *)uid {
    NSString *url = CREATE_USER_URL;
    NSString *data = [NSString stringWithFormat:CREATE_USER_FORMAT, username, uid];
    
    [self.net postRequest:url withData:data];
}

/* Method createRepo
 * ------------------------
 * Does a post request to the database
 * backend to create a repo
 *
 * @reponame - user's name to create
 * @repoid - repo's id
 */
-(void)createRepo:(NSString *)reponame andId:(NSString *)repoid {
    NSString *url = CREATE_REPO_URL;
    NSString *data = [NSString stringWithFormat:CREATE_REPO_FORMAT, reponame, repoid];
    
    [self.net postRequest:url withData:data];
}

/* Method createRepos
 * ------------------------
 * Creates multiple repositories
 * as stored in a dictionary
 * in one single api call.
 *
 * @repos - nsdictionary representing 
 *          repositories
 */
-(void)createRepos:(NSDictionary *)repos {
    
    //Convert dictionary to jsons string
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    NSString *jsonData = [writer stringWithObject:repos];
    
    //Create url and data
    NSString *url = CREATE_REPOS_URL;
    NSString *data = [NSString stringWithFormat:CREATE_REPOS_FORMAT, jsonData];
    
    //Create request
    [self.net postRequest:url withData:data];
}

/* Method createRelations
 * -------------------------------
 * Ties user with repositories
 */
-(void)createRelations:(NSString *)uid withRepos:(NSDictionary *)repos {
   
    //Convert repos dictionary to string
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    NSString *repoJson = [writer stringWithObject:repos];
    
    //Create url and data
    NSString *url = CREATE_RELATIONS_URL;
    NSString *data = [NSString stringWithFormat:CREATE_RELATIONS_FORMAT, uid, repoJson];
        
    //Make request
    [self.net postRequest:url withData:data];
}

/* Method getCommits
 * --------------------------
 * Gets commids of a given repo
 *
 * @repoId - repository from which
 *           to pull commits
 *
 * @return - NSDictionary representing commits
 */
-(NSDictionary *)getCommits:(NSString *)repoId {
    
    //Create url
    NSString *url = GET_COMMITS_URL;
    NSString *data = [NSString stringWithFormat:GET_COMMITS_FORMAT, repoId];
    
    //Execute data
    NSString *commits = [self.net postRequest:url withData:data];
    
    //Parse string data
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *object = [parser objectWithString:commits];
    
    return object;
}

/* Method getUnseenRepos
 * -----------------------
 * Returns unseen repositories
 * of user with given user id
 *
 * @uid - user's id
 @ @return - dictionary representing
 *           all repos not seen
 */
-(NSDictionary *)getUnseenRepos:(NSString *)uid {
    //Create url
    NSString *url = GET_UNSEENREPOS_URL;
    NSString *data = [NSString stringWithFormat:GET_UNSEENREPOS_FORMAT, uid];
    
    //Execute data
    NSString *repos = [self.net postRequest:url withData:data];
    
    //Parse string data
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *object = [parser objectWithString:repos];
    
    return object;
}

/* Method setSeenREpo
 * -----------------------
 * Sets repository to seen
 *
 * @uid - user id 
 * @repoid - repoid
 */
-(void)setSeenRepo:(NSString *)uid and:(NSString *)repoID {
    //Create url
    NSString *url = SET_UNSEENREPOS_URL;
    NSString *data = [NSString stringWithFormat:SET_UNSEENREPOS_FORMAT, uid, repoID];
    
    //Execute data
   [self.net postRequest:url withData:data];
}

@end
