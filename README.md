# LSNavigationBarTransition
##导航栏背景色可以统一设置，每一个控制器导航栏背景色还可以自己单独设置不影响统一设置的界面，采用自定义交互动画实现淘宝，京东等软件当下最流行的导航控制器效果，比其他实现方式每一个控制器都包装一个导航控制器性能更好，使用方法更贴合系统使用方法

#将文件拖到项目里想要这种效果的导航控制器继承LSNavigationController即可使用常用导航栏效果，没有继承它的导航控制器就是默认效果，不会因为分类受到影响

#在UIViewController+LSNavigationBarTransition类里


##若有的界面需要单独设置，只需要在对应控制器viewDidLoad里设置即可，不会影响统一设置的界面**

-(void)ls_viewDidLoad
{
     
     [self ls_viewDidLoad];
     //此处设置全局状态栏背景 其他控制器想修改UINavigationBar背景色可以在viewDidLoad里修改,不会影响其他控制器UINavigationBar背景色
    [self.navigationController.navigationBar setBackgroundImage:[[UIColor colorWithRed:0.671 green:0.184 blue:1.000 alpha:1.000] imageWithColor] forBarMetrics:UIBarMetricsDefault];
 
}

###如果想要关闭全屏右滑而是边缘滑动 则设置导航控制器的fullScreenGesture为NO即可，默认为YES

![image](https://github.com/lsmakethebest/LSNavigationBarTransition/blob/master/images/show.gif)