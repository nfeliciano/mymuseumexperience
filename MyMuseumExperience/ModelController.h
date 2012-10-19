//
//  ModelController.h
//  MyMuseumExperience
//
//  Created by Noel Feliciano on 2012-10-15.
//  Copyright (c) 2012 Noel Feliciano. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BookViewController.h"

@class PageViewController;

@interface ModelController : NSObject <UIPageViewControllerDataSource>

@property (nonatomic) BookName book;

- (id)initWithBook:(BookName)bookName;

- (PageViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(PageViewController *)viewController;

@end
