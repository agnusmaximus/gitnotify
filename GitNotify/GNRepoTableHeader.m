//
//  GNRepoTableHeader.m
//  GitNotify
//
//  Created by Max Lam on 7/22/13.
//  Copyright (c) 2013 Max Lam. All rights reserved.
//

#import "GNRepoTableHeader.h"

@implementation GNRepoTableHeader

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(IBAction)back:(id)sender {
    [self.delegate back];
}

@end
