require 'rails_helper'

RSpec.describe User do
  it { should have_many :votes }
  it { should have_many(:questions).dependent(:destroy) }
  it { should have_many(:answers).dependent(:destroy) }
  it { should have_many(:comments).dependent(:destroy) }
  it { should have_many(:authorizations).dependent(:destroy) }


  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  describe '#author_of'do
    let(:user)      { create :user }
    let(:question)  { create(:question, user: user) }
    let(:question2) { create(:question) }

    context 'user is author' do
      it 'must return true' do
        expect(user.author_of(question)).to be_truthy
      end
    end

    context 'user is not author' do
      it 'must return false' do
        expect(user.author_of(question2)).to be_falsey
      end
    end
  end

  describe '#was_voting' do
    let(:user)       { create(:user) }
    let(:question)   { create(:question) }
    let(:vote)       { create(:vote, user: user, votable: question) }

    context 'tries to vote one time' do
      it 'must return false' do
        expect(user.was_voting(question)).to eq false
      end
    end

    context 'tries to vote second time' do
      it 'must return true' do
        vote
        expect(user.was_voting(question)).to eq true
      end
    end
  end

  describe '.find_for_oauth' do
    let!(:user) { create(:user) }

    context "user already has authorization" do
      let(:auth)  { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456') }

      it 'returns the user' do
        user.authorizations.create(provider: 'facebook', uid: '123456')
        expect(User.find_for_oauth(auth)).to eq user
      end
    end

    context 'User has not authorization' do
      context 'User already exists' do
        let(:auth) do
          OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456', info: { email: user.email })
        end

        it 'does not create a new User' do
          expect { User.find_for_oauth(auth) }.to_not change(User, :count)
        end

        it 'creates authorization for user with uid and provider' do
          expect { User.find_for_oauth(auth) }.to change(user.authorizations, :count).by(1)
          expect(user.authorizations.first.provider).to eq auth.provider
          expect(user.authorizations.first.uid).to eq auth.uid
        end

        it 'returns user' do
          expect(User.find_for_oauth(auth)).to eq user
        end
      end

      context 'User does not exist' do
        context 'Auth email exists' do
          let(:auth) do
            OmniAuth::AuthHash.new(provider: 'facebook',
                                   uid: '123456', info: { email: 'test@polina.com' })
          end

          it 'creates a new user' do
            expect { User.find_for_oauth(auth) }.to change(User, :count).by(1)
          end

          it 'fills email and for user' do
            user = User.find_for_oauth(auth)
            expect(user.email).to eq auth.info.email
          end
          it 'creates a new authorization' do
            expect { User.find_for_oauth(auth) }.to change(Authorization, :count).by(1)
          end

          it 'fills provider and uid for authorization' do
            authorization = User.find_for_oauth(auth).authorizations.first
            expect(authorization.provider).to eq auth.provider
            expect(authorization.uid).to eq auth.uid
          end

          it 'returns user' do
            expect(User.find_for_oauth(auth)).to be_a(User)
          end
        end

        context 'Auth email does not exist' do
          let(:auth) { OmniAuth::AuthHash.new(provider: 'twitter', uid: '12345', info: {}) }

          it 'creates a new user' do
            expect { User.find_for_oauth(auth) }.to change(User, :count).by(1)
          end

          it 'generates email for user' do
            user = User.find_for_oauth(auth)
            expect(user.email).to eq "change@me-#{auth.uid}-#{auth.provider}.com"
          end

          it 'creates a new authorization' do
            expect { User.find_for_oauth(auth) }.to change(Authorization, :count).by(1)
          end

          it 'fills provider and uid for authorization' do
           authorization = User.find_for_oauth(auth).authorizations.first
            expect(authorization.provider).to eq auth.provider
            expect(authorization.uid).to eq auth.uid
          end

          it 'returns user' do
            expect(User.find_for_oauth(auth)).to be_a(User)
          end
        end
      end
    end
  end


  describe '#email_verified?' do
    let(:user) { create(:user) }
    let(:invalid_user) { create(:user, email: 'change@me') }

    context 'Email is not fake' do
      it 'returns true' do
        expect(user.email_verified?).to be_truthy
      end
    end

    context 'Email is fake' do
      it 'returns false' do
        expect(invalid_user.email_verified?).to be_falsey
      end
    end
  end
end
