//
//  ViewController.m
//  OCiDailyProject
//
//  Created by Hellen on 2019-01-28.
//  Copyright © 2019 Six. All rights reserved.
//

#import "ViewController.h"
#import "WebKit/WebKit.h"

@interface ViewController () {
    IBOutlet UISegmentedControl *colorChoice;
    IBOutlet UILabel *chosenColor;
    IBOutlet WKWebView *flowerView;

}

@end

@implementation ViewController

- (IBAction)getFlower:(id)sender {
    NSString *outputHtml;
    NSString *color;
    NSString *colorVal;
    int colorNum;
    colorNum = colorChoice.selectedSegmentIndex;
    
    switch (colorNum) {
        case 0:
            color = @"Red";
            colorVal = @"red";
            break;
        case 1:
            color = @"Blue";
            colorVal = @"blue";
            break;
        case 2:
            color = @"Yellow";
            colorVal = @"yellow";
            break;
        case 3:
            color = @"Green";
            colorVal = @"green";
            break;
        default:
            break;
    }
    
    chosenColor.text = [[NSString alloc] initWithFormat: @"%@", color];
    outputHtml = [[NSString alloc] initWithFormat:@"<body style='margin: 0px; padding: 0px'> <img height='1200' src='https://source.unsplash.com/user/erondu/1600x900'></body>", colorVal];
    [flowerView loadHTMLString:outputHtml baseURL:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


@end
