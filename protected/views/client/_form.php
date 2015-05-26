<?php $form=$this->beginWidget('bootstrap.widgets.TbActiveForm',array(
	'id'=>'client-form',
	'enableAjaxValidation'=>false,
        'layout'=>TbHtml::FORM_LAYOUT_HORIZONTAL,
        'htmlOptions'=>array('data-validate'=>'parsley'),
)); ?>

	<p class="help-block"><?php echo Yii::t('app', 'Fields with'); ?> <span class="required">*</span> <?php echo Yii::t('app', 'are required'); ?></p>

	<?php //echo $form->errorSummary($model); ?>

    <?php echo $form->dropDownListControlGroup($model, 'price_tier_id', PriceTier::model()->getPriceTier(),
        array(
            'class' => 'span3',
            'empty' => Yii::t('app', 'Select Default Price Tier'),
        )
    ); ?>

    <?php echo $form->dropDownListControlGroup($model, 'employee_id', Employee::model()->getEmployee(), array(
            'class' => 'span3',
            'empty' => Yii::t('app', 'Select Employee Reference'),
            'ajax' => array(
                'type' => 'POST',
                'dataType'=>'json',
                'url' => Yii::app()->createUrl('client/copyClientInfo'),
                'success'=>"function(data) {
                    if ( data.status === 'success' ) {
                        $('#Client_mobile_no').val(data.mobile_no);
                        $('#Client_first_name').val(data.first_name);
                        $('#Client_last_name').val(data.last_name);
                        $('#Client_address1').val(data.address1);
                        $('#Client_address2').val(data.address2);
                        $('#Client_notes').val(data.notes);
                    }
                }",
            )
        )
    ); ?>

    <div id="client_info">

    <?php echo $form->textFieldControlGroup($model, 'mobile_no', array('class' => 'span3', 'maxlength' => 15)); ?>

    <?php echo $form->textFieldControlGroup($model, 'first_name', array('class' => 'span3', 'maxlength' => 60)); ?>

    <?php echo $form->textFieldControlGroup($model, 'last_name', array('class' => 'span3', 'maxlength' => 60)); ?>

    <?php //echo $form->dropDownListRow($model,'debter_id', DebtCollector::model()->getDebterInfo(), array('class'=>'span3','prompt'=>'Select Debt Colletor')); ?>

    <?php echo $form->textFieldControlGroup($model, 'address1', array('class' => 'span3', 'maxlength' => 60)); ?>

    <?php echo $form->textFieldControlGroup($model, 'address2', array('class' => 'span3', 'maxlength' => 60)); ?>

    <?php //echo $form->textFieldControlGroup($model,'city_id',array('class'=>'span3')); ?>

    <?php //echo $form->textFieldControlGroup($model,'country_code',array('class'=>'span3','maxlength'=>2)); ?>

    <?php //echo $form->textFieldControlGroup($model,'email',array('class'=>'span3','maxlength'=>30)); ?>

    <?php echo $form->textAreaControlGroup($model, 'notes', array('rows' => 2, 'cols' => 20, 'class' => 'span3')); ?>

    </div>

	<div class="form-actions">
            <?php echo TbHtml::submitButton($model->isNewRecord ? Yii::t('app','Create') : Yii::t('app','Save'),array(
               'color'=>TbHtml::BUTTON_COLOR_PRIMARY,
               //'size'=>TbHtml::BUTTON_SIZE_SMALL,
           )); ?>
        </div>

<?php $this->endWidget(); ?>

<?php Yii::app()->clientScript->registerScript('setFocus',  '$("#Client_mobile_no").focus();'); ?>

<?php Yii::app()->clientScript->registerScript('alertTimeout', '$(".alert").fadeTo(5000, 0).slideUp(1500, function() { $(this).remove(); });'); ?>

