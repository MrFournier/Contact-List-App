require_relative 'contact'

# Interfaces between a user and their contact list. Reads from and writes to standard I/O.
class ContactList

  case ARGV[0]

  when nil
    # Should print the menu in this case
    puts "Here is a list of available commands: \n"\
      "\tnew\t- Create a new contact\n"\
      "\tlist\t- List all contacts\n"\
      "\tshow\t- Show a contact\n"\
      "\tsearch\t- Search contacts"

  when 'list'
    # Should return a list of all contacts
    count = 1
    Contact.all.each do |ele|  
      puts "#{count}: #{ele[0]} #{ele[1]}"
      count += 1
    end

  when 'new'
    # Should allow you to add a new contact to your contact list
    puts "Please enter the full name of your new contact: "
    name = STDIN.gets.strip
    puts "Please enter the email of your new contact: "
    email = STDIN.gets.strip
    Contact.create(name, email)

  end

  end
    
  # TODO: Implement user interaction. This should be the only file where you use `puts` and `gets`