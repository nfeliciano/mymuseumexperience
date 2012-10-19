//
//  HelpScreenView.m
//  MyMuseumExperience
//
//  Created by Noel Feliciano on 2012-09-15.
//  Copyright (c) 2012 Noel Feliciano. All rights reserved.
//

#import "HelpScreenView.h"

@implementation HelpScreenView
@synthesize closeButton;
@synthesize adultButton;
@synthesize kidsButton;
@synthesize mapButton;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSArray* topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"HelpScreenView" owner:nil options:nil];
        for(id currentObject in topLevelObjects)
        {
            if ([currentObject isKindOfClass:[HelpScreenView class]])
            {
                self = currentObject;
                break;
            }
        }
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)buttonPressed:(id)sender {
    if (sender == closeButton) {
        [self.delegate closeHelpScreen];
    } else if (sender == adultButton || sender == kidsButton || sender == mapButton) {
        [self.delegate helpButtonPressed:sender];
    }
}
@end
