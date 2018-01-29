//
//  AlarmInfoCollectionViewCell.m
//  HouseAlarm
//
//  Created by macos on 2018/1/27.
//  Copyright © 2018年 jbu. All rights reserved.
//

#import "AlarmInfoCollectionViewCell.h"
#import "HPRAlarmCell.h"
#import "HPRListItemBean.h"
#import "HPRUtils.h"

#import <MJRefresh.h>

@interface AlarmInfoCollectionViewCell ()<UITableViewDelegate,UITableViewDataSource>{
    NSString* _flag;
}


@property (nonatomic,strong) UITableView* tableView;
@property (nonatomic,strong) NSMutableArray<NSString* >*dataSources;
@end


@implementation AlarmInfoCollectionViewCell

+ (instancetype)createReusedAlarmInfoCollectionViewCell:(UICollectionView *)collectionVC identifier:(NSString *)identifier indexPath:(NSIndexPath *)path flag:(NSString *)flag{
    AlarmInfoCollectionViewCell* cell =[collectionVC dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:path];
    cell->_flag = flag;
    return cell;
}

-(void) requestCache{
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _dataSources = [NSMutableArray array];
        _tableView = ({
            UITableView* tableView1 =[[UITableView alloc] initWithFrame:self.contentView.bounds];
            tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
            tableView1.delegate = self;
            tableView1.dataSource = self;
            
            [tableView1 registerClass:[HPRAlarmCell class] forCellReuseIdentifier:AlarmCellReuseIdentifier];
            {
                __weak typeof (self) weakSelf = self;
                tableView1.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                    [weakSelf requestCache];
                }];
            }
            tableView1;
            
        });
        
        [self.contentView addSubview:_tableView];
    }
    return self;
    
}



#pragma mark - UITableView deledate & dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dataSources.count > 0) {
        return self.dataSources.count;
    }else{
        return 0;
    }
}

- (UITableViewCell* )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataSources.count > 0) {
        NSString* data = self.dataSources[indexPath.row];
        HPRListItemBean* listItemBean= [[HPRListItemBean alloc] init];
        listItemBean.desc =data;
        listItemBean.time = data;
        
        UITableViewCell *curTableView = [tableView dequeueReusableCellWithIdentifier:AlarmCellReuseIdentifier forIndexPath:indexPath];
        [curTableView setValue:listItemBean forKey:@"listItem"];
        curTableView.selectedBackgroundView = [[UIView alloc]initWithFrame:curTableView.frame];
        curTableView.selectedBackgroundView.backgroundColor = [UIColor selectCellColor];
        return curTableView;
    
    }else{
        return [UITableViewCell new];
    }
}



@end
