<?php
Class Common 
{
    public static function Discount($discount) {
        if (substr($discount, 0, 1) == '$') {
            $discount_amount = substr($discount, 1);
            $discount_type = '$';
        } else {
            $discount_amount = $discount;
            $discount_type = '%';
        }
        
        return array($discount_amount, $discount_type);
    }

    /*
   * To Calculate Total Amount after discount
   */
    public static function calTotalAfterDiscount($discount,$price,$qty=1) {
        $total = 0;
        if (substr($discount, 0, 1) == '$') {
            $total+=round($price * $qty - substr($discount, 1), Yii::app()->shoppingCart->getDecimalPlace(), PHP_ROUND_HALF_DOWN);
        } else {
            $total+=round($price * $qty - $price * $qty * $discount / 100, Yii::app()->shoppingCart->getDecimalPlace(), PHP_ROUND_HALF_DOWN);
        }
        return $total;
    }

    /*
     * To Calculate actual discount amount comparing to Total Value
     */
    public static function calDiscountAmount($discount,$price) {
        //$total = 0;
        if (substr($discount, 0, 1) == '$') {
            $total=round(substr($discount, 1), Yii::app()->shoppingCart->getDecimalPlace(), PHP_ROUND_HALF_DOWN);
        } else {
            $total=round($price * $discount / 100, Yii::app()->shoppingCart->getDecimalPlace(), PHP_ROUND_HALF_DOWN);
        }
        return $total;
    }
    
}