//
//  StationSelectViewController.h
//  MyMuseumExperience
//
//  Created by Noel Feliciano on 2012-09-30.
//  Copyright (c) 2012 Noel Feliciano. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StationSelectViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *mammothButton;
@property (weak, nonatomic) IBOutlet UIButton *forestButton;
@property (weak, nonatomic) IBOutlet UIButton *shoreButton;
@property (weak, nonatomic) IBOutlet UIButton *oceanButton;
@property (weak, nonatomic) IBOutlet UIButton *birdsButton;

- (IBAction)buttonPressed:(id)sender;

@end
