<?php

/**
 * This is the model class for table "client".
 *
 * The followings are the available columns in table 'client':
 * @property integer $id
 * @property integer $price_tier_id
 * @property string $first_name
 * @property string $last_name
 * @property string $mobile_no
 * @property string $address1
 * @property string $address2
 * @property integer $city_id
 * @property string $country_code
 * @property string $email
 * @property string $notes
 * @property string $status
 * @property date $created_at
 * @property date $updated_at
 * @property integer $employee_id
 *
 * The followings are the available model relations:
 * @property Account[] $accounts
 */
class Client extends CActiveRecord
{
        public $search;
        private $_active_status='1';
        private $_inactive_status='0';
    
        /**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'client';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('first_name, mobile_no', 'required'),
			array('city_id, price_tier_id, employee_id', 'numerical', 'integerOnly'=>true),
			array('first_name, last_name', 'length', 'max'=>100),
			array('mobile_no', 'length', 'max'=>15),
			array('address1, address2', 'length', 'max'=>60),
			array('country_code', 'length', 'max'=>2),
			array('email', 'length', 'max'=>30),
			array('status', 'length', 'max'=>1),
			array('notes', 'safe'),
            array('created_at,updated_at', 'default', 'value' => date('Y-m-d H:i:s'), 'setOnEmpty' => true, 'on' => 'insert'),
            array('updated_at', 'default', 'value' => date('Y-m-d H:i:s'), 'setOnEmpty' => false, 'on' => 'update'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id, price_tier_id, first_name, last_name, mobile_no, address1, address2, city_id, country_code, email, notes, status, search, employee_id', 'safe', 'on'=>'search'),
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
			'accounts' => array(self::HAS_MANY, 'Account', 'client_id'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id' => 'ID',
			'first_name' => Yii::t('app','First Name'),
			'last_name' => Yii::t('app','Last Name'),
			'mobile_no' => Yii::t('app','Mobile No'),
			'address1' => Yii::t('app','Address1'),
			'address2' => Yii::t('app','Address2'),
			'city_id' => Yii::t('app','City'),
			'country_code' => Yii::t('app','Country Code'),
			'email' => Yii::t('app','Email'),
			'notes' => Yii::t('app','Notes'),
			'status' => Yii::t('app','Status'),
                        'search' => Yii::t('app','Search') . Yii::t('app','Customer') ,
		);
	}

	/**
	 * Retrieves a list of models based on the current search/filter conditions.
	 *
	 * Typical usecase:
	 * - Initialize the model fields with values from filter form.
	 * - Execute this method to get CActiveDataProvider instance which will filter
	 * models according to data in model fields.
	 * - Pass data provider to CGridView, CListView or any similar widget.
	 *
	 * @return CActiveDataProvider the data provider that can return the models
	 * based on the search/filter conditions.
	 */
    public function search($client_id = null)
    {
        // @todo Please modify the following code to remove attributes that should not be searched.

        $criteria = new CDbCriteria;


        if ($client_id !== null) {
            $criteria->compare('id', $client_id);
        }

        //$criteria->compare('first_name',$this->first_name,true);
        //$criteria->compare('last_name',$this->last_name,true);
        //$criteria->compare('mobile_no',$this->mobile_no,true);
        //$criteria->compare('address1',$this->address1,true);
        //$criteria->compare('address2',$this->address2,true);
        //$criteria->compare('city_id',$this->city_id);
        //$criteria->compare('country_code',$this->country_code,true);
        //$criteria->compare('email',$this->email,true);
        //$criteria->compare('notes',$this->notes,true);
        //$criteria->compare('status',$this->status,true);

        //$criteria->addSearchCondition('status',$this->_active_status);

        if ($this->search) {

            $criteria->condition = "(first_name=:first_name or last_name=:last_name or mobile_no=:mobile_no) and status=:status";
            $criteria->params = array(
                ':first_name' => $this->search,
                ':last_name' => $this->search,
                ':mobile_no' => $this->search,
                ':status' => '1',

            );
        }

        return new CActiveDataProvider($this, array(
            'criteria' => $criteria,
        ));
    }

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return Client the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}

    /*
     * Getting client using for select 2
     */
    public static function select2Client($name = '')
    {

        // Recommended: Secure Way to Write SQL in Yii
        $sql = 'SELECT id ,concat_ws(" : ",concat_ws("  ",first_name,last_name),mobile_no) AS text
                    FROM client 
                    WHERE (first_name LIKE :name or last_name like :name or mobile_no like :name)
                    AND status=:active_status';

        $name = '%' . $name . '%';

        return Yii::app()->db->createCommand($sql)->queryAll(true,
            array(':name' => $name, ':active_status' => $this->_active_status));

    }

    protected function getFullname()
    {
        return $this->first_name . ' - ' . $this->last_name;
    }

    public function getClient()
    {
        $model = Client::model()->findAll('status=:status', array(':status' => $this->_active_status));
        $list = CHtml::listData($model, 'id', 'Fullname');

        return $list    ;
    }

    public function deleteClient($id)
    {
        Client::model()->updateByPk($id, array('status' => $this->_inactive_status));
        Account::model()->updateAll(array('status' => $this->_inactive_status), 'client_id=:client_id',
            array(':client_id' => $id));
    }

    public function undodeleteClient($id)
    {
        Client::model()->updateByPk($id, array('status' => $this->_active_status));
        Account::model()->updateAll(array('status' => $this->_active_status), 'client_id=:client_id',
            array(':client_id' => $id));
    }
         
        /**
	 * Suggests a list of existing values matching the specified keyword.
	 * @param string the keyword to be matched
	 * @param integer maximum number of names to be returned
	 * @return array list of matching lastnames
	 */
	public function suggest($keyword,$limit=20)
	{
		$models=$this->findAll(array(
			'condition'=>'(first_name LIKE :keyword or last_name=:keyword or mobile_no like :keyword) and status=:status',
                        'order'=>'first_name',
			'limit'=>$limit,
			'params'=>array(':keyword'=>"%$keyword%",':status'=>$this->_active_status)
		));
		$suggest=array();
		foreach($models as $model) {
			$suggest[] = array(
				'label'=>$model->first_name.' '.$model->last_name.' - '.$model->mobile_no,  // label for dropdown list
				'value'=>$model->first_name,  // value for input field
				'id'=>$model->id,       // return values from autocomplete
			);
		}
		return $suggest;
	}

    /**
     * @getClientLink
     */
    public function getClientLink()
    {
        $url = Url::to(['client/view', 'id'=>$this->id]);
        $options = [];
        return Html::a($this->getFullName(), $url, $options);
    }
        
}
