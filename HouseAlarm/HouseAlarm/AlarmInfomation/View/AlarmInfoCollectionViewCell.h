//
//  AlarmInfoCollectionViewCell.h
//  HouseAlarm
//
//  Created by macos on 2018/1/27.
//  Copyright © 2018年 jbu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlarmInfoCollectionViewCell : UICollectionViewCell



+ (instancetype)createReusedAlarmInfoCollectionViewCell:(UICollectionView* )collectionVC
                                             identifier:(NSString* )identifier
                                              indexPath:(NSIndexPath* )path
                                                   flag:(NSString* )flag;
@end
