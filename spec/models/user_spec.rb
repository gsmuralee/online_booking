describe User do

  before(:each) { @user = User.new(email: 'user@example.com') }

  subject { @user }

  it "#email returns a string" do
    expect(@user.email).to match 'user@example.com'
  end

  it { should respond_to(:email) }
  it { should have_many(:bookings) }
  it { should validate_presence_of(:email) }
  it { should allow_value("test@example.com").for(:email) }
  it { should_not allow_value("test").for(:email) }
  it { should_not allow_value("pass").for(:password) } #less than 8 characters
  it { should_not allow_value("password-1").for(:password) } #more than 8 characters

end
