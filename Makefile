.PHONY: setup run test seed docs clean

setup:
	pip install dbt-duckdb

init:
	dbt init

seed:
	dbt seed

run:
	dbt run

test:
	dbt test

docs:
	dbt docs generate
	dbt docs serve

full:
	dbt seed && dbt run && dbt test

clean:
	rm -rf dev_warehouse.duckdb target/ dbt_packages/
