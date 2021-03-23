START TRANSACTION;
SET
    @posid =(
    SELECT
        emp_pos_id
    FROM
        employees
    WHERE
        emp_lastname LIKE 'HANNAH' AND emp_firstname LIKE "Amity"
);
SET @retraite =(SELECT pos_id FROM `posts` WHERE `pos_libelle` LIKE 'retraite');
SET
    @empid =(
    SELECT
        emp_id
    FROM
        `employees`
    JOIN posts ON `emp_pos_id` = pos_id
    WHERE
        pos_libelle LIKE "pépiniériste" AND emp_sho_id =(
        SELECT
            emp_sho_id
        FROM
            employees
        WHERE
            emp_lastname LIKE 'HANNAH' AND emp_firstname LIKE "Amity"
    )


ORDER BY
    `emp_enter_date` ASC
LIMIT 1
);
SET @empshoid =(
        SELECT
            emp_sho_id
        FROM
            employees
        WHERE
            emp_id = @empid);


UPDATE
    employees
SET
    emp_pos_id = @posid,
    emp_salary = emp_salary * 1.05
WHERE
    emp_id = @empid;




    UPDATE
    employees
SET
    emp_superior_id = @empid
WHERE
    emp_id != @empid and emp_sho_id=@empshoid;

    INSERT INTO `posts` (`pos_id`, `pos_libelle`) VALUES (NULL, 'retraite');


UPDATE employees SET emp_pos_id=(SELECT pos_id FROM posts WHERE pos_libelle LIKE 'retraite')  
    WHERE  emp_lastname LIKE 'HANNAH' AND emp_firstname LIKE "Amity";
    COMMIT;
    