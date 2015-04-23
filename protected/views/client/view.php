<?php
$this->breadcrumbs=array(
	'Clients'=>array('index'),
	$model->id,
);

?>

<h5>View Customer : <?php echo $model->first_name; ?></h5>

<?php $this->widget('bootstrap.widgets.TbDetailView',array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'fullname',
		'mobile_no',
		'adddress1',
		'address2',
		'city_id',
		'country_code',
		'email',
		'notes',
	),
)); ?>
