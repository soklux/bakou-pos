<style>
.btn-group {
  display: flex !important;
}
</style>

<?php
$this->breadcrumbs=array(
	Yii::t('menu','Customer')=>array('admin'),
	Yii::t('app','Manage'),
);
?>
<div class="row" id="client_cart">
    <div class="col-xs-12 widget-container-col ui-sortable  ">
        <?php
        Yii::app()->clientScript->registerScript('search', "
        $('.search-button').click(function(){
                $('.search-form').toggle();
                return false;
        });
        $('.search-form form').submit(function(){
                $.fn.yiiGridView.update('client-grid', {
                        data: $(this).serialize()
                });
                return false;
        });
        ");
        ?>
           
        <?php if( Yii::app()->user->hasFlash('warning') || Yii::app()->user->hasFlash('success') ):?>
            <?php $this->widget('bootstrap.widgets.TbAlert'); ?>
        <?php endif; ?> 

        <?php $box = $this->beginWidget('yiiwheels.widgets.box.WhBox', array(
                      'title' => Yii::t( 'app', 'List of Customers' ),
                      'headerIcon' => 'ace-icon fa fa-user',
                      'htmlHeaderOptions'=>array('class'=>'widget-header-flat widget-header-small'),
        ));?> 
        
        
        <?php echo TbHtml::linkButton(Yii::t('app','Search'),array('class'=>'search-button btn','size'=>TbHtml::BUTTON_SIZE_SMALL,'icon'=>'ace-icon fa fa-search',)); ?>
        <div class="search-form" style="display:none">
            <?php $this->renderPartial('_search',array(
                    'model'=>$model,
            )); ?>
        </div><!-- search-form -->
        
        
        <?php if ( Yii::app()->user->checkAccess('item.create') ) { ?>
            <?php echo TbHtml::linkButton(Yii::t( 'app', 'Add New' ),array(
                    'color'=>TbHtml::BUTTON_COLOR_PRIMARY,
                    'size'=>TbHtml::BUTTON_SIZE_SMALL,
                    'icon'=>'glyphicon-plus white',
                    'url'=>$this->createUrl('create'),
            )); ?>
        <?php } ?>

        <?php /* echo TbHtml::linkButton(Yii::t( 'app', 'Quick Payment' ),array(
                'color'=>TbHtml::BUTTON_COLOR_PRIMARY,
                'size'=>TbHtml::BUTTON_SIZE_SMALL,
                'icon'=>'fa fa-icon fa-credit-card',
                'url'=>$this->createUrl('clientItem/index'),
        )); */ ?>
               
        <?php $this->widget('yiiwheels.widgets.grid.WhGridView',array(
                'id'=>'client-grid',
                'fixedHeader' => true,
                'type' => TbHtml::GRID_TYPE_HOVER,
                //'headerOffset' => 40,
                //'responsiveTable' => true,
                'htmlOptions'=>array('class'=>'table-responsive panel'),
                'dataProvider'=>$model->search($client_id),
                'columns'=>array(
                        /*
                        array(
                            'id'=>'selectedIds',
                            'class'=>'CCheckBoxColumn',
                            'selectableRows' => '1',   
                        ),
                         * 
                        */
                        /*
                        array(
                            'class' => 'yiiwheels.widgets.grid.WhRelationalColumn',
                            //'name' => 'sale_id',
                            //'header'=>Yii::t('app','+'),
                            'url' => $this->createUrl('SalePayment/PaymentDetail'),
                            'value' => '$data->first_name',
                        ),
                         * 
                        */
                        array(
                            'name' => 'first_name',
                            'value' => 'CHtml::link($data->first_name, Yii::app()->createUrl("client/update",array("id"=>$data->primaryKey)))',
                            'type'  => 'raw',   
                        ),
                        'last_name',
                        'mobile_no',
                        'address1',
                        array('name' =>'balance',
                              'header'=>'Balance',
                              'value' =>array($this,"gridBalance"),
                        ),
                        array('class'=>'bootstrap.widgets.TbButtonColumn',
                              'template'=>'<div class="btn-group">{delete}{undeleted}{update}</div>', 
                              'htmlOptions'=>array('class'=>'nowrap'),
                              'buttons' => array(  
                                  'delete' => array(
                                        'url'=>'Yii::app()->createUrl("client/delete/",array("id"=>$data->id))',
                                        'options' => array(
                                            'class'=>'btn btn-xs btn-danger',
                                        ),
                                        'visible'=>'$data->status=="1" && Yii::app()->user->checkAccess("client.delete")',
                                  ),
                                  'undeleted' => array(
                                        'label'=>Yii::t('app','UnDelete'),
                                        'url'=>'Yii::app()->createUrl("client/undodelete", array("id"=>$data->id))',
                                        'icon'=>'bigger-120 glyphicon-refresh',
                                        'options' => array(
                                            'class'=>'btn btn-xs btn-warning btn-undodelete',
                                        ), 
                                        'visible'=>'$data->status=="0" && Yii::app()->user->checkAccess("client.delete")',
                                  ),
                                  'update' => array(
                                        'icon' => 'ace-icon fa fa-edit',
                                        'options' => array(
                                            'class'=>'btn btn-xs btn-info',
                                         ), 
                                  ),
                                  /*
                                  'payment' => array(
                                        'label'=>'Payment',
                                        'icon'=>'fa fa-icon fa-credit-card', 
                                        'url'=>'Yii::app()->createUrl("salePayment/Payment/",array("client_id"=>$data->id))',
                                        'options' => array(
                                           'class'=>'btn btn-xs btn-success',
                                           'title'=>Yii::t('app','Payment'),
                                         ), 
                                  ),
                                   * 
                                  */
                               ),
                        ),
                ),
        )); ?>
        
        <?php echo TbHtml::linkButton(Yii::t( 'app', 'Add New' ),array(
                'color'=>TbHtml::BUTTON_COLOR_PRIMARY,
                'size'=>TbHtml::BUTTON_SIZE_SMALL,
                'icon'=>'glyphicon-plus white',
                'url'=>$this->createUrl('create'),
                //'class'=>'update-dialog-open-link',
                //'data-update-dialog-title' => Yii::t( 'app', 'form.client._form.header_create' ),
        )); ?>
        
    <?php $this->endWidget(); ?>
    </div>
</div>

<?php Yii::app()->clientScript->registerScript('alertTimeout', '$(".alert").fadeTo(4000, 0).slideUp(1500, function() { $(this).remove(); });'); ?>

<?php 
    Yii::app()->clientScript->registerScript( 'undoDelete', "
        jQuery( function($){
            $('div#client_cart').on('click','a.btn-undodelete',function(e) {
                e.preventDefault();
                if (!confirm('Are you sure you want to do undo delete this Item?')) {
                    return false;
                }
                var url=$(this).attr('href');
                $.ajax({url:url,
                        type : 'post',
                        beforeSend: function() { $('.waiting').show(); },
                        complete: function() { $('.waiting').hide(); },
                        success : function(data) {
                            $.fn.yiiGridView.update('client-grid');
                            return false;
                          }
                    });
                });
        });
      ");
 ?>  

<div class="waiting"><!-- Place at bottom of page --></div>