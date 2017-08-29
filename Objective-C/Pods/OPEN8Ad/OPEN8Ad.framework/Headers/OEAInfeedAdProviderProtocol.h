//
//  OEAInfeedAdProviderProtocol.h
//  OPEN8Ad
//
//  Copyright (c) 2017-present, OPEN8, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@protocol OEAInfeedAdProviderDelegate;
@protocol OEAInfeedAdProtocol;
@protocol OEAInfeedAdViewProtocol;
@protocol OEAUserIdProtocol;

typedef NS_ENUM(NSInteger, OEAInfeedAdProviderStatus) {
    OEAInfeedAdProviderStatusInit = 0,
    OEAInfeedAdProviderStatusFetching = 1,
    OEAInfeedAdProviderStatusFetched = 2,
    OEAInfeedAdProviderStatusExpired = 3,
    OEAInfeedAdProviderStatusVideoStarted = 4,
};

@protocol OEAInfeedAdProviderProtocol <NSObject>

@property (nonatomic, copy, readonly) NSString *identifier;
@property (nonatomic, assign, readonly) OEAInfeedAdProviderStatus status;
@property (nonatomic, strong, readonly) NSObject <OEAInfeedAdProtocol> * _Nullable ad;
@property (nonatomic, assign, readonly, getter=isExpired) BOOL expired;
@property (nonatomic, weak) id <OEAInfeedAdViewProtocol> infeedAdView;
@property (nonatomic, weak) id <OEAInfeedAdProviderDelegate> delegate;
@property (nonatomic, assign, getter=isCellRemovable) BOOL cellRemovable;
@property (nonatomic, strong, readonly) id <OEAUserIdProtocol> userId;
@property (nonatomic, copy, readonly) NSString *area;
@property (nonatomic, assign, readonly) CGFloat height;
@property (nonatomic, assign, readonly) CGFloat estimatedHeight;

- (void)fetchAd;

@end

NS_ASSUME_NONNULL_END
