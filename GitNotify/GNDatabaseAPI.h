//
//  GNDatabaseAPI.h
//  GitNotify
//
//  Created by Max Lam on 7/23/13.
//  Copyright (c) 2013 Max Lam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GNNetworkCalls.h"
#import "GNDatabaseConstants.h"
#import "SBJson.h"

@interface GNDatabaseAPI : NSObject

@property (nonatomic, strong) GNNetworkCalls *net;

+(GNDatabaseAPI *)sharedAPI;
-(void)createUser:(NSString *)username andId:(NSString *)uid;
-(void)createRepo:(NSString *)reponame andId:(NSString *)repoid;
-(void)createRepos:(NSDictionary *)repos;
-(void)createRelations:(NSString *)uid withRepos:(NSDictionary *)repos;
-(NSDictionary *)getCommits:(NSString *)repoId;
-(NSDictionary *)getRepos:(NSString *)uid;
-(NSDictionary *)getUnseenRepos:(NSString *)uid;
-(void)setSeenRepo:(NSString *)uid and:(NSString *)repoID;
-(void)setHooked:(NSString *)reponame;

@end
