--Créer un déclencheur after_products_update sur la table products : 
--lorsque le stock physique devient inférieur au stock d'alerte, une nouvelle ligne est insérée dans la table commander_articles.

DELIMITER $$

CREATE TRIGGER after_products_update
AFTER UPDATE  
ON products
FOR EACH ROW 
BEGIN
    IF NEW.pro_stock < NEW.pro_stock_alert THEN
        INSERT INTO commander_articles (qte,codart) VALUES ((NEW.pro_stock_alert - NEW.pro_stock),NEW.pro_id);
    END IF;
END;
$$

DELIMITER ;