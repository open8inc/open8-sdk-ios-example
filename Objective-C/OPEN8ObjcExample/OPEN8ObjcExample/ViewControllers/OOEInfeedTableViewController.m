//
//  OOEInfeedTableViewController.m
//  OPEN8ObjcExample
//
//  Copyright (c) 2017-present, OPEN8, Inc. All rights reserved.
//

#import "OOEInfeedTableViewController.h"
@import OPEN8Ad;

@interface OOEInfeedTableViewController () <OEAInfeedAdProviderDelegate>

@property (nonatomic, strong) id <OEAInfeedAdManagerProtocol> adManager;

@property (nonatomic, strong) NSIndexSet *adIndexes;

@property (nonatomic, strong) NSArray<id <OEAInfeedAdProviderProtocol>> *adProviders;
@property (nonatomic, strong) NSArray <NSString *> *originalContents;

@property (nonatomic, strong) NSArray *contents;

@end

@implementation OOEInfeedTableViewController

static NSString * const kOriginalContentCellIdentifier = @"originalContentCellIdentifier";
static NSString * const kAdCellIdentifier = @"adCellIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.adManager = [[OEA sharedInstance] createAdManager];

    NSArray <NSNumber *> *adRows = self.item[@"adRows"];
    self.adIndexes = [self _indexSetWithAdRows:adRows];
    self.adProviders = [self _createAdProviders];
    
    self.originalContents = self.item[@"contents"];
    
    self.contents = [self _mergeContents];
    
    [self _configureTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (void)_configureTableView {
    self.tableView.allowsSelection = NO;
    if (self.item[@"separatorStyle"]) {
        self.tableView.separatorStyle = [self.item[@"separatorStyle"] floatValue];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.contents count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.adIndexes containsIndex:indexPath.row]) {
        OEAInfeedAdTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kAdCellIdentifier];
        id <OEAInfeedAdProviderProtocol> adProvider = self.contents[indexPath.row];
        [self.adManager bindAdProvider:adProvider toCell:cell onTableView:tableView];
        cell.hidden = (adProvider.ad == nil);
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kOriginalContentCellIdentifier];
        cell.textLabel.text = [NSString stringWithFormat:@"%ld %@", (long)indexPath.row, self.contents[indexPath.row]];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.adIndexes containsIndex:indexPath.row]) {
        id <OEAInfeedAdProviderProtocol> adProvider = self.contents[indexPath.row];
        return adProvider.height;
    } else {
        return UITableViewAutomaticDimension;
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.adIndexes containsIndex:indexPath.row]) {
        id <OEAInfeedAdProviderProtocol> adProvider = self.contents[indexPath.row];
        return adProvider.estimatedHeight;
    } else {
        return 44.f;
    }
}

#pragma mark - initialize ad providers
- (NSIndexSet *)_indexSetWithAdRows:(NSArray <NSNumber *>*)adRows {
    NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] init];
    for (NSNumber *row in adRows) {
        [indexSet addIndex:[row unsignedIntegerValue]];
    }
    return indexSet;
}

- (NSArray <id <OEAInfeedAdProviderProtocol>> *)_createAdProviders {
    NSInteger i, count = [self.adIndexes count];
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:count];

    for (i = 0; i < count; i++) {
        id <OEAInfeedAdProviderProtocol> adProvider = [self.adManager createAdProviderWithArea:@"APP"];
        adProvider.delegate = self;
        [adProvider fetchAd];
        [result addObject:adProvider];
    }

    return result;
}

- (NSArray *)_mergeContents {
    NSMutableArray *contents = [self.originalContents mutableCopy];
    [contents insertObjects:self.adProviders atIndexes:self.adIndexes];

    return contents;
}

#pragma mark - OEAInfeedAdProviderDelegate
- (void)didFetchAdWithAdProvider:(id<OEAInfeedAdProviderProtocol>)adProvider {
    [self.tableView reloadData];
}

@end
