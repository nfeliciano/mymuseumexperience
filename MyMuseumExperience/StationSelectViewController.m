//
//  StationSelectViewController.m
//  MyMuseumExperience
//
//  Created by Noel Feliciano on 2012-09-30.
//  Copyright (c) 2012 Noel Feliciano. All rights reserved.
//

#import "StationSelectViewController.h"
#import "StationViewController.h"

@interface StationSelectViewController ()

@end

@implementation StationSelectViewController

@synthesize mammothButton;
@synthesize forestButton;
@synthesize shoreButton;
@synthesize oceanButton;
@synthesize birdsButton;

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

- (void)viewDidUnload {
    [self setMammothButton:nil];
    [self setForestButton:nil];
    [self setShoreButton:nil];
    [self setOceanButton:nil];
    [self setBirdsButton:nil];
    [super viewDidUnload];
}

- (IBAction)buttonPressed:(id)sender {
    [self performSegueWithIdentifier:@"goToStation" sender:sender];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"goToStation"]) {
        StationViewController *svc = [segue destinationViewController];
        NSInteger tagIndex = [(UIButton *)sender tag];
        svc.selectedStationTag = tagIndex;
    }
}

@end
