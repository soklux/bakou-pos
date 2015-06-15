<?php

/**
 * This is the model class for table "sale".
 *
 * The followings are the available columns in table 'sale':
 * @property integer $id
 * @property string $sale_time
 * @property integer $customer_id
 * @property integer $employee_id
 * @property double $sub_total
 * @property string $payment_type
 * @property string $status
 * @property string $remark
 * @property double $discount_amount
 * @property integer $discount_percent
 * @property integer $salerep_id
 *
 * The followings are the available model relations:
 * @property SaleItem[] $saleItems
 */
class Sale extends CActiveRecord
{

    public $search;
    public $amount;
    public $quantity;
    public $from_date;
    public $to_date;
    public $balance;
    public $data_paid;
    public $note;
    public $sale_id;

    // To do: to remove using params in main config file instead
    const sale_cancel_status = '0';
    const sale_complete_status = '1';
    const sale_suspend_status = '2';

    /**
     * Returns the static model of the specified AR class.
     * @param string $className active record class name.
     * @return Sale the static model class
     */
    public static function model($className = __CLASS__)
    {
        return parent::model($className);
    }

    /**
     * @return string the associated database table name
     */
    public function tableName()
    {
        return 'sale';
    }

    /**
     * @return array validation rules for model attributes.
     */
    public function rules()
    {
        // NOTE: you should only define rules for those attributes that
        // will receive user inputs.
        return array(
            //array('sale_time', 'required'),
            array('client_id, employee_id', 'numerical', 'integerOnly' => true),
            array('sub_total, discount_amount', 'numerical'),
            array('status', 'length', 'max' => 25),
            array('payment_type', 'length', 'max' => 255),
            array('sale_time', 'default', 'value' => date('Y-m-d H:i:s'), 'setOnEmpty' => true, 'on' => 'insert'),
            array('remark, sale_time, discount_type', 'safe'),
            // The following rule is used by search().
            // Please remove those attributes that should not be searched.
            array('id, sale_time, client_id, employee_id, sub_total, payment_type,status, remark, discount_amount, discount_type', 'safe', 'on' => 'search'),
        );
    }

    /**
     * @return array relational rules.
     */
    public function relations()
    {
        // NOTE: you may need to adjust the relation name and the related
        // class name for the relations automatically generated below.
        return array(
            'saleItems' => array(self::HAS_MANY, 'SaleItem', 'sale_id'),
            'employee' => array(self::BELONGS_TO, 'Employee', 'employee_id'),
            'client' => array(self::BELONGS_TO, 'Client', 'client_id'),
        );
    }

    /**
     * @return array customized attribute labels (name=>label)
     */
    public function attributeLabels()
    {
        return array(
            'id' => 'ID',
            'sale_time' => 'Sale Time',
            'client_id' => 'Customer name',
            'employee_id' => 'Employee',
            'sub_total' => 'Amount',
            'payment_type' => 'Payment Type',
            'status' => 'Status',
            'remark' => 'Remark',
            'discount_amount' => Yii::t('app','model.saleitem.discount_amount'), // 'Discount Amount',
            'discount_type' => Yii::t('app','model.saleitem.discount_type'),//'Discount Type',
        );
    }

    /**
     * Retrieves a list of models based on the current search/filter conditions.
     * @return CActiveDataProvider the data provider that can return the models based on the search/filter conditions.
     */
    public function search()
    {
        // Warning: Please modify the following code to remove attributes that
        // should not be searched.

        $criteria = new CDbCriteria;

        //$criteria->compare('id', $this->id);
        $criteria->compare('sale_time', $this->sale_time, true);
        $criteria->compare('client_id', $this->client_id);
        $criteria->compare('employee_id', $this->employee_id);
        //$criteria->compare('sub_total', $this->sub_total);
        //$criteria->compare('payment_type', $this->payment_type, true);
        $criteria->compare('status', $this->status, true);
       // $criteria->compare('remark', $this->remark, true);

        return new CActiveDataProvider($this, array(
            'criteria' => $criteria,
        ));
    }

