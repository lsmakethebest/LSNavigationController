# LSNavigationBarTransition
导航栏背景色可以统一设置，每一个控制器导航栏背景色还可以自己设置不应影响统一设置的界面，边缘手势去除过渡动画

#将两个分类拖到项目里即可使用，轻松实现常用导航栏效果

#在UIViewController+LSNavigationBarTransition类里

-(void)ls_viewDidLoad
{
 
    [self ls_viewDidLoad];
       
    //此处设置全局状态栏背景 其他控制器想修改UINavigationBar背景色可以在viewDidLoad里修改,不会影响其他控制器UINavigationBar背景色
    [self.navigationController.navigationBar setBackgroundImage:[[UIColor colorWithRed:0.671 green:0.184 blue:1.000 alpha:1.000] imageWithColor] forBarMetrics:UIBarMetricsDefault];
    }

若有的界面需要单独设置，只需要在对应控制器viewDidLoad里设置即可，不会影响统一设置的界面

![image](https://github.com/lsmakethebest/LSNavigationBarTransition/blob/master/images/yanshi.gif)