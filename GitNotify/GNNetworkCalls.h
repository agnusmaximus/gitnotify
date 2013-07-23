//
//  GNNetworkCalls.h
//  GitNotify
//
//  Created by Max Lam on 7/22/13.
//  Copyright (c) 2013 Max Lam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GNNetworkCalls : NSObject {
    NSData *responseData;
}

-(NSString *)getRequest:(NSString *)url;
-(NSString *)postRequest:(NSString *)url withData:(NSString *)data;

@end