    public function saveSale($in_sale_id, $items, $payments, $payment_received, $customer_id, $employee_id, $sub_total, $total, $comment, $status = self::sale_complete_status, $discount_amount,$discount_symbol,$gst_amount,$sale_rep_id)
    {
        if (count($items) == 0) {
            return '-1';
        }
        
        $message="";

        //Check if invoice already exists
        $model = Sale::model()->findSale($in_sale_id);
        
        $payment_types = '';
        foreach ($payments as $payment_id => $payment) {
            $payment_types = $payment_types . $payment['payment_type'] . ': ' . $payment['payment_amount'] . '<br />';
        }

        $transaction = Yii::app()->db->beginTransaction();
        try {

            // Transaction Date for Inventory, Payment and sale trans date
            $trans_date = date('Y-m-d H:i:s');

            // Getting Customer Account Info
            $account = Account::model()->getAccountInfo($customer_id);

            $old_total = $this->getOldSaleTotal($in_sale_id);

            //Rolling back the Sale Total of old / previous Sale & Saving Change / Edit Sale into [account receivable] table
            if ($account && $in_sale_id) {
                AccountReceivable::model()->saveAccountRecv($account->id, $employee_id, $in_sale_id, -$old_total,$trans_date,'Edit Sale', 'CHASALE','R');
                Account::model()->withdrawAccountBal($account,$old_total);
            }
            
            //Saving existing Sale Item to Inventory table and removing it out
            $this->updateSale($in_sale_id, $employee_id,$trans_date);
             
            $model->client_id = $customer_id;
            $model->employee_id = $employee_id;
            $model->payment_type = $payment_types;
            $model->remark = $comment;
            $model->sub_total = $sub_total;
            $model->status = $status;
            $model->discount_amount = $discount_amount === null ? 0 : $discount_amount;
            $model->discount_type = $discount_symbol === null ? '%' : $discount_symbol;
            $model->vat = $gst_amount == null ? 0 : $gst_amount;
            $model->salerep_id = $sale_rep_id;

            if ($model->save()) {
                $sale_id = $model->id;
                $date_paid = $trans_date;
                $trans_code = 'CHSALE';
                $trans_status = $total > 0 ? 'N' : 'R'; // If Return Sale Transaction Type = 'CHSALE' same but Transaction Status = 'R' reverse
                
                // Saving Sale Item (Sale & Sale Item gotta save firstly even for Suspended Sale)
                $this->saveSaleItem($items, $sale_id, $employee_id);
                
                // We only save Sale Payment, Account Receivable transaction and update Account (outstanding balance) of completed sale transaction
                if ( $status == self::sale_complete_status ) {

                    //$account = Account::model()->getAccountInfo($customer_id);

                    if ($account) {
                        // Add hot bill before proceed payment
                        Account::model()->depositAccountBal($account,$total);
                        SalePayment::model()->batchPayment($customer_id,$employee_id,$account,$payment_received,$date_paid,$comment);
                        //Saving Account Receivable for Sale transaction code = 'CHSALE'
                        AccountReceivable::model()->saveAccountRecv($account->id, $employee_id, $sale_id, $total,$trans_date,$comment, $trans_code, $trans_status);
                    } else {
                        // If no customer selected only Sale Payment History
                        PaymentHistory::model()->savePaymentHistory($customer_id,$payment_received, $date_paid, $employee_id, $comment);
                    }
                }
                
                $message = $sale_id;
                $transaction->commit();
            }
        } catch (Exception $e) {
            $transaction->rollback();
            $message = '-1' . $e->getMessage();
        }
        
        return $message;
    }
    
    protected function findSale($in_sale_id) 
    {
        if ($in_sale_id) {
            $model = Sale::model()->findByPk((int)$in_sale_id);
        } else {
            $model = new Sale;
        }
        return $model;
    }

    // Rolling back Account & Account Receivable for Edit Sale
    protected function getOldSaleTotal($in_sale_id)
    {
        $total = 0;
        $sql = "SELECT format(total,2) total
               FROM v_sale
               WHERE id=:sale_id
               AND `status`=:status";

        $result = Yii::app()->db->createCommand($sql)->queryAll(true,
            array(':sale_id' => $in_sale_id, ':status' => Yii::app()->params['sale_complete_status']));

        foreach ($result as $record) {
            $total = $record['total'];
        }

        return $total;

    }

    // If Sale ID already exist in DB, this is consider as a change sale transaction
    protected function updateSale($in_sale_id,$employee_id,$trans_date)
    {
        if ($in_sale_id) {
            
            $trans_comment='Change Sale';
            $this->updateItemInventory($in_sale_id,$trans_date,$trans_comment,$employee_id);

            $sql1="insert into sale_item_log
                   select * from sale_item
                   where sale_id=:sale_id";
            
            $command1 = Yii::app()->db->createCommand($sql1);
            $command1->bindParam(":sale_id", $in_sale_id, PDO::PARAM_INT);
            $command1->execute();
            
            $sql2 = "delete from sale_item where sale_id=:sale_id";
            $command2 = Yii::app()->db->createCommand($sql2);
            $command2->bindParam(":sale_id", $in_sale_id, PDO::PARAM_INT);
            $command2->execute();
        }
    }

