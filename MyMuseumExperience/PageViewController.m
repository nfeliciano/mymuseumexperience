//
//  PageViewController.m
//  MyMuseumExperience
//
//  Created by Noel Feliciano on 2012-10-15.
//  Copyright (c) 2012 Noel Feliciano. All rights reserved.
//

#import "PageViewController.h"

@interface PageViewController ()

@end

@implementation PageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.dataLabel.text = self.dataObject;
    
    if ([self.dataObject isEqualToString:@"P1"]) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *path;
        
        path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"Self001.png"]];
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            UIImageView *imageDisplay = [[UIImageView alloc] initWithFrame:CGRectMake(10, 40, 150, 200)];
            [imageDisplay setImage:[UIImage imageWithContentsOfFile:path]];
            [self.view addSubview:imageDisplay];
        }
    }
}

- (IBAction)backButtonPressed:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

@end
