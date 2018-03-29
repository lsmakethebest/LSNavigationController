# LSNavigationController

## 将文件拖到项目里，想要这种效果的导航控制器继承LSNavigationController,将原来项目里的基类继承于LSViewController
## 每个VC都有一个UINavigationBar,导航控制器的navigationBar被隐藏


## 设置UINavigationBar,UIBarButtonItem 和系统使用方式一样
![image](https://github.com/lsmakethebest/LSNavigationController/blob/master/images/show.gif)

`
- (void)viewDidLoad{

        [super viewDidLoad];
        self.title=@"第一页";
        UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithTitle:@"push" style:(UIBarButtonItemStylePlain) target:self action:@selector(click)];
        self.navigationItem.rightBarButtonItem=item;
        [self.navigationBar setBackgroundImage:[self imageWithColor:[UIColor orangeColor]] forBarMetrics:UIBarMetricsDefault];
    }

`

## 设置侧滑手势
`
@property (nonatomic,assign) BOOL cancelGesture; //取消当前页面手势 不影响其他VC手势使用
`
`
@property (nonatomic,assign) BOOL cancelAllGesture;//取消整个导航控制器手势 如果想在启用必须在设置为NO
`

## 设置下列属性来设置frame.origin.y是从0还是64开始
`
       self.edgesForExtendedLayout=UIRectEdgeNone;//代表从64开始 top 从0开始
`
## 如果设置完想重载UINavigationBar
`
        [self reloadNavigationBar];
`



