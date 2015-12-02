//
//  ViewController.m
//  01- UITableView
//
//  Created by qingyun on 15/12/2.
//  Copyright (c) 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "ViewController.h"
#import "QYHero.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (nonatomic,strong) NSArray *heros;
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation ViewController
//声明一个重用的ID
static NSString *identifier = @"hero_cell";

#pragma mark -懒加载
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

#pragma mark -数据源方法
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
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor lightGrayColor];
    cell.selectedBackgroundView = bgView;

    //返回单元格
    return cell;
    
    
}

#pragma mark -点击确定取消的响应事件
//点击确定或取消的事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        //表示点击了确定
        //更新数据
        //1、获取用户文本框中的内容
        NSString *name = [alertView textFieldAtIndex:0].text;
        //2、找到对应的英雄模型
        QYHero *hero = self.heros[alertView.tag];
        
        //3、修改对应英雄的模型
        hero.name = name;
        //4、刷新界面
        //4.1、全部刷新
        //[_tableView reloadData];
        
        //刷新单个行
        NSIndexPath *idxPath = [NSIndexPath indexPathForRow:alertView.tag inSection:0];
        [_tableView reloadRowsAtIndexPaths:@[idxPath] withRowAnimation:UITableViewRowAnimationTop];
        
    }
}

#pragma mark -代理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取点击的单元格
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //将点击的单元格字体变色
    cell.textLabel.textColor = [UIColor yellowColor];
    //设置右边栏的形式
//    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    //创建一个弹出框对象
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"英雄名称" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    //获取当前被选中的这个英雄的名称
    QYHero *hero = self.heros[indexPath.row];
    alertView.tag = indexPath.row;
    
    //修改AlertView的样式显示出来一个文本框
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    //获取那个文本框，并设置文本框中的文字为herosname
    [alertView textFieldAtIndex:0].text = hero.name;
   
    [alertView show];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor blackColor];
//    cell.accessoryType = UITableViewCellAccessoryNone;
}

#pragma mark - 隐藏状态栏
-(BOOL)prefersStatusBarHidden
{
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    
    //设置数据源
    _tableView.dataSource = self;
    _tableView.delegate = self;
    //设置行高
    _tableView.rowHeight = 70;
    
    _tableView.allowsSelection = YES;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
