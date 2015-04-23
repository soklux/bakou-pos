<?php
/* @var $this SiteController */

$this->pageTitle=Yii::app()->name;
$baseUrl = Yii::app()->theme->baseUrl; 
?>
<?php
list($count_12, $qty_12)=$report->itemExpiryCount(12);
list($count_6, $qty_6)=$report->itemExpiryCount(6);
list($count_5, $qty_5)=$report->itemExpiryCount(5);
list($count_4, $qty_4)=$report->itemExpiryCount(4);
list($count_3, $qty_3)=$report->itemExpiryCount(3);
list($count_2, $qty_2)=$report->itemExpiryCount(2);
list($count_1, $qty_1)=$report->itemExpiryCount(1);
?>

<div class="row-fluid">

<div class="span3">
        <div class="sidebar-nav">
            <?php 
                $this->widget('zii.widgets.CMenu', array(
                  'encodeLabel'=>false,
                  'items'=>array(
                          array('label'=>'<i class="icon icon-envelope"></i> 1 Year to Expire <span class="badge badge-info pull-right">' . $count_12 . ' item(s) = '. $qty_12 .' pcs</span>', 'url'=>array('/report/reporttab'),'itemOptions'=>array('class'=>'')),
                          array('label'=>'<i class="icon icon-envelope"></i> 6 Months to Expire <span class="badge badge-info pull-right">'. $count_6 . ' item(s) = '. $qty_6 .' pcs</span>', 'url'=>array('/report/reporttab')),
                          array('label'=>'<i class="icon icon-envelope"></i> 5 Months to Expire <span class="badge badge-success pull-right">'. $count_5 . ' item(s) = '. $qty_5 .' pcs</span>', 'url'=>array('/report/reporttab')),
                          array('label'=>'<i class="icon icon-envelope"></i> 4 Months to Expire <span class="badge badge-success pull-right">'. $count_4 . ' item(s) = '. $qty_4 .' pcs</span>', 'url'=>array('/report/reporttab')),
                          array('label'=>'<i class="icon icon-envelope"></i> 3 Months to Expire <span class="badge badge-important pull-right">'. $count_3 . ' item(s) = '. $qty_3 .' pcs</span>', 'url'=>array('/report/reporttab')),
                          array('label'=>'<i class="icon icon-envelope"></i> 2 Months to Expire <span class="badge badge-important pull-right">'. $count_2 . ' item(s) = '. $qty_2 .' pcs</span>', 'url'=>array('/report/reporttab')),
                          array('label'=>'<i class="icon icon-envelope"></i> 1 Month to Expire <span class="badge badge-important pull-right">'. $count_1 . ' item(s) = '. $qty_1 .' pcs</span>', 'url'=>array('/report/reporttab')),
                          // Include the operations menu
                          array('label'=>'OPERATIONS','items'=>$this->menu),
                  ),
                )); 
            ?>
        </div>  	
</div><!--/span3-->

