//
//  OEAMoPubAd.h
//  OPEN8Ad
//
//  Copyright (c) 2017-present, OPEN8, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface OEAMoPubAd : NSObject

@property (nonatomic, copy, readonly) NSString * _Nullable title;
@property (nonatomic, copy, readonly) NSString * _Nullable text;
@property (nonatomic, copy, readonly) NSString * _Nullable ctaText;
@property (nonatomic, strong, readonly) NSMutableArray * _Nullable impressionTrackerURLStrings;
@property (nonatomic, copy, readonly) NSString * _Nullable clickTrackerURLString;
@property (nonatomic, copy, readonly) NSString * _Nullable defaultActionURLString;
@property (nonatomic, strong, readonly) NSDictionary * _Nullable trackers;
@property (nonatomic, copy, readonly) NSString * _Nullable VASTString;

@property (nonatomic, assign, readonly) NSInteger playVisiblePercent;
@property (nonatomic, assign, readonly) NSInteger pauseVisiblePercent;
@property (nonatomic, assign, readonly) CGFloat impressionMinVisiblePixel;
@property (nonatomic, assign, readonly) NSInteger impressionMinVisiblePercent;
@property (nonatomic, assign, readonly) NSTimeInterval impressionMinVisibleSeconds;
@property (nonatomic, assign, readonly) NSTimeInterval maxBufferingTime;

- (instancetype _Nullable)initWithTitle:(NSString * _Nullable)title
                                   text:(NSString * _Nullable)text
                                ctaText:(NSString * _Nullable)ctaText
            impressionTrackerURLStrings:(NSArray * _Nullable)impressionTrackerURLStrings
                  clickTrackerURLString:(NSString * _Nullable)clickTrackerURLString
                 defaultActionURLString:(NSString * _Nullable)defaultActionURLString
                               trackers:(NSDictionary * _Nullable)trackers
                             VASTString:(NSString * _Nullable)VASTString;

@end
