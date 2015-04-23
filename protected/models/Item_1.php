<?php

/**
 * This is the model class for table "item".
 *
 * The followings are the available columns in table 'item':
 * @property integer $id
 * @property string $name
 * @property string $item_number
 * @property integer $category_id
 * @property integer $supplier_id
 * @property double $cost_price
 * @property double $unit_price
 * @property double $quantity
 * @property double $reorder_level
 * @property string $location
 * @property integer $allow_alt_description
 * @property integer $is_serialized
 * @property string $description
 * @property integer $deleted
 *
 * The followings are the available model relations:
 * @property Supplier $supplier
 * @property Category $category
 */
class Item extends CActiveRecord
{
	
       
        /**
	 * Returns the static model of the specified AR class.
	 * @param string $className active record class name.
	 * @return Item the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}

	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'item';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('name, cost_price, unit_price, quantity', 'required'),
			array('category_id, supplier_id, allow_alt_description, is_serialized, deleted', 'numerical', 'integerOnly'=>true),
			array('cost_price, unit_price, quantity, reorder_level', 'numerical'),
			array('name', 'length', 'max'=>50),
			array('item_number', 'length', 'max'=>255),
			array('location', 'length', 'max'=>20),
			array('description', 'safe'),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('id, name, item_number, category_id, supplier_id, cost_price, unit_price, quantity, reorder_level, location, allow_alt_description, is_serialized, description, deleted', 'safe', 'on'=>'search'),
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
			'supplier' => array(self::BELONGS_TO, 'Supplier', 'supplier_id'),
			'category' => array(self::BELONGS_TO, 'Category', 'category_id'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id' => 'ID',
			'name' => 'Item Name',
			'item_number' => 'UPC/EAN/ISBN:',
			'category_id' => 'Category',
			'supplier_id' => 'Supplier',
			'cost_price' => 'Cost Price',
			'unit_price' => 'Unit Price',
			'quantity' => 'Quantity',
			'reorder_level' => 'Reorder Level',
			'location' => 'Location',
			'allow_alt_description' => 'Allow Alt Description',
			'is_serialized' => 'Is Serialized',
			'description' => 'Description',
			'deleted' => 'Deleted',
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

		$criteria=new CDbCriteria;

		$criteria->compare('id',$this->id);
		$criteria->compare('name',$this->name,true);
		$criteria->compare('item_number',$this->item_number,true);
		$criteria->compare('category_id',$this->category_id);
		$criteria->compare('supplier_id',$this->supplier_id);
		$criteria->compare('cost_price',$this->cost_price);
		$criteria->compare('unit_price',$this->unit_price);
		$criteria->compare('quantity',$this->quantity);
		$criteria->compare('reorder_level',$this->reorder_level);
		$criteria->compare('location',$this->location,true);
		$criteria->compare('allow_alt_description',$this->allow_alt_description);
		$criteria->compare('is_serialized',$this->is_serialized);
		$criteria->compare('description',$this->description,true);
		$criteria->compare('deleted',$this->deleted);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}
        
         /*
         * Look up item(s)
         */
        public static function getItem($name = '') {

            // Recommended: Secure Way to Write SQL in Yii 
            $sql = 'SELECT id ,concat_ws(" : ",name,unit_price) AS text 
                    FROM item 
                    WHERE (name LIKE :name or item_number=:item_number)';
            $name = '%' . $name . '%';
            $item_number = $name;
            return Yii::app()->db->createCommand($sql)->queryAll(true, array(':name' => $name, ':item_number'=>$item_number));
       
        }
        
        /*
         * Add product to cart session
         */
        public function addItemToCart($id)
        {
            $session=Yii::app()->session;
            $arr_session=array();
            $model=Item::model()->findbyPk($id);
            $my_product=$model->attributes;
            if(isset($session['cart']))
            {
                $arr_session=$session['cart'];
                if(array_key_exists($id,$session['cart']))
                {
                    $arr_session=$session['cart'];
                    $arr_session[$id]['quantity']++;
                    $session['cart']=$arr_session;
                    
                }else{
                    $arr_session=$session['cart'];
                    $arr_session[$id]=$my_product;
                    $arr_session[$id]['quantity']=1;
                    $arr_session[$id]['discount']=0;
                    //$arr_session['0']['payment_amount']=0;
                    $session['cart']=$arr_session;
                }
            }else{
                $session['cart']=array($id=>$my_product,);
                $arr_session=$session['cart'];
                $arr_session[$id]['quantity']=1;
                $arr_session[$id]['discount']=0;
                //$arr_session['0']['payment_amount']=0;
                $session['cart']=$arr_session;
            }
         }
         
         /*
          * Creating payment session
          */
         public function addPaymentToCart($payment_id)
         {
             $session=Yii::app()->session;
             $arr_session=array();
             
             if(isset($session['payment']))
             {
                 $arr_session=$session['payment'];
                 if(!array_key_exists($payment_id, $session['payment']))
                 {
                     $arr_session=$session['payment'];
                     $arr_session[$payment_id]['payment_amount']=0;
                     $session['payment']=$arr_session;
                 }  
             }
             else
             {
                 $session['payment']=array($payment_id=>$payment_id);
                 $arr_session=$session['payment'];
                 $arr_session[$payment_id]['payment_amount']=0;
                 $session['payment']=$arr_session;
             }
         }
}