<div class="span9">
        <!--
        <div class="row-fluid">
          <div class="span3 ">
                <div class="stat-block">
                  <ul>
                        <li class="stat-graph inlinebar" id="weekly-visit">8,4,6,5,9,10</li>
                        <li class="stat-count"><span>$23,000</span><span>Weekly Sales</span></li>
                        <li class="stat-percent"><span class="text-success stat-percent">20%</span></li>
                  </ul>
                </div>
          </div>
          <div class="span3 ">
                <div class="stat-block">
                  <ul>
                        <li class="stat-graph inlinebar" id="new-visits">2,4,9,1,5,7,6</li>
                        <li class="stat-count"><span>$123,780</span><span>Monthly Sales</span></li>
                        <li class="stat-percent"><span class="text-error stat-percent">-15%</span></li>
                  </ul>
                </div>
          </div>
          <div class="span3 ">
                <div class="stat-block">
                  <ul>
                        <li class="stat-graph inlinebar" id="unique-visits">200,300,500</li>
                        <li class="stat-count"><span>$12,456</span><span>Open Invoices</span></li>
                        <li class="stat-percent"><span class="text-success stat-percent">10%</span></li>
                  </ul>
                </div>
          </div>
          <div class="span3 ">
                <div class="stat-block">
                  <ul>
                        <li class="stat-graph inlinebar" id="">100,300,600</li>
                        <li class="stat-count"><span>$25,000</span><span>Overdue</span></li>
                        <li class="stat-percent"><span><span class="text-success stat-percent">20%</span></li>
                  </ul>
                </div>
          </div>
        </div>
        -->
        
        <div class="row-fluid">
                <div class="span6">
                    <?php $this->widget('yiiwheels.widgets.grid.WhGridView',array(
                          'id'=>'top-product-grid-qty',
                          'fixedHeader' => true,
                          'responsiveTable' => true,
                          'type'=>TbHtml::GRID_TYPE_BORDERED,
                          'dataProvider'=>$report->dashtopProduct(),
                          'summaryText' =>'<p class="text-info" align="left">' . Yii::t('app','This Year Top 10 Products ') . Yii::t('app','Ranked by QUANTITY') .'</p>', 
                          'columns'=>array(
                                  array('name'=>'rank',
                                        'header'=>Yii::t('app','Rank'),
                                        'value'=>'$data["rank"]',
                                  ),
                                  array('name'=>'item_name',
                                        'header'=>Yii::t('app','Item Name'),  
                                        'value'=>'$data["item_name"]',
                                  ),
                                  array('name'=>'qty',
                                        'header'=>Yii::t('app','Quantity'),  
                                        'value'=>'$data["qty"]',
                                        //'footer'=>$report->paymentTotalQty() ,
                                  ),
                                  array('name'=>'amount',
                                        'header'=>Yii::t('app','Amount'),  
                                        'value'=>'$data["amount"]',
                                        //'footer'=>Yii::app()->getNumberFormatter()->formatCurrency($report->paymentTotalAmount(),'USD'),
                                  ),
                          ),
                    )); ?>
                </div><!--/span-->
                <div class="span6">
                         <?php $this->widget('yiiwheels.widgets.grid.WhGridView',array(
                                'id'=>'top-product-grid-amount',
                                'fixedHeader' => true,
                                'responsiveTable' => true,
                                'type'=>TbHtml::GRID_TYPE_BORDERED,
                                'dataProvider'=>$report->dashtopProductbyAmount(),
                                'summaryText' =>'<p class="text-info" align="left">' . Yii::t('app','This Year Top 10 Products ') . Yii::t('app','Ranked by AMOUNT') .'</p>', 
                                'columns'=>array(
                                        array('name'=>'rank',
                                              'header'=>Yii::t('app','Rank'),
                                              'value'=>'$data["rank"]',
                                        ),
                                        array('name'=>'item_name',
                                              'header'=>Yii::t('app','Item Name'),  
                                              'value'=>'$data["item_name"]',
                                        ),
                                        array('name'=>'qty',
                                              'header'=>Yii::t('app','Quantity'),  
                                              'value'=>'$data["qty"]',
                                              //'footer'=>$report->paymentTotalQty() ,
                                        ),
                                        array('name'=>'amount',
                                              'header'=>Yii::t('app','Amount'),  
                                              'value'=>'$data["amount"]',
                                              //'footer'=>Yii::app()->getNumberFormatter()->formatCurrency($report->paymentTotalAmount(),'USD'),
                                        ),
                                ),
                          )); ?>

                </div><!--/span-->
        </div><!--/row-->

        <div class="row-fluid">
                <div class="span6">
                  <?php
                        $this->beginWidget('zii.widgets.CPortlet', array(
                                'title'=>'<span class="icon-th-large"></span>Income Chart',
                                'titleCssClass'=>''
                        ));
                        ?>

                <div class="visitors-chart" style="height: 230px;width:100%;margin-top:15px; margin-bottom:15px;"></div>

                <?php $this->endWidget(); ?>
                </div><!--/span-->
            <div class="span6">
                <?php
                        $this->beginWidget('zii.widgets.CPortlet', array(
                                'title'=>'<span class="icon-th-list"></span> Sale Chart',
                                'titleCssClass'=>''
                        ));
                        ?>

                <div class="pieStats" style="height: 230px;width:100%;margin-top:15px; margin-bottom:15px;"></div>

                <?php $this->endWidget(); ?>
            </div>
        </div><!--/row-->

</div>
          
</div>
