//
//  StationViewController.m
//  MyMuseumExperience
//
//  Created by Noel Feliciano on 2012-09-30.
//  Copyright (c) 2012 Noel Feliciano. All rights reserved.
//

#import "StationViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/UTCoreTypes.h>
#include <math.h>

static inline double radians (double degrees) {return degrees * M_PI/180;}

@interface StationViewController ()

@property (nonatomic, strong) MPMoviePlayerController *moviePlayer;
@property (nonatomic, strong) UIImageView *imageDisplay;

@end

@implementation StationViewController

@synthesize moviePlayer;
@synthesize imageDisplay;

@synthesize helpScreen;
@synthesize helpButton;

@synthesize selectedStationTag;
@synthesize station;

@synthesize backgroundImage;
@synthesize startButton;
@synthesize photoButton;
@synthesize videoButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        helpScreen = [[HelpScreenView alloc] init];
        helpScreen.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    helpScreen.frame = CGRectMake(30, 10, helpScreen.frame.size.width, helpScreen.frame.size.height);
    [self.view addSubview:helpScreen];
    CGRect frame = helpScreen.frame;
    [helpScreen setFrame:CGRectMake(frame.origin.x, frame.origin.y + self.view.frame.size.height, frame.size.width, frame.size.height)];
    
    switch (station) {
        case MammothStation:
            stationName = @"Mammoth";
            backgroundImagePath = @"mammothBackground.png";
            photoImagePath = @"mammoth_fossilButton.png";
            videoImagePath = @"mammoth_mammothButton.png";
            sampleImageOnePath = @"mammoth_defaultFossilOne2.png";
            sampleImageTwoPath = @"mammoth_defaultFossilTwo2.png";
            introVideoPath = @"mammoth_intro";
            videoVideoPath = @"mammoth_mammoth";
            photoVideoPath = @"mammoth_fossil";
            endingVideoPath = @"mammoth_ending";
            break;
        case ForestStation:
            stationName = @"Forest";
            backgroundImagePath = @"forestBackground.png";
            photoImagePath = @"forest_bear.png";
            videoImagePath = @"forest_deer.png";
            sampleImageOnePath = @"forest_elk.png";
            sampleImageTwoPath = @"forest_mountainLion.png";
            introVideoPath = @"forest_intro";
            videoVideoPath = @"forest_animalStory";
            photoVideoPath = @"forest_forestAnimals";
            endingVideoPath = @"forest_ending";
            break;
        case ShoreStation:
            
            break;
        case OceanStation:
            
            break;
        case BirdStation:
            
            break;
    }
    
    [backgroundImage setImage:[UIImage imageNamed:backgroundImagePath]];
    [photoButton setImage:[UIImage imageNamed:photoImagePath] forState:UIControlStateNormal];
    [videoButton setImage:[UIImage imageNamed:videoImagePath] forState:UIControlStateNormal];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//help screen delegate
- (IBAction)helpScreenPressed:(id)sender {
    CGRect frame = helpScreen.frame;
    [self.view bringSubviewToFront:helpScreen];
    if (!helpScreenUp) {
        helpButton.hidden = YES;
        [UIView animateWithDuration:0.4 animations:^(void){
            [helpScreen setFrame:CGRectMake(frame.origin.x, frame.origin.y - self.view.frame.size.height, frame.size.width, frame.size.height)];
        } completion:^(BOOL finished) {
            helpScreenUp = YES;
        }];
    } else {
        [UIView animateWithDuration:0.4 animations:^(void){
            [helpScreen setFrame:CGRectMake(frame.origin.x, frame.origin.y + self.view.frame.size.height, frame.size.width, frame.size.height)];
        } completion:^(BOOL finished) {
            helpScreenUp = NO;
            helpButton.hidden = NO;
        }];
    }
}

- (void)closeHelpScreen {
    [self helpScreenPressed:nil];
}

