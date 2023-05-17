//
//  ViewController.m
//  tccc-agent-ios-example
//
//  Created by gavinwjwang on 2023/5/17.
//

#import "CallingViewController.h"

@interface CallingViewController ()

@property (nonatomic, strong) UIButton *muteButton;
@property (nonatomic, strong) UIButton *hangupButton;
@property (nonatomic, strong) UIButton *speakerButton;

@end

@implementation CallingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 创建静音按钮
    self.muteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.muteButton.frame = CGRectMake(20, 100, 50, 50);
    [self.muteButton setTitle:@"静音" forState:UIControlStateNormal];
    [self.muteButton setImage:[UIImage imageNamed:@"mute"] forState:UIControlStateNormal];
    [self.muteButton addTarget:self action:@selector(muteButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.muteButton setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:self.muteButton];
    
    // 创建挂断按钮
    self.hangupButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.hangupButton.frame = CGRectMake(self.view.bounds.size.width - 70, 100, 50, 50);
    [self.hangupButton setTitle:@"挂断" forState:UIControlStateNormal];
    [self.hangupButton setImage:[UIImage imageNamed:@"hangup"] forState:UIControlStateNormal];
    [self.hangupButton addTarget:self action:@selector(hangupButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.hangupButton setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:self.hangupButton];
    
    // 创建扬声器按钮
    self.speakerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.speakerButton.frame = CGRectMake(self.view.bounds.size.width / 2 - 25, self.view.bounds.size.height - 100, 50, 50);
    [self.speakerButton setTitle:@"扬声器" forState:UIControlStateNormal];
    [self.speakerButton setImage:[UIImage imageNamed:@"speaker"] forState:UIControlStateNormal];
    [self.speakerButton addTarget:self action:@selector(speakerButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.speakerButton setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:self.speakerButton];
}

- (void)muteButtonTapped:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (void)hangupButtonTapped:(UIButton *)sender {
    // 停止音频通话并返回上一个界面
}

- (void)speakerButtonTapped:(UIButton *)sender {
    sender.selected = !sender.selected;
}

@end
