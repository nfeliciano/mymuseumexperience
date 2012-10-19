//
//  BookSelectionViewController.m
//  MyMuseumExperience
//
//  Created by Noel Feliciano on 2012-10-15.
//  Copyright (c) 2012 Noel Feliciano. All rights reserved.
//

#import "BookSelectionViewController.h"
#import "BookViewController.h"

@interface BookSelectionViewController ()

@end

@implementation BookSelectionViewController

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

- (IBAction)buttonPressed:(id)sender {
    [self performSegueWithIdentifier:@"goToBook" sender:sender];
}

- (IBAction)donePressed:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"goToBook"]) {
        BookViewController *bvc = [segue destinationViewController];
        NSInteger tagIndex = [(UIButton *)sender tag];
        bvc.selectedBookTag = tagIndex;
//        StationViewController *svc = [segue destinationViewController];
//        NSInteger tagIndex = [(UIButton *)sender tag];
//        svc.selectedStationTag = tagIndex;
    }
}
@end
