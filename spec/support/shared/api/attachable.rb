shared_examples_for "API Attachable" do
  context 'attachments' do

    it 'include in attachable attachments' do
      expect(response.body).to have_json_size(1).at_path("#{attachable.class.name.underscore}/attachments")
    end

    it 'contains attachment url' do
      expect(response.body).to be_json_eql(
        attachment.file.url.to_json).at_path("#{attachable.class.name.underscore}/attachments/0/url")
    end

    %w(id file created_at updated_at attachable_id attachable_type).each do |attr|
      it "doesn't contains #{attr}" do
        expect(response.body).to_not have_json_path(
          "#{attachable}/attachments/0/#{attr}")
      end
    end
  end
end
