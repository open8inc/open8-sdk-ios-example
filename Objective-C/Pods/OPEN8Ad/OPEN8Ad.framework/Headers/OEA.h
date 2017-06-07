//
//  OEA.h
//  OPEN8Ad
//
//  Copyright (c) 2017-present, OPEN8, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OEAInfeedAdManagerProtocol;

NS_ASSUME_NONNULL_BEGIN

@interface OEA : NSObject

#pragma mark - initialization
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)sharedInstance;
- (BOOL)activateWithAppKey:(NSString * _Nonnull)appKey
                    option:(NSDictionary * _Nullable)option
                     error:(NSError * _Nullable __autoreleasing * _Nullable)error;

#pragma mark - creating ad manager
- (id <OEAInfeedAdManagerProtocol>)createAdManager;

@end

NS_ASSUME_NONNULL_END
