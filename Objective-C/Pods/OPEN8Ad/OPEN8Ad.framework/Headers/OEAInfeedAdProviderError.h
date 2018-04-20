//
//  OEAInfeedAdProviderError.h
//  OPEN8Ad
//
//  Copyright (c) 2017-present, OPEN8, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString * const OEAInfeedAdProviderErrorDomain;

typedef NS_ENUM(NSInteger, OEAInfeedAdProviderErrorCode) {
    OEAInfeedAdProviderErrorCodeNoInventory = 701,
    OEAInfeedAdProviderErrorCodeFrequencyCap = 702,
    OEAInfeedAdProviderErrorCodeNetworkConnection = 703,
    OEAInfeedAdProviderErrorCodeUnknown = 704,
    OEAInfeedAdProviderErrorCodeNoWiFi = 705,
    OEAInfeedAdProviderErrorCodeDownloadInProgress = 706,
    OEAInfeedAdProviderErrorCodeAdAvailable = 707,
};
