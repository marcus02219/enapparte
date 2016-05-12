require 'rails_helper'

describe ApplicationHelper do
  describe '#angular_templates' do
    subject { angular_templates Rails.root.join('spec/fixtures/angular') }

    it 'returns Angular template' do
      expect(subject).to include '<script id="directives/input_enum.html" ' \
                                 'type="text/ng-template">'
    end
    it 'return template\'s content' do
      expect(subject).to include '<input name="name" type="text" />'
    end
  end
end
