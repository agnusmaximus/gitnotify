//
//  GNCommitsTableVC.m
//  GitNotify
//
//  Created by Max Lam on 7/22/13.
//  Copyright (c) 2013 Max Lam. All rights reserved.
//

#import "GNCommitsTableVC.h"

@interface GNCommitsTableVC ()

@end

@implementation GNCommitsTableVC

/* Method viewDidLoad
 * ---------------------------
 * Gets repository data using
 * api call, extracts repository names,
 * and then reloads data
 */
-(void)viewDidLoad {
    [super viewDidLoad];
    
    //Register custom cells
    [self.tableView registerNib:[UINib nibWithNibName:@"GNCommitsTableCell" bundle:nil]
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
    return [self.commits count];
}

/* Method heightForRowAtIndexPath
 * -------------------------------------
 * Force change heights of different
 * cells depending on number of characaters
 * of commit message
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *text = [[self.commits objectAtIndex:indexPath.row] objectForKey:@"message"];
    return MAX(1.5, ceil(text.length / 40.0)) * 30 + 20;
}

/* Method cellForRowAtIndexPath
 * ------------------------------------
 * Customizes repository cell at given
 * row.
 */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Get cell id, and try to reuse cell with id
    static NSString *CellIdentifier = @"Cell";
    GNCommitsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    //If cell is not found, create a new one
    if (cell == nil) {
        cell = [[GNCommitsTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSString *commitMessage = [[self.commits objectAtIndex:indexPath.row] objectForKey:@"message"];
    NSString *committer = [[[self.commits objectAtIndex:indexPath.row] objectForKey:@"author"]
                           objectForKey:@"name"];
    NSString *dateString = [[self.commits objectAtIndex:indexPath.row] objectForKey:@"timestamp"];
    
    //Set text
    cell.messageLabel.text = commitMessage;
    cell.nameLabel.text = committer;
    
    //Set text field size
    CGSize maximumLabelSize = CGSizeMake(252, FLT_MAX);
    CGSize expectedLabelSize = [commitMessage sizeWithFont:cell.messageLabel.font
                                         constrainedToSize:maximumLabelSize
                                             lineBreakMode:cell.messageLabel.lineBreakMode];
    
    //adjust the label the the new height.
    CGRect newFrame = cell.messageLabel.frame;
    newFrame.size.height = expectedLabelSize.height;
    cell.messageLabel.frame = newFrame;
    
    //Set date
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZ"];
    NSDate *date = [formatter dateFromString:dateString];
        
    //Create date string
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy hh:mm at"];
    dateString = [dateFormatter stringFromDate:date];
   
    cell.dateLabel.text = dateString;
    
    //No selection
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

/* Method viewForHeaderInSection
 * ----------------------------------
 * custom header view
 */
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    //Load headerview from xib file
    GNCommitsTableHeader *headerView = [[[NSBundle mainBundle] loadNibNamed:@"GNCommitsTableHeader"
                                                                   owner:self
                                                                 options:nil] lastObject];
    headerView.delegate = self;
    headerView.titleLabel.text = [NSString stringWithFormat:@"%@", self.repoName];
    [headerView sizeToFit];
    
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
 * returns back to the repo
 */
-(void)back {
    [self.delegate.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Table view delegate

/* Method didSelectRowAtIndexPath
 * -----------------------------------
 * called when repository cell selected
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

@end
