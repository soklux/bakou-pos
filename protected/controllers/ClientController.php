<?php

class ClientController extends Controller
{
	/**
	 * @var string the default layout for the views. Defaults to '//layouts/column2', meaning
	 * using two-column layout. See 'protected/views/layouts/column2.php'.
	 */
	public $layout='//layouts/column1';

	/**
	 * @return array action filters
	 */
	public function filters()
	{
		return array(
			'accessControl', // perform access control for CRUD operations
		);
	}

	/**
	 * Specifies the access control rules.
	 * This method is used by the 'accessControl' filter.
	 * @return array access control rules
	 */
	public function accessRules()
	{
		return array(
			array('allow',  // allow all users to perform 'index' and 'view' actions
				'actions'=>array('index','view'),
				'users'=>array('@'),
			),
			array('allow', // allow authenticated user to perform 'create' and 'update' actions
				'actions'=>array('create','update','admin','GetClient','AddCustomer','delete','undodelete','payment','CopyClientInfo'),
				'users'=>array('@'),
			),
			array('allow', // allow admin user to perform 'admin' and 'delete' actions
				'actions'=>array('admin','delete'),
				'users'=>array('admin'),
			),
			array('deny',  // deny all users
				'users'=>array('*'),
			),
		);
	}

	/**
	 * Displays a particular model.
	 * @param integer $id the ID of the model to be displayed
	 */
	public function actionView($id)
	{
            if (Yii::app()->request->isAjaxRequest) {
               
                Yii::app()->clientScript->scriptMap['*.js'] = false;
               
                echo CJSON::encode(array(
                    'status' => 'render',
                    'div' => $this->renderPartial('view', array('model' => $this->loadModel($id)), true, false),
                ));

                Yii::app()->end();
            } else {
                $this->render('view',array(
                        'model'=>$this->loadModel($id),
                ));
            }
	}

	/**
	 * Creates a new model.
	 * If creation is successful, the browser will be redirected to the 'view' page.
	 */
	public function actionCreate($sale_mode='N')
	{
		$model=new Client;

		// Uncomment the following line if AJAX validation is needed
		//$this->performAjaxValidation($model
                if (Yii::app()->user->checkAccess('client.create'))
                {
                    if(isset($_POST['Client']))
                    {
                        $model->attributes=$_POST['Client'];
                        if($model->validate())
                        {
                            $transaction=Yii::app()->db->beginTransaction();
                            try 
                            {
                                if($model->save())
                                { 
                                    $client_id=$model->id;
                                    $client_fname=$model->first_name . ' ' . $model->last_name;
                                    $price_tier_id = $model->price_tier_id;
                                    Account::model()->saveAccount($client_id,$client_fname); 

                                    $transaction->commit();

                                    if ($sale_mode=='Y') {
                                        Yii::app()->shoppingCart->setCustomer($client_id);
                                        Yii::app()->shoppingCart->setPriceTier($price_tier_id);
                                        $this->redirect(array('saleItem/index'));
                                    } else {
                                        Yii::app()->user->setFlash(TbHtml::ALERT_COLOR_SUCCESS,'<strong>' . ucfirst($model->first_name) . '</strong> have been saved successfully!' );
                                        $this->redirect(array('create'));
                                    }

                                    /* Decide to not using Modal diaglog for CRUD form 
                                    Yii::app()->clientScript->scriptMap['jquery.js'] = false;
                                    echo CJSON::encode(array(
                                       'status'=>'success',
                                       'div'=>"<div class=alert alert-info fade in>Successfully added ! </div>",
                                       ));

                                    Yii::app()->end();
                                     * 
                                    */
                                }
                            }catch (CDbException $e)
                            {
                               $transaction->rollback();
                               //Yii::app()->user->setFlash('error', "{$e->getMessage()}");
                               Yii::app()->user->setFlash(TbHtml::ALERT_COLOR_WARNING,'Oop something wrong : <strong>' . $e->getMessage());
                            } 

                        }
                    }
                }
                else {
                    throw new CHttpException(403, 'You are not authorized to perform this action');
                }

		if(Yii::app()->request->isAjaxRequest)
                {
                    $cs=Yii::app()->clientScript;
                    $cs->scriptMap=array(
                        'jquery.js'=>false,
                        'bootstrap.js'=>false,
                        'jquery.min.js'=>false,
                        'bootstrap.notify.js'=>false,
                        'bootstrap.bootbox.min.js'=>false,
                    );

                    echo CJSON::encode( array(
                        'status' => 'render',
                        'div' => $this->renderPartial( '_form', array('model' => $model),true,false),
                    ));

                    Yii::app()->end();
                }
                else
                {
                    $this->render('create',array('model' => $model)); 
                }
	}
        
