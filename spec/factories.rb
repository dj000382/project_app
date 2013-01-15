FactoryGirl.define do
  factory :user do
    sequence(:nom)  { |n| "Person #{n}" }
		sequence(:prenom)  { |n| "Prenom #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"} 
		labo "labexemple"  
    password "foobar"
    password_confirmation "foobar"

		factory :admin do
      admin true
    end
  end
	factory :publication do
		title "title exemple"
		year "2011"
    content "Lorem ipsum"
    user
  end
end
