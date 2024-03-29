<?php

class ReportController extends Controller
{

    /**
     * @var string the default layout for the views. Defaults to '//layouts/column2', meaning
     * using two-column layout. See 'protected/views/layouts/column2.php'.
     */
    public $layout = '//layouts/column1';

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
            array('allow', // allow all users to perform 'index' and 'view' actions
                'actions' => array('index', 'view'),
                'users' => array('*'),
            ),
            array('allow', // allow authenticated user to perform 'create' and 'update' actions
                'actions' => array('create', 'update', 'ReportTab', 'SaleInvoiceItem', 'SaleInvoice', 'SaleInvoiceAlert', 'SaleDaily', 'SaleReportTab', 'SaleSummary', 'Payment', 'TopProduct', 'SaleHourly', 'Inventory', 'ItemExpiry', 'DailyProfit', 'ItemInactive', 'Transaction', 'TransactionItem', 'ItemAsset', 'SaleItemSummary','StockCount','StockCountPrint','UserLogSummary','UserLogDt','OutStandingInvoice','SaleSummarybySaleRep'),
                'users' => array('@'),
            ),
            array('allow', // allow admin user to perform 'admin' and 'delete' actions
                'actions' => array('admin', 'delete'),
                'users' => array('admin'),
            ),
            array('deny', // deny all users
                'users' => array('*'),
            ),
        );
    }

    /**
     * Manages all models.
     */
    public function actionReportTab()
    {

        $report = new Report;
        $report->unsetAttributes();  // clear any default values
        $date_view = 0; //indicate no date picker from_date & to_date, default view is today 
        $filter = 'all';
        $mfilter = '1';

        if (isset($_GET['Report'])) {
            $report->attributes = $_GET['Report'];
            $from_date = $_GET['Report']['from_date'];
            $to_date = $_GET['Report']['to_date'];
        } else {
            $from_date = date('d-m-Y');
            $to_date = date('d-m-Y');
        }

        $report->from_date = $from_date;
        $report->to_date = $to_date;

        $this->render('_report_tab', array('report' => $report, 'from_date' => $from_date, 'to_date' => $to_date, 'date_view' => $date_view, 'filter' => $filter, 'mfilter' => $mfilter));
    }

    /**
     * Manages all models.
     */
    public function actionSaleReportTab()
    {

        $report = new Report;
        $report->unsetAttributes();  // clear any default values

        if (isset($_GET['Report'])) {
            $report->attributes = $_GET['Report'];
            $from_date = $_GET['Report']['from_date'];
            $to_date = $_GET['Report']['to_date'];
        } else {
            $from_date = date('01-m-Y');
            $to_date = date('d-m-Y');
        }

        $report->from_date = $from_date;
        $report->to_date = $to_date;

        if (Yii::app()->request->isAjaxRequest) {
            Yii::app()->clientScript->scriptMap['*.js'] = false;
            Yii::app()->clientScript->scriptMap['*.css'] = false;
            $this->renderPartial('_sale_report_tab', array('report' => $report), true, true);
            Yii::app()->end();
        } else {
            $this->render('_sale_report_tab', array('report' => $report, 'from_date' => $from_date, 'to_date' => $to_date));
        }
    }

    /**
     * Manages all models.
     */
    public function actionSaleInvoice($period=null)
    {
        if (Yii::app()->user->checkAccess('invoice.index') || Yii::app()->user->checkAccess('invoice.print') || Yii::app()->user->checkAccess('invoice.delete') || Yii::app()->user->checkAccess('invoice.update')) {    
            
            $data = array();
          
            $report = new Report;
            $report->unsetAttributes();  // clear any default values
            $date_view = 0;
            $view_file='sale';
            
            if ($period!==null) {
                Yii::app()->reportCart->setSaleInvPeriod($period);
                $period=Yii::app()->reportCart->getSaleInvPeriod();
            } elseif( Yii::app()->reportCart->getSaleInvPeriod() !== null) {
                $period=Yii::app()->reportCart->getSaleInvPeriod();
            } else {
                 $period='today';
            }
            
                    
            if (!empty($_GET['Report']['sale_id'])) {
                $report->sale_id = $_GET['Report']['sale_id'];
            }

            switch ($period) {
                case 'today':
                    $from_date = date('d-m-Y');
                    $to_date = date('d-m-Y');
                    break;
                case 'yesterday':
                    $from_date = date('d-m-Y', strtotime('-1 day'));
                    $to_date = date('d-m-Y', strtotime('-1 day'));
                    break;
                case 'thismonth':
                    $from_date = date('01-m-Y');
                    $to_date = date('d-m-Y');
                    break;
                case 'lastmonth':
                    $from_date = date('01-m-Y', strtotime("-1 month"));
                    $d = new DateTime($from_date);
                    $to_date = $d->format('t-m-Y');
                    break;
                case 'choose':
                    if (isset($_GET['Report'])) {
                        $report->attributes = $_GET['Report'];
                        $from_date = $_GET['Report']['from_date'];
                        $to_date = $_GET['Report']['to_date'];
                        $date_view = 1;
                    } else {
                        $from_date = date('d-m-Y');
                        $to_date = date('d-m-Y');
                        $date_view = 1;
                    }
                    break;
            }

            $report->from_date = $from_date;
            $report->to_date = $to_date;
           
            $data['report'] = $report;
            $data['from_date'] = $from_date;
            $data['to_date'] = $to_date;
            $data['date_view'] = Yii::app()->reportCart->getSaleInvPeriod();
            
            if (Yii::app()->request->isAjaxRequest) {
                $cs = Yii::app()->clientScript;
                $cs->scriptMap = array(
                    'jquery.js' => false,
                    'bootstrap.js' => false,
                    'jquery.min.js' => false,
                    'bootstrap.notify.js' => false,
                    'bootstrap.bootbox.min.js' => false,
                    //'jquery.yiigridview.js' => false,
                    'jquery.ba-bbq.min.js'=> false,
                    'jquery.stickytableheaders.min.js' => false,
                    'jquery-ui.min.js' => false,
                    //'bootstrap-datepicker.js' => false,
                );

                //Yii::app()->clientScript->scriptMap['*.css'] = false;
                //Yii::app()->clientScript->scriptMap['*.js'] = false;
                if (isset($_GET['ajax']) && $_GET['ajax'] == 'sale-grid') {
                    $this->render('sale',$data);
                    //$this->renderPartialWithHisOwnClientScript($view_file,$data);
                    //$this->renderPartial($view_file, $data, false, false);
                } else {
                    $this->renderPartial($view_file, $data, false, true);
                    //$this->renderPartialWithHisOwnClientScript($view_file,$data);
                }
               
                
            } else {
                $this->render('sale', $data);
            }
        } else {
            throw new CHttpException(403, 'You are not authorized to perform this action');
        }
    }
   
    public function actionSaleInvoiceAlert($period = 'today')
    {
        $report = new Report;
        $report->unsetAttributes();  // clear any default values
        $date_view = 0;

        if ($period == 'choose') {
            if (isset($_GET['Report'])) {
                $report->attributes = $_GET['Report'];
                $from_date = $_GET['Report']['from_date'];
                $to_date = $_GET['Report']['to_date'];
            } else {
                $from_date = date('d-m-Y');
                $to_date = date('d-m-Y');
                $date_view = 1;
                //Yii::app()->clientScript->scriptMap['*.js'] = false;
                Yii::app()->clientScript->scriptMap['*.css'] = false;
                $cs = Yii::app()->clientScript;
                $cs->scriptMap = array(
                    'jquery.js' => false,
                    'bootstrap.js' => false,
                    'jquery.min.js' => false,
                    'bootstrap.notify.js' => false,
                    'bootstrap.bootbox.min.js' => false,
                    'jquery.yiigridview.js' => false,
                );
                echo CJSON::encode(array(
                    'status' => 'success',
                    'div' => $this->renderPartial('sale_alert_ajax', array('report' => $report, 'from_date' => $from_date, 'to_date' => $to_date, 'date_view' => $date_view), true, true),
                ));
                Yii::app()->end();
            }
        } else {
            switch ($period) {
                case 'today':
                    $from_date = date('d-m-Y');
                    $to_date = date('d-m-Y');
                    break;
                case 'yesterday':
                    $from_date = date('d-m-Y', strtotime('-1 day'));
                    $to_date = date('d-m-Y', strtotime('-1 day'));
                    break;
                case 'thismonth':
                    $from_date = date('01-m-Y');
                    $to_date = date('d-m-Y');
                    break;
                case 'lastmonth':
                    $from_date = date('01-m-Y', strtotime("-1 month"));
                    $d = new DateTime($from_date);
                    $to_date = $d->format('t-m-Y');
                    //$to_date=$d->format('Y-m-t',strtotime($from_date)); // will fail after year 2038
                    break;
                case 'choose':
                    $from_date = date('d-m-Y');
                    $to_date = date('d-m-Y');
                    break;
            }
        }

        if (!empty($_GET['Report']['sale_id'])) {
            $report->sale_id = $_GET['Report']['sale_id'];
        }

        $report->from_date = $from_date;
        $report->to_date = $to_date;

        if (Yii::app()->request->isAjaxRequest) {
            Yii::app()->clientScript->scriptMap['*.js'] = false;
            Yii::app()->clientScript->scriptMap['*.css'] = false;
            if (isset($_GET['ajax']) && $_GET['ajax'] == 'sale-alert-grid') {
                $this->render('sale_alert', array(
                    'report' => $report, 'from_date' => $from_date, 'to_date' => $to_date, 'date_view' => $date_view,
                ));
            } else {
                echo CJSON::encode(array(
                    'status' => 'success',
                    'div' => $this->renderPartial('sale_alert_ajax', array('report' => $report, 'from_date' => $from_date, 'to_date' => $to_date, 'date_view' => $date_view), true, false),
                ));
            }
        } else {
            $this->render('sale_alert', array('report' => $report, 'from_date' => $from_date, 'to_date' => $to_date, 'date_view' => $date_view));
        }
    }

    public function actionSaleInvoiceItem($sale_id, $employee_id)
    {
        if (Yii::app()->user->checkAccess('report.index')) {
        
            $model = new SaleItem('search');
            $model->unsetAttributes();  // clear any default values

            $payment = new SalePayment('search');
            //$payment->unsetAttributes();
            //$employee=Employee::model()->findByPk((int)$employee_id);
            //$cashier=$employee->first_name . ' ' . $employee->last_name;

            if (isset($_GET['SaleItem']))
                $model->attributes = $_GET['SaleItem'];

            if (Yii::app()->request->isAjaxRequest) {

                Yii::app()->clientScript->scriptMap['*.js'] = false;
                //Yii::app()->clientScript->scriptMap['*.css'] = false;

                if (isset($_GET['ajax']) && $_GET['ajax'] == 'sale-item-grid') {
                    $this->render('sale_item', array(
                        'model' => $model,
                        'payment' => $payment,
                        'sale_id' => $sale_id,
                        'employee_id' => $employee_id
                    ));
                } else {
                    echo CJSON::encode(array(
                        'status' => 'render',
                        'div' => $this->renderPartial('sale_item', array('model' => $model, 'payment' => $payment, 'sale_id' => $sale_id, 'employee_id' => $employee_id), true, true),
                    ));

                    Yii::app()->end();
                }
            } else {
                $this->render('sale_item', array('model' => $model));
            }
        } else {
            throw new CHttpException(403, 'You are not authorized to perform this action');
        }
    }

    public function actionTransaction($period = 'today')
    {
        $report = new Report;
        $report->unsetAttributes();  // clear any default values
        $date_view = 0;

        if (!empty($_GET['Report']['sale_id'])) {
            $report->sale_id = $_GET['Report']['sale_id'];
        }
  
        switch ($period) {
            case 'today':
                $from_date = date('d-m-Y');
                $to_date = date('d-m-Y');
                break;
            case 'yesterday':
                $from_date = date('d-m-Y', strtotime('-1 day'));
                $to_date = date('d-m-Y', strtotime('-1 day'));
                break;
            case 'thismonth':
                $from_date = date('01-m-Y');
                $to_date = date('d-m-Y');
                break;
            case 'lastmonth':
                $from_date = date('01-m-Y', strtotime("-1 month"));
                $d = new DateTime($from_date);
                $to_date = $d->format('t-m-Y');
                //$to_date=$d->format('Y-m-t',strtotime($from_date)); // will fail after year 2038
                break;
            case 'choose':
                if (isset($_GET['Report'])) {
                    $report->attributes = $_GET['Report'];
                    $from_date = $_GET['Report']['from_date'];
                    $to_date = $_GET['Report']['to_date'];
                    $date_view = 1;
                } else {
                    $from_date = date('d-m-Y');
                    $to_date = date('d-m-Y');
                    $date_view = 1;
                }
                //$view_file='sale_ajax_period';
                break;
        }

        if (!empty($_GET['Report']['receive_id'])) {
            $report->receive_id = $_GET['Report']['receive_id'];
        }

        $report->from_date = $from_date;
        $report->to_date = $to_date;

        if (Yii::app()->request->isAjaxRequest) {
            $cs = Yii::app()->clientScript;
            $cs->scriptMap = array(
                'jquery.js' => false,
                'bootstrap.js' => false,
                'jquery.min.js' => false,
                'bootstrap.notify.js' => false,
                'bootstrap.bootbox.min.js' => false,
                'jquery.yiigridview.js' => false,
                'jquery.ba-bbq.min.js'=>false,
            );
            if (isset($_GET['ajax']) && $_GET['ajax'] == 'receive-grid') {
                $this->render('receive', array(
                    'report' => $report, 'from_date' => $from_date, 'to_date' => $to_date, 'date_view' => $date_view,
                ));
            } else {
                echo CJSON::encode(array(
                    'status' => 'success',
                    'div' => $this->renderPartial('receive_ajax', array('report' => $report, 'from_date' => $from_date, 'to_date' => $to_date, 'date_view' => $date_view), true, true),
                ));
            }
        } else {
            $this->render('receive', array('report' => $report, 'from_date' => $from_date, 'to_date' => $to_date, 'date_view' => $date_view));
        }
    }

    public function actionTransactionItem($receive_id, $employee_id, $remark)
    {
        $model = new ReceivingItem('search');
        $model->unsetAttributes();  // clear any default values
        //$employee=Employee::model()->findByPk((int)$employee_id);
        //$cashier=$employee->first_name . ' ' . $employee->last_name;

        if (isset($_GET['SaleItem']))
            $model->attributes = $_GET['SaleItem'];

        if (Yii::app()->request->isAjaxRequest) {

            Yii::app()->clientScript->scriptMap['*.js'] = false;
            //Yii::app()->clientScript->scriptMap['*.css'] = false;

            if (isset($_GET['ajax']) && $_GET['ajax'] == 'receive-item-grid') {
                $this->render('receive_item', array('model' => $model, 'receive_id' => $receive_id, 'employee_id' => $employee_id, 'remark' => $remark));
            } else {
                echo CJSON::encode(array(
                    'status' => 'render',
                    'div' => $this->renderPartial('receive_item', array('model' => $model, 'receive_id' => $receive_id, 'employee_id' => $employee_id, 'remark' => $remark), true, true),
                ));

                Yii::app()->end();
            }
        } else {
            $this->render('receive_item', array('model' => $model, 'receive_id' => $receive_id, 'employee_id' => $employee_id, 'remark' => $remark));
        }
    }

    /**
     * Manages all models.
     */
    public function actionSaleSummary()
    {

        $report = new Report;
        //$report->unsetAttributes();  // clear any default values

        if (isset($_GET['Report'])) {
            $report->attributes = $_GET['Report'];
            $from_date = $_GET['Report']['from_date'];
            $to_date = $_GET['Report']['to_date'];
        } else {
            $from_date = date('d-m-Y');
            $to_date = date('d-m-Y');
        }

        $report->from_date = $from_date;
        $report->to_date = $to_date;

        if (Yii::app()->request->isAjaxRequest) {
            Yii::app()->clientScript->scriptMap['*.js'] = false;
            Yii::app()->clientScript->scriptMap['*.css'] = false;
            echo CJSON::encode(array(
                'status' => 'success',
                'div' => $this->renderPartial('sale_summary_ajax', array('report' => $report, 'from_date' => $from_date, 'to_date' => $to_date), true, false),
            ));
        } else {
            $this->render('sale_summary', array('report' => $report, 'from_date' => $from_date, 'to_date' => $to_date));
        }
    }

    /**
     * Manages all models.
     */
    public function actionSaleDaily()
    {
        $report = new Report;
        $report->unsetAttributes();  // clear any default values

        if (isset($_GET['Report'])) {
            $report->attributes = $_GET['Report'];
            $from_date = $_GET['Report']['from_date'];
            $to_date = $_GET['Report']['to_date'];
        } else {
            $from_date = date('d-m-Y');
            $to_date = date('d-m-Y');
        }

        $report->from_date = $from_date;
        $report->to_date = $to_date;

        if (Yii::app()->request->isAjaxRequest) {
            /*
              Yii::app()->clientScript->scriptMap['*.js'] = false;
              Yii::app()->clientScript->scriptMap['*.css'] = false;
              $this->renderPartial('sale_daily', array('report' => $report,'from_date'=>$from_date,'to_date'=>$to_date),false,true);
              Yii::app()->end();
             * 
             */
            echo CJSON::encode(array(
                'status' => 'success',
                'div' => $this->renderPartial('sale_daily_ajax', array('report' => $report, 'from_date' => $from_date, 'to_date' => $to_date), true, false),
            ));
        } else {
            $this->render('sale_daily', array('report' => $report, 'from_date' => $from_date, 'to_date' => $to_date));
        }
    }

    public function actionSaleHourly()
    {
        $report = new Report;
        $report->unsetAttributes();  // clear any default values

        if (isset($_GET['Report'])) {
            $report->attributes = $_GET['Report'];
            //$from_date=$_GET['Report']['from_date'];
            $to_date = $_GET['Report']['to_date'];
        } else {
            //$from_date=date('d-m-Y');
            $to_date = date('d-m-Y');
        }

        //$report->from_date=$from_date;
        $report->to_date = $to_date;

        if (Yii::app()->request->isAjaxRequest) {
            echo CJSON::encode(array(
                'status' => 'success',
                'div' => $this->renderPartial('sale_hourly_ajax', array('report' => $report, 'to_date' => $to_date), true, false),
            ));
        } else {
            $this->render('sale_hourly', array('report' => $report, 'to_date' => $to_date));
        }
    }

    /**
     * Manages all models.
     */
    public function actionPayment()
    {
        $report = new Report;
        $report->unsetAttributes();  // clear any default values

        if (isset($_GET['Report'])) {
            $report->attributes = $_GET['Report'];
            $from_date = $_GET['Report']['from_date'];
            $to_date = $_GET['Report']['to_date'];
        } else {
            $from_date = date('d-m-Y');
            $to_date = date('d-m-Y');
        }

        $report->from_date = $from_date;
        $report->to_date = $to_date;

        if (Yii::app()->request->isAjaxRequest) {
            /*
              Yii::app()->clientScript->scriptMap['*.js'] = false;
              Yii::app()->clientScript->scriptMap['*.css'] = false;
              $this->renderPartial('sale_daily', array('report' => $report,'from_date'=>$from_date,'to_date'=>$to_date),false,true);
              Yii::app()->end();
             * 
             */
            echo CJSON::encode(array(
                'status' => 'success',
                'div' => $this->renderPartial('payment_ajax', array('report' => $report, 'from_date' => $from_date, 'to_date' => $to_date), true, false),
            ));
        } else {
            $this->render('payment', array('report' => $report, 'from_date' => $from_date, 'to_date' => $to_date));
        }
    }

    /**
     * Daily Profit
     */
    public function actionDailyProfit()
    {
        $report = new Report;
        $report->unsetAttributes();  // clear any default values

        if (isset($_GET['Report'])) {
            $report->attributes = $_GET['Report'];
            $from_date = $_GET['Report']['from_date'];
            $to_date = $_GET['Report']['to_date'];
        } else {
            $from_date = date('d-m-Y');
            $to_date = date('d-m-Y');
        }

        $report->from_date = $from_date;
        $report->to_date = $to_date;

        if (Yii::app()->request->isAjaxRequest) {
            echo CJSON::encode(array(
                'status' => 'success',
                'div' => $this->renderPartial('sale_daily_profit_ajax', array('report' => $report, 'from_date' => $from_date, 'to_date' => $to_date), true, false),
            ));
        } else {
            $this->render('sale_daily_profit', array('report' => $report, 'from_date' => $from_date, 'to_date' => $to_date));
        }
    }

    /**
     * Top Product
     */
    public function actionTopProduct()
    {
        $report = new Report;
        $report->unsetAttributes();  // clear any default values

        if (isset($_GET['Report'])) {
            $report->attributes = $_GET['Report'];
            $from_date = $_GET['Report']['from_date'];
            $to_date = $_GET['Report']['to_date'];
        } else {
            $from_date = date('d-m-Y');
            $to_date = date('d-m-Y');
        }

        $report->from_date = $from_date;
        $report->to_date = $to_date;

        if (Yii::app()->request->isAjaxRequest) {
            echo CJSON::encode(array(
                'status' => 'success',
                'div' => $this->renderPartial('topproduct_ajax', array('report' => $report, 'from_date' => $from_date, 'to_date' => $to_date), true, false),
            ));
        } else {
            $this->render('topproduct', array('report' => $report, 'from_date' => $from_date, 'to_date' => $to_date));
        }
    }

    public function actionInventory($filter = 'all')
    {
        $report = new Report;
        $data = array();  
        
        $data['report'] = $report;
        $data['filter'] = $filter;

        if (Yii::app()->request->isAjaxRequest) {
            Yii::app()->clientScript->scriptMap['*.js'] = false;
            Yii::app()->clientScript->scriptMap['*.css'] = false;
            if (isset($_GET['ajax']) && $_GET['ajax'] == 'inventory-grid') {
                $this->render('inventory', $data);
            } else {

                $this->renderPartial('inventory_ajax',$data, false, false);

                /*
                echo CJSON::encode(array(
                    'status' => 'success',
                    'div' => $this->renderPartial('inventory_ajax', array('report' => $report, 'filter' => $filter), true, true),
                ));

                Yii::app()->end();
                 *
                */
            }
        } else {
            $this->render('inventory', array('report' => $report, 'filter' => $filter));
        }
    }
    
     public function actionStockCount($filter = 1)
    {
        $report = new Report;
        $report->unsetAttributes();  // clear any default values

        if (Yii::app()->request->isAjaxRequest) {
            
            Yii::app()->shoppingCart->setDayinterval($filter);
            
            Yii::app()->clientScript->scriptMap['*.js'] = false;
            Yii::app()->clientScript->scriptMap['*.css'] = false;

            if (isset($_GET['ajax']) && $_GET['ajax'] == 'stockcount-grid') {
                $this->render('stock_count', array('report' => $report, 'filter' => $filter));
            } else {
                echo CJSON::encode(array(
                    'status' => 'success',
                    'div' => $this->renderPartial('stock_count_ajax', array('report' => $report, 'filter' => $filter), true, true),
                ));

                Yii::app()->end();
            }
        } else {
            $this->render('stock_count', array('report' => $report, 'filter' => $filter));
        }
    }
    
    public function actionStockCountPrint()
    {
        
       
        $report = new Report;
        
        $data['report'] = $report;
        $data['filter'] = Yii::app()->shoppingCart->getDayinterval();
        $data['employee'] = ucwords(Yii::app()->session['emp_fullname']);
        $data['trans_date'] = Date('d-m-Y'); 
        $data['save_id'] = Item::model()->saveStockCount(Yii::app()->shoppingCart->getDayinterval());
        $data['items'] = Item::model()->stockItem(Yii::app()->shoppingCart->getDayinterval());
         
        if (count($data['items']) == 0) {
            $data['warning'] = Yii::t('app','There is no item to print...');
            $this->render('stock_count', $data);
        } else {
            $this->layout = '//layouts/column_receipt';
            $this->render('_stock_count_print', $data);
        }
         
    }

    public function actionItemExpiry($mfilter = '1')
    {
        $report = new Report;
        $report->unsetAttributes();  // clear any default values

        if (Yii::app()->request->isAjaxRequest) {
            Yii::app()->clientScript->scriptMap['*.js'] = false;
            Yii::app()->clientScript->scriptMap['*.css'] = false;

            if (isset($_GET['ajax']) && $_GET['ajax'] == 'rpt-item-expiry-grid') {
                $this->render('item_expiry', array('report' => $report, 'mfilter' => $mfilter));
            } else {
                echo CJSON::encode(array(
                    'status' => 'success',
                    'div' => $this->renderPartial('item_expiry_ajax', array('report' => $report, 'mfilter' => $mfilter), true, true),
                ));

                Yii::app()->end();
            }
        } else {
            $this->render('item_expiry', array('report' => $report, 'mfilter' => $mfilter));
        }
    }

    public function actionItemInactive($mfilter = '1')
    {
        $report = new Report;
        $report->unsetAttributes();  // clear any default values

        if (Yii::app()->request->isAjaxRequest) {
            Yii::app()->clientScript->scriptMap['*.js'] = false;
            Yii::app()->clientScript->scriptMap['*.css'] = false;

            if (isset($_GET['ajax']) && $_GET['ajax'] == 'rpt-item-inactive-grid') {
                $this->render('item_expiry', array('report' => $report, 'mfilter' => $mfilter));
            } else {
                echo CJSON::encode(array(
                    'status' => 'success',
                    'div' => $this->renderPartial('item_inactive_ajax', array('report' => $report, 'mfilter' => $mfilter), true, true),
                ));

                Yii::app()->end();
            }
        } else {
            $this->render('item_inactive', array('report' => $report, 'mfilter' => $mfilter));
        }
    }

    public function actionItemAsset()
    {
        $report = new Report;
        $this->render('item_asset', array('report' => $report));
    }

    public function actionSaleItemSummary($period = 'today')
    {
        $report = new Report;
        //$report->unsetAttributes();  // clear any default values

        if (isset($_GET['Report'])) {
            $report->attributes = $_GET['Report'];
            $from_date = $_GET['Report']['from_date'];
            $to_date = $_GET['Report']['to_date'];
        } else {
            $from_date = date('d-m-Y');
            $to_date = date('d-m-Y');
        }

        $report->from_date = $from_date;
        $report->to_date = $to_date;

        if (Yii::app()->request->isAjaxRequest) {
            Yii::app()->clientScript->scriptMap['*.js'] = false;
            Yii::app()->clientScript->scriptMap['*.css'] = false;
            echo CJSON::encode(array(
                'status' => 'success',
                'div' => $this->renderPartial('sale_item_summary_ajax', array('report' => $report, 'from_date' => $from_date, 'to_date' => $to_date), true, false),
            ));
        } else {
            $this->render('sale_item_summary', array('report' => $report, 'from_date' => $from_date, 'to_date' => $to_date));
        }
    }
    
    public function actionUserLogSummary($period = 'today')
    {
        $report = new Report;
  
        if (isset($_GET['Report'])) {
            $report->attributes = $_GET['Report'];
            $from_date = $_GET['Report']['from_date'];
            $to_date = $_GET['Report']['to_date'];
        } else {
            $from_date = date('d-m-Y');
            $to_date = date('d-m-Y');
        }

        $report->from_date = $from_date;
        $report->to_date = $to_date;

        if (Yii::app()->request->isAjaxRequest) {
            Yii::app()->clientScript->scriptMap['*.js'] = false;
            Yii::app()->clientScript->scriptMap['*.css'] = false;
            echo CJSON::encode(array(
                'status' => 'success',
                'div' => $this->renderPartial('user_log_sum_ajax', array('report' => $report, 'from_date' => $from_date, 'to_date' => $to_date), true, false),
            ));
        } else {
            $this->render('user_log_sum', array('report' => $report, 'from_date' => $from_date, 'to_date' => $to_date));
        }
    }
    
    public function actionUserLogDt($employee_id,$full_name)
    {
        $model = new UserLog('search');
        $model->unsetAttributes();  // clear any default values

        if (isset($_GET['UserLog']))
            $model->attributes = $_GET['UserLog'];

        if (Yii::app()->request->isAjaxRequest) {

            Yii::app()->clientScript->scriptMap['*.js'] = false;
     
            if (isset($_GET['ajax']) && $_GET['ajax'] == 'user-log-dt-grid') {
                $this->render('user_log_dt', array(
                    'model' => $model,
                    'employee_id' => $employee_id,
                    'full_name' => $full_name,
                ));
            } else {
                echo CJSON::encode(array(
                    'status' => 'render',
                    'div' => $this->renderPartial('user_log_dt', array('model' => $model,'employee_id' => $employee_id,'full_name' => $full_name,), true, true),
                ));

                Yii::app()->end();
            }
        } else {
            $this->render('user_log_dt', array('model' => $model,'employee_id' => $employee_id,'full_name' => $full_name,));
        }
    }


    public function actionOutStandingInvoice()
    {
        $report = new Report;

        if (!empty($_GET['Report']['search_id'])) {
            $report->search_id = $_GET['Report']['search_id'];
        }

        if (Yii::app()->request->isAjaxRequest) {


            if (isset($_GET['ajax']) && $_GET['ajax'] == 'outstanding-invoice-grid') {
                $this->render('outstanding_inv', array('report' => $report));

            } else    {
                Yii::app()->clientScript->scriptMap['*.js'] = false;
                Yii::app()->clientScript->scriptMap['*.css'] = false;
                echo CJSON::encode(array(
                    'status' => 'success',
                    'div' => $this->renderPartial('outstanding_inv_ajax', array('report' => $report), true, false),
                ));
            }
        } else {
            $this->render('outstanding_inv', array('report' => $report));
        }
    }

    public function actionSaleSummarybySaleRep()
    {

        $report = new Report;
        //$report->unsetAttributes();  // clear any default values

        if (isset($_GET['Report'])) {
            $report->attributes = $_GET['Report'];
            $from_date = $_GET['Report']['from_date'];
            $to_date = $_GET['Report']['to_date'];
        } else {
            $from_date = date('d-m-Y');
            $to_date = date('d-m-Y');
        }

        $report->from_date = $from_date;
        $report->to_date = $to_date;

        if (Yii::app()->request->isAjaxRequest) {
            Yii::app()->clientScript->scriptMap['*.js'] = false;
            Yii::app()->clientScript->scriptMap['*.css'] = false;
            echo CJSON::encode(array(
                'status' => 'success',
                'div' => $this->renderPartial('sale_summary_by_salerep_ajax', array('report' => $report, 'from_date' => $from_date, 'to_date' => $to_date), true, false),
            ));
        } else {
            $this->render('sale_summary_by_salerep', array('report' => $report, 'from_date' => $from_date, 'to_date' => $to_date));
        }
    }
	
	public function actionSaleItemSumbyCust($period = 'today')
    {
        $report = new Report;
        //$report->unsetAttributes();  // clear any default values

        if (isset($_GET['Report'])) {
            $report->attributes = $_GET['Report'];
            $from_date = $_GET['Report']['from_date'];
            $to_date = $_GET['Report']['to_date'];
        } else {
            $from_date = date('d-m-Y');
            $to_date = date('d-m-Y');
        }

        $report->from_date = $from_date;
        $report->to_date = $to_date;

        if (Yii::app()->request->isAjaxRequest) {
            Yii::app()->clientScript->scriptMap['*.js'] = false;
            Yii::app()->clientScript->scriptMap['*.css'] = false;
            echo CJSON::encode(array(
                'status' => 'success',
                'div' => $this->renderPartial('sale_item_sum_bycust_ajax', array('report' => $report, 'from_date' => $from_date, 'to_date' => $to_date), true, false),
            ));
        } else {
            $this->render('sale_item_sum_bycust', array('report' => $report, 'from_date' => $from_date, 'to_date' => $to_date));
        }
    }
    

}
