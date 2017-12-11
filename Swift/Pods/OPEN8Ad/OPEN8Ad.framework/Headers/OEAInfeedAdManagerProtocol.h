//
//  OEAInfeedAdManagerProtocol.h
//  OPEN8Ad
//
//  Copyright (c) 2017-present, OPEN8, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol OEAInfeedAdProviderProtocol;
@class OEAInfeedAdView;
@class OEAInfeedAdTableViewCell;
@class OEAInfeedAdCollectionViewCell;

@protocol OEAInfeedAdManagerProtocol <NSObject>

- (id <OEAInfeedAdProviderProtocol>)createAdProvider;
- (id <OEAInfeedAdProviderProtocol>)createAdProviderWithArea:(NSString *)area;
- (OEAInfeedAdView *)createView;
- (void)bindAdProvider:(id <OEAInfeedAdProviderProtocol>)adProvider toCell:(OEAInfeedAdTableViewCell *)cell onTableView:(UITableView *)tableView;
- (void)bindAdProvider:(id <OEAInfeedAdProviderProtocol>)adProvider toCell:(OEAInfeedAdCollectionViewCell *)cell onCollectionView:(UICollectionView *)collectionView;

@end
