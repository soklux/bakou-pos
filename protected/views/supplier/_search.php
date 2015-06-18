<?php $form=$this->beginWidget('bootstrap.widgets.TbActiveForm',array(
	'action'=>Yii::app()->createUrl($this->route),
	'method'=>'get',
        'layout'=>TbHtml::FORM_LAYOUT_SEARCH,
)); ?>

	<?php //echo $form->textFieldControlGroup($model,'id',array('class'=>'span4')); ?>

	<?php //echo $form->textFieldControlGroup($model,'search',array('class'=>'span4','maxlength'=>60,'placeholder'=>Yii::t('app','Type Name or Phone Number'))); ?>

    <?php echo CHtml::activeTelField($model,'search', array('class' => 'col-xs-12 col-sm-12','placeholder' => Yii::t('app','Filter'))); ?>

	<!--<div class="form-actions">
            <?php /*echo TbHtml::submitButton('Search',  array('color' => TbHtml::BUTTON_COLOR_PRIMARY,));*/?>
	</div>-->

<?php $this->endWidget(); ?>
