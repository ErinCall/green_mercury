FactoryGirl.define do
  factory :member_application do 
    sequence(:user_uuid) { |n| "member#{n}" }
    why_you_want_to_join "I don't know"
    experience_level "Advanced"
    comfortable_learning 2
    time_commitment 'All day'
    
    factory :approved_member_application do 
      approved_date Time.now - 1.day
      approved_by_user_uuid "admin"
    end

    factory :rejected_member_application do 
      rejected_date Time.now - 1.day
      rejected_by_user_uuid "admin"
    end
  end

  factory :mentor_application do 
    sequence(:user_uuid) { |n| "mentor#{n}" }
    contact 'email'
    geography 'Portland'
    hear_about 'website'
    motivation 'Very'
    time_commitment 'all day'
    mentor_one_on_one 'very interested'
    mentor_group 'very interested'
    mentor_online 'very interested'
    volunteer_events 'very interested'
    volunteer_teams 'very interested'
    volunteer_solo 'very interested'
    volunteer_technical 'very interested'
    volunteer_online 'very interested'

    factory :approved_mentor_application do
      approved_date Time.now - 1.day
      approved_by_user_uuid "admin"
    end

    factory :rejected_mentor_application do 
      rejected_date Time.now - 1.day
      rejected_by_user_uuid "admin"
    end
  end

  factory :user do
    sequence(:name) { |n| "user#{n}" }
    sequence(:uuid) { |n| "user#{n}" } 

    factory :admin do 
      is_admin true
    end
  end 

  factory :concept do
    name "Ruby"
  end

  factory :concept_description do
    description "A programming language"
    concept
    user_uuid '1'
  end

  factory :request do
    sequence(:title) { |n| "help me #{n} I need help" }
    content 'need help learning ruby'
    contact_info 'call my cell all hours'
    member_uuid 'member-uuid'
  end
end
