shared_examples_for "API Commentable" do
  context 'comments' do
    it 'include in commentable comments' do
      expect(response.body).to have_json_size(1).at_path(
        "#{commentable.class.name.underscore}/comments")
    end

    %w(id created_at updated_at commentable_type commentable_id body user_id).each do |attr|
      it "contains #{attr}" do
        expect(response.body).to be_json_eql(
          comment.send(attr.to_sym).to_json).at_path(
            "#{commentable.class.name.underscore}/comments/0/#{attr}")
      end
    end
  end
end
