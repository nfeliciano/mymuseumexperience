//
//  IntroViewController.h
//  MyMuseumExperience
//
//  Created by Noel Feliciano on 2012-09-14.
//  Copyright (c) 2012 Noel Feliciano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HelpScreenView.h"

typedef enum {
    photoState,
    videoState,
    noState
} CurrentState;

@interface IntroViewController : UIViewController <HelpScreenViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
    BOOL helpScreenUp;
    UIButton *photoSelected;
    CurrentState currentState;
    BOOL photoStateComplete;
    BOOL videoStateComplete;
}

@property (strong, nonatomic) HelpScreenView *helpScreen;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;;
@property (weak, nonatomic) IBOutlet UIButton *helpButton;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *photoButton;
@property (weak, nonatomic) IBOutlet UIButton *videoButton;

- (IBAction)buttonPressed:(id)sender;

@end
