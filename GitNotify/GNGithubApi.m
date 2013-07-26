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

/* Method login
 * -------------------------
 * Logs in
 */
-(BOOL)login:(NSString *)username andPass:(NSString *)password {
    engine = [[UAGithubEngine alloc] initWithUsername:username
                                             password:password
                                     withReachability:YES];
    self.uname = username;
    return [engine isReachable];
}

/* Method getUserRepos
 * -------------------------------
 * Returns users' repositories
 */
-(void)getUserReposWithDelegate:(id)delegate andSelector:(SEL)sel {
    [self getUserRepos:self.uname withDelegate:delegate andSelector:sel];
}

/* Method getUserRepos
 * ----------------------------
 * Uses github api to retrieve
 * a mutable array of user's repositories
 *
 * @username - username of github member
 * @delegate - responder to repository data
 * @sel - selector of responder to call
 */
-(void)getUserRepos:(NSString *)username withDelegate:(id)delegate andSelector:(SEL)sel {
    //Request watched repos
    [engine repositoriesForUser:username includeWatched:YES success:^(NSDictionary *repos) {
        //Perform selector on repositories
        if ([delegate respondsToSelector:sel]) {
            #pragma clang diagnostic push
            #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [delegate performSelector:sel withObject:repos];
            #pragma clang pop
        }
        
    } failure:^(NSError *error) {
        //Print error
        if (DEBUG_TEST) NSLog(@"Error: %@", [error description]);
    }];
}


/* Method getUser
 * --------------------------
 * Gets user by user name
 * 
 * @username - user to get
 * @return - NSDictionary representing user
 */
-(void)getUserWithDelegate:(id)delegate andSelector:(SEL)sel {
    [engine userWithSuccess:^(NSArray *user) {
        
        self.uid = [[[user objectAtIndex:0] objectForKey:@"id"] intValue];
        
        //Call callback method
        if ([delegate respondsToSelector:sel]) {
            #pragma clang diagnostic push
            #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [delegate performSelector:sel withObject:user];
            #pragma clang pop
        }

        
    } failure:^(NSError *err) {
        //Print error
        if (DEBUG_TEST) NSLog(@"Error: %@", [err description]);        
    }];
}

/* Method createHook
 * ------------------------
 * Creates a hook so that whenever
 * the repository is pushed, a notification
 * will update the server backend
 *
 * @owner - owner of the repository
 * @repo - repository name
 */
-(void)createHook:(NSString *)owner andRepo:(NSString *)repo {
    
    //Create json data
    NSDictionary *JSON =
    [NSJSONSerialization JSONObjectWithData:[CREATE_HOOK_DATA dataUsingEncoding:NSUTF8StringEncoding]
                                    options: NSJSONReadingMutableContainers
                                      error: nil];
    
    [engine addHook: JSON
      forRepository: [owner stringByAppendingFormat:@"/%@", repo]
            success: ^(NSArray *obj) {
                
                //Add repo to hooked
                [[GNDatabaseAPI sharedAPI] setHooked:repo];
                
            } failure: ^(NSError *err) {                
                //Print error
                if (DEBUG_TEST) NSLog(@"Error: %@", [err description]);
                
                //Repo already hooked
                if ([err code] == 422) {
                    //Add repo to hooked
                    [[GNDatabaseAPI sharedAPI] setHooked:repo];
                }
            }];
}

@end
