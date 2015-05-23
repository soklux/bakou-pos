<?php

/**
 * This is the model class for table "employee".
 *
 * The followings are the available columns in table 'employee':
 * @property integer $id
 * @property string $first_name
 * @property string $last_name
 * @property date $dob
 * @property string $mobile_no
 * @property string $adddress1
 * @property string $address2
 * @property integer $city_id
 * @property string $country_code
 * @property string $email
 * @property string $notes
 * @property string $status
 *
 * The followings are the available model relations:
 * @property RbacUser[] $rbacUsers
 * @property Transactions[] $transactions
 */
class Employee extends CActiveRecord
{
	
        public $login_id;
        public $image;
        public $search;
        
        private $employee_active = '1';
        private $employee_inactive = '0'; 
    
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
			array('first_name, last_name', 'required'),
			array('city_id', 'numerical', 'integerOnly'=>true),
			array('first_name, last_name', 'length', 'max'=>50),
			array('mobile_no', 'length', 'max'=>15),
			array('adddress1, address2', 'length', 'max'=>60),
			array('country_code', 'length', 'max'=>2),
			array('email', 'length', 'max'=>30),
			array('status', 'length', 'max'=>1),
			array('notes', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id, first_name, last_name, dob, mobile_no, adddress1, address2, city_id, country_code, email, notes, status', 'safe', 'on'=>'search'),
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
			'transactions' => array(self::HAS_MANY, 'Transactions', 'employee_id'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
    public function attributeLabels()
    {
        return array(
            'id' => 'ID',
            'first_name' => Yii::t('app', 'First Name'), //'First Name',
            'last_name' => Yii::t('app', 'Last Name'), //'Last Name',
            'mobile_no' => Yii::t('app', 'Mobile No'), //'Mobile No',
            'adddress1' => Yii::t('app', 'Address1'), //'Adddress1',
            'address2' => Yii::t('app', 'Address2'), //Address2',
            'city_id' => Yii::t('app', 'City'), //'City',
            'country_code' => Yii::t('app', 'Country Code'), //'Country Code',
            'email' => Yii::t('app', 'Email'), //'Email',
            'notes' => Yii::t('app', 'Notes'), //'Notes',
            'search' => Yii::t('app', 'Search') . Yii::t('app', 'Employee'),
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
	public function search()
	{
		// @todo Please modify the following code to remove attributes that should not be searched.

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
		//$criteria->compare('status',$this->status,true);
                
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
                        //'sort'=>array( 'defaultOrder'=>'first_name'),
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return Employee the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}

    public function deleteEmployee($id)
    {
        Employee::model()->updateByPk((int)$id, array('status' => $this->employee_inactive));
    }

    public function undodeleteEmployee($id)
    {
        Employee::model()->updateByPk((int)$id, array('status' => $this->employee_active));
    }

    protected function getEmployeeInfo()
    {
        return $this->first_name . ' ' . $this->last_name;

    }

    public function getEmployee()
    {
        $model = Employee::model()->findAll();
        $list  = CHtml::listData($model , 'id', 'EmployeeInfo');
        return $list;
    }

    /*
     * This is to get Employee but as Sale Representative
     */
    public function getEmpRep($employee_id)
    {
        $model = Employee::model()->findAll(
            array('select' => '*',
                'condition' => 'id not in ("1","2") and id<>:employee_id',
                 'params'=>array(':employee_id' => $employee_id)
                ,
            ));
        $list  = CHtml::listData($model , 'id', 'EmployeeInfo');
        return $list;
    }


    public static function itemAlias($type, $code = null)
    {

        $_items = array(
            'day' => array(
                '01' => '01',
                '02' => '02',
                '03' => '03',
                '04' => '04',
                '05' => '05',
                '06' => '06',
                '07' => '07',
                '08' => '08',
                '09' => '09',
                '10' => '10',
                '11' => '11',
                '12' => '12',
                '13' => '13',
                '14' => '14',
                '15' => '15',
                '16' => '16',
                '17' => '17',
                '18' => '18',
                '19' => '19',
                '20' => '20',
                '21' => '21',
                '22' => '22',
                '23' => '23',
                '24' => '24',
                '25' => '25',
                '26' => '26',
                '27' => '27',
                '28' => '28',
                '29' => '29',
                '30' => '30',
                '31' => '31',
            ),
            'month' => array(
                '01' => Yii::t('app','January'),
                '02' => Yii::t('app','February'),
                '03' => Yii::t('app','March'),
                '04' => Yii::t('app','April'),
                '05' => Yii::t('app','May'),
                '06' => Yii::t('app','June'),
                '07' => Yii::t('app','July'),
                '08' => Yii::t('app','August'),
                '09' => Yii::t('app','September'),
                '10' => Yii::t('app','October'),
                '11' => Yii::t('app','November'),
                '12' => Yii::t('app','December'),
            ),
            'year' => array(
                '2015' => '2015',
                '2014' => '2014',
                '2013' => '2013',
                '2012' => '2012',
                '2011' => '2011',
                '2010' => '2010',
                '2009' => '2009',
                '2008' => '2008',
                '2007' => '2007',
                '2006' => '2006',
                '2005' => '2005',
                '2004' => '2004',
                '2003' => '2003',
                '2002' => '2002',
                '2001' => '2001',
                '2000' => '2000',
                '1999' => '1999',
                '1998' => '1998',
                '1997' => '1997',
                '1996' => '1996',
                '1995' => '1995',
                '1994' => '1994',
                '1993' => '1993',
                '1992' => '1992',
                '1991' => '1991',
                '1990' => '1990',
                '1989' => '1989',
                '1988' => '1988',
                '1987' => '1987',
                '1986' => '1986',
                '1985' => '1985',
                '1984' => '1984',
                '1983' => '1983',
                '1982' => '1982',
                '1981' => '1981',
                '1980' => '1980',
                '1979' => '1979',
                '1978' => '1978',
                '1977' => '1977',
                '1976' => '1976',
                '1975' => '1975',
                '1974' => '1974',
                '1973' => '1973',
                '1972' => '1972',
                '1971' => '1971',
                '1970' => '1970',
                '1969' => '1969',
                '1968' => '1968',
                '1967' => '1967',
                '1966' => '1966',
                '1965' => '1965',
                '1964' => '1964',
                '1963' => '1963',
                '1962' => '1962',
                '1961' => '1961',
                '1960' => '1960',
                '1959' => '1959',
                '1958' => '1958',
                '1957' => '1957',
                '1956' => '1956',
                '1955' => '1955',
                '1954' => '1954',
                '1953' => '1953',
                '1952' => '1952',
                '1951' => '1951',
                '1950' => '1950',
                '1949' => '1949',
                '1948' => '1948',
                '1947' => '1947',
                '1946' => '1946',
                '1945' => '1945',
                '1944' => '1944',
                '1943' => '1943',
                '1942' => '1942',
                '1941' => '1941',
                '1940' => '1940',

            ),
        );

        if (isset($code)) {
            return isset($_items[$type][$code]) ? $_items[$type][$code] : false;
        } else {
            return isset($_items[$type]) ? $_items[$type] : false;
        }
    }
        
}
