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
    result = Contact.all
    result.map do |contact|
      puts "#{contact["id"]}: #{contact["name"]} (#{contact["email"]})"
    end

  when 'new'
    # Should allow you to add a new contact to your contact list
    puts "Please enter the full name of your new contact: "
    name = STDIN.gets.strip
    puts "Please enter the email of your new contact: "
    email = STDIN.gets.strip
    Contact.create(name, email)
    puts "Contact created successfully"

  when 'show'
    # Should take two params in ARGV show and an ID and
    # return a contact
    result = Contact.find(ARGV[1])
    result.map do |contact|
      puts "#{contact["id"]}: #{contact["name"]} (#{contact["email"]})"
    end

  when 'search'
    found = Contact.search(ARGV[1])
    found.map do |contact|
      puts "#{contact["id"]}: #{contact["name"]} (#{contact["email"]})"
    end

  when 'update'
    puts "Please enter the new full name of your contact: "
    name = STDIN.gets.strip
    puts "Please enter the new email of your contact: "
    email = STDIN.gets.strip
    Contact.update(ARGV[1], name, email)
    puts "Update successful"

  when 'destroy'
    Contact.destroy(ARGV[1])

  end
end
    
  # TODO: Implement user interaction. This should be the only file where you use `puts` and `gets`