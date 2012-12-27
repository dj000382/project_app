# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  nom        :string(255)
#  prenom     :string(255)
#  labo       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#



require 'spec_helper'

describe User do

  before { @user = User.new(nom: "Dupont", prenom: "Michel" , labo: "laboExemple") }

  subject { @user }

  it { should respond_to(:nom) }
  it { should respond_to(:prenom) }
	it { should respond_to(:labo) }
end


