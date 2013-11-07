require 'spec_helper'

describe User do
  before(:each) do
    @user = create(:user)
    Devise::Mailer.stub(:delay).and_return(Devise::Mailer)
  end
  
  subject { @user }

   it { should respond_to(:email)}
   it { should respond_to(:password)}
   it { should respond_to(:password_confirmation)}
   it { should respond_to(:remember_me)}
   it { should respond_to(:reputation)}
   it { should respond_to(:rank)}
   it { should have_many(:questions)}
   it { should have_many(:videos)}
   it { should have_many(:comments)}
   it { should have_many(:answers)}
   it { should have_many(:votes)}
   it { should have_many(:tags)}

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
  
  describe "to_param" do
    it "returns id and username string" do
      @user.to_param.should eq "#{@user.id}-#{@user.username}"
    end
  end
  
  describe "create_welcome_notification" do
    it "triggers after_create" do
      subject.should_receive(:after_create)
      subject.after_create(recipient: subject)
    end
  end
       
  describe "user mail triggers" do
    it 'send_on_create_confirmation_instructions' do
      subject.should_receive(:send_on_create_confirmation_instructions)
      subject.send_on_create_confirmation_instructions
    end
    
    # it 'send_on_create_confirmation_instructions' do
    #       subject.should_receive(:send_reset_password_instructions)
    #       subject.send_reset_password_instructions
    #     end
    #     
    #     it 'send_unlock_instructions' do
    #       subject.should_receive(:send_unlock_instructions)
    #       subject.send_unlock_instructions
    #     end
  end
end