    // In Sale Update Transaction
    protected function updateItemInventory($in_sale_id,$trans_date,$trans_comment,$employee_id)
    {
            $sql = "INSERT INTO inventory(trans_items,trans_user,trans_date,trans_comment,trans_inventory,t)
                    SELECT si.item_id,:employee_id trans_user,:trans_date trans_date,:trans_comment trans_comment,si.quantity
                    FROM sale_item si INNER JOIN sale s ON s.id=si.sale_id and s.id=:sale_id
                    ";
            
            // Rolling back the previous sale QTY so QTY After Transaction = [Cur QTY in Stock] + [Previous Sale Qty]
            $sql = "INSERT INTO inventory(trans_items,trans_user,trans_date,trans_comment,trans_inventory,qty_b4_trans,qty_af_trans)
                    SELECT si.item_id,:employee_id trans_user,:trans_date trans_date,:trans_comment trans_comment,si.quantity,i.quantity,
                           (i.quantity+si.quantity) qty_af_transaction
                    FROM sale_item si, sale s, item i
                    WHERE s.id=:sale_id 
                    and si.sale_id=s.id 
                    AND si.`item_id`=i.id";

            $command = Yii::app()->db->createCommand($sql);

            $trans_comment = $trans_comment . ' ' . $in_sale_id;
            $command->bindParam(":trans_date", $trans_date);
            $command->bindParam(":trans_comment", $trans_comment, PDO::PARAM_STR);
            $command->bindParam(":employee_id", $employee_id, PDO::PARAM_INT);
            $command->bindParam(":sale_id", $in_sale_id, PDO::PARAM_INT);

            $command->execute();

            // Rolling back previous sale Item Quantity to stock
            $sql1 = "UPDATE item t1 
                        INNER JOIN sale_item t2 
                             ON t1.id = t2.item_id
                    SET t1.quantity = t1.quantity+t2.quantity
                    WHERE t2.sale_id=:sale_id";

            $command1 = Yii::app()->db->createCommand($sql1);
            $command1->bindParam(":sale_id", $in_sale_id, PDO::PARAM_INT);
            $command1->execute();
    }

    // Saving into Sale_Item table for each item purchased
    protected function saveSaleItem($items, $sale_id, $employee_id)
    {
        // Saving sale item to sale_item table
        foreach ($items as $line => $item) {
            $cur_item_info = Item::model()->findbyPk($item['item_id']);
            $qty_in_stock = $cur_item_info->quantity;

            if (substr($item['discount'], 0, 1) == '$') {
                $discount_amount = substr($item['discount'], 1);
                $discount_type = '$';
            } else {
                $discount_amount = $item['discount'];
                $discount_type = '%';
            }

            $sale_item = new SaleItem;

            $sale_item->sale_id = $sale_id;
            $sale_item->item_id = $item['item_id'];
            $sale_item->line = $line;
            $sale_item->quantity = $item['quantity'];
            $sale_item->cost_price = $cur_item_info->cost_price;
            $sale_item->unit_price = $cur_item_info->unit_price;
            $sale_item->price = $item['price']; // The exact selling price
            $sale_item->discount_amount = $discount_amount == null ? 0 : $discount_amount;
            $sale_item->discount_type = $discount_type;

            $sale_item->save();
            
            $qty_afer_transaction = $qty_in_stock - $item['quantity'];

            //Updating stock quantity
            $cur_item_info->quantity = $qty_afer_transaction;
            $cur_item_info->save();
            
            //Ramel Inventory Tracking
            $inventory = new Inventory;
            $qty_buy = -$item['quantity'];
            $sale_remarks = 'POS ' . $sale_id;
            $inventory->trans_items = $item['item_id'];
            $inventory->trans_user = $employee_id;
            $inventory->trans_comment = $sale_remarks;
            $inventory->trans_inventory = $qty_buy;
            $inventory->trans_qty = $item['quantity'];
            $inventory->qty_b4_trans = $qty_in_stock;  // for tracking purpose recording the qty before operation effected
            $inventory->qty_af_trans = $qty_afer_transaction;
            $inventory->trans_date = date('Y-m-d H:i:s');
            $inventory->save();
            
            //Update quantity in expiry table
            //$this->updateStockExpire($item['item_id'], $item['quantity'], $sale_id);
        }
    }