        /**
	 * Creates a new model.
	 * If creation is successful, the browser will be redirected to the 'view' page.
	 */
	public function actionAddCustomer()
	{
		$model=new Client;

		if (Yii::app()->user->checkAccess('client.create'))
                {
                    if(isset($_POST['Client']))
                    {
                            $model->attributes=$_POST['Client'];
                            if($model->validate())
                            {
                                if($model->save())
                                {
                                    if (!empty($_POST['Client']['debter_id'])) 
                                    {           
                                       $debter_id=$_POST['Client']['debter_id'];

                                       $mod_debter_ref=new DebterClientRef;
                                       $mod_debter_ref->client_id=$model->id;
                                       $mod_debter_ref->debter_id=(int)$debter_id;
                                       $mod_debter_ref->save();
                                    } 
                                    
                                    Yii::app()->clientScript->scriptMap['jquery.js'] = false;
                                    
                                    Yii::app()->shoppingCart->setCustomer($model->id);
                                    $this->redirect(array('saleItem/index'));
                                    
                                }
                            }
                    }
                }
                else {
                    throw new CHttpException(403, 'You are not authorized to perform this action');
                }
                

		if(Yii::app()->request->isAjaxRequest)
                {
                    Yii::app()->clientScript->scriptMap['*.js'] = false;
                    //Yii::app()->clientScript->scriptMap['*.cs'] = false;
                   
                    if (Yii::app()->settings->get('system', 'touchScreen')=='1') {
                         echo CJSON::encode( array(
                            'status' => 'render',
                            'div' => $this->renderPartial( '_form_touchscreen', array('model' => $model),true,false),
                        ));
                    } else {
                        echo CJSON::encode( array(
                            'status' => 'render',
                            'div' => $this->renderPartial( '_form', array('model' => $model),true,false),
                        ));
                    }
                    
                    Yii::app()->end();
                }
                else
                {
                    $this->render('_form',array('model' => $model)); 
                }
	}
        
        /**
	 * Updates a particular model.
	 * If update is successful, the browser will be redirected to the 'view' page.
	 * @param integer $id the ID of the model to be updated
	 */
	public function actionUpdate($id,$sale_mode='N')
	{
		$model=$this->loadModel($id);

		// Uncomment the following line if AJAX validation is needed
		// $this->performAjaxValidation($model);

                if (Yii::app()->user->checkAccess('client.update'))
                {
                    if(isset($_POST['Client']))
                    {
                            $model->attributes=$_POST['Client'];
                            if ($model->validate())
                            {    
                                $transaction=$model->dbConnection->beginTransaction(); 
                                try
                                {
                                    if ($model->save())
                                    {
                                        $client_fname=$model->first_name . ' ' . $model->last_name;
                                        Account::model()->saveAccount($model->id,$client_fname);
                                        $price_tier_id = $model->price_tier_id;
                                        
                                        $transaction->commit(); 
                                        
                                        if ($sale_mode=='Y') {
                                            Yii::app()->shoppingCart->setCustomer($id);
                                            Yii::app()->shoppingCart->setPriceTier($price_tier_id);
                                            $this->redirect(array('saleItem/index'));
                                        } else {
                                             Yii::app()->user->setFlash(TbHtml::ALERT_COLOR_SUCCESS,'<strong>' . ucfirst($model->first_name) . '</strong> have been saved successfully!' );
                                            $this->redirect(array('admin'));
                                        }
                                    }
                                }catch(Exception $e)
                                {
                                    $transaction->rollback();
                                    print_r($e);
                                } 
                            }
                    }
                }
                else {
                    throw new CHttpException(403, 'You are not authorized to perform this action');
                }    

		if(Yii::app()->request->isAjaxRequest)
                {
                    $cs=Yii::app()->clientScript;
                    $cs->scriptMap=array(
                        'jquery.js'=>false,
                        'bootstrap.js'=>false,
                        'jquery.min.js'=>false,
                        'bootstrap.notify.js'=>false,
                        'bootstrap.bootbox.min.js'=>false,
                    );

                    echo CJSON::encode( array(
                        'status' => 'render',
                        'div' => $this->renderPartial( '_form', array('model' => $model),true,false),
                    ));

                    Yii::app()->end();
                }
                else
                {
                    $this->render('update',array('model' => $model)); 
                }
	}

