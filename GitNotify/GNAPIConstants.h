//
//  GNAPIConstants.h
//  GitNotify
//
//  Created by Max Lam on 7/22/13.
//  Copyright (c) 2013 Max Lam. All rights reserved.
//

#ifndef GitNotify_APIConstants_h
#define GitNotify_APIConstants_h

//Access token
#define ACCESS_TOKEN @"?access_token=053e635b489343e76bcf06dfc44768fa9e2febae"

//Base url for github api
#define BASE_URL @"https://api.github.com/"

//Formats for different API requests
#define LIST_REPO_FORMAT @"users/%@/repos"
#define LIST_WATCHED_REPO_FORMAT @"users/%@/subscriptions"

#endif
