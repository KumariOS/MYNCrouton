//
//  MYNCrouton.h
//  Myntra
//
//  Created by Mario Stallone on 29/06/16.
//  Copyright © 2016 Myntra Designs. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MYNCroutonActionBlock)(void);

/**
 *  Predefined Crouton Types
 */
typedef NS_OPTIONS(NSUInteger, MYNCroutonType) {
    /**
     *  An Alert Crouton presented with a red background and white text
     */
    MYNCroutonTypeAlert     = 0,
    /**
     *  An Info Crouton presented with a green background and white text
     */
    MYNCroutonTypeInfo      = 1,
    /**
     *  A Warn Crouton presented with a yellow background and white text
     */
    MYNCroutonTypeWarn      = 2
};

@interface MYNCrouton : UIView

@property (nonatomic, retain) IBOutlet UILabel *text;
@property (nonatomic, retain) IBOutlet UIButton *actionButton;
@property (nonatomic, retain) UISwipeGestureRecognizer *swipeGestureRecognizer;
@property (nonatomic, weak) MYNCroutonActionBlock onClickBlock;

/**
 *  Bring up an instance of MYNCrouton of a predefined type
 *
 *  @param type            Crouton Type - Alert, Info, Warn
 *  @param text            Crouton message
 *  @param buttonText      Crouton Action Button Text
 *  @param textFont        Text Font
 *  @param buttonFont      Button Font
 *  @param viewController  Present on thsi viewController
 *  @param onClick         Block to handle the onClick of the button
 */
+ (void)ofType:(MYNCroutonType)type
   withMessage:(NSString*)text
    buttonText:(NSString*)buttonText
      textFont:(UIFont*)textFont
    buttonFont:(UIFont*)buttonFont
    onViewController:(UIViewController*)viewController
       onClick:(void (^)(void))onClick;

/**
 *  Bring up an instance of MYNCrouton
 *
 *  @param text            Crouton message
 *  @param buttonText      Crouton Action Button Text
 *  @param backgroundColor Background Colur
 *  @param textColor       Text Color
 *  @param textFont        Text Font
 *  @param buttonFont      Button Font
 *  @param viewController  Present on thsi viewController
 *  @param onClick         Block to handle the onClick of the button
 */
+ (void)withMessage:(NSString*)text
         buttonText:(NSString*)buttonText
    backgroundColor:(UIColor*)color
          textColor:(UIColor*)textColor
           textFont:(UIFont*)textFont
         buttonFont:(UIFont*)buttonFont
   onViewController:(UIViewController*)viewController
            onClick:(void (^)(void))onClick;

@end