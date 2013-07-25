//
//  GNRepoTableHeader.h
//  GitNotify
//
//  Created by Max Lam on 7/22/13.
//  Copyright (c) 2013 Max Lam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GNRepoVC.h"

@class GNRepoTableVC;

@interface GNRepoTableHeader : UIView

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) GNRepoTableVC *delegate;

-(IBAction)back:(id)sender;

@end
