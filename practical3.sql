Find the name(s) of the movie(s) after 2010 in which the actor ’TomHanks’ played

EXPLAIN ANALYZE select distinct Movie.name from Actor, Casts, Movie where fname = 'Tom' and lname = 'Hanks' and Casts.pid = Actor.id and Casts.mid = Movie.id;

QUERY PLAN
---------------------------------------------------------------------------------------------------------------------------------------------------------------
Unique  (cost=181288.89..181288.92 rows=6 width=17) (actual time=679.042..679.137 rows=449 loops=1)
->  Sort  (cost=181288.89..181288.90 rows=6 width=17) (actual time=679.041..679.064 rows=536 loops=1)
Sort Key: movie.name
Sort Method: quicksort  Memory: 60kB
->  Gather  (cost=161976.11..181288.81 rows=6 width=17) (actual time=600.944..679.209 rows=536 loops=1)
Workers Planned: 2
Workers Launched: 2
->  Parallel Hash Join  (cost=160976.11..180288.21 rows=2 width=17) (actual time=589.364..667.281 rows=179 loops=3)
Hash Cond: (movie.id = casts.mid)
->  Parallel Seq Scan on movie  (cost=0.00..16909.88 rows=640588 width=21) (actual time=0.035..37.358 rows=512470 loops=3)
->  Parallel Hash  (cost=160976.09..160976.09 rows=2 width=4) (actual time=588.651..588.651 rows=179 loops=3)
Buckets: 1024  Batches: 1  Memory Usage: 104kB
->  Parallel Hash Join  (cost=23592.48..160976.09 rows=2 width=4) (actual time=184.961..588.536 rows=179 loops=3)
Hash Cond: (casts.pid = actor.id)
->  Parallel Seq Scan on casts  (cost=0.00..119493.88 rows=4770588 width=8) (actual time=0.026..272.221 rows=3815282 loops=3)
->  Parallel Hash  (cost=23592.46..23592.46 rows=1 width=4) (actual time=56.518..56.518 rows=0 loops=3)
Buckets: 1024  Batches: 1  Memory Usage: 40kB
->  Parallel Seq Scan on actor  (cost=0.00..23592.46 rows=1 width=4) (actual time=42.140..56.502 rows=0 loops=3)
Filter: (((fname)::text = 'Tom'::text) AND ((lname)::text = 'Hanks'::text))
Rows Removed by Filter: 621678
Planning Time: 0.632 ms
Execution Time: 680.161 ms


CREATE INDEX cast_pid ON Casts(pid);

QUERY PLAN
---------------------------------------------------------------------------------------------------------------------------------------------------------
 Unique  (cost=43919.48..43919.51 rows=6 width=17) (actual time=153.574..153.674 rows=449 loops=1)
   ->  Sort  (cost=43919.48..43919.50 rows=6 width=17) (actual time=153.573..153.597 rows=536 loops=1)
         Sort Key: movie.name
         Sort Method: quicksort  Memory: 60kB
         ->  Gather  (cost=24606.71..43919.40 rows=6 width=17) (actual time=69.306..153.723 rows=536 loops=1)
               Workers Planned: 2
               Workers Launched: 2
               ->  Parallel Hash Join  (cost=23606.71..42918.80 rows=2 width=17) (actual time=66.643..149.880 rows=179 loops=3)
                     Hash Cond: (movie.id = casts.mid)
                     ->  Parallel Seq Scan on movie  (cost=0.00..16909.88 rows=640588 width=21) (actual time=0.034..42.175 rows=512470 loops=3)
                     ->  Parallel Hash  (cost=23606.68..23606.68 rows=2 width=4) (actual time=66.172..66.173 rows=179 loops=3)
                           Buckets: 1024  Batches: 1  Memory Usage: 40kB
                           ->  Nested Loop  (cost=0.43..23606.68 rows=2 width=4) (actual time=51.437..66.113 rows=179 loops=3)
                                 ->  Parallel Seq Scan on actor  (cost=0.00..23592.46 rows=1 width=4) (actual time=51.427..66.058 rows=0 loops=3)
                                       Filter: (((fname)::text = 'Tom'::text) AND ((lname)::text = 'Hanks'::text))
                                       Rows Removed by Filter: 621678
                                 ->  Index Scan using cast_pid on casts  (cost=0.43..12.48 rows=174 width=8) (actual time=0.024..0.113 rows=536 loops=1)
                                       Index Cond: (pid = actor.id)
 Planning Time: 0.414 ms
 Execution Time: 154.593 ms


