<style>
    .btn-group {
        display: flex !important;
    }
</style>
<?php
$this->breadcrumbs = array(
    Yii::t('menu', 'Item') => array('admin'),
    Yii::t('app', 'Manage'),
);
?>
<div class="row" id="item_cart">
    <div class="col-xs-12 widget-container-col ui-sortable">

        <?php $box = $this->beginWidget('yiiwheels.widgets.box.WhBox', array(
            'title' => Yii::t('app', 'List of Items'),
            'headerIcon' => 'ace-icon fa fa-list',
            'htmlHeaderOptions' => array('class' => 'widget-header-flat widget-header-small'),
        )); ?>

        <?php
        Yii::app()->clientScript->registerScript('search', "
        $('.search-button').click(function(){
            $('.search-form').toggle();
            return false;
        });
        $('.search-form form').submit(function(){
            $.fn.yiiGridView.update('item-grid', {
                data: $(this).serialize()
            });
            return false;
        });
        ");
        ?>

        <?php $this->widget('ext.modaldlg.EModalDlg'); ?>

        <?php //echo TbHtml::linkButton(Yii::t('app','Search'),array('class'=>'search-button btn','size'=>TbHtml::BUTTON_SIZE_SMALL,'icon'=>'ace-icon fa fa-search',)); ?>

        <div class="page-header">
            <div class="nav-search search-form" id="nav-search">
                <?php $this->renderPartial('_search', array(
                    'model' => $model,
                )); ?>
            </div>
            <!-- search-form -->


            <?php if (Yii::app()->user->checkAccess('item.create')) { ?>

                <?php echo TbHtml::linkButton(Yii::t('app', 'Add New'), array(
                    'color' => TbHtml::BUTTON_COLOR_PRIMARY,
                    'size' => TbHtml::BUTTON_SIZE_SMALL,
                    'icon' => 'ace-icon fa fa-plus white',
                    'url' => $this->createUrl('createImage'),
                )); ?>

            <?php } ?>

                &nbsp;&nbsp;

                <?php echo CHtml::activeCheckBox($model, 'item_archived', array(
                    'value' => 1,
                    'uncheckValue' => 0,
                    'checked' => ($model->item_archived == 'false') ? false : true,
                    'onclick' => "$.fn.yiiGridView.update('item-grid',{data:{archivedItem:$(this).is(':checked')}});"
                )); ?>

                Show archived/deleted <b>Item</b>
        </div>

        <?php if (Yii::app()->user->hasFlash('success')): ?>
            <?php $this->widget('bootstrap.widgets.TbAlert'); ?>
        <?php endif; ?>


        <?php
        $pageSizeDropDown = CHtml::dropDownList(
            'pageSize',
            Yii::app()->user->getState('pageSize', Common::defaultPageSize()) ,
            Common::arrayFactory('page_size'),
            array(
                'class' => 'change-pagesize',
                'onchange' => "$.fn.yiiGridView.update('item-grid',{data:{pageSize:$(this).val()}});",
            )
        );
        ?>

        <?php $this->widget('yiiwheels.widgets.grid.WhGridView', array(
            'id' => 'item-grid',
            'fixedHeader' => true,
            'type' => TbHtml::GRID_TYPE_HOVER,
            //'headerOffset' => 40,
            //'responsiveTable' => true,
            'template' => "{items}\n{summary}\n{pager}",
            'summaryText' => 'Showing {start}-{end} of {count} entries ' . $pageSizeDropDown . ' rows per page',
            'htmlOptions' => array('class' => 'table-responsive panel'),
            'dataProvider' => $model->search(),
            'filter' => $model,
            'columns' => array(
                /*
                array('name'=>'id',
                    'value' => array($this,'gridImageColumn'),
                    'type' => 'raw'
                ),
                */
                array(
                    'name' => 'name',
                    'value' => '$data->status=="1" ? CHtml::link($data->name, Yii::app()->createUrl("item/updateImage",array("id"=>$data->primaryKey))) : "<span class=\"text-muted\">  $data->name <span>" ',
                    'type' => 'raw',
                    'filter' => '',
                ),
                array(
                    'name' => 'item_number',
                    'header' => 'Item-Code',
                    'filter' => '',
                ),
                /*
                array('name'=>'description',
                      'headerHtmlOptions'=>array('class'=>'hidden-480 hidden-xs'),
                      'htmlOptions'=>array('class' => 'hidden-480 hidden-xs'),
                ),
                 *
                */
                array(
                    'name' => 'location',
                    'value' => '$data->status=="1" ? $data->location : "<span class=\"text-muted\">  $data->location <span>"',
                    'type' => 'raw',
                ),
                array(
                    'name' => 'category_id',
                    //'header' => 'Category',
                    //'headerHtmlOptions'=>array('class'=>'hidden-480 hidden-xs hidden-md'),
                    'value' => '$data->category_id==null? " " : $data->category->name',
                    'filter' =>  CHtml::listData(Category::model()->findAll(array('order'=>'name')), 'id', 'name'),
                ),
                /*
                array('name'=>'supplier_id',
                      'value'=>'($data->supplier_id==null || $data->supplier_id==0)? "N/A" : $data->supplier->company_name'
                ),
                 *
                */
                /*
                array('name'=>'cost_price',
                      'headerHtmlOptions'=>array('class'=>'hidden-480 hidden-xs hidden-md'),
                      'htmlOptions'=>array('class' => 'hidden-480 hidden-xs hidden-md'),
                ),
                 *
                */
                /*
                array('name'=>'unit_price',
                      'header'=>'Sell-Price',
                ),
                 *
                */
                array(
                    'name' => 'quantity',
                    'value' => '$data->status=="1" ? $data->quantity : "<span class=\"text-muted\">  $data->quantity <span>"',
                    'type' => 'raw',
                ),
                array(
                    'name' => 'status',
                    'type' => 'raw',
                    'value' => '$data->status==1 ? TbHtml::labelTb("Active", array("color" => TbHtml::LABEL_COLOR_SUCCESS)) : TbHtml::labelTb("Inactive")',
                    'filter' => '',
                ),
                array(
                    'class' => 'bootstrap.widgets.TbButtonColumn',
                    'header' => 'Action',
                    'template' => '<div class="hidden-sm hidden-xs btn-group">{detail}{cost}{price}{delete}{undeleted}</div>',
                    'buttons' => array(
                        'detail' => array(
                            'click' => 'updateDialogOpen',
                            'label' => Yii::t('app', 'Stock'),
                            'url' => 'Yii::app()->createUrl("Inventory/admin", array("item_id"=>$data->id))',
                            'options' => array(
                                'data-toggle' => 'tooltip',
                                'data-update-dialog-title' => 'Stock History',
                                'class' => 'btn btn-xs btn-pink',
                                'title' => 'Stock History',
                            ),
                            'visible' => '$data->status=="1" && Yii::app()->user->checkAccess("item.index") ',
                        ),
                        'cost' => array(
                            'click' => 'updateDialogOpen',
                            'label' => Yii::t('app', 'Cost'),
                            'url' => 'Yii::app()->createUrl("Item/CostHistory", array("item_id"=>$data->id))',
                            'options' => array(
                                'data-update-dialog-title' => Yii::t('app', 'Cost History'),
                                'class' => 'btn btn-xs btn-info',
                                'title' => 'Cost History',
                            ),
                            'visible' => '$data->status=="1"  && (Yii::app()->user->checkAccess("item.create") || Yii::app()->user->checkAccess("item.update"))',
                        ),
                        'price' => array(
                            'click' => 'updateDialogOpen',
                            //'label'=>"<span class='text-info'>" . Yii::t('app','Price') . "</span><i class='icon-info-sign'></i> ",
                            'label' => Yii::t('app', 'Price'),
                            'url' => 'Yii::app()->createUrl("Item/PriceHistory", array("item_id"=>$data->id))',
                            'options' => array(
                                'data-update-dialog-title' => Yii::t('app', 'Price History'),
                                'class' => 'btn btn-xs btn-success',
                                'title' => 'Price History',
                            ),
                            'visible' => '$data->status=="1"  && (Yii::app()->user->checkAccess("item.create") || Yii::app()->user->checkAccess("item.update"))',
                        ),
                        /*
                        'edit' => array(
                          'label'=>Yii::t('app','Edit Item'),
                          'url'=>'Yii::app()->createUrl("Item/UpdateImage", array("id"=>$data->id))',
                          'icon'=>'bigger-120 ace-icon fa fa-edit',
                          'visible'=>'Yii::app()->user->checkAccess("item.update")',
                          'options' => array(
                              'class' => 'btn btn-xs btn-info',
                          )
                        ),
                         *
                        */
                        'delete' => array(
                            'label' => Yii::t('app', 'Delete Item'),
                            'icon' => 'bigger-120 glyphicon-trash',
                            'options' => array(
                                'class' => 'btn btn-xs btn-danger',
                            ),
                            'visible' => '$data->status=="1" && Yii::app()->user->checkAccess("item.delete")',
                        ),
                        'undeleted' => array(
                            'label' => Yii::t('app', 'Restore Item'),
                            'url' => 'Yii::app()->createUrl("Item/UndoDelete", array("id"=>$data->id))',
                            'icon' => 'bigger-120 glyphicon-refresh',
                            'options' => array(
                                'class' => 'btn btn-xs btn-warning btn-undodelete',
                            ),
                            'visible' => '$data->status=="0" && Yii::app()->user->checkAccess("item.delete")',
                        ),
                    ),
                ),
            ),
        )); ?>

        <?php $this->endWidget(); ?>

    </div>
</div>

<script>
    $(document).ready(function () {
        window.setTimeout(function () {
            $(".alert").fadeTo(1000, 0).slideUp(1000, function () {
                $(this).remove();
            });
        }, 2000);
    });
</script>

<?php
Yii::app()->clientScript->registerScript('undoDelete', "
        jQuery( function($){
            $('div#item_cart').on('click','a.btn-undodelete',function(e) {
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
                            $.fn.yiiGridView.update('item-grid');
                            return false;
                          }
                    });
                });
        });
      ");
?>

<div class="waiting"><!-- Place at bottom of page --></div>