//
//  GNDatabaseConstants.h
//  GitNotify
//
//  Created by Max Lam on 7/23/13.
//  Copyright (c) 2013 Max Lam. All rights reserved.
//

#ifndef GitNotify_GNDatabaseConstants_h
#define GitNotify_GNDatabaseConstants_h

//Database URL
#define CREATE_USER_URL @"http://42c3a868.ngrok.com/createuser"
#define CREATE_REPO_URL @"http://42c3a868.ngrok.com/createrepo"
#define CREATE_REPOS_URL @"http://42c3a868.ngrok.com/createrepos"
#define CREATE_RELATIONS_URL @"http://42c3a868.ngrok.com/createrelations"
#define GET_COMMITS_URL @"http://42c3a868.ngrok.com/getcommits"
#define GET_UNSEENREPOS_URL @"http://42c3a868.ngrok.com/getunseenrepos"
#define SET_UNSEENREPOS_URL @"http://42c3a868.ngrok.com/setunseenrepos"
#define SET_HOOKED_URL @"http://42c3a868.ngrok.com/sethooked"
#define GET_REPOS_URL @"http://42c3a868.ngrok.com/getrepos"

//Different methods for the database
#define CREATE_USER_FORMAT @"name=%@&id=%@"
#define CREATE_REPO_FORMAT @"name=%@&id=%@"
#define CREATE_REPOS_FORMAT @"repos=%@"
#define CREATE_RELATIONS_FORMAT @"id=%@&repos=%@"
#define GET_COMMITS_FORMAT @"repoid=%@"
#define GET_UNSEENREPOS_FORMAT @"id=%@"
#define SET_UNSEENREPOS_FORMAT @"uid=%@&repoId=%@"
#define SET_HOOKED_FORMAT @"repoName=%@"
#define GET_REPOS_FORMAT @"uid=%@"

#endif
