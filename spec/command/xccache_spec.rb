require File.expand_path('../../spec_helper', __FILE__)

module Pod
  describe Command::Xccache do
    describe 'CLAide' do
      it 'registers it self' do
        Command.parse(%w{ xccache }).should.be.instance_of Command::Xccache
      end
    end
  end
end

