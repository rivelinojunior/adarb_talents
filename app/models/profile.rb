class Profile < ApplicationRecord
  belongs_to :user

  validates :fullname, :current_role, :short_bio, :skills, presence: true
  validates :links, 'profiles/links_schema': true
  validates :skills, 'profiles/skills_schema': true
end
