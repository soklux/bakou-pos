<?php
    $this->pageTitle = Yii::app()->name;
    $baseUrl = Yii::app()->theme->baseUrl;
    //$qty = Item::model()->stockItemDash();
     
?>
<div id="navbar" class="navbar navbar-default">
    <script type="text/javascript">
            try{ace.settings.check('navbar' , 'fixed')}catch(e){}
    </script>

    <div class="navbar-container" id="navbar-container">
            <!-- #section:basics/sidebar.mobile.toggle -->
            <button type="button" class="navbar-toggle menu-toggler pull-left" id="menu-toggler">
                    <span class="sr-only">Toggle sidebar</span>

                    <span class="icon-bar"></span>

                    <span class="icon-bar"></span>

                    <span class="icon-bar"></span>
            </button>

            <!-- /section:basics/sidebar.mobile.toggle -->
            <div class="navbar-header pull-left">
                    <!-- #section:basics/navbar.layout.brand -->
                    <a href="#" class="navbar-brand">
                        <small>
                                <i class="fa fa-leaf"></i>
                                Ezy Tool
                        </small>
                    </a>
                    <!-- /section:basics/navbar.layout.brand -->

            </div>

            <!-- #section:basics/navbar.dropdown -->
            <div class="navbar-buttons navbar-header pull-right" role="navigation">
                    <ul class="nav ace-nav">       
                        
                        <!--
                        <li class="purple">
                                <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                                        <i class="ace-icon fa fa-bell icon-animated-bell"></i>
                                        <span class="badge badge-important"><?php //echo number_format($qty[4],0); ?></span>
                                </a>
                            
                                <ul class="dropdown-menu-right dropdown-navbar navbar-pink dropdown-menu dropdown-caret dropdown-close">
                                        <li class="dropdown-header">
                                                <i class="ace-icon fa fa-exclamation-triangle"></i>
                                                8 Items to Count
                                        </li>

                                        <li class="dropdown-content">
                                                <ul class="dropdown-menu dropdown-navbar navbar-pink">
                                                        <li>
                                                            <a href="<?php //echo Yii::app()->urlManager->createUrl('report/StockCount') ?>">
                                                                <div class="clearfix">
                                                                    <span class="pull-left">
                                                                        <i class="btn btn-xs no-hover btn-pink fa fa-calendar"></i>
                                                                        Daily
                                                                    </span>
                                                                    <span class="pull-right badge badge-pink"><?php //echo number_format($qty[0],0); ?></span>
                                                                </div>
                                                            </a>
                                                        </li>
                                                        <li>
                                                            <a href="<?php //echo Yii::app()->urlManager->createUrl('report/StockCount') ?>">
                                                                <div class="clearfix">
                                                                    <span class="pull-left">
                                                                            <i class="btn btn-xs no-hover btn-warning fa fa-calendar"></i>
                                                                            Weekly
                                                                    </span>
                                                                    <span class="pull-right badge badge-warning"><?php //echo number_format($qty[1],0); ?></span>
                                                                </div>
                                                            </a>
                                                        </li>
                                                        <li>
                                                            <a href="<?php //echo Yii::app()->urlManager->createUrl('report/StockCount') ?>">
                                                                <div class="clearfix">
                                                                    <span class="pull-left">
                                                                            <i class="btn btn-xs no-hover btn-info fa fa-calendar"></i>
                                                                            Bi-Weekly
                                                                    </span>
                                                                    <span class="pull-right badge badge-info"><?php //echo number_format($qty[2],0); ?></span>
                                                                </div>
                                                            </a>
                                                        </li>
                                                        <li>
                                                            <a href="<?php //echo Yii::app()->urlManager->createUrl('report/StockCount') ?>">
                                                                <div class="clearfix">
                                                                    <span class="pull-left">
                                                                            <i class="btn btn-xs no-hover btn-primary fa fa-calendar"></i>
                                                                            Monthly
                                                                    </span>
                                                                    <span class="pull-right badge badge-primary"><?php //echo number_format($qty[3],0); ?></span>
                                                                </div>
                                                            </a>
                                                        </li>
                                                </ul>
                                        </li>

                                        <li class="dropdown-footer">
                                                <a href="#">
                                                        See Detail
                                                        <i class="ace-icon fa fa-arrow-right"></i>
                                                </a>
                                        </li>
                                </ul>
                        </li>
                        -->
                        
                        <li class="white">
                            <a href="<?php echo Yii::app()->createUrl('site/logout'); ?>">
                                <i class="ace-icon fa fa-power-off"></i>
                                Logout
                            </a>
                        </li>
                        
                        <li class="light-blue">
                            <a>
                                <i class="glyphicon glyphicon-time"></i>
                                <?php  echo date("H:i j M Y"); ?>
                            </a>
                        </li>
                       
                        <li class="light-blue">
                                <a data-toggle="dropdown" href="#" class="dropdown-toggle">
                                    <!-- <img class="nav-user-photo" alt="Jasos Photo" src="<?php //echo Yii::app()->theme->baseUrl . '/avatars/user.jpg'; ?>" /> -->
                                    <span class="user-info">
                                            <small>Welcome,</small>
                                            <?php echo CHtml::encode(ucwords(Yii::app()->user->name)); ?>
                                    </span>
                                    <i class="ace-icon fa fa-caret-down"></i>
                                </a>

                                <ul class="user-menu dropdown-menu-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
                                    <!--
                                    <li>
                                        <a href="<?php //echo Yii::app()->urlManager->createUrl('Employee/View', array('id' => Yii::app()->session['employeeid'])); ?>">
                                                <i class="ace-icon fa fa-user"></i>
                                                Profile
                                        </a>
                                    </li>
                                    -->
                                    <li>
                                        <a href="<?php echo Yii::app()->urlManager->createUrl('RbacUser/Update', array('id' => Yii::app()->user->id)); ?>">
                                                <i class="ace-icon fa fa-key"></i>
                                                Change Password
                                        </a>
                                    </li>

                                    <!--    
                                    <li class="divider"></li>
                                        
                                    <li>
                                        <a href="<?php //echo Yii::app()->createUrl('site/logout'); ?>">
                                            <i class="ace-icon fa fa-power-off"></i>
                                            Logout
                                        </a>
                                    </li>
                                    -->
                                </ul>
                        </li>

                            <!-- /section:basics/navbar.user_menu -->
                    </ul>
            </div>

            <!-- /section:basics/navbar.dropdown -->
    </div><!-- /.navbar-container -->
</div>