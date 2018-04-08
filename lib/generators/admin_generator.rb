class AdminGenerator < Rails::Generators::Base
  class_option :email, type: :string
  class_option :username, type: :string
  class_option :password, type: :string

  def create_admin
    email = options.email || read_input("Email: ")
    username = options.username || read_input("Username: ")
    password = options.password || read_input("Password: ")

    admin = User.new(email: email, username: username, password: password, role: "admin")

    if admin.save
      puts "Admin created"
    else
      puts "Error".pluralize(admin.errors.count)
      admin.errors.full_messages.each do |error|
        puts "  - #{error}"
      end
    end
  end

  private

  def read_input(text)
    print text
    $stdin.gets.chomp
  end
end
