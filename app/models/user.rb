class User < ActiveRecord::Base

  acts_as_authentic

  def self.find_or_create_from_auth_hash(auth)
    user = User.where(github_id: auth.uid).first

    unless user
      data = auth["info"]
      user = User.create(
        login: data["nickname"],
        avatar_url: data["image"],
        name: data["name"],
        github_id: auth.uid,
        email: data["email"]
      )
    end

    user
  end
end
