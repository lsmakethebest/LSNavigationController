# LSNavigationController

## 将文件拖到项目里，想要这种效果的导航控制器继承LSNavigationController
## 每个VC都有一个UINavigationBar,导航控制器的navigationBar被隐藏

## 使用此框架适用于frame从64开始算的项目
## 设置UINavigationBar,UIBarButtonItem 和系统使用方法一样
![image](https://github.com/lsmakethebest/LSNavigationController/blob/master/images/show.gif)

## 在UIViewController里设置 ，如果有基类直接在基类设置一遍就不用在设置了
`
- (void)viewDidLoad{

        [super viewDidLoad];
        [self reloadNavigationBar];//创建UINavigationBar 必须在设设置item前面 也可以在基类统一创建
        self.title=@"第一页";
        UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithTitle:@"push" style:(UIBarButtonItemStylePlain) target:self action:@selector(click)];
        self.navigationItem.rightBarButtonItem=item;
        [self.navigationBar setBackgroundImage:[self imageWithColor:[UIColor orangeColor]] forBarMetrics:UIBarMetricsDefault];
    }

`

## 禁用启用侧滑手势 在viewDidLoad里设置即可
`
@property (nonatomic,assign) BOOL cancelGesture; //取消当前页面手势 不影响其他VC手势使用
`
## 禁用启用所有界面侧滑手势
`self.navigationController.cancelGesture=YES;//禁用整个导航控制器手势 如果想在启用必须在设置为NO
`
## 如果想在当前view上添加一个全屏view覆盖navigationBar
``
    //设置要添加view的view.viewLevel即可 
    view.viewLevel=UIViewLevelHigh;
``








