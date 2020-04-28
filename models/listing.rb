def run_sql(sql,params)
    conn = PG.connect(dbname: 'classic_car_parts')
    records = conn.exec_params(sql,params)
    conn.close
    records
end

def create_listing(headline, description)
    run_sql("insert into listings(headline,description)values ($1, $2);",[headline, description])
end

def all_listings()
    listings = run_sql("select * from listings;",[])
    listings
end

def find_a_listing_by_id(id)
    run_sql("select * from listings where id = $1;",[id])[0]
end

def update_listing(id, headline, description)
    run_sql("update listings set headline = $1, description = $2 where id = $3;",[headline,description,id])
end

def delete_listing(id)
    run_sql("delete from listings where id = $1;",[id])
end
