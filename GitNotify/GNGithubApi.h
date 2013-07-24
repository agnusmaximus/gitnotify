//
//  GNGithubApi.h
//  GitNotify
//
//  Created by Max Lam on 7/22/13.
//  Copyright (c) 2013 Max Lam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GNNetworkCalls.h"
#import "GNAPIConstants.h"
#import "SBJson.h"

@interface GNGithubApi : NSObject {
    GNNetworkCalls *net;
}

+(GNGithubApi *)sharedGitAPI;

-(NSDictionary *)getUserRepos:(NSString *)username;
-(NSDictionary *)getWatchedRepos:(NSString *)username;
-(NSDictionary *)getUser:(NSString *)username;

@end
