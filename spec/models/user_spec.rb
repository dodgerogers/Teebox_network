require 'spec_helper'

describe User do
  before(:each) do
    @user = FactoryGirl.create(:user)
  end
  
  subject { @user }

   it { should respond_to(:email)}
   it { should respond_to(:password)}
   it { should respond_to(:password_confirmation)}
   it { should respond_to(:remember_me)}
   it { should respond_to(:reputation)}

   describe 'email' do
     before { @user.email = nil }
     it { should_not be_valid }
   end
   describe "password" do
     before { @user.password = nil }
     it { should_not be_valid }
   end
   
   describe "password_confirmation" do
     before { @user.password_confirmation = 'password1' }
      it { should_not be_valid }
    end
    
    describe "passwords match" do
      before { @user.password == @user.password_confirmation }
      it { should be_valid }
    end 
end