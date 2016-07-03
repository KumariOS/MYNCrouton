//
//  MYNViewController.m
//  MYNCrouton
//
//  Created by Mario Stallone on 07/04/2016.
//  Copyright (c) 2016 Mario Stallone. All rights reserved.
//

#import "MYNViewController.h"
#import "MYNCrouton.h"

@interface MYNViewController ()

@end

@implementation MYNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [MYNCrouton
     ofType: MYNCroutonTypeInfo
     withMessage:@"App Delegate Test"
     buttonText:@"BLAH"
     textFont: [UIFont systemFontOfSize:14]
     buttonFont: [UIFont systemFontOfSize:14]
     onViewController:self
     onClick:^{
         NSLog(@"Hello");
     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end