//  Copyright (c) 2015 AppDynamics Technologies. All rights reserved.

#import <Foundation/Foundation.h>
#import "ADEumCommons.h"

ADEUM_ASSUME_NONNULL_BEGIN

/**
 * If the SDK does not automatically discover your HTTP requests, use this class to explicitly
 * report them. Note that most users will not need to use this class; check the documentation
 * for the list of HTTP APIs that are automatically discovered.
 */
@interface ADEumHTTPRequestTracker : NSObject

/**
 * Begins tracking an HTTP request.
 *
 * Call this immediately before sending an HTTP request to track it manually.
 *
 * @param url The URL being requested.
 *
 * @warning `url` must not be `nil`.
 * @warning One of ADEumInstrumentation's initWithKey: methods must be called before this method.
 */
+ (ADEumHTTPRequestTracker *)requestTrackerWithURL:(NSURL *)url;

/**
 * Stops tracking an HTTP request.
 *
 * Immediately after receiving a response or an error, set the appropriate properties and call this method
 * to report the outcome of the HTTP request. You should not continue to use this object after calling
 * this method -- if you need to track another request, call requestTrackerWithURL:.
 */
- (void)reportDone;

/**
 * The URL for the network request
 *
 */
@property (copy, nonatomic) NSURL *url;

/**
 * An error describing the failure to receive a response, if one occurred.
 *
 * If the request was successful, this should be `nil`.
 */
@property (copy, nonatomic) NSError * ADEUM_NULLABLE error;

/**
 * The status code of response, if one was received.
 *
 * If a response was received, this should be an an integer. If an error occurred and a
 * response was not received, this should be `nil`.
 */
@property (copy, nonatomic) NSNumber * ADEUM_NULLABLE statusCode;

/**
 * A dictionary representing the keys and values from the server’s response header.
 *
 * If an error occurred and a response was not received, this should be `nil`.
 */
@property (copy, nonatomic) NSDictionary * ADEUM_NULLABLE allHeaderFields;

/**
 * A dictionary representing the keys and values from the client's request header.
 */
@property (copy, nonatomic) NSDictionary * ADEUM_NULLABLE allRequestHeaderFields;

/**
 * A string to identify the source of the instrumentation that generated this tracker.
 *
 * The default is "Manual HttpTracker".
 *
 * You should not have to modify this.
 */
@property (copy, nonatomic) NSString * ADEUM_NULLABLE instrumentationSource;

@end

ADEUM_ASSUME_NONNULL_END
