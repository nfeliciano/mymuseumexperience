//
//  ModelController.m
//  MyMuseumExperience
//
//  Created by Noel Feliciano on 2012-10-15.
//  Copyright (c) 2012 Noel Feliciano. All rights reserved.
//

#import "ModelController.h"
#import "PageViewController.h"

@interface ModelController()

@property (readonly, strong, nonatomic) NSArray *pageData;

@end

@implementation ModelController

@synthesize book;

- (id)initWithBook:(BookName)bookName
{
    self = [super init];
    if (self) {
        // Create the data model.
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        _pageData = [[dateFormatter monthSymbols] copy];
        book = bookName;
        _pageData = [NSArray arrayWithObjects:@"P1", @"P2", @"P3", @"P4", nil];
        
        if (book == MammothStation) {
            NSLog(@"MAMM");
        } else if (book == ForestStation) {
            NSLog(@"FORR");
        }
    }
    return self;
}

- (PageViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard
{
    // Return the data view controller for the given index.
    if (([self.pageData count] == 0) || (index >= [self.pageData count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    PageViewController *pageViewController = [storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    pageViewController.dataObject = self.pageData[index];
    return pageViewController;
}

- (NSUInteger)indexOfViewController:(PageViewController *)viewController
{
    // Return the index of the given data view controller.
    // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
    return [self.pageData indexOfObject:viewController.dataObject];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(PageViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(PageViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageData count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

@end
