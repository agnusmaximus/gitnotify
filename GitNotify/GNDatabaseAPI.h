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

@interface GNDatabaseAPI : NSObject

@property (nonatomic, strong) GNNetworkCalls *net;

+(GNDatabaseAPI *)sharedAPI;
-(void)createUser:(NSString *)username andId:(NSString *)uid;

@end
