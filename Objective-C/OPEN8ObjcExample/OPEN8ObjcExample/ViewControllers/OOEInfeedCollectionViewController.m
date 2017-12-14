//
//  OOEInfeedCollectionViewController.m
//  OPEN8ObjcExample
//
//  Copyright (c) 2017-present, OPEN8, Inc. All rights reserved.
//

#import "OOEInfeedCollectionViewController.h"
@import OPEN8Ad;

@interface OOEInfeedCollectionViewController () <OEAInfeedAdProviderDelegate>

@property (nonatomic, strong) id <OEAInfeedAdManagerProtocol> adManager;
@property (nonatomic, strong) id <OEAInfeedAdProviderProtocol> adProvider;
@property (nonatomic, assign) NSInteger adRowIndex;

@end

@implementation OOEInfeedCollectionViewController

static NSString * const kNonAdCellIdentifier = @"nonAdCellIdentifier";
static NSString * const kAdCellIdentifier = @"adCellIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.adManager = [[OEA sharedInstance] createAdManager];
    self.adProvider = [self _createAdProviderWithAdManager:self.adManager];
    self.adRowIndex = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (id <OEAInfeedAdProviderProtocol>)_createAdProviderWithAdManager:(id <OEAInfeedAdManagerProtocol>)adManager {
    id <OEAInfeedAdProviderProtocol> adProvider = [adManager createAdProvider];
    adProvider.delegate = self;
    [adProvider fetchAd];
    return adProvider;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.adRowIndex) {
        OEAInfeedAdCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kAdCellIdentifier
                                                                                          forIndexPath:indexPath];
        [self.adManager bindAdProvider:self.adProvider toCell:cell onCollectionView:collectionView];
        return cell;
    } else {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kNonAdCellIdentifier
                                                                               forIndexPath:indexPath];
        return cell;
    }
}

@end
