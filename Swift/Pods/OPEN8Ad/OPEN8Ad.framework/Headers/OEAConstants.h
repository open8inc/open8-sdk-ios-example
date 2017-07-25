//
//  OEAConstants.h
//  OPEN8Ad
//
//  Copyright (c) 2017-present, OPEN8, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - OEA option keys

/*
 * OEAOptionEnableInAppWebViewKey
 * @YES ... use SFSafariViewController to open URLs for ad detail page in the application
 * @NO  ... open Safari.
 * default is @NO
 */
FOUNDATION_EXPORT NSString * const OEAOptionEnableInAppWebViewKey;

/*
 * OEAOptionFetchAdOnWiFiOnlyKey
 * @YES ... ad will be fetched on WiFi only
 * @NO  ... ad will be fetched on both WiFi and WWAN (4G/3G network)
 * default is @NO
 */
FOUNDATION_EXPORT NSString * const OEAOptionFetchAdOnWiFiOnlyKey;

#pragma mark -

@interface OEAConstants : NSObject

@end
