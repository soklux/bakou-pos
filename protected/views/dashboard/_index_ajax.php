<?php
    $records=$report->saleDailyChart();
    $date = array();
    $amount = array();
    foreach($records as $record) 
    {
        $amount[] = floatval($record["amount"]);
        $date[] = $record["date"];
    }
?>
<div class="row summary_header">
    <div class="col-xs-12 widget-container-col">
        <div class="infobox infobox-green">
            <div class="infobox-icon">
                <i class="ace-icon fa fa-shopping-cart"></i>
            </div>
            <div class="infobox-data">
                <span class="infobox-data-number"><?php echo number_format($report->totalSale2Y(),
                        Yii::app()->shoppingCart->getDecimalPlace()); ?></span>

                <div class="infobox-content"><?php echo CHtml::link('Today\'s Sale',
                        Yii::app()->createUrl("report/SaleReportTab")); ?></div>
            </div>
        </div>

        <div class="infobox infobox-blue">
            <div class="infobox-icon">
                <i class="ace-icon fa fa-shopping-cart"></i>
            </div>

            <div class="infobox-data">
                <span class="infobox-data-number"><?php echo number_format($report->totalSale2D(),
                        Yii::app()->shoppingCart->getDecimalPlace()); ?></span>

                <div class="infobox-content">Total Sales</div>
            </div>
        </div>

        <div class="infobox infobox-blue">
            <div class="infobox-icon">
                <i class="ace-icon fa fa-users"></i>
            </div>
            <div class="infobox-data">
                <span class="infobox-data-number"><?php echo $report->countCustomer(); ?></span>

                <div class="infobox-content"><?php echo CHtml::link('Total Customers',
                        Yii::app()->createUrl("client/admin")); ?></div>
            </div>
        </div>

        <div class="infobox infobox-green">
            <div class="infobox-icon">
                <i class="ace-icon fa fa-user icon-animated-vertical"></i>
            </div>
            <div class="infobox-data">
                <span class="infobox-data-number"><?php echo $report->countCustReg2D(); ?></span>

                <div class="infobox-content"><?php echo CHtml::link('New Customer Today',
                        Yii::app()->createUrl("client/admin")); ?></div>
            </div>
        </div>

        <div class="infobox infobox-orange2">
            <div class="infobox-icon">
                <i class="ace-icon fa fa-square-o"></i>
            </div>
            <div class="infobox-data">
                <span class="infobox-data-number"><?php echo $report->outofStock(); ?></span>

                <div class="infobox-content"><?php echo CHtml::link(Yii::t('app;', 'Out of Stock'),
                        Yii::app()->createUrl("report/inventory", array('filter' => 'outstock'))); ?></div>
            </div>
        </div>

        <div class="infobox infobox-red">
            <div class="infobox-icon">
                <i class="ace-icon fa fa-minus-square icon-animated-bell""></i>
            </div>
            <div class="infobox-data">
                <span class="infobox-data-number"><?php echo -$report->negativeStock(); ?></span>

                <div class="infobox-content"><?php echo CHtml::link(Yii::t('app;', 'Negative Stock'),
                        Yii::app()->createUrl("report/inventory")); ?></div>
            </div>
        </div>

    </div>
</div>


