--générer une facture il faut les produits les prix unitaire  reduction etc
DELIMITER $$

CREATE PROCEDURE facture(IN p_orderid INT(10))

BEGIN
SELECT
    ord_id,
    ord_order_date,
    ord_reception_date,
    cus_lastname,
    cus_firstname,
    cus_address,
    cus_zipcode,
    cus_city,
    cou_name,
    ode_unit_price,
    ode_quantity,
    ode_discount,
    (
        CONVERT(
            (
                ode_unit_price - ode_unit_price / 100 * ode_discount
            ) * ode_quantity,
            DECIMAL(10, 2)
        )
    ) AS Total,
    pro_ref,
    pro_name,
    cat_name
FROM
    countries
JOIN customers ON cou_id = cus_countries_id
JOIN orders ON cus_id = ord_cus_id
JOIN orders_details ON ode_ord_id = ord_id
JOIN products ON ode_pro_id = pro_id
JOIN categories ON pro_cat_id = cat_id
WHERE
    ord_id = p_orderid;
    END $$

DELIMITER ;

--on génére la facture numéro 6
CALL facture(6)