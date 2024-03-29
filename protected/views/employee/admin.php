<style>
    .btn-group {
        display: flex !important;
    }
</style>
<div class="row" id="employee_cart">
    <div class="col-xs-12 widget-container-col ui-sortable">
        <?php $box = $this->beginWidget('yiiwheels.widgets.box.WhBox', array(
            'title' => Yii::t('app', 'List of Employee'),
            'headerIcon' => 'ace-icon fa fa-users',
            'htmlHeaderOptions' => array('class' => 'widget-header-flat widget-header-small'),
        )); ?>

        <?php
        $this->breadcrumbs = array(
            Yii::t('menu', 'Employee') => array('admin'),
            Yii::t('app', 'Manage'),
        );

        Yii::app()->clientScript->registerScript('search', "
            $('.search-button').click(function(){
                    $('.search-form').toggle();
                    return false;
            });
            $('.search-form form').submit(function(){
                    $.fn.yiiGridView.update('employee-grid', {
                            data: $(this).serialize()
                    });
                    return false;
            });
            ");
        ?>

        <div class="page-header">
            <div class="nav-search search-form" id="nav-search">
                <?php $this->renderPartial('_search', array(
                    'model' => $model,
                )); ?>
            </div>

            <?php if (Yii::app()->user->checkAccess('employee.create')) { ?>

                <?php echo TbHtml::linkButton(Yii::t('app', 'Add New'), array(
                    'color' => TbHtml::BUTTON_COLOR_PRIMARY,
                    'size' => TbHtml::BUTTON_SIZE_SMALL,
                    'icon' => 'glyphicon-plus white',
                    'url' => $this->createUrl('create'),
                )); ?>

            <?php } ?>

            &nbsp;&nbsp;

            <?php echo CHtml::activeCheckBox($model, 'employee_archived', array(
                'value' => 1,
                'uncheckValue' => 0,
                'checked' => ($model->employee_archived == 'false') ? false : true,
                'onclick' => "$.fn.yiiGridView.update('employee-grid',{data:{archivedEmployee:$(this).is(':checked')}});"
            )); ?>

            Show archived/deleted <b>Employee</b>

        </div>

        <?php if (Yii::app()->user->hasFlash('success')): ?>
            <?php $this->widget('bootstrap.widgets.TbAlert'); ?>
        <?php endif; ?>

        <?php
        $pageSizeDropDown = CHtml::dropDownList(
            'pageSize',
            Yii::app()->user->getState('employeePageSize', Common::defaultPageSize()),
            Common::arrayFactory('page_size'),
            array(
                'class' => 'change-pagesize',
                'onchange' => "$.fn.yiiGridView.update('employee-grid',{data:{pageSize:$(this).val()}});",
            )
        );
        ?>

        <?php $this->widget('bootstrap.widgets.TbGridView', array(
            'id' => 'employee-grid',
            'dataProvider' => $model->search(),
            'template' => "{items}\n{summary}\n{pager}",
            'summaryText' => 'Showing {start}-{end} of {count} entries ' . $pageSizeDropDown . ' rows per page',
            'htmlOptions' => array('class' => 'table-responsive panel'),
            'columns' => array(
                //'id',
                array(
                    'name' => 'login_id',
                    'header' => 'Login ID',
                    'value' => array($this, "gridLoginIDColumn"),
                ),
                'first_name',
                'last_name',
                array(
                    'name' => 'mobile_no',
                ),
                array(
                    'name' => 'adddress1',
                    //'headerHtmlOptions'=>array('class'=>'hidden-480 hidden-xs'),
                    //'htmlOptions'=>array('class' => 'hidden-480 hidden-xs'),
                ),
                array(
                    'name' => 'address2',
                    //'headerHtmlOptions'=>array('class'=>'hidden-480 hidden-xs'),
                    //'htmlOptions'=>array('class' => 'hidden-480 hidden-xs'),
                ),
                /*
                'city_id',
                'country_code',
                'email',
                'notes',
                */
                array(
                    'class' => 'bootstrap.widgets.TbButtonColumn',
                    'header' => Yii::t('app','Action'),
                    'template' => '<div class="btn-group">{view}{update}{delete}{undeleted}</div>',
                    'htmlOptions' => array('class' => 'nowrap'),
                    'buttons' => array(
                        'view' => array(
                            //'url'=>'Yii::app()->createUrl("client/delete/",array("id"=>$data->id))',
                            'options' => array(
                                'class' => 'btn btn-xs btn-success',
                            ),
                        ),
                        'update' => array(
                            'icon' => 'ace-icon fa fa-edit',
                            'options' => array(
                                'class' => 'btn btn-xs btn-info',
                            ),
                        ),
                        'delete' => array(
                            'label' => 'Delete',
                            //'url'=>'Yii::app()->createUrl("sale/Invoice/",array("client_id"=>$data->id))',
                            'options' => array(
                                'class' => 'btn btn-xs btn-danger',
                            ),
                            'visible' => '$data->status=="1" && Yii::app()->user->checkAccess("employee.delete")',
                        ),
                        'undeleted' => array(
                            'label' => Yii::t('app', 'Undo Delete Item'),
                            'url' => 'Yii::app()->createUrl("Employee/UndoDelete", array("id"=>$data->id))',
                            'icon' => 'bigger-120 glyphicon-refresh',
                            'options' => array(
                                'class' => 'btn btn-xs btn-warning btn-undodelete',
                            ),
                            'visible' => '$data->status=="0" && Yii::app()->user->checkAccess("employee.delete")',
                        ),
                    ),
                ),
            ),
        )); ?>

        <?php $this->endWidget(); ?>
    </div>
</div>

<?php
Yii::app()->clientScript->registerScript('undoDelete', "
        jQuery( function($){
            $('div#employee_cart').on('click','a.btn-undodelete',function(e) {
                e.preventDefault();
                if (!confirm('Are you sure you want to do undo delete this item?')) {
                    return false;
                }
                var url=$(this).attr('href');
                $.ajax({url:url,
                        type : 'post',
                        beforeSend: function() { $('.waiting').show(); },
                        complete: function() { $('.waiting').hide(); },
                        success : function(data) {
                            $.fn.yiiGridView.update('employee-grid');
                            return false;
                          }
                    });
                });
        });
      ");
?>

<script>
    $(document).ready(function () {
        window.setTimeout(function () {
            $(".alert").fadeTo(2000, 0).slideUp(2000, function () {
                $(this).remove();
            });
        }, 2000);
    });
</script>


<div class="waiting"><!-- Place at bottom of page --></div>