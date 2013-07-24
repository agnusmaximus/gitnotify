//
//  GNCommitsVC.m
//  GitNotify
//
//  Created by Max Lam on 7/23/13.
//  Copyright (c) 2013 Max Lam. All rights reserved.
//

#import "GNCommitsVC.h"

@interface GNCommitsVC ()

@end

@implementation GNCommitsVC

/* Method initWithNibName
 * -----------------------------
 * Called when initializing from nib
 * file. Do any extra initialization here
 */
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

/* Method setRepoId
 * ---------------------------
 * Sets repository id from which
 * to pull commits from.
 */
-(void)setRepoId:(NSString *)repoId {
    
    //Set instance var id
    self.repositoryId = repoId;
    
    //Pull commits into array
    self.commits = [[GNDatabaseAPI sharedAPI] getCommits:repoId];
}

/* Method viewdidLoad
 * --------------------------
 * Called when view is loaded. 
 * Do ui customization here
 */
-(void)viewDidLoad {
    [super viewDidLoad];
}

/* Method didReceiveMemoryWarning
 * -----------------------------------
 * Handle memory warnings here
 */
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
