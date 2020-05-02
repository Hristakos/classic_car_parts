require 'bcrypt'

def find_a_user_by_id(id)
    records = run_sql("select * from users where id = $1;",[id])[0]
    
end

def create_user(name, email, password)
    digested_password = BCrypt::Password.create(password)
    run_sql("INSERT INTO users (name,email, password_digest) values($1, $2, $3);",[name,email, digested_password])
end

def find_a_user_by_email(email)
    records = run_sql("select * from users where email = $1;",[email])
    if records.count == 0
        return nil
    else
        return records[0]
    end
end

def register_input_validate(name, email, password)
    msg = nil
    if name.size < 3
       msg = "name must be at least 3 characters long"
    elsif email.size < 5 
        msg = "email must be at least 5 characters long"
    elsif password.size < 7
        msg = "password must be at least 7 characters long"
    end
    
    if msg 
        return error = {name: name,
                      email: email,
                      password: password,
                      message: msg
                    }       
    else
        return nil
    end
end