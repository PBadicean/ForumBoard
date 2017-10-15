shared_examples_for "Voted" do
  describe 'POST #up_vote' do
    sign_in_user

    context 'Non-author tries to up vote votable' do
      it 'assigns the requested votable to @votable' do
        post :up_vote, params: { id: other_user_votable, format: :json }
        expect(assigns(:votable)).to eq other_user_votable
      end

      it 'saves the new vote for votable' do
        expect do
          post :up_vote, params: { id: other_user_votable, format: :json }
        end.to change(other_user_votable.votes, :count).by(1)
      end

      it 'checks that value of vote to equal 1' do
        post :up_vote, params: { id: other_user_votable, format: :json }
        expect(assigns(:vote).value).to eq 1
      end
    end

    context 'Author tries to up vote' do
      it 'does not create a new vote' do
        expect do
          post :up_vote, params: { id: votable, format: :json }
        end.to_not change(votable.votes, :count)
      end
    end

    context 'Non-author tries to up vote 2 times' do
      it 'does not create a new vote' do
        post :up_vote, params: { id: votable, format: :json }
        expect do
          post :up_vote, params: { id: votable, format: :json }
        end.to_not change(votable.votes, :count)
      end
    end
  end

  describe 'POST #down_vote' do
    sign_in_user

    context 'Non-author tries to down vote votable' do
      it 'assigns the requested votable to @votable' do
        post :down_vote, params: { id: other_user_votable, format: :json }
        expect(assigns(:votable)).to eq other_user_votable
      end

      it 'checks that value of vote to equal 1' do
        post :down_vote, params: { id: other_user_votable, format: :json }
        expect(assigns(:vote).value).to eq -1
      end

      it 'saves the new vote for votable' do
        expect do
          post :down_vote, params: { id: other_user_votable, format: :json }
        end.to change(other_user_votable.votes, :count).by(1)
      end
    end

    context 'Author tries to down vote' do
      it 'does not create a new vote' do
        expect do
          post :down_vote, params: { id: votable, format: :json }
        end.to_not change(votable.votes, :count)
      end
    end

    context 'Non-author tries to down vote 2 times' do
      it 'does not create a new vote' do
        post :down_vote, params: { id: votable, format: :json }
        expect do
          post :down_vote, params: { id: votable, format: :json }
        end.to_not change(votable.votes, :count)
      end
    end
  end

  describe 'DELETE #revote' do
    sign_in_user
    context 'Author the vote tries to revote' do
      it 'destroy vote of the hes author' do
        vote_of_author
        expect do
          delete :revote, params: { id: other_user_votable, format: :json }
        end.to change(other_user_votable.votes, :count).by(-1)
      end
    end

    context 'Non-author the vote tries revote' do
      it 'not destroy vote of the hes author' do
        vote
        expect do
          delete :revote, params: { id: other_user_votable, format: :json }
        end.to_not change(other_user_votable.votes, :count)
      end
    end
  end
end
