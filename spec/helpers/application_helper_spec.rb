require 'rails_helper'

describe ApplicationHelper do

  context "#angular_templates" do
    subject { angular_templates Rails.root.join('spec/fixtures/angular') }

    it { expect(subject).to include "<script type='text/ng-template' id='directives/input_enum.html'>" }
    it { expect(subject).to include '<input name="name" type="text" />' }
  end

end
