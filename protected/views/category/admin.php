<style>
    .btn-group {
        display: flex !important;
    }
</style>
<div class="row" id="category_cart">
    <div class="col-xs-12 widget-container-col ui-sortable">
        <?php
        $this->breadcrumbs = array(
            'Item' => array('item/admin'),
            'Category',
        );

        Yii::app()->clientScript->registerScript('search', "
        $('.search-button').click(function(){
            $('.search-form').toggle();
            return false;
        });
        $('.search-form form').submit(function(){
            $.fn.yiiGridView.update('category-grid', {
                data: $(this).serialize()
            });
            return false;
        });
        ");
        ?>

        <?php $this->widget('ext.modaldlg.EModalDlg'); ?>

        <?php $box = $this->beginWidget('yiiwheels.widgets.box.WhBox', array(
            'title' => Yii::t('app', 'List of Category'),
            'htmlHeaderOptions' => array('class' => 'widget-header-flat widget-header-small'),
            'headerIcon' => 'ace-icon fa fa-list',
        )); ?>

        <div class="page-header">

            <div class="nav-search search-form" id="nav-search">
                <?php $this->renderPartial('_search', array(
                    'model' => $model,
                )); ?>
            </div>
            <!-- search-form -->

            <?php if (Yii::app()->user->checkAccess('item.create')) { ?>

                <?php echo TbHtml::linkButton(Yii::t('app', 'New Category'), array(
                    'color' => TbHtml::BUTTON_COLOR_PRIMARY,
                    'size' => TbHtml::BUTTON_SIZE_SMALL,
                    'icon' => 'ace-icon fa fa-plus white',
                    'url' => $this->createUrl('create'),
                    'class' => 'update-dialog-open-link',
                    'data-update-dialog-title' => Yii::t('app', 'New Category'),
                    'data-refresh-grid-id' => 'category-grid',
                )); ?>

            <?php } ?>

        </div>

        <?php
        $pageSizeDropDown = CHtml::dropDownList(
            'pageSize',
            Yii::app()->user->getState('categoryPageSize', Common::defaultPageSize()),
            Common::arrayFactory('page_size'),
            array(
                'class' => 'change-pagesize',
                'onchange' => "$.fn.yiiGridView.update('category-grid',{data:{pageSize:$(this).val()}});",
            )
        );
        ?>

        <?php $this->widget('yiiwheels.widgets.grid.WhGridView', array(
            'id' => 'category-grid',
            'fixedHeader' => true,
            'template' => "{items}\n{summary}\n{pager}",
            'summaryText' => 'Showing {start}-{end} of {count} entries ' . $pageSizeDropDown . ' rows per page',
            'htmlOptions' => array('class' => 'table-responsive panel'),
            'dataProvider' => $model->search(),
            'columns' => array(
                //'id',
                'name',
                'created_date',
                'modified_date',
                array(
                    'class' => 'bootstrap.widgets.TbButtonColumn',
                    'buttons' => array(
                        'update' => array(
                            'click' => 'updateDialogOpen',
                            'label' => 'Update Category',
                            'options' => array(
                                'data-update-dialog-title' => Yii::t('app', 'Update Category'),
                                'data-refresh-grid-id' => 'category-grid',
                            ),
                        ),
                    ),
                ),
            ),
        )); ?>

        <?php $this->endWidget(); ?>

    </div>
</div>
