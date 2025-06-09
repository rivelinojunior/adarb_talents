require "test_helper"

class ProfileTest < ActiveSupport::TestCase
  def setup
    @profile = profiles(:one)
  end

  test "should be valid" do
    assert @profile.valid?
  end

  test "should require fullname" do
    @profile.fullname = nil
    assert_not @profile.valid?
    assert_includes @profile.errors[:fullname], "can't be blank"
  end

  test "should require current_role" do
    @profile.current_role = nil
    assert_not @profile.valid?
    assert_includes @profile.errors[:current_role], "can't be blank"
  end

  test "should require short_bio" do
    @profile.short_bio = nil
    assert_not @profile.valid?
    assert_includes @profile.errors[:short_bio], "can't be blank"
  end

  test "should require skills" do
    @profile.skills = nil
    assert_not @profile.valid?
    assert_includes @profile.errors[:skills], "can't be blank"
  end

  test "should belong to user" do
    assert_respond_to @profile, :user
    assert_instance_of User, @profile.user
  end

  test "should have valid links with correct schema" do
    links = @profile.links
    assert_kind_of Array, links
    assert_equal 2, links.length

    github_link = links.find { |link| link["name"] == "GitHub" }
    assert_equal "https://github.com/johndoe", github_link["link"]

    linkedin_link = links.find { |link| link["name"] == "LinkedIn" }
    assert_equal "https://linkedin.com/in/johndoe", linkedin_link["link"]
  end

  test "should have valid skills with correct schema" do
    skills = @profile.skills
    assert_kind_of Array, skills
    assert_equal 5, skills.length

    ruby_skill = skills.find { |skill| skill["name"] == "Ruby" }
    assert_equal 5, ruby_skill["experience_in_year"]

    rails_skill = skills.find { |skill| skill["name"] == "Rails" }
    assert_equal 4, rails_skill["experience_in_year"]
  end

  test "should validate links schema when missing link" do
    @profile.links = [ { name: "Invalid" } ]
    assert_not @profile.valid?
    assert_includes @profile.errors[:links], "is invalid"
  end

  test "should validate links schema when missing name" do
    @profile.links = [ { link: "https://example.com" } ]
    assert_not @profile.valid?
    assert_includes @profile.errors[:links], "is invalid"
  end

  test "should validate skills schema when missing experience_in_year" do
    @profile.skills = [ { name: "Invalid" } ]
    assert_not @profile.valid?
    assert_includes @profile.errors[:skills], "is invalid"
  end

  test "should validate skills schema when missing name" do
    @profile.skills = [ { experience_in_year: 5 } ]
    assert_not @profile.valid?
    assert_includes @profile.errors[:skills], "is invalid"
  end

  test "should validate skills schema when experience_in_year is negative" do
    @profile.skills = [ { name: "Ruby", experience_in_year: -1 } ]
    assert_not @profile.valid?
    assert_includes @profile.errors[:skills], "is invalid"
  end
end
