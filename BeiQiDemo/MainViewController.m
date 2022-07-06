//
//  ViewController.m
//  BeiQiDemo
//
//  Created by liu001 on 2022/7/4.
//

#import "MainViewController.h"

@interface MainViewController ()
@property (nonatomic, strong) UIButton *groupChatButton;
@property (nonatomic, strong) UIButton *singleChatButton;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.groupChatButton = [[UIButton alloc] init];
    self.groupChatButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [self.groupChatButton setTitle:@"groupChat" forState:UIControlStateNormal];
    [self.groupChatButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.groupChatButton.layer.cornerRadius = 50 * 0.5;
    self.groupChatButton.backgroundColor = UIColor.blueColor;
    [self.groupChatButton addTarget:self action:@selector(groupChatAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.singleChatButton = [[UIButton alloc] init];
    self.singleChatButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [self.singleChatButton setTitle:@"signleChat" forState:UIControlStateNormal];
    [self.singleChatButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.singleChatButton.layer.cornerRadius = 50 * 0.5;
    self.singleChatButton.backgroundColor = UIColor.blueColor;
    [self.singleChatButton addTarget:self action:@selector(singleChatAction) forControlEvents:UIControlEventTouchUpInside];

    
    [self.view addSubview:self.groupChatButton];
    [self.view addSubview:self.singleChatButton];

    
    [self.groupChatButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100.0);
        make.height.equalTo(@(50.0));
        make.left.equalTo(self.view).offset(50.0);
        make.right.equalTo(self.view).offset(-50.0);
    }];

    
    [self.singleChatButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.groupChatButton.mas_bottom).offset(20.0);
        make.height.equalTo(@(50.0));
        make.left.equalTo(self.view).offset(50.0);
        make.right.equalTo(self.view).offset(-50.0);
    }];

    
}


#pragma mark action
- (void)groupChatAction {
    EMConversationsViewController *vc = [[EMConversationsViewController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)singleChatAction {
    
}


@end
