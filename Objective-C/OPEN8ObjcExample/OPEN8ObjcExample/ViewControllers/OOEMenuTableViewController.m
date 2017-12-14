//
//  OOEMenuTableViewController.m
//  OPEN8ObjcExample
//
//  Copyright (c) 2017-present, OPEN8, Inc. All rights reserved.
//

#import "OOEMenuTableViewController.h"
#import "OOEInfeedTableViewController.h"
#import "OOEInfeedCollectionViewController.h"

@interface OOEMenuTableViewController ()

@property (nonatomic, strong) NSArray *menuItems;

@end

@implementation OOEMenuTableViewController

static NSString * const kMenuItemCellIdentifier = @"menuItem";
static NSString * const kTableViewSegueIdentifier = @"toTableViewController";
static NSString * const kCollectionViewSegueIdentifier = @"toCollectionViewController";

- (void)viewDidLoad {
    [super viewDidLoad];

    self.menuItems = @[@{@"title" : @"TableView (ad on top with cell separator)",
                         @"segueIdentifier" : kTableViewSegueIdentifier,
                         @"adRows" : @[@0],
                         @"contents" : @[@"foo", @"bar", @"baz"]
                         },
                       @{@"title" : @"TableView (ad on top without cell separator)",
                         @"segueIdentifier" : kTableViewSegueIdentifier,
                         @"adRows" : @[@0],
                         @"contents" : @[@"foo", @"bar", @"baz"],
                         @"separatorStyle" : @(UITableViewCellSeparatorStyleNone)
                         },
                       @{@"title" : @"TableView (ad in the middle)",
                         @"segueIdentifier" : kTableViewSegueIdentifier,
                         @"adRows" : @[@15],
                         @"contents" : @[@"foo", @"bar", @"baz", @"foo", @"bar",
                                        @"baz", @"foo", @"bar", @"baz", @"foo",
                                        @"bar", @"baz", @"foo", @"bar", @"baz",
                                        @"foo", @"bar", @"baz", @"foo", @"bar",
                                        @"baz", @"foo", @"bar", @"baz", @"foo",
                                        @"bar", @"baz", @"foo", @"bar", @"baz"
                                        ]
                         },
                       @{@"title" : @"CollectionView (ad on top)",
                         @"segueIdentifier" : kCollectionViewSegueIdentifier,
                         @"adRows" : @[@0],
                         @"contents" : @[@"foo", @"bar", @"baz"]
                         },
                       ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.menuItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMenuItemCellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = self.menuItems[indexPath.row][@"title"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:self.menuItems[indexPath.row][@"segueIdentifier"] sender:self.menuItems[indexPath.row]];
    [self.tableView deselectRowAtIndexPath:indexPath animated:false];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kTableViewSegueIdentifier]) {
        OOEInfeedTableViewController *vc = (OOEInfeedTableViewController *)segue.destinationViewController;
        vc.item = sender;
    } else if ([segue.identifier isEqualToString:kCollectionViewSegueIdentifier]) {
        OOEInfeedCollectionViewController *vc = (OOEInfeedCollectionViewController *)segue.destinationViewController;
        vc.item = sender;
    }
}

@end
