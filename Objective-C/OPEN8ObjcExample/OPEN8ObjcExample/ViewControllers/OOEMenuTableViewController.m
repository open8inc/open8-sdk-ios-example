//
//  OOEMenuTableViewController.m
//  OPEN8ObjcExample
//
//  Copyright (c) 2017-present, OPEN8, Inc. All rights reserved.
//

#import "OOEMenuTableViewController.h"
#import "OOEInfeedTableViewController.h"

@interface OOEMenuTableViewController ()

@property (nonatomic, strong) NSArray *menuItems;

@end

@implementation OOEMenuTableViewController

static NSString * const kMenuItemCellIdentifier = @"menuItem";
static NSString * const kInfeedSegueIdentifier = @"toInfeedViewController";

- (void)viewDidLoad {
    [super viewDidLoad];

    self.menuItems = @[@{@"title" : @"infeed(ad at top)",
                         @"segueIdentifier" : kInfeedSegueIdentifier,
                         @"adRows": @[@0],
                         @"contents": @[@"foo", @"bar", @"baz"]
                         },
                       @{@"title" : @"infeed(ad at middle)",
                         @"segueIdentifier" : kInfeedSegueIdentifier,
                         @"adRows": @[@15],
                         @"contents": @[@"foo", @"bar", @"baz", @"foo", @"bar",
                                        @"baz", @"foo", @"bar", @"baz", @"foo",
                                        @"bar", @"baz", @"foo", @"bar", @"baz",
                                        @"foo", @"bar", @"baz", @"foo", @"bar",
                                        @"baz", @"foo", @"bar", @"baz", @"foo",
                                        @"bar", @"baz", @"foo", @"bar", @"baz"
                                        ]
                         }
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
    if ([segue.identifier isEqualToString:kInfeedSegueIdentifier]) {
        OOEInfeedTableViewController *vc = (OOEInfeedTableViewController *)segue.destinationViewController;
        vc.item = sender;
    }
}

@end
