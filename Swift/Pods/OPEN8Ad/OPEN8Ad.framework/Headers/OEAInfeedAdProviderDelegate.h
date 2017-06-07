//
//  OEAInfeedAdProviderDelegate.h
//  OPEN8Ad
//
//  Copyright (c) 2017-present, OPEN8, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OEAInfeedAdProviderDelegate <NSObject>

@optional
- (void)didFetchAdWithAdProvider:(id <OEAInfeedAdProviderProtocol> _Nonnull)adProvider;

@end
