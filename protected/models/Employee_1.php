<?php

/**
 * This is the model class for table "employee".
 *
 * The followings are the available columns in table 'employee':
 * @property integer $id
 * @property string $first_name
 * @property string $last_name
 * @property string $mobile_no
 * @property string $adddress1
 * @property string $address2
 * @property integer $city_id
 * @property string $country_code
 * @property string $email
 * @property string $notes
 *
 * The followings are the available model relations:
 * @property RbacUser[] $rbacUsers
 */
class Employee extends CActiveRecord
{
        public $login_id;
        public $image;
        public $search;
        
        private $employee_active = '1';
        private $employee_inactive = '0'; 
	
        /**
	 * Returns the static model of the specified AR class.
	 * @param string $className active record class name.
	 * @return Employee the static model class
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
		return 'employee';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('first_name, last_name, mobile_no', 'required'),
			array('city_id', 'numerical', 'integerOnly'=>true),
			array('first_name, last_name', 'length', 'max'=>50),
			array('mobile_no', 'length', 'max'=>15),
			array('adddress1, address2', 'length', 'max'=>60),
			array('country_code', 'length', 'max'=>2),
			array('email', 'length', 'max'=>30),
			array('notes', 'safe'),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('id, first_name, last_name, mobile_no, adddress1, address2, city_id, country_code, email, notes, search', 'safe', 'on'=>'search'),
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
			'rbacUsers' => array(self::HAS_MANY, 'RbacUser', 'employee_id'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id' => 'ID',
			'first_name' => Yii::t('app','First Name'), //'First Name',
			'last_name' => Yii::t('app','Last Name'), //'Last Name',
			'mobile_no' => Yii::t('app','Mobile No'), //'Mobile No',
			'adddress1' => Yii::t('app','Adddress1'), //'Adddress1',
			'address2' => Yii::t('app','Adddress2'), //Address2',
			'city_id' => Yii::t('app','City'), //'City',
			'country_code' => Yii::t('app','Country Code'), //'Country Code',
			'email' => Yii::t('app','Email'), //'Email',
			'notes' => Yii::t('app','Notes'), //'Notes',
                        'search' => Yii::t('app','Search') . Yii::t('app','Employee'),
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
		//$criteria->compare('first_name',$this->first_name,true);
		//$criteria->compare('last_name',$this->last_name,true);
		//$criteria->compare('mobile_no',$this->mobile_no,true);
		//$criteria->compare('adddress1',$this->adddress1,true);
		//$criteria->compare('address2',$this->address2,true);
		//$criteria->compare('city_id',$this->city_id);
		//$criteria->compare('country_code',$this->country_code,true);
		//$criteria->compare('email',$this->email,true);
		//$criteria->compare('notes',$this->notes,true);
                
                if ($this->search) {
                
                    $criteria->condition="(first_name=:search or last_name=:search or concat(first_name,last_name)=:fullname or concat(last_name,first_name)=:fullname  or mobile_no like :mobile_no)";
                    $criteria->params = array(
                                ':search' => $this->search, 
                                ':fullname' => preg_replace('/\s+/', '',$this->search),
                                ':mobile_no' => '%' . $this->search . '%',
                    );
                }

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
                        'sort'=>array( 'defaultOrder'=>'first_name')
		));
	}
        
        public function deleteEmployee($item_id)
        {
            Employee::model()->updateByPk((int)$item_id,array('status'=>$this->employee_inactive));
        }

        public function undodeleteEmployee($item_id)
        {
            Employee::model()->updateByPk((int)$item_id,array('status'=>$this->employee_active));
        }
        
        
        
}