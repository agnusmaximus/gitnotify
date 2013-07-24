//
//  GNCommitsTableHeader.h
//  GitNotify
//
//  Created by Max Lam on 7/24/13.
//  Copyright (c) 2013 Max Lam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GNCommitsTableVC.h"

@class GNCommitsTableVC;

@interface GNCommitsTableHeader : UIView

@property (nonatomic, strong) GNCommitsTableVC *delegate;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;

-(IBAction)back:(id)sender;

@end
