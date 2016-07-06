require 'pg'
require 'pry'

class Contact

  @@connection = nil

  attr_reader :id
  attr_accessor :name, :email

  def initialize(name, email, id = nil)
    @name = name
    @email = email
    @id = id
  end

  def save
    Contact.connection.exec_params("INSERT INTO contacts (name, email) VALUES ($1, $2);", [@name, @email])
  end

  class << self

    def connection
      # @@conn = @@conn || PG.connect({dbname 'contact_list_db}')
      # might not need ':user...'
      # ::Connection.open(:dbname => 'contact_list_db', :user => 'development', :password => 'development')
      @@connection = @@connection || PG.connect({dbname: 'contact_list_db'})
    end

    def all
      self.connection.exec_params("SELECT * FROM contacts;")
    end

    def create(name, email)
      Contact.new(name, email).save
    end

    def find(id)
      self.connection.exec_params("SELECT * FROM contacts WHERE id = $1;", [id])

    end

    def search(term)
      result = connection.exec_params("SELECT * FROM contacts WHERE name LIKE '%#{term}%';")
    end

    def update(id, new_name, new_email)
      results = find(id)
      if results.num_tuples == 0
        self.create(new_name, new_email)
        self.save
      else
        @name = new_name
        @email = new_email
        Contact.connection.exec_params("UPDATE contacts SET name = $1, email = $2 WHERE id = $3;", [@name, @email, id])
      end
    end

    def destroy(id)
      results = find(id)
      if results.num_tuples == 0
        return puts "No contact with that id"
      else
        self.connection.exec_params("DELETE FROM contacts WHERE id = $1", [id])
        puts 'Contact deleted'
      end
    end
  end
end
