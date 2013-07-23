//
//  GNRepoVC.m
//  GitNotify
//
//  Created by Max Lam on 7/22/13.
//  Copyright (c) 2013 Max Lam. All rights reserved.
//

#import "GNRepoVC.h"

@interface GNRepoVC ()

@end

@implementation GNRepoVC

/* Method initWithNibName
 * ------------------------------
 * initialization method. Creates a new
 * repo table view controller and adds
 * it as its main component
 */
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        //Create table vc and add to subview
        self.tableVC = [[GNRepoTableVC alloc] initWithNibName:@"GNRepoTableVC" bundle:nil];
        [self.view addSubview:self.tableVC.view];
    }
    return self;
}

/* MEthod viewdidLoad
 * ---------------------------
 * Called for extra view initialization
 */
-(void)viewDidLoad {
    [super viewDidLoad];
}

/* Method didReceiveMemoryWarning
 * ---------------------------------
 * Handle memory warnings here
 */
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
