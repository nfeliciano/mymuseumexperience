//
//  StationViewController.h
//  MyMuseumExperience
//
//  Created by Noel Feliciano on 2012-09-30.
//  Copyright (c) 2012 Noel Feliciano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HelpScreenView.h"

typedef enum {
    MammothStation,
    ForestStation,
    ShoreStation,
    OceanStation,
    BirdStation
} StationName;

typedef enum {
    photoState,
    videoState,
    noState
} CurrentState;

@interface StationViewController : UIViewController <HelpScreenViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    BOOL helpScreenUp;
    
    NSString *stationName;
    NSString *introVideoPath;
    NSString *photoVideoPath;
    NSString *videoVideoPath;
    NSString *endingVideoPath;
    NSString *backgroundImagePath;
    NSString *photoImagePath;
    NSString *videoImagePath;
    NSString *sampleImageOnePath;
    NSString *sampleImageTwoPath;
    
    CurrentState currentState;
    BOOL photoStateComplete;
    BOOL videoStateComplete;
    UIButton *photoSelected;
}

@property (strong, nonatomic) HelpScreenView *helpScreen;
@property (weak, nonatomic) IBOutlet UIButton *helpButton;

@property (nonatomic) NSInteger selectedStationTag;
@property (nonatomic) StationName station;

@property (nonatomic, weak) IBOutlet UIImageView *backgroundImage;
@property (nonatomic, weak) IBOutlet UIButton *startButton;
@property (nonatomic, weak) IBOutlet UIButton *photoButton;
@property (nonatomic, weak) IBOutlet UIButton *videoButton;

- (IBAction)buttonPressed:(id)sender;

@end
