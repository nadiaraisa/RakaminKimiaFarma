SELECT 
    ft.transaction_id,
    ft.date,
    kc.branch_id,
    kc.branch_name,
    kc.kota,
    kc.provinsi,
    kc.rating AS rating_cabang,
    ft.customer_name,
    p.product_id,
    p.product_name,
    p.price AS actual_price,
    ft.discount_percentage,
    CASE
        WHEN p.price <= 50000 THEN 0.1
        WHEN p.price > 50000 AND p.price <= 100000 THEN 0.15
        WHEN p.price > 100000 AND p.price <= 300000 THEN  0.2
        WHEN p.price > 300000 AND p.price <= 500000 THEN 0.25
        WHEN p.price > 500000 THEN 0.3
    END AS persentase_gross_laba,
    (p.price * (1-ft.discount_percentage)) AS nett_sales,
    CASE
        WHEN p.price <= 50000 THEN ((p.price * (1-ft.discount_percentage)) * 0.1)
        WHEN p.price > 50000 AND p.price <= 100000 THEN ((p.price * (1-ft.discount_percentage)) * 0.15)
        WHEN p.price > 100000 AND p.price <= 300000 THEN  ((p.price * (1-ft.discount_percentage)) * 0.2)
        WHEN p.price > 300000 AND p.price <= 500000 THEN ((p.price * (1-ft.discount_percentage)) * 0.25)
        WHEN p.price > 500000 THEN ((p.price * (1-ft.discount_percentage)) * 0.3)
    END AS nett_profit,
    ft.rating AS rating_transaksi
FROM
    galvanic-being-427009-n3.Kimia_Farma_Dataset.kf_final_transaction ft
INNER JOIN
    galvanic-being-427009-n3.Kimia_Farma_Dataset.kf_product p ON ft.product_id = p.product_id
INNER JOIN
    galvanic-being-427009-n3.Kimia_Farma_Dataset.kf_kantor_cabang kc ON ft.branch_id = kc.branch_id;