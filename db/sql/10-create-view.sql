CREATE VIEW dog_final AS 
WITH RECURSIVE CTE_Id (id) AS
(
  SELECT 1
  union all
  SELECT id+1
  from CTE_Id
  where id < 4
), CTE_Color (id, val) AS
(
  SELECT b.breedId, string_agg(c.color::text, ', ')
  FROM dog AS b
  JOIN colorLookup AS c ON c.id = b.colorId
  GROUP BY b.breedId
)

SELECT b.id, b.breed,
COUNT(*), d.val
FROM CTE_Id AS a
JOIN breedLookup AS b ON b.id = a.id
RIGHT JOIN dog AS c ON c.breedId = a.id
JOIN CTE_Color AS d ON c.breedId = d.id
GROUP BY b.id, b.breed, d.val
ORDER BY b.id;
