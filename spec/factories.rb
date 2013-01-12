FactoryGirl.define do
  factory :user do
    nom     "Michael Hartl"
    prenom    "michael@example.com"
		labo    "labexemple"
    password "foobar"
    password_confirmation "foobar"
  end
end
