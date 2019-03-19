module Commands::User
  class Authenticate
    def initialize(email, password)
      @email = email
      @password = password
    end

    def perform
      user = ::User.find_by_email(email)
      return unless user&.authenticate(password)

      user
    end

    private

    attr_reader :email, :password
  end
end