    public function updateStockExpire($item_id, $quantity, $sale_id)
    {
        $sql = "SELECT `id`,`item_id`,`expire_date`,`quantity`
                FROM `item_expire`
                WHERE item_id=:item_id
                AND quantity>0
                ORDER BY expire_date";
        $result = Yii::app()->db->createCommand($sql)->queryAll(true, array(':item_id' => $item_id));
        if ($result) {
            foreach ($result as $record) {
                $item_expire = ItemExpire::model()->find('id=:id', array(':id' => $record["id"]));
                if ($quantity <= $record["quantity"]) {
                    $item_expire->quantity = $item_expire->quantity - $quantity;
                    $item_expire->save();
                    $item_expire_dt = new ItemExpireDt;
                    $item_expire_dt->item_expire_id=$item_expire->id;
                    $item_expire_dt->trans_id=$sale_id;
                    $item_expire_dt->trans_qty=-$quantity;
                    $item_expire_dt->trans_comment='POS ' . $sale_id;
                    $item_expire_dt->modified_date=date('Y-m-d H:s:i');
                    $item_expire_dt->save();
                    break;
                } else {
                    $deducted_qty=$item_expire->quantity;
                    $item_expire->quantity = $item_expire->quantity - $deducted_qty;
                    $item_expire->save();

                    $item_expire_dt = new ItemExpireDt;
                    $item_expire_dt->item_expire_id=$item_expire->id;
                    $item_expire_dt->trans_id=$sale_id;
                    $item_expire_dt->trans_qty=-$quantity;
                    $item_expire_dt->trans_comment='POS ' . $sale_id;
                    $item_expire_dt->modified_date=date('Y-m-d H:s:i');
                    $item_expire_dt->save();
                    $quantity = $quantity - $deducted_qty;
                }
            }
        }
    }

    public function deleteSale($sale_id, $remark,$customer_id, $employee_id, $status = self::sale_cancel_status)
    {

        $transaction = Yii::app()->db->beginTransaction();
        try {

            $trans_date = date('Y-m-d H:i:s');
            $trans_comment='Cancel Sale';
            $trans_code='CHSALE';
            $trans_status='R';

            $this->updateItemInventory($sale_id,$trans_date,$trans_comment,$employee_id);

            $sale = $this->findByPk($sale_id);

            //$sale_amount = ($sale->sub_total - ($sale->sub_total*$sale->discount_amount)/100);
            //$customer_id = $sale->client_id;

            $total = $this->getOldSaleTotal($sale_id);

            $sale->status=$status;
            $sale->remark=$remark;
            $sale->save();

            // Updating current_balance in account table
            //$account = $this->updateAccount($customer_id, $sale_amount);
            $account = Account::model()->getAccountInfo($customer_id);

            if ($account) {
                // Rollback Account = Outstanding Balance + Total Sub
                Account::model()->withdrawAccountBal($account,$total);
                // Saving to Account Receivable where trans_cod='R' reverse (Payment, Sale Transaction ..)
                AccountReceivable::model()->saveAccountRecv($account->id, $employee_id, $sale_id, $total,$trans_date,$trans_comment, $trans_code, $trans_status);
                //$this->saveAR($account->id, $employee_id, $sale_id, $sale_amount, 0, $trans_date,'CHSALE','R');
            }

            $transaction->commit();

        } catch (Exception $e) {
            $transaction->rollback();
            return -1;
        }

        //2nd Way using store procedure in mysql database
        //$sql = "CALL pro_cancelsale(:sale_id,:remark)";
        //return Yii::app()->db->createCommand($sql)->queryAll(true, array(':sale_id' => $sale_id, ':remark' => $remark));
    }

    public function saveSaleCookie($items, $customer_id, $employee_id, $comment)
    {
        if (count($items) == 0 && !isset($customer_id)) {
            return -1;
        }

        $transaction = Yii::app()->db->beginTransaction();
        try {
            $query = "delete from sale_client_cookie where client_id=:client_id";
            $command = Yii::app()->db->createCommand($query);
            $command->bindParam(":client_id", $customer_id, PDO::PARAM_INT);
            $command->execute();

            // Saving sale item to sale_item table
            foreach ($items as $line => $item) {

                if (substr($item['discount'], 0, 1) == '$') {
                    $discount_amount = substr($item['discount'], 1);
                    $discount_type = '$';
                } else {
                    $discount_amount = $item['discount'];
                    $discount_type = '%';
                }

                $cur_item_info = Item::model()->findbyPk($item['item_id']);

                //Saving frequency buy items for client
                $sale_client_cookie = new SaleClientCookie;
                $sale_client_cookie->client_id = $customer_id;
                $sale_client_cookie->item_id = $item['item_id'];
                $sale_client_cookie->quantity = $item['quantity'];
                $sale_client_cookie->cost_price = $cur_item_info->cost_price;
                $sale_client_cookie->unit_price = $cur_item_info->unit_price;
                $sale_client_cookie->price = $item['price']; // The exact selling price
                $sale_client_cookie->discount_amount = $discount_amount == null ? 0 : $discount_amount;
                $sale_client_cookie->discount_type = $discount_type;
                $sale_client_cookie->save();
            }
            $transaction->commit();
        } catch (Exception $e) {
            //$sale_id=$e; //Uncomment here for debuggin purpose
            $transaction->rollback();
            return -1;
        }
        //return $sale_id;
    }

