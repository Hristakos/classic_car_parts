require 'bcrypt'

def find_a_user_by_id(id)
    records = run_sql("select * from users where id = $1;",[id])[0]
    
end

def create_user(email, password)
    digested_password = BCrypt::Password.create(password)
    run_sql("INSERT INTO users (email, password_digest) values($1, $2);",[email, digested_password])
end

def find_a_user_by_email(email)
    records = run_sql("select * from users where email = $1;",[email])
    if records.count == 0
        return nil
    else
        return records[0]
    end
end