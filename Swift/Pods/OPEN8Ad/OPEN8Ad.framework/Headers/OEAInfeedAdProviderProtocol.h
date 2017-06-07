//
//  OEAInfeedAdProviderProtocol.h
//  OPEN8Ad
//
//  Copyright (c) 2017-present, OPEN8, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol OEAInfeedAdProviderDelegate;
@protocol OEAInfeedAdProtocol;
@protocol OEAInfeedAdViewProtocol;
@protocol OEAUserIdProtocol;

@protocol OEAInfeedAdProviderProtocol <NSObject>

@property (nonatomic, strong, readonly) NSObject <OEAInfeedAdProtocol> * _Nullable ad;
@property (nonatomic, assign, readonly, getter=isExpired) BOOL expired;
@property (nonatomic, weak) id <OEAInfeedAdViewProtocol> infeedAdView;
@property (nonatomic, weak) id <OEAInfeedAdProviderDelegate> delegate;
@property (nonatomic, assign, getter=isCellRemovable) BOOL cellRemovable;
@property (nonatomic, strong, readonly) id <OEAUserIdProtocol> userId;
@property (nonatomic, copy, readonly) NSString *area;

- (void)fetchAd;

@end

NS_ASSUME_NONNULL_END