    public static function itemAlias($type, $code = NULL)
    {

        $_items = array(
            'register_mode' => array(
                'Sale' => 'Sale',
                'Return' => 'Return',
            ),
        );

        if (isset($code))
            return isset($_items[$type][$code]) ? $_items[$type][$code] : false;
        else
            return isset($_items[$type]) ? $_items[$type] : false;
    }

    public function Invoice($client_id = 0)
    {

        if ($client_id == 0) {
            $sql = "SELECT sale_id,sale_time,client_id,amount,(amount-paid) amount_to_paid,paid,balance
                    FROM v_cust_invoice";
            
            $rawData = Yii::app()->db->createCommand($sql)->queryAll(true);
        } else { 
            $sql="SELECT sale_id,sale_time,client_id,amount,(amount-paid) amount_to_paid,paid,balance
                  FROM v_cust_invoice 
                  WHERE client_id=:client_id
                  ORDER BY sale_time";

            $rawData = Yii::app()->db->createCommand($sql)->queryAll(true, array(':client_id' => (int) $client_id));
        }

        $dataProvider = new CArrayDataProvider($rawData, array(
            //'id'=>'saleinvoice',
            'keyField' => 'sale_id',
            'sort' => array(
                'attributes' => array(
                    'sale_time',
                ),
            ),
            'pagination' => false,
        ));

        return $dataProvider; // Return as array object
    }


    public function datePaid($sale_id)
    {

        $sql = "SELECT date_format(t1.date_paid,'%d-%m-%Y %H:%i') date_paid
                  FROM sale_payment t1 INNER JOIN (
                            SELECT MAX(date_paid) date_paid FROM sale_payment WHERE sale_id=:sale_id) t2
                           ON t1.`date_paid`=t2.date_paid
                  WHERE sale_id=:sale_id";

        $result = Yii::app()->db->createCommand($sql)->queryAll(true, array(':sale_id' => $sale_id));

        if ($result) {
            foreach ($result as $record) {
                $string = $record['date_paid'];
            }
            return $string;
        } else {
            return 'N/A';
        }
    }

    public function paymentNote($sale_id)
    {

        $sql = "SELECT t1.`note`
                  FROM sale_payment t1 INNER JOIN (
                            SELECT MAX(date_paid) date_paid FROM sale_payment WHERE sale_id=:sale_id) t2
                           ON t1.`date_paid`=t2.date_paid
                  WHERE sale_id=:sale_id";

        $result = Yii::app()->db->createCommand($sql)->queryAll(true, array(':sale_id' => $sale_id));

        if ($result) {
            foreach ($result as $record) {
                $string = $record['note'];
            }
            return $string;
        } else {
            return 'N/A';
        }
    }

    public function ListSuspendSale()
    {

        $sql = "SELECT s.id sale_id,
                      CONCAT(c.first_name,' ',c.last_name) customer_name, c.client_id,
                      DATE_FORMAT(s.sale_time,'%d-%m-%Y %H:%i') sale_time,st.items,remark
                FROM sale s INNER JOIN (SELECT si.sale_id, GROUP_CONCAT(i.name) items
                                            FROM sale_item si INNER JOIN item i ON i.id=si.item_id 
                                            GROUP BY si.sale_id
                                            ) st ON st.sale_id=s.id
                     left join `client` c on c.`id` = s.`client_id`
                WHERE status='2'";

        $rawData = Yii::app()->db->createCommand($sql)->queryAll(true);

        $dataProvider = new CArrayDataProvider($rawData, array(
            //'id'=>'saleinvoice',
            'keyField' => 'sale_id',
            'sort' => array(
                'attributes' => array(
                    'sale_time',
                ),
            ),
            'pagination' => false,
        ));

        return $dataProvider; // Return as array object
    }

    /* List all Same Item by Sale ID */

    public function getSaleItem($sale_id)
    {
        $model = SaleItem::model()->findAll('sale_id=:saleId', array(':saleId' => $sale_id));
        return $model;
    }

}
