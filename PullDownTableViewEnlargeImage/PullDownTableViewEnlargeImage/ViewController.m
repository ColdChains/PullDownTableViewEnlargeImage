//
//  ViewController.m
//  PullDownTableViewEnlargeImage
//
//  Created by 冰凉的枷锁 on 2017/3/7.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

#import "ViewController.h"

#define NavigationBarHight 64.0f

#define ImageHight 200.0f

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIImageView *zoomImageView;//变焦图片做底层
    UIImageView *circleView;//类似头像的UIImageView
    UILabel *textLabel;//类似昵称UILabel
}

@property(nonatomic,strong)UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];//不能放init处
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    self.navigationItem.title = @"实现拖动列表时放大列表顶部的图片";
    
    //1.定义全局tableView
    
    //2.初始化_tableView
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    //3.设置代理，头文件也要包含 UITableViewDelegate,UITableViewDataSource
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //4.设置contentInset属性（上左下右 的值）
    self.tableView.contentInset = UIEdgeInsetsMake(ImageHight, 0, 0, 0);
    //5.添加_tableView
    [self.view addSubview:self.tableView];
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    zoomImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dingbubeijing"]];
    zoomImageView.frame = CGRectMake(0, -ImageHight, self.view.frame.size.width, ImageHight);
    
    //contentMode = UIViewContentModeScaleAspectFill时，高度改变宽度也跟着改变
    zoomImageView.contentMode = UIViewContentModeScaleAspectFill;//重点（不设置那将只会被纵向拉伸）
    
    [self.tableView addSubview:zoomImageView];
    
    //设置autoresizesSubviews让子类自动布局
    zoomImageView.autoresizesSubviews = YES;
    
    circleView = [[UIImageView alloc]initWithFrame:CGRectMake(10, ImageHight-50, 40, 40)];
    circleView.image = [UIImage imageNamed:@"head"];
    circleView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;//自动布局，自适应顶部
    [zoomImageView addSubview:circleView];
    
    textLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, ImageHight-40, 280, 20)];
    textLabel.textColor = [UIColor whiteColor];
    textLabel.text = @"namelabel";
    textLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;//自动布局，自适应顶部
    [zoomImageView addSubview:textLabel];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat y = scrollView.contentOffset.y;
    NSLog(@"%lf",y);
    //    +NavigationBarHight;//根据实际选择加不加上NavigationBarHight（44、64 或者没有导航条）
    if (y < -ImageHight) {
        CGRect frame = zoomImageView.frame;
        frame.origin.y = y;
        frame.size.height =  -y;//contentMode = UIViewContentModeScaleAspectFill时，高度改变宽度也跟着改变
        zoomImageView.frame = frame;
    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"这个自己命名"];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"这个自己命名"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.separatorInset=UIEdgeInsetsZero;
        cell.clipsToBounds = YES;
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"第 %ld 行",indexPath.row];
    
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
