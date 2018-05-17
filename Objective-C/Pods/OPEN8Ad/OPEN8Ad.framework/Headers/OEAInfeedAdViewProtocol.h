//
//  OEAInfeedAdViewProtocol.h
//  OPEN8Ad
//
//  Copyright (c) 2017-present, OPEN8, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol OEAInfeedAdProviderProtocol;

@protocol OEAInfeedAdViewProtocol <NSObject>

@property (nonatomic, assign, readonly) BOOL originalHidden;
@property (nonatomic, retain) NSObject <OEAInfeedAdProviderProtocol> *adProvider;

- (void)startTrackingWithScrollView:(UIScrollView *)scrollView;
- (CGFloat)heightByWidth:(CGFloat)width;

@end
