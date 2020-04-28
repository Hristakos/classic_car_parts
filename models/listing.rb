def run_sql(sql,params)
    conn = PG.connect(dbname: 'classic_car_parts')
    records = conn.exec_params(sql,params)
    conn.close
    records
end

def create_listing(headline, description, user_id)
    run_sql("insert into listings(headline,description,user_id)values ($1, $2, $3);",[headline, description,user_id])
end

def all_listings()
    listings = run_sql("select * from listings;",[])
    listings
end

def all_listings_for_user(user_id)
    listings = run_sql("select * from listings where user_id = $1;",[user_id])
    listings
end

def find_a_listing_by_id(id)
    run_sql("select * from listings where id = $1;",[id])[0]
end

def find_a_user_listing_by_ids(id, user_id)
    records = run_sql("select * from listings where id = $1 and user_id = $2;",[id, user_id])
    if records.count == 0
        return nil
    else
        return records[0]
    end
end

def update_listing(id, headline, description)
    run_sql("update listings set headline = $1, description = $2 where id = $3;",[headline,description,id])
end

def delete_listing(id)
    run_sql("delete from listings where id = $1;",[id])
end
