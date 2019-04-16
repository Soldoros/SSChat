//
//  MineAboutUsController.m
//  SSChat
//
//  Created by soldoros on 2019/4/14.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import "MineAboutUsController.h"

@interface MineAboutUsController ()

@end

@implementation MineAboutUsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavgaionTitle:@"关于我们"];
    
    // 38 206 178
    // 106 226 164
    for(int i=100;i<100 + SCREEN_Width;i++){
        double r1 = 106 - (i-100)*(106.0 - 30.0)/SCREEN_Width;
        double g1 = 226 -  (i-100)*(226.0- 200.0)/SCREEN_Width;
        double b1 = 164 -  (i-100)*(164.0 - 160.0)/SCREEN_Width;

        UIView *line = [UIView new];
        line.frame = makeRect(0, i, SCREEN_Width, 1);
        [self.view addSubview:line];
        line.backgroundColor =  makeColorRgb(r1, g1, b1);
    }
    
    
    NSArray *array = [UIFont familyNames];
    cout(array);
    
    
    UILabel *tl = [[UILabel alloc]init];
    tl.frame = makeRect(0, 110, SCREEN_Width, SCREEN_Width);
    tl.textColor = [UIColor whiteColor];
    [self.view addSubview:tl];
    tl.text = @"H";
    tl.font = [UIFont fontWithName:@"Snell Roundhand" size:305];
    tl.textAlignment = NSTextAlignmentLeft;
    tl.backgroundColor = [UIColor clearColor];
    
  
}

@end
