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

/* Method reversedArray
 * ------------------------
 * REturns reversed array
 */
-(NSMutableArray *)reversedArray:(NSMutableArray *)array {
    NSMutableArray *results = [NSMutableArray array];
    NSEnumerator *enumerator = [array reverseObjectEnumerator];
    for (id element in enumerator) {
        [results addObject:element];
    }
    return results;
}

/* Method viewDidLoad
 * ---------------------------
 * Gets repository data using
 * api call, extracts repository names,
 * and then reloads data
 */
-(void)viewDidLoad {
    [super viewDidLoad];
    
    //Register custom cells
    [self.tableView registerNib:[UINib nibWithNibName:@"GNRepoTableCell" bundle:nil]
         forCellReuseIdentifier:@"Cell"];
    
    //Update
    [self update];
    
    //Do updates every few seconds
    [NSTimer scheduledTimerWithTimeInterval:10
                            target:self
                          selector:@selector(asyncupdate)
                          userInfo:nil
                           repeats:YES];
}

/* Method asyncupdate
 * ------------------------------
 * Asynchronous update
 */
-(void)asyncupdate {
    [self performSelectorInBackground:@selector(update) withObject:nil];
}

/* Method update
 * ----------------------------
 * Updates table data
 */
-(void)update {

    //Refresh data
    [[GNGithubApi sharedGitAPI] getUserReposWithDelegate:self
                                 andSelector:@selector(refreshRepoData:)];
}

/* Method refresh
 * -------------------------
 * Refreshes table view
 */
-(void)refreshRepoData:(NSArray *)repos {
    self.watched = (NSMutableArray *)repos;
    
    //Sort in updated order
    [self.watched sortUsingComparator:
     ^NSComparisonResult(NSDictionary *obj1, NSDictionary *obj2) {
         //Get time stamps
         NSString *timestamp1, *timestamp2;
         timestamp1 = [obj1 objectForKey:@"updated_at"];
         timestamp2 = [obj2 objectForKey:@"updated_at"];
         
         //Set date
         NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
         [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZ"];
         NSDate *time1 = [formatter dateFromString:timestamp1];
         NSDate *time2 = [formatter dateFromString:timestamp2];
         
         return [time1 compare:time2];
     }];
    
    //Reverse array
    self.watched = [self reversedArray:self.watched];
    
    
    //Extract repository names and ids
    NSMutableArray *repNames = [NSMutableArray array];
    NSMutableArray *repIds = [NSMutableArray array];
    
    for (NSDictionary *dict in self.watched) {
        
        //Create the title by appending owner's name to repo name
        NSString *name = [[dict objectForKey:@"owner"] objectForKey:@"login"];
        name = [name stringByAppendingFormat:@"/%@", [dict objectForKey:@"name"]];
        
        //Add to the list
        [repNames addObject:name];
        
        //Get id
        NSString *repo_id = [dict objectForKey:@"id"];
        [repIds addObject:repo_id];
    }
    
    self.repoNames = repNames;
    self.repoIds = repIds;
    
    //Get unseen repositories
    self.unseenRepoIds = (NSMutableArray *)[[GNDatabaseAPI sharedAPI]
                                            getUnseenRepos:[NSString stringWithFormat:@"%d", [GNGithubApi sharedGitAPI].uid]];
    if ([self.unseenRepoIds count] > 0)
        self.unseenRepoIds = [self.unseenRepoIds objectAtIndex:0];
    
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
    
    //Current repo id
    NSString *repoId = [self.repoIds objectAtIndex:indexPath.row];
    BOOL seen = YES;
    
    //Check if repo is unseen
    for (NSString *rid in self.unseenRepoIds) {
        if ([rid compare:repoId] == 0) {
            //this repo is unseen
            seen = NO;
            break;
        }
    }
    
    //If repo is unseen, set notification icon to
    //not hidden
    if (seen) {
        cell.unseen.hidden = YES;
    }
    else {
        cell.unseen.hidden = NO;
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
    headerView.delegate = self;
    
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

/* Method back
 * -------------------------
 * pops view controller
 */
-(void)back {
    [self.delegate.navigationController popViewControllerAnimated:YES];
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
    
    //Set this repo to seen
    [[GNDatabaseAPI sharedAPI] setSeenRepo:
     [NSString stringWithFormat:@"%d", [GNGithubApi sharedGitAPI].uid]
                                       and:repo_id];
    
    //Transition to commits vc
    [self.delegate.navigationController pushViewController:commitsVC animated:YES];
}

@end
