<?php $this->widget('EExcelView', array(
    'id' => 'outstanding-invoice-grid',
    'fixedHeader' => true,
    'responsiveTable' => true,
    'type' => TbHtml::GRID_TYPE_BORDERED,
    'dataProvider' => $report->oustandingInvoice(),
    //'filter'=>$filtersForm,
    /*'summaryText' => '<p class="text-info" align="left">' . Yii::t('app', 'Sales Summary') . Yii::t('app',
            'From') . ':  ' . $from_date . '  ' . Yii::t('app', 'To') . ':  ' . $to_date . '</p>',*/
    'template' => "{summary}\n{items}\n{exportbuttons}\n{pager}",
    'columns' => array(
        array(
            'name' => 'client_name',
            'header' => Yii::t('app', 'Client'),
            'value' => '$data["client_name"]',
        ),
        array(
            'name' => 'invoices',
            'header' => Yii::t('app', 'Num of Invoices'),
            'value' => '$data["invoices"]',
            //'value' => 'number_format($data["quantity"],Yii::app()->shoppingCart->getDecimalPlace(), ".", ",")',
            'htmlOptions' => array('style' => 'text-align: right;'),
            'headerHtmlOptions' => array('style' => 'text-align: right;'),
        ),
        array(
            'name' => 'balance',
            'header' => Yii::t('app', 'Outstanding Balance'),
            'value' => 'number_format($data["balance"],Yii::app()->shoppingCart->getDecimalPlace(), ".", ",")',
            'htmlOptions' => array('style' => 'text-align: right;'),
            'headerHtmlOptions' => array('style' => 'text-align: right;'),
        ),
        array(
            'name' => 'last_payment',
            'header' => Yii::t('app', 'Last Payment'),
            'value' => '$data["last_payment"]',
            'htmlOptions' => array('style' => 'text-align: right;'),
            'headerHtmlOptions' => array('style' => 'text-align: right;'),
        ),
        array(
            'name' => 'days',
            'header' => Yii::t('app', 'Last Payment # Days'),
            'value' => '$data["days"]',
            'htmlOptions' => array('style' => 'text-align: right;'),
            'headerHtmlOptions' => array('style' => 'text-align: right;'),
        ),
    ),
)); ?>