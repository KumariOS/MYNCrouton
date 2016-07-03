//
//  MYNCrouton.m
//  Myntra
//
//  Created by Mario Stallone on 29/06/16.
//  Copyright © 2016 Myntra Designs. All rights reserved.
//

#import "MYNCrouton.h"

// App Constants
#define kCroutonHeight 49
#define kTextHeight 40
#define kActionButtonWidth 40
#define kTextMargin 10
#define kEntryAnimationDuration 1
#define kExitAnimationDuration 0.5
#define kEntryAnimationDelay 1
#define kExitAnimationDelay 0
#define kSpringDamping 0.5
#define kSpringInitialVelocity 0.5

@implementation MYNCrouton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        float center = (self.frame.size.height - kTextHeight)/2;
        self.text = [[UILabel alloc]
                     initWithFrame:CGRectMake(
                                              kTextMargin,
                                              center,
                                              self.frame.size.width * .7,
                                              kTextHeight)
                     ];
        self.actionButton = [[UIButton alloc]
                             initWithFrame:CGRectMake(
                                                      (self.frame.size.width - (kActionButtonWidth + kTextMargin)),
                                                      center,
                                                      kActionButtonWidth,
                                                      kTextHeight)
                             ];
        [self.actionButton addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.text];
        [self addSubview:self.actionButton];
        self.swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swiped:)];
        [self addGestureRecognizer:self.swipeGestureRecognizer];
    }
    return self;
}

+(void)ofType:(MYNCroutonType)type withMessage:(NSString *)text buttonText:(NSString *)buttonText textFont:(UIFont *)textFont buttonFont:(UIFont *)buttonFont onViewController:(UIViewController *)viewController onClick:(void (^)(void))onClick {
    UIColor *backgroundColor = nil;
    UIColor *textColor = nil;
    
    switch (type) {
        case MYNCroutonTypeAlert:
            backgroundColor = [UIColor redColor];
            textColor = [UIColor whiteColor];
            break;
        
        case MYNCroutonTypeInfo:
            backgroundColor = [UIColor colorWithRed:0.310 green:0.816 blue:0.478 alpha:1.00];
            textColor = [UIColor whiteColor];
            break;
        
        case MYNCroutonTypeWarn:
            backgroundColor = [UIColor colorWithRed:0.929 green:0.792 blue:0.078 alpha:1.00];
            textColor = [UIColor whiteColor];
            break;
            
        default:
            break;
    }
    [MYNCrouton withMessage:text buttonText:buttonText backgroundColor:backgroundColor textColor:textColor textFont:textFont buttonFont:buttonFont onViewController:viewController onClick:onClick];
}

+ (void)withMessage:(NSString*)text
         buttonText:(NSString*)buttonText
    backgroundColor:(UIColor*)backgroundColor
          textColor:(UIColor*)textColor
           textFont:(UIFont*)textFont
         buttonFont:(UIFont*)buttonFont
   onViewController:(UIViewController*)viewController
            onClick:(MYNCroutonActionBlock)onClick {
    
    // View Setup
    UIView *view = viewController.view;
    float heightDelta = 0;
    if ([viewController isKindOfClass:[UITabBarController class]]) {
        heightDelta = ((UITabBarController*)viewController).tabBar.frame.size.height;
    }
    //MYNCrouton *crouton = [[[NSBundle mainBundle] loadNibNamed:@"MYNCrouton" owner:self options:nil] firstObject];
    
    MYNCrouton *crouton = [[MYNCrouton alloc] initWithFrame:CGRectMake(0, view.frame.size.height, view.frame.size.width, kCroutonHeight)];
    
    crouton.text.text = text;
    [crouton.actionButton setTitle:buttonText forState:UIControlStateNormal];
    CGRect frame = crouton.frame;
    frame.origin.y = view.frame.size.height;
    [crouton setFrame:frame];
    [crouton setAlpha:0.0];
    crouton.backgroundColor = backgroundColor;
    [crouton.text setTextColor:textColor];
    [crouton.actionButton setTitleColor:textColor forState:UIControlStateNormal];
    crouton.text.font = textFont;
    crouton.actionButton.titleLabel.font = buttonFont;
    
    // SwipeGesutre Recognizer Config
    crouton.swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    crouton.swipeGestureRecognizer.numberOfTouchesRequired = 1;
    
    // Add Crouton to view
    [view addSubview:crouton];
    
    // Click Handler
    crouton.onClickBlock = onClick;
    
    // Animate Entry
    [UIView
     animateWithDuration:kEntryAnimationDuration
     delay:kEntryAnimationDelay
     usingSpringWithDamping:kSpringDamping
     initialSpringVelocity:kSpringInitialVelocity
     options:UIViewAnimationOptionCurveEaseIn
     animations:^{
        CGRect frame = crouton.frame;
        frame = crouton.frame;
        frame.origin.y = frame.origin.y - (frame.size.height + heightDelta);
        [crouton setFrame:frame];
        [crouton setAlpha:1.0];
    } completion:nil];
}

/**
 *  Swipe Gesture Recognizer
 *
 *  @param recognizer Gesture Recognizer instance
 */
- (IBAction)swiped:(UISwipeGestureRecognizer *)recognizer {
    // Animate exit
    [UIView
     animateWithDuration:kExitAnimationDuration
     delay:kExitAnimationDelay
     usingSpringWithDamping:kSpringDamping
     initialSpringVelocity:kSpringInitialVelocity
     options:UIViewAnimationOptionCurveEaseOut
     animations:^{
        CGRect frame = self.frame;
        frame.origin.x = frame.origin.x + frame.size.width;
        [self setFrame:frame];
        [self setAlpha:0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

/**
 *  Button onClick Handler
 *
 *  @param sender Click sener
 */
-(void)clickAction:(id)sender {
    if (self.onClickBlock != nil) {
        self.onClickBlock();
    }
}

@end
