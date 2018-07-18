//
//  OEAInfeedAdProviderDelegate.h
//  OPEN8Ad
//
//  Copyright (c) 2017-present, OPEN8, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 `OEAInfeedAdProviderDelegate` is the delegate to be called on ad and ad fetching events.
 */
@protocol OEAInfeedAdProviderDelegate <NSObject>

@optional
/**
 Called on successful ad fetching.

 @param adProvider  An adProvider object that fetched an ad.
 */
- (void)didFetchAdWithAdProvider:(id <OEAInfeedAdProviderProtocol> _Nonnull)adProvider;
/**
 Called when ad fetching is cancelled.

 Ad fetching is cancelled when:
 - OEAOptionFetchAdOnWiFiOnlyKey is enabled and the WiFi connection is not detected when fetching ad.
 - A new ad fetching is requested while ad fetching is still in progress on the same adProvider object.
 - The adProvider already has a valid ad.

 @param adProvider  An adProvider object that requested ad fetching.
 @param error       An error object that contains error details.
 */
- (void)adProvider:(id <OEAInfeedAdProviderProtocol> _Nonnull)adProvider didCancelToFetchAdWithError:(NSError * _Nonnull)error;
/**
 Called when ad fatching is failed.

 Ad fetching fails when:
 - Inventory does not have an ad.
 - Frequency control stops to activate the downloaded ad.
 - Network is disconnected.

 @param adProvider  An adProvider object that requested ad fetching.
 @param error       An error object that contains error details.
 */
- (void)adProvider:(id <OEAInfeedAdProviderProtocol> _Nonnull)adProvider didFailToFetchAdWithError:(NSError * _Nonnull)error;
/**
 Called before a URL is opened by built-in WebView or SFSafariViewController.

 @param adProvider  An adProvider object for the tapped ad.
 @param url         A URL to be opened.
 @return YES if SDK should continue to open the URL with built-in WebView or SFSafariViewController, and NO if not.
 */
- (BOOL)adProvider:(id <OEAInfeedAdProviderProtocol> _Nonnull)adProvider shouldOpenWebViewWithURL:(NSURL * _Nonnull)url;

@end
