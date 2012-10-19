//
//  PageViewController.h
//  MyMuseumExperience
//
//  Created by Noel Feliciano on 2012-10-15.
//  Copyright (c) 2012 Noel Feliciano. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *dataLabel;
@property (strong, nonatomic) NSString *dataObject;

-(IBAction)backButtonPressed:(id)sender;

@end
