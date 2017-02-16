# LSNavigationController


#将文件拖到项目里想要这种效果的导航控制器继承LSNavigationController即可使用常用导航栏效果


![image](https://github.com/lsmakethebest/LSNavigationBarTransition/blob/master/images/show.gif)

#1.没有设置VC2.ls_normalPush
######结构如下:Nav->(VC.Nav1.VC1)->(VC.Nav2.VC2)->(VC.Nav3.VC3)->(VC.Nav4.VC4)

###(1)popToRootViewControllerAnimated
#####在VC4里调用,其实是pop到VC1

###(2) popViewControllerAnimated
#####正常调用即可

###(3)popToViewController
#####如果要显示VC2 
######VC2=self.ls_topNavigationController.viewControllers[1]
######在VC4里调用  [self.navigationController popToViewController:VC2 animated:YES];

#2.设置了 VC2.ls_normalPush=YES
######结构如下:Nav->(VC.Nav1.VC1)->(VC.Nav2.VC2)->VC3->VC4-VC5->VC6

##(1)popToRootViewControllerAnimated
######VC6里调用,其实是pop到VC2

###(2)popViewControllerAnimated
######VC6调用会pop到VC5
######VC2调用会pop到VC1

###(3)popToViewController
#####如果要显示VC3 
######VC3=self.navigationController.viewControllers[1]
######在VC6里调用  [self.navigationController popToViewController:VC3 animated:YES];

####如果要显示VC1 
######VC1=self.ls_topNavigationController.viewControllers[0]
######在VC6里调用  [self.navigationController popToViewController:VC1 animated:YES];
