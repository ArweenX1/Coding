-- Given a Weather table, write a SQL query to find all dates' Ids with higher temperature compared to its previous (yesterday's) dates.
--
-- +---------+------------+------------------+
-- | Id(INT) | Date(DATE) | Temperature(INT) |
-- +---------+------------+------------------+
-- |       1 | 2015-01-01 |               10 |
-- |       2 | 2015-01-02 |               25 |
-- |       3 | 2015-01-03 |               20 |
-- |       4 | 2015-01-04 |               30 |
-- +---------+------------+------------------+
-- For example, return the following Ids for the above Weather table:
-- +----+
-- | Id |
-- +----+
-- |  2 |
-- |  4 |
-- +----+
SELECT
  W2.ID
from
  weather w1
  inner join weather W2 on w2.Date = DATE_ADD(W2.date, Interval -1 day)
  and w2.Temperature > w1.Temperature;
select
  w1.Id
from
  Weather w1,
  Weather w2
where
  w1.Temperature > w2.Temperature
  and to_days(w1.Date) - to_days(w2.date) = 1;