CREATE INDEX cast_mid ON Casts(mid);
QUERY PLAN
---------------------------------------------------------------------------------------------------------------------------------------------------------
 Unique  (cost=43919.48..43919.51 rows=6 width=17) (actual time=142.326..142.421 rows=449 loops=1)
   ->  Sort  (cost=43919.48..43919.50 rows=6 width=17) (actual time=142.325..142.348 rows=536 loops=1)
         Sort Key: movie.name
         Sort Method: quicksort  Memory: 60kB
         ->  Gather  (cost=24606.71..43919.40 rows=6 width=17) (actual time=64.466..142.763 rows=536 loops=1)
               Workers Planned: 2
               Workers Launched: 2
               ->  Parallel Hash Join  (cost=23606.71..42918.80 rows=2 width=17) (actual time=60.537..138.122 rows=179 loops=3)
                     Hash Cond: (movie.id = casts.mid)
                     ->  Parallel Seq Scan on movie  (cost=0.00..16909.88 rows=640588 width=21) (actual time=0.036..37.340 rows=512470 loops=3)
                     ->  Parallel Hash  (cost=23606.68..23606.68 rows=2 width=4) (actual time=59.686..59.686 rows=179 loops=3)
                           Buckets: 1024  Batches: 1  Memory Usage: 40kB
                           ->  Nested Loop  (cost=0.43..23606.68 rows=2 width=4) (actual time=45.083..59.623 rows=179 loops=3)
                                 ->  Parallel Seq Scan on actor  (cost=0.00..23592.46 rows=1 width=4) (actual time=45.068..59.555 rows=0 loops=3)
                                       Filter: (((fname)::text = 'Tom'::text) AND ((lname)::text = 'Hanks'::text))
                                       Rows Removed by Filter: 621678
                                 ->  Index Scan using cast_pid on casts  (cost=0.43..12.48 rows=174 width=8) (actual time=0.035..0.143 rows=536 loops=1)
                                       Index Cond: (pid = actor.id)
 Planning Time: 0.575 ms
 Execution Time: 143.575 ms


 CREATE INDEX cast_pid_mid ON Casts(pid, mid);
 QUERY PLAN
 ---------------------------------------------------------------------------------------------------------------------------------------------------------
  Unique  (cost=43919.48..43919.51 rows=6 width=17) (actual time=141.155..141.283 rows=449 loops=1)
    ->  Sort  (cost=43919.48..43919.50 rows=6 width=17) (actual time=141.154..141.189 rows=536 loops=1)
          Sort Key: movie.name
          Sort Method: quicksort  Memory: 60kB
          ->  Gather  (cost=24606.71..43919.40 rows=6 width=17) (actual time=62.946..142.263 rows=536 loops=1)
                Workers Planned: 2
                Workers Launched: 2
                ->  Parallel Hash Join  (cost=23606.71..42918.80 rows=2 width=17) (actual time=59.980..137.077 rows=179 loops=3)
                      Hash Cond: (movie.id = casts.mid)
                      ->  Parallel Seq Scan on movie  (cost=0.00..16909.88 rows=640588 width=21) (actual time=0.028..36.519 rows=512470 loops=3)
                      ->  Parallel Hash  (cost=23606.68..23606.68 rows=2 width=4) (actual time=59.393..59.393 rows=179 loops=3)
                            Buckets: 1024  Batches: 1  Memory Usage: 40kB
                            ->  Nested Loop  (cost=0.43..23606.68 rows=2 width=4) (actual time=45.120..59.331 rows=179 loops=3)
                                  ->  Parallel Seq Scan on actor  (cost=0.00..23592.46 rows=1 width=4) (actual time=45.105..59.256 rows=0 loops=3)
                                        Filter: (((fname)::text = 'Tom'::text) AND ((lname)::text = 'Hanks'::text))
                                        Rows Removed by Filter: 621678
                                  ->  Index Scan using cast_pid on casts  (cost=0.43..12.48 rows=174 width=8) (actual time=0.032..0.149 rows=536 loops=1)
                                        Index Cond: (pid = actor.id)
  Planning Time: 0.626 ms
  Execution Time: 143.089 ms
