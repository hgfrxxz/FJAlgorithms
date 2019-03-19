//
//  ViewController.m
//  ReloadTableView
//
//  Created by taojunfeng on 2019/3/19.
//  Copyright © 2019年 taojunfeng. All rights reserved.
//

#import "ViewController.h"
#import "DeepDiff.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *allArray;
@property (nonatomic, strong) DeepDiff *diff;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(randomData)];
    [self.view addGestureRecognizer:gesture];
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _dataArray = [self getData];
    _diff = [[DeepDiff alloc] init];
    [_tableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = _dataArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - event responses
- (void)randomData {
    int count = (int)_allArray.count - 1;
    for ( int i = count; i > 0; i--) {
        int random = arc4random()%i;
        [_allArray exchangeObjectAtIndex:random withObjectAtIndex:i];
    }
    
    NSMutableArray *newArray = [self getData];
    NSArray *changes = [_diff diff:_dataArray newArray:newArray];
    _dataArray = newArray;
    [self updateView:changes section:0];
}

#pragma mark - private methods
- (NSMutableArray *)getData {
    int count = (int)self.allArray.count - 1;
    int random = arc4random()%count;
    NSMutableArray *newArray = [[NSMutableArray alloc] init];
    for (int i = random; i > 0; i--) {
        [newArray addObject:_allArray[i]];
    }
    return newArray;
}

- (void)updateView:(NSArray *)changes section:(int)setion {
    NSMutableArray<NSIndexPath *> *insertArray = [[NSMutableArray alloc] init];
    NSMutableArray<NSIndexPath *> *deleteArray = [[NSMutableArray alloc] init];
    NSMutableArray<NSIndexPath *> *replaceArray = [[NSMutableArray alloc] init];
    for (Change *item in changes) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item.index inSection:setion];;
        if (item.type == insertType) {
            [insertArray addObject:indexPath];
        } else if (item.type == deleteType) {
            [deleteArray addObject:indexPath];
        } else if (item.type == replaceType) {
            [replaceArray addObject:indexPath];
        }
    }
    
    [_tableView beginUpdates];
    if (insertArray.count) {
        [_tableView insertRowsAtIndexPaths:insertArray.copy withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    if (deleteArray.count) {
        [_tableView deleteRowsAtIndexPaths:deleteArray.copy withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    if (replaceArray.count) {
        [_tableView reloadRowsAtIndexPaths:replaceArray.copy withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    [_tableView endUpdates];
    
}

#pragma mark - setters and getters
- (NSMutableArray *)allArray {
    if (!_allArray) {
        _allArray = [[NSMutableArray alloc] initWithArray:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",
                                                            @"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",
                                                            @"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",
                                                            @"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"40",
                                                            @"41",@"42",@"43",@"44",@"45",@"46",@"47",@"48",@"49",@"50",
                                                            @"51",@"52",@"53",@"54"]];
    }
    return _allArray;
}


@end
