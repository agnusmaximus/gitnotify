//
//  GNCommitsTableHeader.m
//  GitNotify
//
//  Created by Max Lam on 7/24/13.
//  Copyright (c) 2013 Max Lam. All rights reserved.
//

#import "GNCommitsTableHeader.h"

@implementation GNCommitsTableHeader

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

/* Method back
 * ------------------------
 * Goes back to the repository
 * screen.
 */
-(IBAction)back:(id)sender {
    [self.delegate back];
}

@end
