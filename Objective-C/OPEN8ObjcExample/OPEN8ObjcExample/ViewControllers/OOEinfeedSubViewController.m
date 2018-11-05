//
//  OEEinfeedSubViewController.h
//  OPEN8ObjcExample
//
//  Created by 森崎 麻衣子 on 2018/10/05.
//  Copyright © 2018年 OPEN8. All rights reserved.
//

#import "OOEInfeedSubViewController.h"
@import OPEN8Ad;

@interface OOEInfeedSubViewController () <OEAInfeedAdProviderDelegate>

@property (nonatomic, strong) id <OEAInfeedAdManagerProtocol> adManager;
@property (nonatomic, strong) NSArray<id <OEAInfeedAdProviderProtocol>> *adProvider;
//@property (nonatomic, strong) id <OEAInfeedAdProviderProtocol> adProvider;
@property (nonatomic, strong) NSIndexSet *adIndexes;
@property (nonatomic, strong) NSArray <NSString *> *originalContents;
@property (nonatomic, strong) NSMutableArray *subViewY;
@property (nonatomic, strong) NSMutableArray *subViewArray;

@property (nonatomic, strong) NSArray *contents;

@end

@implementation OOEInfeedSubViewController

static NSUInteger subViewNo = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.lightGrayColor;
    self.adManager = [[OEA sharedInstance] createAdManager];
    NSArray <NSNumber *> *adRows = self.item[@"adRows"];
    self.adIndexes = [self _indexSetWithAdRows:adRows];
    self.adProvider = [self _createAdProviderWithAdManager:self.adManager];
    [self bindAd];
}

- (void)bindAd {
    
    subViewNo = 0;
    CGRect size = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height/2+60);
    CGRect scrollSize = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height*2);
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:scrollSize];
    scrollView.delegate = (id)self;
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height*7);
    [self.view addSubview:scrollView];

    OEAInfeedAdSubView *subView1 = [self createView:size];
    [scrollView addSubview:subView1];
    
    [self.adManager bindAdProvider:self.adProvider[subViewNo] toView:subView1 onScrollView:scrollView];
    
    _subViewY = [[NSMutableArray alloc] init];
    [_subViewY addObject:[NSNumber numberWithInteger:size.origin.y]];
    
    size = [self getSize:size];
    OEAInfeedAdSubView *subView2 = [self createView:size];
    [scrollView addSubview:subView2];
    
    size = [self getSize:size];
    OEAInfeedAdSubView *subView3 = [self createView:size];
    [scrollView addSubview:subView3];
    
    size = [self getSize:size];
    OEAInfeedAdSubView *subView4 = [self createView:size];
    [scrollView addSubview:subView4];
    
    size = [self getSize:size];
    OEAInfeedAdSubView *subView5 = [self createView:size];
    [scrollView addSubview:subView5];
    
    _subViewArray = [[NSMutableArray alloc] init];
    [_subViewArray addObject:subView1];
    [_subViewArray addObject:subView2];
    [_subViewArray addObject:subView3];
    [_subViewArray addObject:subView4];
    [_subViewArray addObject:subView5];
    
}

- (CGRect)getSize: (CGRect)size{
    size.origin.y = size.origin.y+self.view.bounds.size.height+self.view.bounds.size.height/2;
    [_subViewY addObject:[NSNumber numberWithInteger:size.origin.y]];
    return size;
}

- (OEAInfeedAdSubView *)createView: (CGRect)size{
    OEAInfeedAdSubView *subView = [[OEAInfeedAdSubView alloc] initWithFrame:size];
    subView.backgroundColor = UIColor.whiteColor;
    return subView;
}

- (void)scrollViewDidScroll:(UIScrollView*)scrollView{
    CGRect windowSize = [[UIScreen mainScreen] bounds];
    int topy = scrollView.contentOffset.y;
    int downy = scrollView.contentOffset.y+windowSize.size.height;
    int height = (int)self.view.bounds.size.height/2;
    
    [_subViewY enumerateObjectsUsingBlock:^(NSNumber *y, NSUInteger idx, BOOL *stop){
        if(_adProvider.count <= idx){
            return;
        }
        int viewy = [y intValue];
        if (topy<viewy && downy>viewy && subViewNo != idx) {
            [self setAd:scrollView :idx];
            *stop = YES;
        }else if (topy<viewy+height && downy>viewy+height && subViewNo != idx) {
            [self setAd:scrollView :idx];
            *stop = YES;
        }
    }];
}


- (void)setAd:(UIScrollView*)scrollView :(NSUInteger)idx{
    [self.adManager bindAdProvider:self.adProvider[idx] toView:_subViewArray[idx] onScrollView:scrollView];
    subViewNo = idx;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (NSIndexSet *)_indexSetWithAdRows:(NSArray <NSNumber *>*)adRows {
    NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] init];
    for (NSNumber *row in adRows) {
        [indexSet addIndex:[row unsignedIntegerValue]];
    }
    return indexSet;
}

- (NSArray <id <OEAInfeedAdProviderProtocol>> *)_createAdProviderWithAdManager:(id <OEAInfeedAdManagerProtocol>)adManager {
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

@end

