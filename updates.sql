ALTER TABLE `purchase_details` ADD `sale_type` VARCHAR(191) NULL AFTER `sub_total`;
ALTER TABLE `sale_details` ADD `sale_type` VARCHAR(191) NULL AFTER `sub_total`;
