//
//  ViewController.m
//  01- UITableView
//
//  Created by qingyun on 15/12/2.
//  Copyright (c) 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "ViewController.h"
#import "QYHero.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSArray *heros;
@end

@implementation ViewController
//声明一个重用的ID
static NSString *identifier = @"hero_cell";

- (NSArray *)heros
{
    if (_heros == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"heros" ofType:@"plist"];
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *models = [NSMutableArray array];
        
        for (NSDictionary *dict in arrayDict) {
            QYHero *model = [QYHero heroWithDict:dict];
            [models addObject:model];
        }
        _heros = models;
    }
    return _heros;
}

//每组的有多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.heros.count;
}

//
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取数据模型
    QYHero *model = self.heros[indexPath.row];
    //创建单元格
//    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];

    //单元格的重用
    //1、在创建单元格的时候要指定一个重用ID
    //2、当需要一个新的单元格的时候，会先去“缓存池”中根据重用ID去查找是否有可用的单元格
    //**如果有则直接取出进行使用
    //**如果没有就在创建一个新的单元格
    
    

    
    //根据这个ID去缓存池中查找对应的cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    //判断，是否有可用的单元格 没有就在创建一个
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    //把数据模型设置给单元格
    cell.imageView.image = [UIImage imageNamed:model.icon];
    cell.textLabel.text = model.name;
    cell.detailTextLabel.text = model.desc;
    
    cell.accessoryType = UITableViewCellAccessoryDetailButton;
    
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor yellowColor];
    cell.selectedBackgroundView = bgView;
    
    
    //输出当前单元格的行索引
    NSLog(@"%p----行索引:%ld",cell,indexPath.row);
    //返回单元格
    return cell;
    
    
}

#pragma mark -代理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取点击的单元格
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //将点击的单元格字体变色
    cell.textLabel.textColor = [UIColor yellowColor];
    //设置右边栏的形式
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor redColor];
    cell.accessoryType = UITableViewCellAccessoryNone;
}

#pragma mark - 隐藏状态栏
-(BOOL)prefersStatusBarHidden
{
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    
    //设置数据源
    tableView.dataSource = self;
    
    //设置行高
    tableView.rowHeight = 70;
    
    tableView.allowsSelection = YES;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
