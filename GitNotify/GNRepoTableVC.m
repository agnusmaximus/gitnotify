//
//  GNRepoTableVC.m
//  GitNotify
//
//  Created by Max Lam on 7/22/13.
//  Copyright (c) 2013 Max Lam. All rights reserved.
//

#import "GNRepoTableVC.h"

@interface GNRepoTableVC ()

@end

@implementation GNRepoTableVC

/* Method viewDidLoad
 * ---------------------------
 * Gets repository data using
 * api call, extracts repository names,
 * and then reloads data
 */
-(void)viewDidLoad {
    [super viewDidLoad];
    
    //Load data
    self.watched = [[GNGithubApi sharedGitAPI] getWatchedRepos:@"agnusmaximus"];
    
    //Extract repository names and ids
    self.repoNames = [NSMutableArray array];
    self.repoIds = [NSMutableArray array];

    for (NSDictionary *dict in self.watched) {
        
        //Create the title by appending owner's name to repo name
        NSString *name = [[dict objectForKey:@"owner"] objectForKey:@"login"];
        name = [name stringByAppendingFormat:@"/%@", [dict objectForKey:@"name"]];
        
        //Add to the list 
        [self.repoNames addObject:name];
        
        //Get id
        NSString *repo_id = [dict objectForKey:@"id"];
        [self.repoIds addObject:repo_id];
    }
    
    //Register custom cells
    [self.tableView registerNib:[UINib nibWithNibName:@"GNRepoTableCell" bundle:nil]
         forCellReuseIdentifier:@"Cell"];
    
    //Reload data
    [self.tableView reloadData];
}

/* Method didReceiveMemoryWarning
 * ------------------------------------
 * Handles memory warnings
 */
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

/* Method numberOfSEctionsInTableView
 * -----------------------------------------
 * Returns number of sections -- in this case
 * 1 since there are no other types of cells
 * other than repo cells
 */
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

/* Method numberOfRowsInSection
 * ----------------------------------
 * Returns number of cells -- in this
 * case equivalent to the number of 
 * repositories the user has
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.repoNames count];
}

/* Method cellForRowAtIndexPath
 * ------------------------------------
 * Customizes repository cell at given
 * row.
 */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Get cell id, and try to reuse cell with id
    static NSString *CellIdentifier = @"Cell";
    GNRepoTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    //If cell is not found, create a new one
    if (cell == nil) {
        cell = [[GNRepoTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    //Set repo name
    cell.repoName.text = [self.repoNames objectAtIndex:indexPath.row];

    //Set background color
    cell.contentView.backgroundColor = [UIColor whiteColor];
    
    //Set selected background color
    UIView *selectedBGColor = [[UIView alloc] initWithFrame:self.view.frame];
    [selectedBGColor setBackgroundColor:[UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1]];
    cell.selectedBackgroundView = selectedBGColor;
    
    return cell;
}

/* Method viewForHeaderInSection
 * ----------------------------------
 * custom header view 
 */
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    //Load headerview from xib file
    GNRepoTableHeader *headerView = [[[NSBundle mainBundle] loadNibNamed:@"GNRepoTableHeader"
                                                                  owner:self
                                                                options:nil] lastObject];
    
    //Set quartzcore layer properties
    headerView.layer.borderColor = [[UIColor colorWithRed:.8 green:.8 blue:.8 alpha:1] CGColor];    
    headerView.layer.borderWidth = 1;
    headerView.layer.cornerRadius = 1;
    headerView.layer.shadowOpacity = .3;
    headerView.layer.shadowRadius = 2;
    headerView.layer.shadowOffset = CGSizeMake(.2f, .2f);
    headerView.layer.shadowColor = [[UIColor blackColor] CGColor];
    
    //Add gradient
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = headerView.bounds;
    gradient.colors = [NSArray arrayWithObjects:
                       (id)[[UIColor colorWithRed:.93 green:.93 blue:.93 alpha:1] CGColor],
                       (id)[[UIColor colorWithRed:.95 green:.95 blue:.95 alpha:1] CGColor], nil];
    [headerView.layer insertSublayer:gradient atIndex:0];
    
    return headerView;
}

#pragma mark - Table view delegate

/* Method didSelectRowAtIndexPath
 * -----------------------------------
 * called when repository cell selected -- 
 * navigates to the notification view controller
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //Deselect cell
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //Get repository id
    NSString *repo_id = [self.repoIds objectAtIndex:indexPath.row];
    NSString *repo_name = [self.repoNames objectAtIndex:indexPath.row];
    
    //Create commits vc and set repository id of the vc
    GNCommitsVC *commitsVC = [[GNCommitsVC alloc] initWithNibName:@"GNCommitsVC" bundle:nil];
    [commitsVC setRepoId:repo_id];
    [commitsVC setRepoName:repo_name];
        
    //Transition to commits vc
    [self.delegate.navigationController pushViewController:commitsVC animated:YES];
}

@end