	/**
	 * Deletes a particular model.
	 * If deletion is successful, the browser will be redirected to the 'admin' page.
	 * @param integer $id the ID of the model to be deleted
	 */
    public function actionDelete($id)
    {
        if (Yii::app()->user->checkAccess('client.delete')) {
            if (Yii::app()->request->isPostRequest && Yii::app()->request->isAjaxRequest) {
                Client::model()->deleteClient($id);
                // if AJAX request (triggered by deletion via admin grid view), we should not redirect the browser
                if (!isset($_GET['ajax'])) {
                    $this->redirect(isset($_POST['returnUrl']) ? $_POST['returnUrl'] : array('admin'));
                }
            } else {
                throw new CHttpException(400, 'Invalid request. Please do not repeat this request again.');
            }
        } else {
            throw new CHttpException(403, 'You are not authorized to perform this action');
        }
    }
        
        public function actionUndoDelete($id)
	{
            if (Yii::app()->user->checkAccess('client.delete'))
            {
                if(Yii::app()->request->isPostRequest && Yii::app()->request->isAjaxRequest)
		{
                        Client::model()->undodeleteClient($id);

			// if AJAX request (triggered by deletion via admin grid view), we should not redirect the browser
			if(!isset($_GET['ajax'])) 
				$this->redirect(isset($_POST['returnUrl']) ? $_POST['returnUrl'] : array('admin'));
		} else { 
                    throw new CHttpException(400,'Invalid request. Please do not repeat this request again.');
                }
            } else {
                throw new CHttpException(403, 'You are not authorized to perform this action');
            }
	}
        
	/**
	 * Manages all models.
	 */
    public function actionAdmin($client_id = null)
    {
        if (Yii::app()->user->checkAccess('client.index') || Yii::app()->user->checkAccess('client.create') || Yii::app()->user->checkAccess('client.update') || Yii::app()->user->checkAccess('client.delete')) {
            $model = new Client('search');
            $model->unsetAttributes();  // clear any default values
            if (isset($_GET['Client'])) {
                $model->attributes = $_GET['Client'];
            }

            $this->render('admin', array(
                'model' => $model,
                'client_id' => $client_id
            ));
        } else {
            throw new CHttpException(403, 'You are not authorized to perform this action');
        }
    }

	/**
	 * Returns the data model based on the primary key given in the GET variable.
	 * If the data model is not found, an HTTP exception will be raised.
	 * @param integer the ID of the model to be loaded
	 */
	public function loadModel($id)
	{
		$model=Client::model()->findByPk($id);
		if($model===null)
			throw new CHttpException(404,'The requested page does not exist.');
		return $model;
	}

	/**
	 * Performs the AJAX validation.
	 * @param CModel the model to be validated
	 */
	protected function performAjaxValidation($model)
	{
		if(isset($_POST['ajax']) && $_POST['ajax']==='client-form')
		{
			echo CActiveForm::validate($model);
			Yii::app()->end();
		}
	}

    /** Lookup Client for autocomplete
     *
     * @throws CHttpException
     */
    public function actionGetClient()
    {
        if (isset($_GET['term'])) {
            $term = trim($_GET['term']);
            $ret['results'] = Client::model()->select2Client($term); //PHP Example · ivaynberg/select2  http://bit.ly/10FNaXD got stuck serveral hoursss :|
            echo CJSON::encode($ret);
            Yii::app()->end();

        }
    }

    public function gridBalance($data, $row)
    {
        $account = Account::model()->getAccountInfo($data->id);
        if ($account) {
            echo $account->current_balance;
        } else {
            echo CHtml::encode('0.00');
        }
    }

    public function actionPayment($client_id)
    {
        if (!Yii::app()->user->checkAccess('payment.index')) {
            throw new CHttpException(403, 'You are not authorized to perform this action');
        }

        Yii::app()->paymentCart->setClientId($client_id);
        $this->redirect(array('salePayment/index'));

    }

    public function actionCopyClientInfo()
    {
        if (Yii::app()->request->isPostRequest && Yii::app()->request->isAjaxRequest) {

            $param = (int)$_POST['Client']['employee_id'];
            $employee = Employee::model()->findByPk($param);

            echo CJSON::encode(array(
                'status' => 'success',
                'mobile_no' => $employee->mobile_no,
                'first_name' => $employee->first_name,
                'last_name' => $employee->last_name,
                'address1' => $employee->adddress1,
                'address2' => $employee->address2,
                'notes' => $employee->notes,
            ));
        }
    }
              
}
