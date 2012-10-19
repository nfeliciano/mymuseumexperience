//
//  BookViewController.h
//  MyMuseumExperience
//
//  Created by Noel Feliciano on 2012-10-15.
//  Copyright (c) 2012 Noel Feliciano. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    MammothStation,
    ForestStation,
    ShoreStation,
    OceanStation,
    BirdStation
} BookName;

@interface BookViewController : UIViewController <UIPageViewControllerDelegate>

@property (nonatomic, strong) UIPageViewController *pageViewController;

@property (nonatomic) NSInteger selectedBookTag;
@property (nonatomic) BookName book;

@end
