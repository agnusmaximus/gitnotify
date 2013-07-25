//
//  AppDelegate.m
//  GitNotify
//
//  Created by Max Lam on 7/22/13.
//  Copyright (c) 2013 Max Lam. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //Login

    
    //Set up UI
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //Set up navigation controller with repovc as root view controller
    repoVC = [[GNRepoVC alloc] initWithNibName:@"GNRepoVC" bundle:nil];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:repoVC];
    
    //Set navigation controller topbar to none
    navController.navigationBar.hidden = YES;
    navController.delegate = self;
    
    //Set window's root view controller to the navigation controller
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    
    //Update
    [self performSelectorInBackground:@selector(update) withObject:nil];
    
    return YES;
}

/* Method updateDatabase
 * ----------------------------
 * Updates the database
 */
-(void)update {
    //Update database
    [[GNGithubApi sharedGitAPI] getUserWithDelegate:self andSelector:@selector(updateDatabase:)];
}

/* Method updateDatabase
 * ----------------------------
 * Updates database with user info,
 * repo info, and relationships
 * between the two.
 */
-(void)updateDatabase:(NSArray *)userArray {
    
    //Extract user
    NSDictionary *user = [userArray objectAtIndex:0];
    
    //Set user information
    self.user = user;
    
    //Create a user on the database
    [[GNDatabaseAPI sharedAPI] createUser:[user objectForKey:@"login"]
                                    andId:[user objectForKey:@"id"]];
    
    
    //Get repository information from github
    [[GNGithubApi sharedGitAPI] getUserReposWithDelegate:self
                                 andSelector:@selector(createRepos:)];
}

/* Method createRepos
 * -----------------------------------
 * Creates repositories on the backend
 */
-(void)createRepos:(NSDictionary *)repos {
        
    //Create repos in backend
    [[GNDatabaseAPI sharedAPI] createRepos:repos];
    
    //Tie user with repositories
    [[GNDatabaseAPI sharedAPI] createRelations:[self.user objectForKey:@"id"] withRepos:repos];
    
    //Create hooks for every repo
    for (NSDictionary *repo in repos) {
        NSString *owner = [[repo objectForKey:@"owner"] objectForKey:@"login"];
        NSString *name = [repo objectForKey:@"name"];
    
        //Create repo hook
        [[GNGithubApi sharedGitAPI] createHook:owner andRepo:name];        
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
