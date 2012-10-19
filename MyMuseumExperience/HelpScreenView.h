//
//  HelpScreenView.h
//  MyMuseumExperience
//
//  Created by Noel Feliciano on 2012-09-15.
//  Copyright (c) 2012 Noel Feliciano. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HelpScreenViewDelegate <NSObject>

-(void)closeHelpScreen;
-(void)helpButtonPressed:(id)sender;

@end

@interface HelpScreenView : UIView
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UIButton *adultButton;
@property (weak, nonatomic) IBOutlet UIButton *kidsButton;
@property (weak, nonatomic) IBOutlet UIButton *mapButton;
@property (nonatomic, assign) id <HelpScreenViewDelegate> delegate;

- (IBAction)buttonPressed:(id)sender;

@end
