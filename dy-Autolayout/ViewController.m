//
//  ViewController.m
//  dy-Autolayout
//
//  Created by jzb_iOS on 15/6/9.
//  Copyright (c) 2015年 jzb_iOS. All rights reserved.
//

#import "ViewController.h"
#import "userObject.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)userObject * userInfo;

@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary * userdic  = @{@"1":@"11",@"2":@"22"};
    _userInfo = [userObject shareInstance];
    [_userInfo setUserInfoDictionaryWithDictionary:userdic];
    
    

    // Do any additional setup after loading the view, typically from a nib.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"reuseBall" forIndexPath:indexPath];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
