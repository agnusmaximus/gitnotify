//
//  GNNetworkCalls.m
//  GitNotify
//
//  Created by Max Lam on 7/22/13.
//  Copyright (c) 2013 Max Lam. All rights reserved.
//

#import "GNNetworkCalls.h"

@implementation GNNetworkCalls

/* Method getRequest
 * ------------------------------
 * Performs a network GET request
 * to the specified url.
 *
 * @url - url to GET request
 * @return - response
 */
-(NSString *)getRequest:(NSString *)url {
    
    //Create the request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    //Set method of request, as well as url
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:url]];
    
    //Check for errors and response code
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;
    
    //Perform the request
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request
                                                  returningResponse:&responseCode
                                                              error:&error];
    
    //Check for errors
    if([responseCode statusCode] != 200){
        NSLog(@"Error: getting %@, HTTP status code %i", url, [responseCode statusCode]);
    }
    
    //Convert data to string
    NSString *data = [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
    
    return data;
}

/* Method postRequest
 * ---------------------------------
 * Perofrms a network post to the specified
 * url, passing parameter data to the url.
 *
 * @url - url to POST request
 * @data - data to send
 *
 * @return - response
 */
-(NSString *)postRequest:(NSString *)url withData:(NSString *)data {
    
    //Create request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    //Set method and data
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
    
    //Set header
    [request setValue:[NSString stringWithFormat:@"%d", [data length]]
   forHTTPHeaderField:@"Content-Length"];
    
    //Set url
    [request setURL:[NSURL URLWithString:url]];
    
    //Check for errors and response code
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;
    
    //Perform the request
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request
                                                  returningResponse:&responseCode
                                                              error:&error];
    
    //Check for errors
    if([responseCode statusCode] != 200){
        NSLog(@"Error: getting %@, HTTP status code %i", url, [responseCode statusCode]);
    }
    
    //Convert data to string
    NSString *response = [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
    
    return response;
}

@end