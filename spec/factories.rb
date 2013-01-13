FactoryGirl.define do
  factory :user do
    nom     "Michael Hartl"
    prenom    "michael@example.com"
		labo    "labexemple"
    password "foobar"
    password_confirmation "foobar"
		email    "michael@example.com"
  end
end
