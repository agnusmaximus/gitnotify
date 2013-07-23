//
//  GNGithubApi.m
//  GitNotify
//
//  Created by Max Lam on 7/22/13.
//  Copyright (c) 2013 Max Lam. All rights reserved.
//

#import "GNGithubApi.h"

@implementation GNGithubApi

/* Method sharedGitAPI
 * --------------------------
 * Returns a singleton representing
 * the github api object
 */
+(GNGithubApi *)sharedGitAPI {
    static GNGithubApi *api;
    
    @synchronized(self) {
        if (!api) {
            api = [[GNGithubApi alloc]init];
        }
        return api;
    }
}

/* Method init
 * ---------------------------
 * initialization method
 */
-(id)init {
    self = [super init];
    
    //create the network object for making
    //get and post requests
    net = [[GNNetworkCalls alloc] init];
    
    return self;
}

/* Method getUserRepos
 * ----------------------------
 * Uses github api to retrieve
 * a mutable array of user's repositories
 *
 * @username - username of github member
 * @return - array of user's repos
 */
-(NSDictionary *)getUserRepos:(NSString *)username {
    
    //Create the url
    NSString *head = BASE_URL;
    NSString *partialUrl = [NSString stringWithFormat:LIST_REPO_FORMAT, username];
    NSString *url = [head stringByAppendingString:partialUrl];
    
    if (DEBUG_TEST) {
        NSLog(@"GNGithubApi.getUserRepos: %@", url);
    }
    
    //array holding 
    NSMutableArray *repositories = [NSMutableArray array];
    
    //MAke network request
    NSString *data = [net getRequest:url];
   
    //Parse json string
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *json = [parser objectWithString:data];
    
    if (DEBUG_TEST) {
        NSLog(@"GNGithubAPI.getUserRepos: %@", json);
    }
    
    return json;
}

@end
