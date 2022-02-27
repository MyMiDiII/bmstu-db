CREATE TABLE IF NOT EXISTS nums (
    num numeric
);

INSERT INTO nums
VALUES
(1),
(2),
(1.5),
(-100);

INSERT INTO nums
VALUES
(0);

SELECT * FROM nums;

DELETE FROM nums;

UPDATE nums
SET num = -5
WHERE num = 0;

WITH prod_sign AS (
    WITH is_zero AS (
        SELECT (CASE WHEN count(*) = 0 THEN 1 ELSE 0 END) AS zero_sign
        FROM nums
        WHERE num = 0
    )
    SELECT (CASE (sum(CASE WHEN num < 0 THEN 1 ELSE 0 END) % 2)
            WHEN 0
            THEN 1
            ELSE -1
            END) * zero_sign AS p_sign
    FROM nums, is_zero
    GROUP BY zero_sign
)
SELECT exp(sum(ln(abs(num)))) * p_sign AS prod
FROM nums, prod_sign
WHERE num != 0
GROUP BY p_sign;


SELECT sum(CASE WHEN num < 0 THEN 1 ELSE 0 END) AS n_num
FROM nums;

SELECT (CASE (sum(CASE WHEN num < 0 THEN 1 ELSE 0 END) % 2) WHEN 0 THEN 1 ELSE -1 END) AS p_sign
FROM nums;