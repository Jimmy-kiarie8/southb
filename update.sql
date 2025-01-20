UPDATE sale_payments sp JOIN sales s ON sp.sale_id = s.id SET sp.customer_code = s.clientcode WHERE sp.customer_code is null;
