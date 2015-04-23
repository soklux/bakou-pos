DELETE FROM sale;

ALTER TABLE sale AUTO_INCREMENT=1;

DELETE FROM inventory;

ALTER TABLE inventory AUTO_INCREMENT=1;

DELETE FROM `transactions`;

ALTER TABLE transactions AUTO_INCREMENT=1;

DELETE FROM item;

ALTER TABLE item AUTO_INCREMENT=1;

DELETE FROM receiving_payment;

ALTER TABLE receiving_payment AUTO_INCREMENT=1;

DELETE FROM `payment_history_recv`;

ALTER TABLE payment_history_recv AUTO_INCREMENT=1;

DELETE FROM supplier;

ALTER TABLE supplier AUTO_INCREMENT=1;

DELETE FROM CLIENT;

ALTER TABLE CLIENT AUTO_INCREMENT=1;

DELETE FROM account;

ALTER TABLE account AUTO_INCREMENT=1;

DELETE FROM `account_receivable`;

ALTER TABLE account_receivable AUTO_INCREMENT=1;

DELETE FROM `account_supplier`;

ALTER TABLE `account_supplier` AUTO_INCREMENT=1;

DELETE FROM `account_receivable_supplier`;

ALTER TABLE account_receivable_supplier AUTO_INCREMENT=1;

DELETE FROM price_tier;

ALTER TABLE price_tier AUTO_INCREMENT=1;

DELETE FROM item_price_tier;

ALTER TABLE `item_price_tier` AUTO_INCREMENT=1;

DELETE FROM category;

ALTER TABLE category AUTO_INCREMENT=1;

DELETE FROM `item_price`;

ALTER TABLE item_price AUTO_INCREMENT=1;

DELETE FROM sale_payment;

ALTER TABLE sale_payment AUTO_INCREMENT=1;

DELETE FROM `payment_history`;

ALTER TABLE payment_history AUTO_INCREMENT=1;

DELETE FROM `receiving_item`;

ALTER TABLE receiving_item AUTO_INCREMENT=1;

DELETE FROM  `receiving`;

DELETE FROM `receiving_item`;

ALTER TABLE receiving AUTO_INCREMENT=1;

ALTER TABLE receiving_item AUTO_INCREMENT=1;