- (void)helpButtonPressed:(id)sender {
    if (sender == helpScreen.adultButton) {
        
    } else if (sender == helpScreen.kidsButton) {
        
    } else if (sender == helpScreen.mapButton) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//end help screen delegate

- (void)setSelectedStationTag:(NSInteger)tag {
    if (tag == 1) {
        station = MammothStation;
    } else if (tag == 2) {
        station = ForestStation;
    } else if (tag == 3) {
        station = ShoreStation;
    } else if (tag == 4) {
        station = OceanStation;
    } else if (tag == 5) {
        station = BirdStation;
    }
}

- (IBAction)buttonPressed:(id)sender {
    UIButton *button = (UIButton *)sender;
    if (button == startButton) {
        startButton.alpha = 0.0;
        startButton.hidden = YES;
        
        NSURL *introVideo = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:introVideoPath ofType:@"MP4"]];
        moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:introVideo];
        moviePlayer.scalingMode = MPMovieScalingModeAspectFill;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(introVideoFinishedPlayback:)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification
                                                   object:moviePlayer];
        self.moviePlayer.controlStyle = MPMovieControlStyleFullscreen;
        [self.moviePlayer.view setFrame:self.view.bounds];
        [self.view addSubview:self.moviePlayer.view];
        [moviePlayer play];
    } else if (button == photoButton) {
        currentState = photoState;
        photoButton.hidden = YES;
        videoButton.hidden = YES;
        photoButton.alpha = 0.0;
        videoButton.alpha = 0.0;
        
        imageDisplay = [[UIImageView alloc] initWithFrame:CGRectMake(15, 20, 200, 266)];
        imageDisplay.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:imageDisplay];
        
        NSURL *photoVideo = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:photoVideoPath ofType:@"MP4"]];
        moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:photoVideo];
        moviePlayer.scalingMode = MPMovieScalingModeAspectFill;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(photoVideoFinishedPlayback:)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification
                                                   object:moviePlayer];
        self.moviePlayer.controlStyle = MPMovieControlStyleFullscreen;
        [self.moviePlayer.view setFrame:self.view.bounds];
        [self.view addSubview:self.moviePlayer.view];
        [moviePlayer play];
        
    } else if (button == videoButton) {
        currentState = videoState;
        photoButton.hidden = YES;
        videoButton.hidden = YES;
        photoButton.alpha = 0.0;
        videoButton.alpha = 0.0;
        
        NSURL *videoVideo = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:videoVideoPath ofType:@"MP4"]];
        moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:videoVideo];
        moviePlayer.scalingMode = MPMovieScalingModeAspectFill;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(videoVideoFinishedPlayback:)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification
                                                   object:moviePlayer];
        self.moviePlayer.controlStyle = MPMovieControlStyleFullscreen;
        [self.moviePlayer.view setFrame:self.view.bounds];
        [self.view addSubview:self.moviePlayer.view];
        [moviePlayer play];
    }
    
    else if (button.tag == 10) {
        UIImagePickerController *camera = [[UIImagePickerController alloc] init];
        camera.sourceType = UIImagePickerControllerSourceTypeCamera;
        camera.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
        camera.delegate = self;
        [self presentModalViewController:camera animated:YES];
    } else if (button.tag == 11 || button.tag == 12 || button.tag == 13 || button.tag == 17 || button.tag == 18) {
        photoSelected = button;
        [imageDisplay setImage:nil];
        [imageDisplay setImage:button.imageView.image];
        if (button.tag == 17 || button.tag == 18) {
            NSArray *subviews = [self.view subviews];
            for (id subview in subviews) {
                if ([subview isKindOfClass:[UIButton class]]) {
                    UIButton *button = subview;
                    if (button.tag == 10) button.hidden = YES;
                }
            }
        } else {
            NSArray *subviews = [self.view subviews];
            for (id subview in subviews) {
                if ([subview isKindOfClass:[UIButton class]]) {
                    UIButton *button = subview;
                    if (button.tag == 10) button.hidden = NO;
                }
            }
        }
    } else if (button.tag == 19) {
        photoStateComplete = YES;
        photoButton.hidden = NO;
        videoButton.hidden = NO;
        [UIView animateWithDuration:0.6 animations:^(void) {
            imageDisplay.alpha = 0.0;
            photoButton.alpha = 1.0;
            videoButton.alpha = 1.0;
            for (UIButton *button in [self.view subviews]) {
                if (button.tag != 0) button.alpha = 0.0;
            }
        } completion:^(BOOL completed) {
            for (UIButton *button in [self.view subviews]) {
                if (button.tag != 0) {
                    [button removeFromSuperview];
                }
            }
            if (photoStateComplete && videoStateComplete) {
                UIButton *doneStation = [UIButton buttonWithType:UIButtonTypeCustom];
                doneStation.frame = CGRectMake(self.view.frame.size.width - 70, 10, 50, 50);
                [doneStation setImage:[UIImage imageNamed:@"doneButton.png"] forState:UIControlStateNormal];
                [doneStation addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
                doneStation.tag = 30;
                [self.view addSubview:doneStation];
            }
        }];
        currentState = noState;
    }
    else if (button.tag == 20) {
        UIImagePickerController *videoCamera = [[UIImagePickerController alloc] init];
        videoCamera.sourceType = UIImagePickerControllerCameraCaptureModeVideo;
        videoCamera.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
        //videoCamera.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie, nil];
        videoCamera.videoMaximumDuration = 30;
        videoCamera.showsCameraControls = YES;
        videoCamera.delegate = self;
        [self presentModalViewController:videoCamera animated:YES];
    }
    else if (button.tag == 29) {
        for (id subview in self.view.subviews) {
            if ([subview isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView = subview;
                if (imageView != backgroundImage) [imageView removeFromSuperview];
            }
        }
        videoStateComplete = YES;
        photoButton.hidden = NO;
        videoButton.hidden = NO;
        [UIView animateWithDuration:0.6 animations:^(void) {
            imageDisplay.alpha = 0.0;
            photoButton.alpha = 1.0;
            videoButton.alpha = 1.0;
            for (UIButton *button in [self.view subviews]) {
                if (button.tag != 0) button.alpha = 0.0;
            }
        } completion:^(BOOL completed) {
            for (UIButton *button in [self.view subviews]) {
                if (button.tag != 0) {
                    [button removeFromSuperview];
                }
            }
            if (photoStateComplete && videoStateComplete) {
                UIButton *doneStation = [UIButton buttonWithType:UIButtonTypeCustom];
                doneStation.frame = CGRectMake(self.view.frame.size.width - 70, 10, 50, 50);
                [doneStation setImage:[UIImage imageNamed:@"doneButton.png"] forState:UIControlStateNormal];
                [doneStation addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
                doneStation.tag = 30;
                [self.view addSubview:doneStation];
            }
        }];
        currentState = noState;
    }
    else if (button.tag == 30) {
        photoButton.hidden = YES;
        videoButton.hidden = YES;
        photoButton.alpha = 0.0;
        videoButton.alpha = 0.0;
        
        NSURL *videoVideo = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:endingVideoPath ofType:@"MP4"]];
        moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:videoVideo];
        moviePlayer.scalingMode = MPMovieScalingModeAspectFill;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(endingVideoFinishedPlayback:)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification
                                                   object:moviePlayer];
        self.moviePlayer.controlStyle = MPMovieControlStyleFullscreen;
        [self.moviePlayer.view setFrame:self.view.bounds];
        [self.view addSubview:self.moviePlayer.view];
        [moviePlayer play];
    }
    else if (button.tag == 40) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    if (currentState == photoState) {
        UIButton *replacement = [UIButton buttonWithType:UIButtonTypeCustom];
        [replacement addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        replacement.frame = photoSelected.frame;
        UIImage *image = [self resizeImage:[info objectForKey:UIImagePickerControllerOriginalImage] :267 :400];
        [replacement setImage:image forState:UIControlStateNormal];
        replacement.tag = photoSelected.tag;
        [photoSelected removeFromSuperview];
        photoSelected = nil;
        [self.view addSubview:replacement];
        photoSelected = replacement;
        
        [imageDisplay setImage:nil];
        [imageDisplay setImage:[info objectForKey:UIImagePickerControllerOriginalImage]];
        
        [picker dismissModalViewControllerAnimated:YES];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString* path;
        if (photoSelected.tag == 11) path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@001.png", stationName]];
        else if (photoSelected.tag == 12) path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@002.png", stationName]];
        else if (photoSelected.tag == 13) path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@003.png", stationName]];
        NSData* data = UIImagePNGRepresentation(image);
        [data writeToFile:path atomically:YES];
        
        BOOL doneButtonExists = NO;
        for (id subview in self.view.subviews) {
            if ([subview isKindOfClass:[UIButton class]]) {
                UIButton *button = subview;
                if (button.tag == 19) doneButtonExists = YES;
            }
        }
        if (!doneButtonExists) {
            UIButton *donePhoto = [UIButton buttonWithType:UIButtonTypeCustom];
            donePhoto.frame = CGRectMake(self.view.frame.size.width - 70, 10, 50, 50);
            [donePhoto setImage:[UIImage imageNamed:@"doneButton.png"] forState:UIControlStateNormal];
            [donePhoto addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            donePhoto.tag = 19;
            [self.view addSubview:donePhoto];
        }
    }
    else if (currentState == videoState) {
        [picker dismissModalViewControllerAnimated:YES];
        
        NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
        NSData *videoData = [NSData dataWithContentsOfURL:videoURL];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@Vid.mp4", stationName]];
        [videoData writeToFile:path atomically:YES];
        
        BOOL doneButtonExists = NO;
        for (id subview in self.view.subviews) {
            if ([subview isKindOfClass:[UIButton class]]) {
                UIButton *button = subview;
                if (button.tag == 29) doneButtonExists = YES;
            }
        }
        if (!doneButtonExists) {
            UIButton *doneVideo = [UIButton buttonWithType:UIButtonTypeCustom];
            doneVideo.frame = CGRectMake(self.view.frame.size.width - 70, 10, 50, 50);
            [doneVideo setImage:[UIImage imageNamed:@"doneButton.png"] forState:UIControlStateNormal];
            [doneVideo addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            doneVideo.tag = 29;
            [self.view addSubview:doneVideo];
        }
        
    }
}

- (void)introVideoFinishedPlayback:(NSNotification *)notification {
    [moviePlayer.view removeFromSuperview];
    [[NSNotificationCenter defaultCenter] removeObserver: self
                                                    name: MPMoviePlayerPlaybackDidFinishNotification
                                                  object:moviePlayer];
    photoButton.hidden = NO;
    videoButton.hidden = NO;
    photoButton.alpha = 1.0;
    videoButton.alpha = 1.0;
}

- (void)photoVideoFinishedPlayback:(NSNotification *)notification {
    [moviePlayer.view removeFromSuperview];
    [[NSNotificationCenter defaultCenter] removeObserver: self
                                                    name: MPMoviePlayerPlaybackDidFinishNotification
                                                  object:moviePlayer];
    
    UIButton *newPhotoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [newPhotoButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    newPhotoButton.frame = CGRectMake(85, 210, 60, 60);
    [newPhotoButton setBackgroundImage:[UIImage imageNamed:@"cameraButton.png"] forState:UIControlStateNormal];
    newPhotoButton.tag = 10;
    [self.view addSubview:newPhotoButton];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path;
    BOOL checkPics = NO;
    
    path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@001.png", stationName]];
    UIButton *photoOneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [photoOneButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [photoOneButton setImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateNormal];
        checkPics = YES;
        [imageDisplay setImage:[UIImage imageWithContentsOfFile:path]];
    }
    photoOneButton.frame = CGRectMake(15, 310, 90, 120);
    [photoOneButton setBackgroundColor:[UIColor whiteColor]];
    photoOneButton.tag = 11;
    [self.view addSubview:photoOneButton];
    photoSelected = photoOneButton;
    
    path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@002.png", stationName]];
    UIButton *photoTwoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [photoTwoButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [photoOneButton setImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateNormal];
        checkPics = YES;
    }
    photoTwoButton.frame = CGRectMake(115, 310, 90, 120);
    [photoTwoButton setBackgroundColor:[UIColor whiteColor]];
    photoTwoButton.tag = 12;
    [self.view addSubview:photoTwoButton];
    
    path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@003.png", stationName]];
    UIButton *photoThreeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [photoThreeButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [photoOneButton setImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateNormal];
        checkPics = YES;
    }
    photoThreeButton.frame = CGRectMake(215, 310, 90, 120);
    [photoThreeButton setBackgroundColor:[UIColor whiteColor]];
    photoThreeButton.tag = 13;
    [self.view addSubview:photoThreeButton];
    
    if (checkPics) {
        UIButton *donePhoto = [UIButton buttonWithType:UIButtonTypeCustom];
        donePhoto.frame = CGRectMake(self.view.frame.size.width - 70, 10, 50, 50);
        [donePhoto setImage:[UIImage imageNamed:@"doneButton.png"] forState:UIControlStateNormal];
        [donePhoto addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        donePhoto.tag = 19;
        [self.view addSubview:donePhoto];
    }
    
    UIButton *samplePhotoOneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [samplePhotoOneButton setImage:[UIImage imageNamed:sampleImageOnePath] forState:UIControlStateNormal];
    [samplePhotoOneButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    samplePhotoOneButton.frame = CGRectMake(220, 90, 90, 68);
    [samplePhotoOneButton setBackgroundColor:[UIColor whiteColor]];
    samplePhotoOneButton.tag = 17;
    [self.view addSubview:samplePhotoOneButton];
    
    UIButton *samplePhotoTwoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [samplePhotoTwoButton setImage:[UIImage imageNamed:sampleImageTwoPath] forState:UIControlStateNormal];
    [samplePhotoTwoButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    samplePhotoTwoButton.frame = CGRectMake(220, 168, 90, 68);
    [samplePhotoTwoButton setBackgroundColor:[UIColor whiteColor]];
    samplePhotoTwoButton.tag = 18;
    [self.view addSubview:samplePhotoTwoButton];
}

- (void)videoVideoFinishedPlayback:(NSNotification *)notification {
    [moviePlayer.view removeFromSuperview];
    [[NSNotificationCenter defaultCenter] removeObserver: self
                                                    name: MPMoviePlayerPlaybackDidFinishNotification
                                                  object:moviePlayer];
    
    if (station == MammothStation) {
        UIImageView *mammothSamplePic = [[UIImageView alloc] initWithFrame:videoButton.frame];
        [mammothSamplePic setImage:[UIImage imageNamed:@"mammoth_mammothButton.png"]];
        [self.view addSubview:mammothSamplePic];
        
        UIImageView *elephantSamplePic = [[UIImageView alloc] initWithFrame:photoButton.frame];
        [elephantSamplePic setImage:[UIImage imageNamed:@"mammoth_elephant.png"]];
        [self.view addSubview:elephantSamplePic];
    }
    
    UIButton *newVideoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [newVideoButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    newVideoButton.frame = CGRectMake(120, 190, 80, 80);
    [newVideoButton setBackgroundImage:[UIImage imageNamed:@"recordButton.png"] forState:UIControlStateNormal];
    newVideoButton.tag = 20;
    [self.view addSubview:newVideoButton];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@Vid.mp4", stationName]];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        UIButton *doneVideo = [UIButton buttonWithType:UIButtonTypeCustom];
        doneVideo.frame = CGRectMake(self.view.frame.size.width - 70, 10, 50, 50);
        [doneVideo setImage:[UIImage imageNamed:@"doneButton.png"] forState:UIControlStateNormal];
        [doneVideo addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        doneVideo.tag = 29;
        [self.view addSubview:doneVideo];
    }
}

- (void)endingVideoFinishedPlayback:(NSNotification *)notification {
    for (UIButton *button in [self.view subviews]) {
        if (button.tag != 0) {
            [button removeFromSuperview];
        }
    }
    
    [moviePlayer.view removeFromSuperview];
    [[NSNotificationCenter defaultCenter] removeObserver: self
                                                    name: MPMoviePlayerPlaybackDidFinishNotification
                                                  object:moviePlayer];
    
    UIButton *doneStationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneStationButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    doneStationButton.frame = CGRectMake(120, 190, 80, 80);
    [doneStationButton setBackgroundImage:[UIImage imageNamed:@"doneButton"] forState:UIControlStateNormal];
    doneStationButton.tag = 40;
    [self.view addSubview:doneStationButton];
}



- (UIImage *)resizeImage:(UIImage *)image :(NSInteger) width :(NSInteger) height {
	
	CGImageRef imageRef = [image CGImage];
	CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(imageRef);
	CGColorSpaceRef colorSpaceInfo = CGColorSpaceCreateDeviceRGB();
	
	if (alphaInfo == kCGImageAlphaNone)
		alphaInfo = kCGImageAlphaNoneSkipLast;
	
	CGContextRef bitmap;
	
	if (image.imageOrientation == UIImageOrientationUp || image.imageOrientation == UIImageOrientationDown) {
		bitmap = CGBitmapContextCreate(NULL, width, height, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, alphaInfo);
		
	} else {
		bitmap = CGBitmapContextCreate(NULL, height, width, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, alphaInfo);
		
	}
	
	if (image.imageOrientation == UIImageOrientationLeft) {
		//NSLog(@"image orientation left");
		CGContextRotateCTM (bitmap, radians(90));
		CGContextTranslateCTM (bitmap, 0, -height);
		
	} else if (image.imageOrientation == UIImageOrientationRight) {
		//NSLog(@"image orientation right");
		CGContextRotateCTM (bitmap, radians(-90));
		CGContextTranslateCTM (bitmap, -width, 0);
		
	} else if (image.imageOrientation == UIImageOrientationUp) {
		//NSLog(@"image orientation up");
		
	} else if (image.imageOrientation == UIImageOrientationDown) {
		//NSLog(@"image orientation down");
		CGContextTranslateCTM (bitmap, width,height);
		CGContextRotateCTM (bitmap, radians(-180.));
		
	}
	
	CGContextDrawImage(bitmap, CGRectMake(0, 0, width, height), imageRef);
	CGImageRef ref = CGBitmapContextCreateImage(bitmap);
	UIImage *result = [UIImage imageWithCGImage:ref];
	
	CGColorSpaceRelease(colorSpaceInfo);
	CGContextRelease(bitmap);
	CGImageRelease(ref);
	
	return result;
}

@end
